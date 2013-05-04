(*
** for testing [libats/dynarray]
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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/dynarray.sats"
staload
_(*anon*) = "libats/DATS/dynarray.dats"

(* ****** ****** *)

postfix sz
macdef sz (x) = g1int2uint_int_size (,(x))

(* ****** ****** *)

val () =
{
//
typedef T = int
//
(*
implement
dynarray$recapacitize<> () = 0
*)
//
val A = dynarray_make_nil<T> (g1i2u(1))
//
val ans0 = dynarray_insert_at_opt (A, 0sz, 0)
val-~None_vt () = ans0
val ans1 = dynarray_insert_at_opt (A, 1sz, 1)
val-~None_vt () = ans1
//
val () = println! ("A[0] = ", A[0sz])
val () = println! ("A->cap = ", dynarray_get_capacity (A))
val () = println! ("A[1] = ", A[1sz])
val () = println! ("A->cap = ", dynarray_get_capacity (A))
//
val () = dynarray_free (A)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_dynarray.dats] *)
