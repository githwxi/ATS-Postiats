(*
** for testing [libats/sllist]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: March, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload _ = "libats/DATS/gnode.dats"
staload _ = "libats/DATS/sllist.dats"

(* ****** ****** *)

staload "libats/SATS/sllist.sats"

(* ****** ****** *)

#define :: sllist_cons
#define cons sllist_cons

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val out = stdout_ref
//
val xs1 = sllist_nil{T}()
val xs1 = 1 :: 2 :: xs1
val xs2 = sllist_nil{T}()
val xs2 = 3 :: 4 :: 5 :: xs2
//
val xs = sllist_append (xs1, xs2)
//
val () = assertloc (1 = xs[0])
val () = assertloc (2 = xs[1])
val () = assertloc (3 = xs[2])
val () = assertloc (4 = xs[3])
val () = assertloc (5 = xs[4])
//
val () = fprintln! (out, xs)
val () = assertloc (sllist_length (xs) = 5)
//
val rxs = sllist_reverse (xs)
//
val () = fprintln! (out, rxs)
val () = assertloc (sllist_length (rxs) = 5)
//
val () = sllist_free (rxs)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val out = stdout_ref
//
val xs = sllist_nil{T}()
val xs = 1 :: 2 ::  3 :: 4 :: 5 :: xs
val () = fprintln! (out, "xs = ", xs)
//
implement
sllist_map$fwork<T><T> (x) = 2 * x - 1
val ys = sllist_map<T><T> (xs)
val () = fprintln! (out, "ys = ", ys)
//
val () = sllist_free (xs)
val () = sllist_free (ys)
//
}
(* ****** ****** *)

val () =
{
//
typedef T = int
//
val out = stdout_ref
//
val xs = sllist_nil{T}()
val xs = sllist_insert_at (xs, 0, 0)
val xs = sllist_insert_at (xs, 1, 1)
val xs = sllist_insert_at (xs, 2, 2)
val xs = sllist_insert_at (xs, 3, 3)
val xs = sllist_insert_at (xs, 4, 4)
//
var xs = xs
val () = assertloc (4 = sllist_takeout_at (xs, 4))
val () = assertloc (3 = sllist_takeout_at (xs, 3))
val () = assertloc (2 = sllist_takeout_at (xs, 2))
val () = assertloc (1 = sllist_takeout_at (xs, 1))
val () = assertloc (0 = sllist_takeout_at (xs, 0))
//
prval () = sllist_free_nil (xs)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_sllist.dats] *)
