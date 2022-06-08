open Vector

type t = { point : Vec.t ; normal : Vec.t ; t : float ; front_face : bool }

let make point normal t front_face = { point; normal; t; front_face; }

let set_front_face (h : t) (r : Ray.t) n =
  let front_face = Vec.dot r.direction n < 0. in
  let normal = if front_face then n else Vec.negate n in
  { h with normal ; front_face }
