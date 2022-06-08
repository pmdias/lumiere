open Entities

let trace_sample scene ray =
  let result =
    List.map Object.hit_test @@ Scene.get_objects scene
    |> List.map (fun x -> x ray 0.001 Float.infinity)
    |> List.filter (fun x -> match x with None -> false | _ -> true)
  in
  match result with
  | [] -> None
  | x :: _ -> x

let color_sample = function
  | None -> Color.blue
  | _ -> Color.red

let trace_pixel scene output pixel_data =
  let (_, _, x, y) = pixel_data in
  let camera = Scene.get_camera scene in
  let u = float_of_int x /. (float_of_int @@ Output.get_width output - 1) in
  let v = float_of_int y /. (float_of_int @@ Output.get_height output - 1) in
  Camera.get_ray camera u v
  |> trace_sample scene
  |> color_sample

