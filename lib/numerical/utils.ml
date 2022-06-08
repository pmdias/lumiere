let clamp v min max = if v < min then min else if v > max then max else v

let random_float a b =
  let breadth = b -. a in
  a +. Random.float breadth
