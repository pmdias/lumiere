open Geometry

module HitRecord = struct
  type t = { p : Vec.t; normal : Vec.t; t : float }

  let make p n t = { p; normal = n; t }
end

type t = { orig : Geometry.Point.t; dir : Geometry.Vec.t }

let make o d = { orig = o; dir = d }
let at { orig = o; dir = d } t = o +: (d *: t)
