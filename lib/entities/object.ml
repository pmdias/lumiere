open Numerical
open Numerical.Vector

type hittable = Ray.t -> float -> float -> Hitrecord.t option
type t = { hit_test : hittable }

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

  let hit_test sphere (ray : Ray.t) t_min t_max =
    let oc = ray.origin -: sphere.center in
    let a = Vec.length_squared ray.direction in
    let half_b = Vec.dot oc ray.direction in
    let c = Vec.length_squared oc -. (sphere.radius *. sphere.radius) in
    let discriminant = (half_b *. half_b) -. (a *. c) in
    if discriminant >= 0. then
      let sqrtd = sqrt discriminant in
      let root_a = check_root ((-.half_b -. sqrtd) /. a) t_min t_max in
      let root_b = check_root ((-.half_b +. sqrtd) /. a) t_min t_max in
      (root_a, root_b) |> match_roots sphere ray
    else None

  let make center radius = { center; radius }
end

let hit_test o = o.hit_test

let make_sphere center radius =
  let s = Sphere.make center radius in
  let hit_test = Sphere.hit_test s in
  { hit_test }
