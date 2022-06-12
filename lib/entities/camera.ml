open Numerical
open Numerical.Vector

type t = {
  origin : Vec.t;
  lower_left_corner : Vec.t;
  horizontal : Vec.t;
  vertical : Vec.t;
}

let degrees_to_radians degrees = degrees *. Float.pi /. 180.

let make lookfrom lookat vup vfov aspect_ratio =
  let theta = degrees_to_radians vfov in
  let h = Float.tan @@ (theta /. 2.) in
  let height = 2. *. h in
  let width = aspect_ratio *. height in

  let w = Vec.normalize @@ (lookfrom -: lookat) in
  let u = Vec.normalize @@ Vec.cross vup w in
  let v = Vec.cross w u in

  let origin = lookfrom in
  let horizontal = u *: width in
  let vertical = v *: height in
  let lower_left_corner =
    origin -: (horizontal /: 2.) -: (vertical /: 2.) -: w
  in
  { origin; lower_left_corner; horizontal; vertical }

let get_ray c u v =
  c.lower_left_corner +: (c.horizontal *: u) +: (c.vertical *: v) -: c.origin
  |> Ray.make c.origin
