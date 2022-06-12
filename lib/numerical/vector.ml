module Vec = struct
  type t = { x : float; y : float; z : float }

  let make x y z = { x; y; z }

  let add a b =
    let x = a.x +. b.x in
    let y = a.y +. b.y in
    let z = a.z +. b.z in
    make x y z

  let subtract a b =
    let x = a.x -. b.x in
    let y = a.y -. b.y in
    let z = a.z -. b.z in
    make x y z

  let multiply v k =
    let x = v.x *. k in
    let y = v.y *. k in
    let z = v.z *. k in
    make x y z

  let divide v k =
    let x = v.x /. k in
    let y = v.y /. k in
    let z = v.z /. k in
    make x y z

  let dot a b =
    let x = a.x *. b.x in
    let y = a.y *. b.y in
    let z = a.z *. b.z in
    x +. y +. z

  let cross a b =
    let x = (a.y *. b.z) -. (a.z *. b.y) in
    let y = (a.z *. b.x) -. (a.x *. b.z) in
    let z = (a.x *. b.y) -. (a.y *. b.x) in
    make x y z

  let length_squared v = dot v v
  let length v = sqrt @@ length_squared v
  let normalize v = length v |> divide v

  let negate v =
    let x = -.v.x in
    let y = -.v.y in
    let z = -.v.z in
    make x y z

  let make_normalized x y z = make x y z |> normalize

  let make_of_int a b c =
    let x = float_of_int a in
    let y = float_of_int b in
    let z = float_of_int c in
    make x y z

  let fmap f =
    let call v =
      let x = f v.x in
      let y = f v.y in
      let z = f v.z in
      make x y z
    in
    call

  let near_zero v =
    let s = 1e-8 in
    let av = fmap Float.abs @@ v in
    av.x < s && av.y < s && av.z < s

  let vector_multiply a b =
    let x = a.x *. b.x in
    let y = a.y *. b.y in
    let z = a.z *. b.z in
    make x y z

  let reflect v n =
    subtract v @@ multiply n (2. *. dot v n)

  let refract uv n etai_over_etat =
    let cos_theta = Float.min 1. @@ dot n @@ negate uv in
    let r_out_perp = multiply (add uv @@ multiply n cos_theta) etai_over_etat in
    let r_out_parallel = multiply n @@ -1. *. (sqrt @@ Float.abs (1. -. length_squared r_out_perp)) in
    add r_out_perp r_out_parallel
end

let ( +: ) a b = Vec.add a b
let ( -: ) a b = Vec.subtract a b
let ( *: ) v k = Vec.multiply v k
let ( /: ) v k = Vec.divide v k
