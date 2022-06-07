open Numerical.Vector

module Vec_test = struct
  let to_list (v : Vec.t) = [ v.x; v.y; v.z ]
end

let test_cross () =
  let a = Vec.make 1. 0. 0. in
  let b = Vec.make 0. 1. 0. in
  let result = Vec_test.to_list @@ Vec.make 0. 0. 1. in
  Alcotest.(check (list @@ float 0.001))
    "same vector" result
    (Vec_test.to_list @@ Vec.cross a b)

let () =
  let open Alcotest in
  run "Vector"
    [ ("cross", [ test_case "Cross product valid" `Quick test_cross ]) ]
