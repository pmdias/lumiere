open Gg

type t = { origin : V3.t; direction : V3.t }

let make origin direction = { origin; direction }
let at r t = V3.(r.origin + t * r.direction)
