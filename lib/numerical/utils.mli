open Vector

val clamp : float -> float -> float -> float
(** Given a value [v], and a [max] and [min], it returns a new value which
    clamped between [max] and [min] *)

val clamp_int : int -> int -> int -> int
(** Similar to [clamp], but operates on values of type [int] *)

val random_float : float -> float -> float
(** Using a range [r] given by [a] and [b], where [r] includes both [a] and
    [b] and all numbers between them, returns a random number in [r]. *)

val random_vector : float -> float -> Vec.t
(** Generate a new random [Vec.t] where all of its components have a value
    inside the range [a] and [b]. *)

val random_in_unit_sphere : unit -> Vec.t
(** Generate a new random [Vec.t] that is contained inside the unit
    sphere. *)

val random_unit_vector : unit -> Vec.t
(** Generate a new random unit [Vec.t] *)

val random_vector_in_hemisphere : Vec.t -> Vec.t
(** Generate a new random unit vector  [Vec.t] that is inside the same hemisphere
    given by [normal] vector. *)

val random_in_unit_disk : unit -> Vec.t
