open Lumiere.Geometry

type image_spec = { width : int; height : int }

let write_output_header { width; height } =
  Printf.fprintf stdout "P3\n%d %d\n255\n" width height

let hit_sphere (center : Vec.t) (r : float) (ray : Lumiere.Ray.t) : bool =
  let oc = ray.orig -: center in
  let a = Vec.dot ray.dir ray.dir in
  let b = 2. *. Vec.dot oc ray.dir in
  let c = Vec.dot oc oc -. r *. r in
  let discriminant = b *. b -. 4. *. a *. c in
  discriminant > 0.

let ray_color (r : Lumiere.Ray.t) =
  if hit_sphere (Vec.make 0. 0. (-1.)) 0.5 r then
    Vec.make 1. 0. 0.
  else
    let unit_direction = Vec.norm r.dir in
    let t = 0.5 *. (unit_direction.y +. 1.) in
    (Vec.make 1. 1. 1. *: (1. -. t)) +: (Vec.make 0.5 0.7 1.0 *: t)

let () =
  let aspect_ratio = 16. /. 9. in
  let spec = { width = 400; height = int_of_float (400. /. aspect_ratio) } in
  let viewport_height = 2. in
  let viewport_width = aspect_ratio *. viewport_height in
  let focal_length = 1. in
  let origin = Vec.make 0. 0. 0. in
  let horizontal = Vec.make viewport_width 0. 0. in
  let vertical = Vec.make 0. viewport_height 0. in
  let lower_left_corner = origin -: horizontal /: 2. -: vertical /: 2. -: Vec.make 0. 0. focal_length in
  write_output_header spec;
  for j = spec.height - 1 downto 0 do
    Printf.fprintf stderr "\rScanlines remaining: %d " j;
    for i = 0 to spec.width - 1 do
      let u = float_of_int i /. float_of_int (spec.width - 1) in
      let v = float_of_int j /. float_of_int (spec.height - 1) in
      let r = Lumiere.Ray.make origin (lower_left_corner +: horizontal *: u +: vertical *: v -: origin) in
      let color = ray_color r in
      Lumiere.Color.write_color color
    done
  done;
  Printf.fprintf stderr "\nDone.\n"
