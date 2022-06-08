type t = { width : int; height : int; aspect_ratio : float }

let make width height =
  let aspect_ratio = float_of_int width /. float_of_int height in
  { width; height; aspect_ratio }

let get_width o = o.width
let get_height o = o.height
let get_aspect_ratio o = o.aspect_ratio

let generate_pixels o =
  let pixel_count = o.width * o.height in
  let gen_pixel i =
    let x = i mod o.width in
    let y = i / o.width in
    (pixel_count, i, x, y)
  in
  Seq.init pixel_count gen_pixel
