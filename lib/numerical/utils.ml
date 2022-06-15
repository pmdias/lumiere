open Gg

let clamp v min max = if v < min then min else if v > max then max else v
let clamp_int v min max = clamp v min max

let random_float a b =
  let breadth = b -. a in
  a +. Random.float breadth

let random_vector a b =
  let x = random_float a b in
  let y = random_float a b in
  let z = random_float a b in
  V3.v x y z

let rec random_in_unit_sphere () =
  let pick = function
    | v when 1. > V3.norm2 v -> v
    | _ -> random_in_unit_sphere ()
  in
  random_vector (-1.) 1. |> pick

let random_unit_vector () = V3.unit @@ random_in_unit_sphere ()

let random_vector_in_hemisphere normal =
  let v = random_in_unit_sphere () in
  if V3.dot v normal > 0. then v else V3.neg v

let rec random_in_unit_disk () =
  let p = V3.v (random_float (-1.) 1.) (random_float (-1.) 1.) 0. in
  let pick = function
    | v when 1. > V3.norm2 v -> v
    | _ -> random_in_unit_disk ()
  in
  pick p
