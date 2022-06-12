open Numerical.Vector

type t

val make : int -> int -> int -> t
val from_vec : Vec.t -> t
val to_vec : t -> Vec.t
val get_red : t -> int
val get_green : t -> int
val get_blue : t -> int
val red : t
val green : t
val blue : t
val white : t
val black : t
