module Vec = struct
    type t = {
        x : float;
        y : float;
        z : float;
    }

    let make x y z =
        { x=x; y=y; z=z }

    let dot v1 v2 =
        (v1.x *. v2.x) +. (v1.y *. v2.y) +. (v1.z *. v2.z)

    let length_squared v =
        dot v v

    let length v =
        sqrt (length_squared v)

    let norm v =
        let scale = length v in
        make (v.x /. scale) (v.y /. scale) (v.z /. scale)

    let negate v =
        make (-.v.x) (-.v.y) (-.v.z)
end

module Point = struct
    type t = Vec.t
end

let ( +: ) (a : Vec.t) (b : Vec.t) : Vec.t =
    Vec.make (a.x +. b.x) (a.y +. b.y) (a.z +. b.z)

let ( -: ) (a : Vec.t) (b : Vec.t) : Vec.t =
    Vec.make (a.x -. b.x) (a.y -. b.y) (a.z -. b.z)

let ( *: ) (v : Vec.t) (k : float) : Vec.t =
    Vec.make (v.x *. k) (v.y *. k) (v.z *. k)

let ( /: ) (v : Vec.t) (k : float) : Vec.t =
    Vec.make (v.x /. k) (v.y /. k) (v.z /. k)
