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

val generate_pixels : t -> (int * int * int * int) Seq.t
(** Returns a sequence of pixels [Seq.t] where each node of the sequence is
    a tuple of four values, matching the total number of nodes in the sequence,
    the current node index, the [x] coordinate of the pixel that matches the
    current node, and the [y] coordinate of the pixel that matches the current
    node. *)
