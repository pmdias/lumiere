open Numerical
open Numerical.Vector

type t = {
  origin : Vec.t;
  lower_left_corner : Vec.t;
  horizontal : Vec.t;
  vertical : Vec.t;
  u : Vec.t;
  v : Vec.t;
  w : Vec.t;
  lens_radius : float;
}

let degrees_to_radians degrees = degrees *. Float.pi /. 180.

let make lookfrom lookat vup vfov aspect_ratio aperture focus_dist =
  let theta = degrees_to_radians vfov in
  let h = Float.tan @@ (theta /. 2.) in
  let height = 2. *. h in
  let width = aspect_ratio *. height in

  let w = Vec.normalize @@ (lookfrom -: lookat) in
  let u = Vec.normalize @@ Vec.cross vup w in
  let v = Vec.cross w u in

  let lens_radius = aperture /. 2. in
  let origin = lookfrom in
  let horizontal = u *: width *: focus_dist in
  let vertical = v *: height *: focus_dist in
  let lower_left_corner =
    origin -: (horizontal /: 2.) -: (vertical /: 2.) -: (w *: focus_dist)
  in
  { origin; lower_left_corner; horizontal; vertical; lens_radius; u; v; w }

let get_ray c s t =
  let rd = Utils.random_in_unit_disk () *: c.lens_radius in
  let offset = (c.u *: rd.x) +: (c.v *: rd.y) in
  c.lower_left_corner +: (c.horizontal *: s) +: (c.vertical *: t) -: c.origin
  -: offset
  |> Ray.make (c.origin +: offset)
