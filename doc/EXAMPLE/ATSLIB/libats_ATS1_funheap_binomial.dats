(*
** for testing
** [libats/ATS1/funheap_binomial]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: January, 2014
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ATS1/SATS/funheap_binomial.sats"
staload _(*anon*) = "libats/ATS1/DATS/funheap_binomial.dats"

(* ****** ****** *)

val () =
{
//
var hp0 = funheap_make_nil{int}()
val-(0) = sz2i(funheap_size(hp0))
//
val cmp = lam (x:int, y:int): int =<cloref> compare (x, y)
//
val ((*void*)) = funheap_insert (hp0, 9, cmp)
val ((*void*)) = funheap_insert (hp0, 5, cmp)
val ((*void*)) = funheap_insert (hp0, 7, cmp)
val ((*void*)) = funheap_insert (hp0, 2, cmp)
val ((*void*)) = funheap_insert (hp0, 8, cmp)
val ((*void*)) = funheap_insert (hp0, 1, cmp)
val ((*void*)) = funheap_insert (hp0, 6, cmp)
val ((*void*)) = funheap_insert (hp0, 3, cmp)
val ((*void*)) = funheap_insert (hp0, 4, cmp)
//
val-(9) = sz2i(funheap_size(hp0))
//
val-~Some_vt(1) = funheap_delmin_opt (hp0, cmp)
val-~Some_vt(2) = funheap_delmin_opt (hp0, cmp)
val-~Some_vt(3) = funheap_delmin_opt (hp0, cmp)
val-~Some_vt(4) = funheap_delmin_opt (hp0, cmp)
//
val-(5) = sz2i(funheap_size(hp0))
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ATS1_funheap_binomial.dats] *)
