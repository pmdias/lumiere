type hittable = Ray.t -> Ray.HitRecord.t
(** The type definition of what an [hittable] is. In our case, we define
    an hittable as a function that encapsulates the information regarding
    a specific shape instance, and that when given a [Ray.t], will return
    a [Ray.HitRecord.t] instance that matches the hit record of the given
    ray with the encaplusated shape. *)

type world = { objects : hittable list }
(** Type that encapsulates the information required to describe the world
    of the scene that is intended to be rendered. *)
