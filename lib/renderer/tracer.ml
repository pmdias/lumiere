open Entities
open Numerical
open Numerical.Vector

let default_color (ray : Ray.t) =
  let direction = Vec.normalize ray.direction in
  let t = 0.5 *. (direction.y +. 1.) in
  (Vec.make 1. 1. 1. *: (1. -. t)) +: (Vec.make 0.5 0.7 1. *: t)

let is_hit = function
  | None -> false
  | _ -> true

let safe_head = function
  | [] -> None
  | x :: _ -> x

let rec trace_sample scene depth ray =
  if depth <= 0 then Vec.make 0. 0. 0.
  else
    List.map Object.hit_test @@ Scene.get_objects scene
    |> List.map (fun x -> x ray 0.001 Float.infinity)
    |> List.filter is_hit |> safe_head
    |> color_sample scene depth ray

and color_sample scene depth ray sh =
  let material_color (hitrecord : Hitrecord.t) =
    let target =
      hitrecord.point +: hitrecord.normal +: Utils.random_unit_vector ()
    in
    let new_ray = Ray.make hitrecord.point (target -: hitrecord.point) in
    trace_sample scene (depth - 1) new_ray *: 0.5
  in
  match sh with
  | None -> default_color ray
  | Some hitrecord -> material_color hitrecord

let convert_pixel_to_camera_coordinates output x y =
  let width = Output.get_width output - 1 in
  let height = Output.get_height output - 1 in
  let u_bias = Utils.random_float 0. 1. in
  let v_bias = Utils.random_float 0. 1. in
  let u = (float_of_int x +. u_bias) /. float_of_int width in
  let v = (float_of_int y +. v_bias) /. float_of_int height in
  (u, v)

let trace_pixel scene output pixel_data =
  let _, _, x, y = pixel_data in
  let camera = Scene.get_camera scene in
  let inner_trace color =
    let u, v = convert_pixel_to_camera_coordinates output x y in
    let ray = Camera.get_ray camera u v in
    ray |> trace_sample scene 50 |> ( +: ) color
  in
  let color = Vec.make 0. 0. 0. in
  Seq.init 100 (fun x -> x)
  |> Seq.fold_left (fun acc _ -> inner_trace acc) color
  |> (fun x -> Vec.fmap sqrt @@ (x /: 100.))
  |> Color.from_vec
