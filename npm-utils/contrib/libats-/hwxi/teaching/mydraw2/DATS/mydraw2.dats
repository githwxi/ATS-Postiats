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
//
datatype
point =
POINT of (double, double)
//
extern
fun
point_make_int2
  (x: int, y: int): point
and
point_make_float2
  (x: double, y: double): point
//
overload
point with point_make_int2
overload
point with point_make_float2
//
(* ****** ****** *)
//
abstype label_type
typedef label = label_type
//
(* ****** ****** *)
//
extern
fun
label_make(x: string): label
//
symintr label
overload label with label_make
//
(* ****** ****** *)

datatype
drawarg =
| DRAWARG of drawexp

and
drawexp =
| DRAWEXPint of (int)
| DRAWEXPbool of (bool)

where
drawexplst = List0(drawexp)
and
drawarglst = List0(drawarg)

(* ****** ****** *)

abstype drawenv_type
typedef drawenv = drawenv_type

(* ****** ****** *)

datatype
drawobj =
| DRAWOBJfapp of
  (
    string(*fopr*), drawenv, drawarglst
  ) (* DRAWOBJfopr *)

and
drawtfm =
//
| DRAWTFMident of ()
//
| DRAWTFMcompose of (drawtfm, drawtfm)
//
| DRAWTFMextmcall of
  (
    string(*fmod*), drawenv(*env*), drawarglst(*args*)
  ) (* DRAWTFMextmcall *)
//
where drawobjlst = List0(drawobj)

(* ****** ****** *)
//
extern
fun
drawenv_nil(): drawenv
and
drawenv_sing
  (l: label, x: drawexp): drawenv
//
(* ****** ****** *)
//
extern
fun
drawenv_is_nil(drawenv): bool
and
drawenv_is_cons(drawenv): bool
//
(* ****** ****** *)

(* end of [mydraw2.dats] *)
