(*
** Bug in handling
** implementation of a value
*)
(*
** Source: reported by Hongwei Xi
*)

(* ****** ****** *)

(*
** Status: Fixed by HX-2013-11-06
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern val x0 : int

(* ****** ****** *)

implement x0 = 1 + 2

(* ****** ****** *)

implement main0 () = println! ("x0 = ", x0)

(* ****** ****** *)

(* end of [bug-2013-11-06.dats] *)
