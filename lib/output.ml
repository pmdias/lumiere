module Config = struct
  type t = { width : int; height : int; aspect_ratio : float }
  (** Configuration parameters used to create the output of the rendering
      pipeline *)

  (** Make a new output configuration from a specific [width] and
      [height] values *)
  let make_from_dims width height =
    let aspect_ratio = float_of_int width /. float_of_int height in
    { width; height; aspect_ratio }

  (** Make a new output configuration from a specific [width] and
      [aspect ratio]. *)
  let make_from_ratio width aspect_ratio =
    let height = int_of_float @@ (float_of_int width /. aspect_ratio) in
    { width; height; aspect_ratio }
end

module PPM = struct
  (** Write the header of a PPM file *)
  let write_header w h = Printf.fprintf stdout "P3\n%d %d\n255\n" w h

  (** Write a single pixel to the output *)
  let write_pixel r g b = Printf.fprintf stdout "%d %d %d\n" r g b
end

(** Log to stderr the remaining number of scanlines *)
let log_remaining_scanlines i =
  Printf.fprintf stderr "\rScanlines remaining: %d " i

(** Log to stderr the termination of the rendering *)
let log_render_finished () = Printf.fprintf stderr "\nDone\n"
