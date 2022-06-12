open Entities
open Numerical.Vector
open Renderer

let make_camera aspect_ratio =
  let lookfrom = Vec.make (-2.) 2. 1. in
  let lookat = Vec.make 0. 0. (-1.) in
  let vup = Vec.make 0. 1. 0. in
  Camera.make lookfrom lookat vup 20. aspect_ratio

let scene_factory aspect_ratio =
  let camera = make_camera aspect_ratio in
  let objects =
    [
      Object.make_sphere (Vec.make 0. 0. (-1.)) 0.5 (Vec.make 0.7 0.3 0.3);
      Object.make_metal_sphere (Vec.make (-1.) 0. (-1.)) 0.5
        (Vec.make 0.8 0.8 0.8) 0.;
      Object.make_dielectric_sphere (Vec.make 1. 0. (-1.)) 0.5 1.5;
      Object.make_sphere (Vec.make 0. (-100.5) (-1.)) 100. (Vec.make 0.8 0.8 0.);
    ]
  in
  Scene.make camera objects

let () =
  let output = Output.make 400 200 in
  let scene = scene_factory @@ Output.get_aspect_ratio output in
  Printf.fprintf stdout "P3\n%d %d\n255\n" (Output.get_width output)
    (Output.get_height output);
  Output.generate_pixels output
  |> Seq.map (fun x -> Tracer.trace_pixel scene output x)
  |> Seq.iter (fun c ->
         Printf.fprintf stdout "%d %d %d\n" (Color.get_red c)
           (Color.get_green c) (Color.get_blue c))
