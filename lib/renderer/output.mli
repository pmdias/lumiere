type t
(** Output structure that holds information regarding the output format,
    dimensions, and other required information for the rendering process. *)

val make : int -> int -> t
(** Create a new output [t] based on two arguments, the [width] and the
    [height] of the output. *)

val get_width : t -> int
(** Get the width of a target output *)

val get_height : t -> int
(** Get the height of a target output *)

val get_aspect_ratio : t -> float
(** Get the aspect ratio of a target output *)
