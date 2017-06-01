(*
//
Author: Hongwei Xi
Start time: Summer I, 2017
Authoremai: gmhwxiatgmaildotcom
//
*)
(* ****** ****** *)
(*
//
Mydraw2:
Drawing of functional style
that is inspired by OpenSCAD
//
*)
(* ****** ****** *)

#staload "./mydraw2.dats"

(* ****** ****** *)

extern
fun
drawobj_square_int1
  (x: int): drawobj

implement
drawobj_square_int1
  (x) = let
//
val x = DRAWEXPint(x)
val x = DRAWARGexp(x)
//
val env = drawenv_nil((*void*))
//
in
  DRAWOBJfapp("square", env, list_sing(x))
end // end of [scadobj_cube_int1]

(* ****** ****** *)

(* end of [mydraw2_meta.dats] *)
