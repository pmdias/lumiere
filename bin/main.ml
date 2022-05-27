type image_spec = { width : int; height : int }

let write_output_header { width; height } =
  Printf.fprintf stdout "P3\n%d %d\n255\n" width height

let () =
  let spec = { width = 256; height = 256 } in
  write_output_header spec;
  for j = spec.height - 1 downto 0 do
    Printf.fprintf stderr "\rScanlines remaining: %d " j;
    for i = 0 to spec.width - 1 do
      let r = float_of_int i /. float_of_int (spec.width - 1) in
      let g = float_of_int j /. float_of_int (spec.height - 1) in
      Lumiere.Color.write_color (Lumiere.Geometry.Vec.make r g 0.25)
    done
  done;
  Printf.fprintf stderr "\nDone.\n"
