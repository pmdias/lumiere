open Numerical
open Numerical.Vector

module Scatter = struct
  type t = { scattered_ray : Ray.t; attenuation : Vec.t }

  let make scattered_ray attenuation =
    { scattered_ray; attenuation; }
end

type t = { _scatterer : Ray.t -> Hitrecord.t -> Scatter.t }

let get_scatterer material = material._scatterer

let scatter material ray hitrecord =
  get_scatterer material ray hitrecord

let make_lambertian albedo =
  let lambertian_scatter _ (hitrecord : Hitrecord.t) =
    let direction = hitrecord.normal +: Utils.random_unit_vector () in
    let scatter_direction = if Vec.near_zero direction then hitrecord.normal else direction in
    Scatter.make (Ray.make hitrecord.point scatter_direction) albedo
  in
  { _scatterer=lambertian_scatter }
