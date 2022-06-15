open Gg

type t = { point : V3.t; normal : V3.t; t : float; front_face : bool }
(** Record structure used to store the information regarding the intersection
    of a [Ray.t] with any structure in the scene *)

val make : V3.t -> V3.t -> float -> bool -> t
(** Create a new [t] instance from a [point] vector, a [normal] vector, a [t]
    value, and a [front_face] boolean. *)

val set_front_face : t -> Ray.t -> V3.t -> t
(** Given a hit record [h], a ray [r], and a normal vector [n], this function
    updates the hit record so that the normal that is stored inside is pointing
    outside the surface. *)

val compare : t -> t -> int
