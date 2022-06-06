open Geometry

type t = { point : Vec.t; normal : Vec.t; value : float; front_face : bool }

let make point normal value = { point; normal; value; front_face = false }

let set_front_face hrec (ray : Ray.t) outward_normal =
  let front_face = Vec.dot ray.dir outward_normal < 0. in
  let normal = if front_face then outward_normal else outward_normal *: -1. in
  let new_rec = make hrec.point normal hrec.value in
  { new_rec with front_face }

let get_point hr = hr.point
