open Gg

type t = { point : V3.t; normal : V3.t; t : float; front_face : bool }

let make point normal t front_face = { point; normal; t; front_face }

let set_front_face (h : t) (r : Ray.t) n =
  let front_face = V3.(dot r.direction n) < 0. in
  let normal = if front_face then n else V3.(neg n) in
  { h with normal; front_face }

let compare a b = if a.t > b.t then 1 else if a.t < b.t then -1 else 0
