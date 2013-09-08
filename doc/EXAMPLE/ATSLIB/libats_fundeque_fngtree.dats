(*
** for testing [libats/fundeque_fngtree]
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
"libats/SATS/fundeque_fngtree.sats"
staload
_(*anon*) = "libats/DATS/fundeque_fngtree.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val out = stdout_ref
//
val DQ0 = fundeque_nil{T}()
val DQ1 = fundeque_cons (1, DQ0)
val DQ2 = fundeque_snoc (DQ1, 2)
val () = assertloc (fundeque_size (DQ2) = 2)
//
val DQ4 = fundeque_append (DQ2, DQ2)
val () = assertloc (fundeque_size (DQ4) = 4)
//
val DQ6 = fundeque_append (DQ2, DQ4)
val () = assertloc (fundeque_size (DQ6) = 6)
//
val DQ8 = fundeque_append (DQ6, DQ2)
val () = assertloc (fundeque_size (DQ8) = 8)
//
val () = assertloc (fundeque_get_atbeg (DQ8) = 1)
val () = assertloc (fundeque_get_atend (DQ8) = 2)
//
val () = fprintln! (out, "DQ8 = ", DQ8)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_fundeque_fngtree.dats] *)
