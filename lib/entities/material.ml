open Numerical
open Numerical.Vector

module Scatter = struct
  type t = { scattered_ray : Ray.t; attenuation : Vec.t }

  let make scattered_ray attenuation = { scattered_ray; attenuation }
end

type t = { _scatterer : Ray.t -> Hitrecord.t -> Scatter.t option }

let get_scatterer material = material._scatterer
let scatter material ray hitrecord = get_scatterer material ray hitrecord

let make_lambertian albedo =
  let lambertian_scatter _ (hitrecord : Hitrecord.t) =
    let direction = hitrecord.normal +: Utils.random_unit_vector () in
    let scatter_direction =
      if Vec.near_zero direction then hitrecord.normal else direction
    in
    Some (Scatter.make (Ray.make hitrecord.point scatter_direction) albedo)
  in
  { _scatterer = lambertian_scatter }

let make_metal albedo fuzz =
  let metal_scatter (ray : Ray.t) (hitrecord : Hitrecord.t) =
    let reflected =
      Vec.reflect (Vec.normalize ray.direction) hitrecord.normal
    in
    let scatterd_ray =
      Ray.make hitrecord.point
        (reflected +: (Utils.random_in_unit_sphere () *: fuzz))
    in
    if Vec.dot scatterd_ray.direction hitrecord.normal > 0. then
      Some (Scatter.make scatterd_ray albedo)
    else None
  in
  { _scatterer = metal_scatter }

let reflectance cosine ref_idx =
  let r0 = (1. -. ref_idx) /. (1. +. ref_idx) in
  let r = r0 *. r0 in
  r +. ((1. -. r) *. ((1. -. cosine) ** 5.))

let make_dielectric index_of_refraction =
  let dielectric_scatter (ray : Ray.t) (hitrecord : Hitrecord.t) =
    let attenuation = Vec.make 1. 1. 1. in
    let refraction_ratio =
      if hitrecord.front_face then 1. /. index_of_refraction
      else index_of_refraction
    in
    let unit_direction = Vec.normalize ray.direction in

    let cos_theta =
      Float.min 1. @@ Vec.dot hitrecord.normal @@ Vec.negate unit_direction
    in
    let sin_theta = sqrt @@ (1. -. (cos_theta *. cos_theta)) in
    let cannot_refract = refraction_ratio *. sin_theta > 1. in
    let direction =
      match cannot_refract with
      | true
        when reflectance cos_theta refraction_ratio > Utils.random_float 0. 1.
        ->
          Vec.reflect unit_direction hitrecord.normal
      | _ -> Vec.refract unit_direction hitrecord.normal refraction_ratio
    in
    let scattered_ray = Ray.make hitrecord.point direction in
    Some (Scatter.make scattered_ray attenuation)
  in
  { _scatterer = dielectric_scatter }
