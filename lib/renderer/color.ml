open Numerical.Vector

type t = { r : int; g : int; b : int }

let make r g b =
  let clamp v = Numerical.Utils.clamp_int v 0 255 in
  let rc = clamp r in
  let gc = clamp g in
  let bc = clamp b in
  { r = rc; g = gc; b = bc }

let from_vec (v : Vec.t) =
  let r = int_of_float @@ v.x *. 255.999 in
  let g = int_of_float @@ v.y *. 255.999 in
  let b = int_of_float @@ v.z *. 255.999 in
  make r g b


let get_red c = c.r
let get_green c = c.g
let get_blue c = c.b
let red = make 255 0 0
let green = make 0 255 0
let blue = make 0 0 255
let white = make 255 255 255
let black = make 0 0 0
