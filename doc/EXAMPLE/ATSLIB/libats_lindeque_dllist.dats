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
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/SATS/dllist.sats"
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
var DQ = lindeque_nil {T} ()
//
val () = lindeque_insert_atbeg (DQ, 0)
val () = lindeque_insert_atbeg (DQ, 1)
val () = lindeque_insert_atbeg (DQ, 2)
val () = lindeque_insert_atbeg (DQ, 3)
val () = lindeque_insert_atbeg (DQ, 4)
//
val () = assertloc (lindeque_length (DQ) = 5)
//
val () = println! ("DQ[beg] = ", lindeque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", lindeque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", lindeque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", lindeque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", lindeque_takeout_atbeg (DQ))
//
val () = assertloc (lindeque_is_nil (DQ))
//
val () = lindeque_insert_atbeg (DQ, 0)
val () = lindeque_insert_atbeg (DQ, 1)
val () = lindeque_insert_atbeg (DQ, 2)
val () = lindeque_insert_atbeg (DQ, 3)
val () = lindeque_insert_atbeg (DQ, 4)
//
val () = assertloc (lindeque_length (DQ) = 5)
//
val () = println! ("DQ[end] = ", lindeque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", lindeque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", lindeque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", lindeque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", lindeque_takeout_atend (DQ))
//
val () = assertloc (lindeque_is_nil (DQ))
//
prval () = lindeque_free_nil (DQ)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
var DQ = lindeque_nil {T} ()
//
val () = lindeque_insert_atend (DQ, 0)
val () = lindeque_insert_atend (DQ, 1)
val () = lindeque_insert_atend (DQ, 2)
val () = lindeque_insert_atend (DQ, 3)
val () = lindeque_insert_atend (DQ, 4)
//
val () = assertloc (lindeque_length (DQ) = 5)
//
val () = println! ("DQ[beg] = ", lindeque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", lindeque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", lindeque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", lindeque_takeout_atbeg (DQ))
val () = println! ("DQ[beg] = ", lindeque_takeout_atbeg (DQ))
//
val () = assertloc (lindeque_is_nil (DQ))
//
val () = lindeque_insert_atend (DQ, 0)
val () = lindeque_insert_atend (DQ, 1)
val () = lindeque_insert_atend (DQ, 2)
val () = lindeque_insert_atend (DQ, 3)
val () = lindeque_insert_atend (DQ, 4)
//
val () = assertloc (lindeque_length (DQ) = 5)
//
val () = println! ("DQ[end] = ", lindeque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", lindeque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", lindeque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", lindeque_takeout_atend (DQ))
val () = println! ("DQ[end] = ", lindeque_takeout_atend (DQ))
//
val () = assertloc (lindeque_is_nil (DQ))
//
prval () = lindeque_free_nil (DQ)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
var DQ = lindeque_nil {T} ()
//
val () = lindeque_insert_atend (DQ, 0)
val () = lindeque_insert_atend (DQ, 1)
val () = lindeque_insert_atend (DQ, 2)
val () = lindeque_insert_atend (DQ, 3)
val () = lindeque_insert_atend (DQ, 4)
//
val xs = lindeque2dllist (DQ)
//
val out = stdout_ref
val () = fprint_dllist (out, xs)
val () = fprint_newline (out)
//
val () = dllist_free<T> (xs)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_lindeque_dllist.dats] *)
