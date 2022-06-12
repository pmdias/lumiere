open Numerical
open Numerical.Vector

type t
(** Material type object *)

module Scatter : sig
  type t = { scattered_ray : Ray.t; attenuation : Vec.t }
end

val scatter : t -> Ray.t -> Hitrecord.t -> Scatter.t option
val make_lambertian : Vec.t -> t
