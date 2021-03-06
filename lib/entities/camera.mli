open Numerical
open Numerical.Vector

type t
(** Type structure that represents the camera used to render a scene. *)

val make : Vec.t -> Vec.t -> Vec.t -> float -> float -> float -> float -> t
(** Create a new camera instance based on a specific aspect ratio *)

val get_ray : t -> float -> float -> Ray.t
(** Get a ray that is shot through the camera and passing through a specific
    location. *)
