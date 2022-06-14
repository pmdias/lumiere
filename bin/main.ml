open Entities
open Numerical
open Numerical.Vector
open Renderer

let make_camera aspect_ratio =
  let lookfrom = Vec.make 13. 2. 3. in
  let lookat = Vec.make 0. 0. 0. in
  let vup = Vec.make 0. 1. 0. in
  let dist_to_focus = 13. in
  let aperture = 0.1 in
  Camera.make lookfrom lookat vup 30. aspect_ratio aperture dist_to_focus

let make_diffuse_sphere center =
  let albedo = Utils.random_vector 0. 1. in
  Object.make_sphere center 0.2 albedo

let make_metal_sphere center =
  let albedo = Utils.random_vector 0. 1. in
  let fuzz = Utils.random_float 0. 0.5 in
  Object.make_metal_sphere center 0.2 albedo fuzz

let make_random_sphere center =
  let choose_mat = Utils.random_float 0. 1. in
  match choose_mat with
  | _ when choose_mat < 0.8 -> make_diffuse_sphere center
  | _ -> make_metal_sphere center

let make_ground_sphere () =
  let center = Vec.make 0. (-1000.) 0. in
  Object.make_sphere center 1000. @@ Vec.make 0.5 0.5 0.5

let make_random_point a b =
  let x = float_of_int a in
  let y = float_of_int b in
  Vec.make
    (x +. (0.9 *. Utils.random_float 0. 1.))
    0.2
    (y +. (0.9 *. Utils.random_float 0. 1.))

let make_row a =
  Seq.init 3 (fun x -> x - 1)
  |> Seq.map (fun b -> make_random_point a b)
  |> Seq.filter (fun p -> Vec.length @@ (p -: Vec.make 4. 0.2 0.) > 0.9)
  |> Seq.map (fun p -> make_random_sphere p)
  |> Seq.fold_left (fun acc s -> acc @ [ s ]) []

let make_random_scene () =
  let camera = make_camera (3. /. 2.) in
  let ground = make_ground_sphere () in
  let big_sphere = Object.make_metal_sphere (Vec.make 0. 1. 0.) 1. (Vec.make 0.8 0.8 0.8) 0.1 in
  let spheres =
    Seq.init 3 (fun x -> x - 1)
    |> Seq.map make_row
    |> Seq.fold_left (fun acc r -> acc @ r) []
  in
  let world = [ ground; big_sphere ] @ spheres in
  Scene.make camera world

(** let scene_factory aspect_ratio =
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
  Scene.make camera objects *)

let () =
  let output = Output.make 1200 800 in
  let scene = make_random_scene () in
  Printf.fprintf stdout "P3\n%d %d\n255\n" (Output.get_width output)
    (Output.get_height output);
  Output.generate_pixels output
  |> Seq.map (fun x -> Tracer.trace_pixel scene output x)
  |> Seq.iter (fun c ->
         Printf.fprintf stdout "%d %d %d\n" (Color.get_red c)
           (Color.get_green c) (Color.get_blue c))
