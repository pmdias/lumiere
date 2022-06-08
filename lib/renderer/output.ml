type t = { width : int; height : int; aspect_ratio : float }

let make width height =
  let aspect_ratio = float_of_int width /. float_of_int height in
  { width; height; aspect_ratio }

let get_width o = o.width
let get_height o = o.height
let get_aspect_ratio o = o.aspect_ratio
