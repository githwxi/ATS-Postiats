(*
** for testing [libats/funralist_nested]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: June, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
"libats/SATS/funralist_nested.sats"
staload
_(*anon*) = "libats/DATS/funralist_nested.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
//
typedef T = int
//
val out = stdout_ref
//
val xs = $list{int}(0, 1, 2, 3, 4)
val RL = funralist_make_list<T> (xs)
val () = assertloc (funralist_length (RL) = length (xs))
val () = fprintln! (out, "RL = ", RL)
//
val () = assertloc (2 = RL[2])
//
val RL = funralist_set_at (RL, 2, ~2)
val () = assertloc (2 = ~RL[2])
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_funralist_nested.dats] *)
