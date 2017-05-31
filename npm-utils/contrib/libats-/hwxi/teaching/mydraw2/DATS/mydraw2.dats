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

datatype
drawarg =
| DRAWARG of drawexp

and
drawexp =
| DRAWEXPint of (int)
| DRAWEXPbool of (bool)

where
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

(* ****** ****** *)

(* end of [mydraw2.dats] *)
