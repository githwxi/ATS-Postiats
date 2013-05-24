(*
** for testing [libats/lindeque_dllist]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: May, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "libats/SATS/lindeque_dllist.sats"

(* ****** ****** *)

staload _(*anon*) = "libats/DATS/gnode.dats"
staload _(*anon*) = "libats/DATS/dllist.dats"
staload _(*anon*) = "libats/DATS/lindeque_dllist.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
//
var DQ = deque_nil {T} ()
//
val () = deque_insert_atbeg (DQ, 0)
val () = deque_insert_atbeg (DQ, 1)
val () = deque_insert_atbeg (DQ, 2)
val () = deque_insert_atbeg (DQ, 3)
val () = deque_insert_atbeg (DQ, 4)
//
val () = assertloc (deque_length (DQ) = 5)
//
val () = println! ("DQ[beg] = ", deque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", deque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", deque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", deque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", deque_takeout_atbeg (DQ))
//
val () = assertloc (deque_is_nil (DQ))
//
val () = deque_insert_atbeg (DQ, 0)
val () = deque_insert_atbeg (DQ, 1)
val () = deque_insert_atbeg (DQ, 2)
val () = deque_insert_atbeg (DQ, 3)
val () = deque_insert_atbeg (DQ, 4)
//
val () = assertloc (deque_length (DQ) = 5)
//
val () = println! ("DQ[end] = ", deque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", deque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", deque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", deque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", deque_takeout_atend (DQ))
//
val () = assertloc (deque_is_nil (DQ))
//
prval () = deque_free_nil (DQ)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
var DQ = deque_nil {T} ()
//
val () = deque_insert_atend (DQ, 0)
val () = deque_insert_atend (DQ, 1)
val () = deque_insert_atend (DQ, 2)
val () = deque_insert_atend (DQ, 3)
val () = deque_insert_atend (DQ, 4)
//
val () = assertloc (deque_length (DQ) = 5)
//
val () = println! ("DQ[beg] = ", deque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", deque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", deque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", deque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", deque_takeout_atbeg (DQ))
//
val () = assertloc (deque_is_nil (DQ))
//
val () = deque_insert_atend (DQ, 0)
val () = deque_insert_atend (DQ, 1)
val () = deque_insert_atend (DQ, 2)
val () = deque_insert_atend (DQ, 3)
val () = deque_insert_atend (DQ, 4)
//
val () = assertloc (deque_length (DQ) = 5)
//
val () = println! ("DQ[end] = ", deque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", deque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", deque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", deque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", deque_takeout_atend (DQ))
//
val () = assertloc (deque_is_nil (DQ))
//
prval () = deque_free_nil (DQ)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_lindeque_dllist.dats] *)
