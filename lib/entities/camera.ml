open Numerical.Vector

type t = {
  origin : Vec.t;
  lower_left_corner : Vec.t;
  horizontal : Vec.t;
  vertical : Vec.t;
}

let make aspect_ratio =
  let height = 2. in
  let width = aspect_ratio *. height in
  let focal_length = 1. in
  let origin = Vec.make 0. 0. 0. in
  let horizontal = Vec.make width 0. 0. in
  let vertical = Vec.make 0. height 0. in
  let lower_left_corner =
    origin -: (horizontal /: 2.) -: (vertical /: 2.)
    -: Vec.make 0. 0. focal_length
  in
  { origin; lower_left_corner; horizontal; vertical }
