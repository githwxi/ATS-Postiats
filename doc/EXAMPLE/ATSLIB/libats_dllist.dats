(*
** for testing [libats/dllist]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: February, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "libats/SATS/dllist.sats"
//
staload _ = "libats/DATS/gnode.dats"
staload _ = "libats/DATS/dllist.dats"
//
(* ****** ****** *)

#define :: dllist_cons
#define cons dllist_cons
#define snoc dllist_snoc

(* ****** ****** *)

val () = {
//
typedef T = int
val out = stdout_ref
//
val xs = dllist_sing<T> (5)
val xs = cons (1, cons (2, cons (3, cons (4, xs))))
//
val () = fprint_dllist (out, xs)
val () = fprint_newline (out)
//
val xs_beg = xs
val p_beg = dllist2ptr (xs_beg)
//
val xs_end = dllist_move_all (xs_beg)
val xs2_beg = rdllist_move_all (xs_end)
val p2_beg = dllist2ptr (xs2_beg)
//
val () = dllist_free (xs2_beg)
//
val () = assertloc (p_beg = p2_beg)
//
} // end of [val]

(* ****** ****** *)

val () = {
//
typedef T = int
val out = stdout_ref
//
val xs = dllist_sing<T> (1)
val xs = snoc (snoc (snoc (snoc (xs, 2), 3), 4), 5)
//
val () = fprint_dllist (out, xs)
val () = fprint_string (out, "->")
val () = fprint_rdllist (out, xs)
val () = fprint_newline (out)
//
val xs_beg = rdllist_move_all (xs)
//
val () = dllist_free (xs_beg)
//
} // end of [val]

(* ****** ****** *)

val () = {
//
typedef T = int
val out = stdout_ref
//
val xs = dllist_sing<T> (1)
val xs = dllist_insert_next (xs, 2)
val xs = dllist_move (xs)
val xs = dllist_insert_next (xs, 3)
val xs = dllist_move (xs)
//
val nr = dllist_length (xs)
val nf = rdllist_length (xs)
val () = assertloc (nf + nr = 3)
//
val xs = rdllist_move_all (xs)
//
val () = fprint_dllist (out, xs)
val () = fprint_newline (out)
//
val () = dllist_free (xs)
//
} // end of [val]

(* ****** ****** *)

val () = {
//
typedef T = string
val out = stdout_ref
//
val xs = dllist_sing<T> ("A")
val xs = dllist_insert_prev (xs, "B")
val xs = dllist_insert_prev (xs, "C")
//
val nr = dllist_length (xs)
val nf = rdllist_length (xs)
val () = assertloc (nf + nr = 3)
//
val () = fprint_dllist (out, xs)
val () = fprint_newline (out)
//
val () = dllist_free (xs)
//
} // end of [val]

(* ****** ****** *)

val () = {
//
typedef T = int
val out = stdout_ref
//
val xs = dllist_nil {T} ()
val xs = 1 :: 2 :: 3 :: xs
//
val xs2 = dllist_nil {T} ()
val xs2 = 4 :: 5 :: 6 :: xs2
//
val xs_xs2 = dllist_append (xs, xs2)
//
val () = fprint_dllist (out, xs_xs2)
val () = fprint_newline (out)
//
val () = dllist_free (xs_xs2)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_dllist.dats] *)
