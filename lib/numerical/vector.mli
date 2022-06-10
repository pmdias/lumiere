module Vec : sig
  type t = { x : float; y : float; z : float }
  (** Record that provides a representation of a 3-dimensional vector, with
      the components [x], [y], and [z], each representing one of the dimensions
      of the vector. *)

  val make : float -> float -> float -> t
  (** Create a new [Vec.t] record from the three provided floats [x], [y], and [z] *)

  val make_normalized : float -> float -> float -> t
  (** Similar to [Vec.make], but the returned vector is already normalized. This is
      essentialy similar to doing

        Vec.make x y z
        |> Vec.norm

      So this function is just synthatic sugar for an already available operation
      on vectors. *)

  val make_of_int : int -> int -> int -> t
  (** Similar to [Vec.make] but accepts the inputs [x], [y], and [z] to be provided
      as type [int]. The resulting vector still uses [float] for each component *)

  val dot : t -> t -> float
  (** Compute the dot product of two vectors [a] and [b] *)

  val cross : t -> t -> t
  (** Compute the cross product of two vectors [a] and [b] *)

  val length_squared : t -> float
  (** Compute the squared length of vector [v]. This is essentialy the same as computing
      [Vec.dot v v]. *)

  val length : t -> float
  (** Compute the length, i.e. the magnitude, of a vector. If you're only using the length
      to perform some comparison, think about using [Vec.length_squared] instead, since
      it is more efficient. *)

  val normalize : t -> t
  (** Normalize vector [v] so that it has length equal to 1. This is essentialy the same
      operation as computing the length of the vector and dividing every component of
      the vector by it. *)

  val negate : t -> t
  (** Return a new vector that has all its components equal to vector [v] components
      multiplied by -1. *)

  val fmap : (float -> float) -> t -> t
  (** Given a function [f] that maps a [float] to a [float], apply that function to each
      component of the vector [v] and return a new vector *)
end

val ( +: ) : Vec.t -> Vec.t -> Vec.t
(** Operator that performs component wise addition of two vectors [a] and [b] *)

val ( -: ) : Vec.t -> Vec.t -> Vec.t
(** Operator that performs component wise subtraction of two vectors [a] and [b] *)

val ( *: ) : Vec.t -> float -> Vec.t
(** Operator that multiplies each component of a vector [v] by a scale factor [k] *)

val ( /: ) : Vec.t -> float -> Vec.t
(** Operator that divides each component of a vector [v] by a scale factor [k] *)
