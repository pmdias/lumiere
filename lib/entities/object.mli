open Numerical
open Numerical.Vector

type t
(** Opaque type that encapsulates an object that exists in the simulation world,
    and therefore makes up part of the rendering scene *)

type hittable = Ray.t -> float -> float -> Hitrecord.t option
(** Type used to represent any shape that can be hit and therefore return
    information regarding a specific ray hitting the shape. *)

val hit_test : t -> hittable
(** Access the hit test of a specific object [t] instance *)

val make_sphere : Vec.t -> float -> t
(** Create a new object [t] that emulates the behaviour of a sphere shaped
    structure. *)
