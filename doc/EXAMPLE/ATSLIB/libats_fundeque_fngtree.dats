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
//
staload
"libats/SATS/fundeque_fngtree.sats"
staload
_(*anon*) =
"libats/DATS/fundeque_fngtree.dats"
//
(* ****** ****** *)

val () =
{
//
typedef T = int
//
val out = stdout_ref
//
val Q0 = fundeque_nil{T}()
val Q1 = fundeque_cons(1, Q0)
val Q2 = fundeque_snoc(Q1, 2)
val () = assertloc(fundeque_size(Q2) = 2)
//
val Q4 = fundeque_append(Q2, Q2)
val () = assertloc(fundeque_size(Q4) = 4)
//
val Q6 = fundeque_append(Q2, Q4)
val () = assertloc(fundeque_size(Q6) = 6)
//
val Q8 = fundeque_append(Q6, Q2)
val () = assertloc(fundeque_size(Q8) = 8)
//
val () = assertloc(fundeque_get_atbeg(Q8) = 1)
val () = assertloc(fundeque_get_atend(Q8) = 2)
//
val ((*void*)) = fprintln! (out, "Q8 = ", Q8)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_fundeque_fngtree.dats] *)
