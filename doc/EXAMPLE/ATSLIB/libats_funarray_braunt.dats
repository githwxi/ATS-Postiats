(*
** for testing [libats/funset_avltree]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: March, 2016
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/funarray.sats"

(* ****** ****** *)

staload _(*anon*) = "libats/DATS/qlist.dats"
staload _(*anon*) = "libats/DATS/funarray_braunt.dats"

(* ****** ****** *)

var A = funarray_nil{int}()
val () = funarray_insert_l(A, 0)
val () = funarray_insert_r(A, 1, 1)
val () = funarray_insert_r(A, 2, 2)
val () = funarray_insert_r(A, 3, 3)
val () = fprintln! (stdout_ref, "A = ", A)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_funarray_braunt.dats] *)
