open Geometry

module Sphere = struct
  type t = { center : Vec.t; radius : float }

  let make c r = { center = c; radius = r }

  let hit s (r : Ray.t) t_min t_max =
    let get_record sphere ray t =
      let intersect = Ray.at ray t in
      let normal = (intersect -: sphere.center) /: sphere.radius in
      Ray.HitRecord.make intersect normal t
    in
    let oc = r.orig -: s.center in
    let a = Vec.length_squared r.dir in
    let half_b = Vec.dot oc r.dir in
    let c = Vec.length_squared oc -. (s.radius *. s.radius) in
    let discriminant = (half_b *. half_b) -. (a *. c) in
    if discriminant < 0. then None
    else
      let sqrtd = sqrt discriminant in
      let root = (-.half_b -. sqrtd) /. a in
      if t_min <= root && root <= t_max then Some (get_record s r root)
      else
        let root_pos = (-.half_b +. sqrtd) /. a in
        if t_min <= root_pos && root_pos <= t_max then
          Some (get_record s r root_pos)
        else None
end

type t = SphereShape of Sphere.t | NilShape

let hit shape r t_min t_max =
  match shape with SphereShape s -> Sphere.hit s r t_min t_max | _ -> None
