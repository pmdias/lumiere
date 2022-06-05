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
