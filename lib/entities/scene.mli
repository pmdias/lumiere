type t
(** Type structure representing a scene that is the target of the rendering *)

val get_camera : t -> Camera.t
(** Get the camera that is assigned to a scene [s] structure *)

val get_objects : t -> Object.t list
(** Get the list of objects that is assigned to a scene [s] structure *)
