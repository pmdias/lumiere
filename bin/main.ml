open Entities
open Numerical.Vector
open Renderer

let scene_factory aspect_ratio =
  let camera = Camera.make aspect_ratio in
  let objects =
    [
      Object.make_sphere (Vec.make 0. 0. (-1.)) 0.5;
      Object.make_sphere (Vec.make 0. (-100.5) (-1.)) 100.;
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
