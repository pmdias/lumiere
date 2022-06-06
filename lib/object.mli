open Geometry

type t
(** Structure for objects that make up a scene *)

type hittable = Ray.t -> float -> float -> Hitrecord.t option

val make_sphere : Vec.t -> float -> hittable
(** Create a new object that has the shape of a sphere *)
