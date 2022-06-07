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
  val cross : t -> t -> t
  val length_squared : t -> float
  val length : t -> float
  val norm : t -> t
  val negate : t -> t
end

val ( +: ) : Vec.t -> Vec.t -> Vec.t
(** Operator that performs component wise addition of two vectors [a] and [b] *)

val ( -: ) : Vec.t -> Vec.t -> Vec.t
(** Operator that performs component wise subtraction of two vectors [a] and [b] *)

val ( *: ) : Vec.t -> float -> Vec.t
(** Operator that multiplies each component of a vector [v] by a scale factor [k] *)

val ( /: ) : Vec.t -> float -> Vec.t
(** Operator that divides each component of a vector [v] by a scale factor [k] *)
