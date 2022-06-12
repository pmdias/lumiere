open Numerical
open Numerical.Vector

module Scatter = struct
  type t = { scattered_ray : Ray.t; attenuation : Vec.t }

  let make scattered_ray attenuation = { scattered_ray; attenuation }
end

type t = { _scatterer : Ray.t -> Hitrecord.t -> Scatter.t  option }

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

let make_metal albedo =
  let metal_scatter (ray : Ray.t) (hitrecord : Hitrecord.t) =
    let reflected = Vec.reflect (Vec.normalize ray.direction) hitrecord.normal in
    let scatterd_ray = Ray.make hitrecord.point reflected in
    if (Vec.dot scatterd_ray.direction hitrecord.normal) > 0. then
      Some (Scatter.make scatterd_ray albedo)
    else
      None
  in
  { _scatterer = metal_scatter }
