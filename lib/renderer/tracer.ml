open Entities
open Numerical
open Numerical.Vector

let trace_sample scene ray =
  let result =
    List.map Object.hit_test @@ Scene.get_objects scene
    |> List.map (fun x -> x ray 0.001 Float.infinity)
    |> List.filter (fun x ->
           match x with
           | None -> false
           | _ -> true)
  in
  match result with
  | [] -> None
  | x :: _ -> x

let default_color (ray : Ray.t) =
  let direction = Vec.normalize ray.direction in
  let t = 0.5 *. (direction.y +. 1.) in
  let c = (Vec.make 1. 1. 1. *: (1. -. t)) +: (Vec.make 0.5 0.7 1. *: t) in
  Color.from_vec c

let color_sample ray c =
  match c with
  | None -> default_color ray
  | _ -> Color.red

let convert_pixel_to_camera_coordinates output x y =
  let width = Output.get_width output - 1 in
  let height = Output.get_height output - 1 in
  let u = float_of_int x /. float_of_int width in
  let v = float_of_int y /. float_of_int height in
  (u, v)

let trace_pixel scene output pixel_data =
  let _, _, x, y = pixel_data in
  let camera = Scene.get_camera scene in
  let u, v = convert_pixel_to_camera_coordinates output x y in
  let ray = Camera.get_ray camera u v in
  ray |> trace_sample scene |> color_sample ray
