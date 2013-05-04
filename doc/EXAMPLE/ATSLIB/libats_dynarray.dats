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
val () = println! ("A[0] = ", A[0sz])
val () = println! ("A->sz = ", dynarray_get_size (A))
val () = println! ("A->cap = ", dynarray_get_capacity (A))
//
val ans1 = dynarray_insert_at_opt (A, 1sz, 1)
val-~None_vt () = ans1
val () = println! ("A[1] = ", A[1sz])
val () = println! ("A->sz = ", dynarray_get_size (A))
val () = println! ("A->cap = ", dynarray_get_capacity (A))
//
val ans2 = dynarray_insert_at_opt (A, 2sz, 2)
val-~None_vt () = ans2
val () = println! ("A[2] = ", A[2sz])
val () = println! ("A->sz = ", dynarray_get_size (A))
val () = println! ("A->cap = ", dynarray_get_capacity (A))
//
val-~Some_vt(x) = dynarray_takeout_atbeg_opt (A)
val () = println! ("takeout(beg) = ", x)
val-~Some_vt(x) = dynarray_takeout_atend_opt (A)
val () = println! ("takeout(end) = ", x)
val () = println! ("A->sz = ", dynarray_get_size (A))
//
val () = dynarray_free (A)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_dynarray.dats] *)
