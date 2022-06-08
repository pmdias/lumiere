open Vector

type t = { origin : Vec.t; direction : Vec.t }

let make origin direction = { origin; direction }
let at r t = r.origin +: (r.direction *: t)
