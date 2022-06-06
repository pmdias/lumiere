open Lumiere.Geometry

let hit_sphere (center : Vec.t) (r : float) (ray : Lumiere.Ray.t) : float =
  let oc = ray.orig -: center in
  let a = Vec.dot ray.dir ray.dir in
  let b = 2. *. Vec.dot oc ray.dir in
  let c = Vec.dot oc oc -. (r *. r) in
  let discriminant = (b *. b) -. (4. *. a *. c) in
  if discriminant < 0. then -1. else (-.b -. sqrt discriminant) /. (2. *. a)

let ray_color (r : Lumiere.Ray.t) =
  let t = hit_sphere (Vec.make 0. 0. (-1.)) 0.5 r in
  if t > 0. then
    let n = Vec.norm (Lumiere.Ray.at r t -: Vec.make 0. 0. (-1.)) in
    Vec.make (n.x +. 1.) (n.y +. 1.) (n.z +. 1.) *: 0.5
  else
    let unit_direction = Vec.norm r.dir in
    let t = 0.5 *. (unit_direction.y +. 1.) in
    (Vec.make 1. 1. 1. *: (1. -. t)) +: (Vec.make 0.5 0.7 1.0 *: t)

let () =
  let aspect_ratio = 16. /. 9. in
  let image_width = 400 in
  let cfg = Lumiere.Output.Config.make_from_ratio image_width aspect_ratio in
  let camera = Lumiere.Camera.make cfg.aspect_ratio 2. in
  Lumiere.Output.PPM.write_header cfg.width cfg.height;
  for j = cfg.height - 1 downto 0 do
    Printf.fprintf stderr "\rScanlines remaining: %d " j;
    for i = 0 to cfg.width - 1 do
      let u = float_of_int i /. float_of_int (cfg.width - 1) in
      let v = float_of_int j /. float_of_int (cfg.height - 1) in
      let r = Lumiere.Camera.get_ray camera u v in
      let color = ray_color r in
      Lumiere.Color.write_color color
    done
  done;
  Printf.fprintf stderr "\nDone.\n"
