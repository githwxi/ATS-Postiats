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
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/dynarray.sats"
staload _(*anon*) = "libats/DATS/dynarray.dats"

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
val DA = dynarray_make_nil<T> (g1i2u(1))
//
val ans0 = dynarray_insert_at_opt (DA, 0sz, 0)
val-~None_vt () = ans0
val () = println! ("DA[0] = ", DA[0sz])
val () = println! ("DA->sz = ", dynarray_get_size (DA))
val () = println! ("DA->cap = ", dynarray_get_capacity (DA))
//
val ans1 = dynarray_insert_at_opt (DA, 1sz, 1)
val-~None_vt () = ans1
val () = println! ("DA[1] = ", DA[1sz])
val () = println! ("DA->sz = ", dynarray_get_size (DA))
val () = println! ("DA->cap = ", dynarray_get_capacity (DA))
//
val ans2 = dynarray_insert_at_opt (DA, 2sz, 2)
val-~None_vt () = ans2
val () = println! ("DA[2] = ", DA[2sz])
val () = println! ("DA->sz = ", dynarray_get_size (DA))
val () = println! ("DA->cap = ", dynarray_get_capacity (DA))
//
val ans3 = dynarray_insert_at_opt (DA, 3sz, 3)
val-~None_vt () = ans3
val () = println! ("DA[3] = ", DA[3sz])
val () = println! ("DA->sz = ", dynarray_get_size (DA))
val () = println! ("DA->cap = ", dynarray_get_capacity (DA))
//
val () = dynarray_insert_at_exn (DA, 4sz, 4)
val () = println! ("DA[4] = ", DA[4sz])
val () = println! ("DA->sz = ", dynarray_get_size (DA))
val () = println! ("DA->cap = ", dynarray_get_capacity (DA))
//
val out = stdout_ref
val () = fprint_dynarray (out, DA)
val () = fprint_newline (out)
//
val x = dynarray_takeout_at_exn (DA, 0sz)
val () = println! ("takeout(0) = ", x)
val x = dynarray_takeout_atbeg_exn (DA)
val () = println! ("takeout(beg) = ", x)
val-~Some_vt(x) = dynarray_takeout_atend_opt (DA)
val () = println! ("takeout(end) = ", x)
val () = println! ("DA->sz = ", dynarray_get_size (DA))
//
val () = dynarray_free (DA)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_dynarray.dats] *)
