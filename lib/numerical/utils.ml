open Vector

let clamp v min max = if v < min then min else if v > max then max else v
let clamp_int v min max = clamp v min max

let random_float a b =
  let breadth = b -. a in
  a +. Random.float breadth

let random_vector a b =
  let x = random_float a b in
  let y = random_float a b in
  let z = random_float a b in
  Vec.make x y z

let rec random_in_unit_sphere () =
  let pick = function
    | v when 1. > Vec.length_squared v -> v
    | _ -> random_in_unit_sphere ()
  in
  random_vector (-1.) 1. |> pick
