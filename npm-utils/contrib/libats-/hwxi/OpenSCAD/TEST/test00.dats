(* ****** ****** *)
(*
** Testing the setup in ATS
** for OpenSCADE meta-programming
** 
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload
"libats/libc/SATS/math.sats"
#staload _ =
"libats/libc/DATS/math.dats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
//
#staload $OpenSCAD // opening it!
//
#include "./../mylibies_link.hats"
//
(* ****** ****** *)

implement
main0() = println! ("Hello from [test00]!")

(* ****** ****** *)

(* end of [test00.dats] *)
