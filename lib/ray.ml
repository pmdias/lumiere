open Geometry

type t = { orig : Geometry.Point.t; dir : Geometry.Vec.t }

let make o d = { orig = o; dir = d }
let at { orig = o; dir = d } t = o +: (d *: t)
