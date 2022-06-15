open Entities
open Numerical
open Numerical.Vector
open Renderer

let make_camera aspect_ratio =
  let lookfrom = Vec.make 10. 2. 3. in
  let lookat = Vec.make 0. 0. 0. in
  let vup = Vec.make 0. 1. 0. in
  let dist_to_focus = 10. in
  let aperture = 0.1 in
  Camera.make lookfrom lookat vup 30. aspect_ratio aperture dist_to_focus

let make_diffuse_sphere center =
  let albedo = Utils.random_vector 0. 1. in
  Object.make_sphere center 0.2 albedo

let make_metal_sphere center =
  let albedo = Utils.random_vector 0. 1. in
  let fuzz = Utils.random_float 0. 0.2 in
  Object.make_metal_sphere center 0.2 albedo fuzz

let make_dielectric_sphere center =
  Object.make_dielectric_sphere center 0.2 0.4

let make_demo_scene () =
  let camera = make_camera (3. /. 2.) in
  let ground = Object.make_plane (Vec.make 0. 0. 0.) (Vec.make 0. 1. 0.) (Vec.make 0.3 0.3 0.45) in
  let world = [
    ground;
    make_metal_sphere (Vec.make (-1.) 0.2 0.);
    make_diffuse_sphere (Vec.make 1. 0.2 0.);
    make_dielectric_sphere (Vec.make 1. 0.2 1.);
    make_metal_sphere (Vec.make (-1.) 0.2 1.);
  ] in
  Scene.make camera world

let () =
  let output = Output.make 1200 800 in
  let scene = make_demo_scene () in
  Printf.fprintf stdout "P3\n%d %d\n255\n" (Output.get_width output)
    (Output.get_height output);
  Output.generate_pixels output
  |> Seq.map (fun x -> Tracer.trace_pixel scene output x)
  |> Seq.iter (fun c ->
         Printf.fprintf stdout "%d %d %d\n" (Color.get_red c)
           (Color.get_green c) (Color.get_blue c))
