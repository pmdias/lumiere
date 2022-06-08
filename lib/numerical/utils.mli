val clamp : float -> float -> float -> float
(** Given a value [v], and a [max] and [min], it returns a new value which
    clamped between [max] and [min] *)

val random_float : float -> float -> float
(** Using a range [r] given by [a] and [b], where [r] includes both [a] and
    [b] and all numbers between them, returns a random number in [r]. *)