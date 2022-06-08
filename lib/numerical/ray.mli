open Vector

type t = { origin : Vec.t; direction : Vec.t }
(** Record type that contains the information required to emulate a
    ray to be shot into the scene. If consists of two vectors [Vec.t]
    fields: an [origin] that specifies the origin point of the ray, and
    a [direction] vector that gives the world direction where the ray
    is shot *)

val make : Vec.t -> Vec.t -> t
(** Create a new [Ray.t] instance provided the two arguments, a [origin]
   point, and a [direction] vector *)

val at : t -> float -> Vec.t
(** Given a ray [r] and a value [t], gives the point vector that matches
    the location of the ray at that instant. *)
