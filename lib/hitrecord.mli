open Geometry

type t
(** Hit record structure *)

val make : Vec.t -> Vec.t -> float -> t
(** Create a new hit record structure with the provided [p] point,
    [n] normal, and [t] value at intersection. *)

val set_front_face : t -> Ray.t -> Vec.t -> t
(** Update the [front_face] flag of a specific hit record structure *)
