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
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

#staload "libats/SATS/funarray.sats"

(* ****** ****** *)
//
#staload
_(*anon*) =
"libats/DATS/qlist.dats"
#staload
_(*anon*) =
"libats/DATS/funarray_braunt.dats"
//
(* ****** ****** *)
//
var A0 = farray_nil{int}()
val () = farray_insert_l(A0, 0)
val () = farray_insert_r(A0, 1, 1)
val () = farray_insert_r(A0, 2, 2)
val () = farray_insert_r(A0, 3, 3)
val () = fprintln! (stdout_ref, "A0 = ", A0)
//
(* ****** ****** *)
//
val-~None_vt() = getopt_at(A0, 4)
//
val-(true) = setopt_at(A0, 1, 10)
val-~Some_vt(10) = getopt_at(A0, 1)
val-(true) = setopt_at(A0, 2, 20)
val-~Some_vt(20) = getopt_at(A0, 2)
val-(true) = setopt_at(A0, 3, 30)
val-~Some_vt(30) = getopt_at(A0, 3)
//
val () = fprintln! (stdout_ref, "A0 = ", A0)
//
(* ****** ****** *)
//
var A1 =
farray_make_list<int>
(list_vt2t(list_make_intrange(0, 10)))
val () = fprintln! (stdout_ref, "A1 = ", A1)
//
(* ****** ****** *)

val () = println! ("size(A1) = ", size(A1))

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_funarray_braunt.dats] *)
