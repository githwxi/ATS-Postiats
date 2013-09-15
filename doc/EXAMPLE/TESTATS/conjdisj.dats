//
// conjunctions and disjunctions
//
// Author: Hongwei Xi (March 2013)
// Authoremail: gmhwxiATgmailDOTcom
//

(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

val () = assertloc (0 <= 1 && 1 <= 2 && 2 <= 3)
val () = assertloc (not(0 >= 1 || 1 >= 2 || 2 >= 3))

(* ****** ****** *)

val () = assertloc (0 <= 1 andalso 1 <= 2 andalso 2 <= 3)
val () = assertloc (not(0 >= 1 orelse 1 >= 2 orelse 2 >= 3))

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [conjdisj.dats] *)
