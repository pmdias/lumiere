type t = { camera : Camera.t; objects : Object.t list }

let make camera objects = { camera; objects }
let get_camera scene = scene.camera
let get_objects scene = scene.objects
