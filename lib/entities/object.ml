open Numerical
open Numerical.Vector

type hittable = Ray.t -> float -> float -> (Hitrecord.t * Material.t) option
type t = { hit_test : hittable; material : Material.t }

module Plane = struct
  type t = { point : Vec.t; normal : Vec.t }

  let make point normal = { point; normal; }

  let hit_test plane material (ray : Ray.t) t_min t_max =
    let denom = Vec.dot plane.normal ray.direction in
    if Float.abs denom > 0. then
      let p0l0 = plane.point -: ray.origin in
      let t = Vec.dot p0l0 plane.normal /. denom in
      if t > t_min && t < t_max then
        let point = Ray.at ray t in
        let record = Hitrecord.make point plane.normal t false in
        Some (Hitrecord.set_front_face record ray plane.normal, material)
      else
        None
    else
      None
end

module Sphere = struct
  type t = { center : Vec.t; radius : float }

  let get_normal point center radius =
    (point -: center) /: radius |> Vec.normalize

  let get_hit_record sphere ray value =
    let point = Ray.at ray value in
    let normal = get_normal point sphere.center sphere.radius in
    let record = Hitrecord.make point normal value false in
    Hitrecord.set_front_face record ray normal

  let check_root root t_min t_max =
    if root >= t_min && root <= t_max then Some root else None

  let match_roots sphere ray roots =
    match roots with
    | None, None -> None
    | None, Some v -> Some (get_hit_record sphere ray v)
    | Some v, _ -> Some (get_hit_record sphere ray v)

  let hit_test sphere material (ray : Ray.t) t_min t_max =
    let oc = ray.origin -: sphere.center in
    let a = Vec.length_squared ray.direction in
    let half_b = Vec.dot oc ray.direction in
    let c = Vec.length_squared oc -. (sphere.radius *. sphere.radius) in
    let discriminant = (half_b *. half_b) -. (a *. c) in
    if discriminant >= 0. then
      let sqrtd = sqrt discriminant in
      let root_a = check_root ((-.half_b -. sqrtd) /. a) t_min t_max in
      let root_b = check_root ((-.half_b +. sqrtd) /. a) t_min t_max in
      (root_a, root_b) |> match_roots sphere ray |> fun r ->
      match r with
      | None -> None
      | Some h -> Some (h, material)
    else None

  let make center radius = { center; radius }
end

let hit_test o = o.hit_test

let make_plane point normal albedo =
  let material = Material.make_lambertian albedo in
  let plane = Plane.make point normal in
  let hit_test = Plane.hit_test plane material in
  { hit_test; material }

let make_sphere center radius albedo =
  let material = Material.make_lambertian albedo in
  let s = Sphere.make center radius in
  let hit_test = Sphere.hit_test s material in
  { hit_test; material }

let make_metal_sphere center radius albedo fuzz =
  let material = Material.make_metal albedo fuzz in
  let s = Sphere.make center radius in
  let hit_test = Sphere.hit_test s material in
  { hit_test; material }

let make_dielectric_sphere center radius index_of_refraction =
  let material = Material.make_dielectric index_of_refraction in
  let s = Sphere.make center radius in
  let hit_test = Sphere.hit_test s material in
  { hit_test; material }
