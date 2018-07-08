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
//
extern
fun
drawobj_triangle_point3
( p1: point
, p2: point
, p3: point ) : drawobj
//
implement
drawobj_triangle_point3
  (p1, p2, p3) = let
//
val p1 =
  DRAWARGexp(DRAWEXPpoint(p1))
val p2 =
  DRAWARGexp(DRAWEXPpoint(p2))
val p3 =
  DRAWARGexp(DRAWEXPpoint(p3))
//
val env = drawenv_nil((*void*))
//
in
//
DRAWOBJfapp
  ("polygon", env, $list{drawarg}(p1, p2, p3))
//
end // end of [drawobj_triangle_point3]
//
(* ****** ****** *)
//
extern
fun
drawobj_rectangle_int2
  (W: int, H: int): drawobj
//
implement
drawobj_rectangle_int2
  (W, H) = let
//
val W =
  DRAWARGexp(DRAWEXPint(W))
val H =
  DRAWARGexp(DRAWEXPint(H))
//
val env = drawenv_nil((*void*))
//
in
  DRAWOBJfapp("rectangle", env, $list{drawarg}(W, H))
end // end of [drawobj_rectangle_int2]
//
(* ****** ****** *)

(* end of [mydraw2_meta.dats] *)
