open Geometry

type hittable = Ray.t -> float -> float -> Hitrecord.t option
type t = { hit : hittable }

module Sphere = struct
  type t = { center : Vec.t; radius : float }

  let get_record (sphere : t) (r : Ray.t) (t : float) =
    let intersect = Ray.at r t in
    let normal = (intersect -: sphere.center) /: sphere.radius in
    let hit_record = Hitrecord.make intersect normal t in
    let outward_normal =
      (Hitrecord.get_point hit_record -: sphere.center) /: sphere.radius
    in
    Hitrecord.set_front_face hit_record r outward_normal

  let hit (sphere : t) (ray : Ray.t) (t_min : float) (t_max : float) :
      Hitrecord.t option =
    let oc = ray.orig -: sphere.center in
    let a = Vec.length_squared ray.dir in
    let half_b = Vec.dot oc ray.dir in
    let c = Vec.length_squared oc -. (sphere.radius *. sphere.radius) in
    let discriminant = (half_b *. half_b) -. (a *. c) in
    if discriminant < 0. then None
    else
      let sqrtd = sqrt discriminant in
      let root_a = (-.half_b -. sqrtd) /. a in
      if t_min <= root_a && root_a <= t_max then
        Some (get_record sphere ray root_a)
      else
        let root_b = (-.half_b +. sqrtd) /. a in
        if t_min <= root_b && root_b <= t_max then
          Some (get_record sphere ray root_b)
        else None

  let make center radius =
    let sphere = { center; radius } in
    hit sphere
end

let make_sphere center radius = Sphere.make center radius
