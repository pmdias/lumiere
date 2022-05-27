module RGB = struct
    type t = Geometry.Vec.t
end

let write_color (color : RGB.t) =
    let r = int_of_float (255.999 *. color.x) in
    let g = int_of_float (255.999 *. color.y) in
    let b = int_of_float (255.999 *. color.z) in
    Printf.fprintf stdout "%d %d %d\n" r g b
