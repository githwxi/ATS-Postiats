(*
** for testing [libats/funset_listord]
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

staload "libats/ATS1/SATS/funset_listord.sats"
staload _ = "libats/ATS1/DATS/funset_listord.dats"

(* ****** ****** *)

val () =
{
//
val
cmp = lam (x:int, y:int): int =<cloref> compare(x, y)
//
val xs = $list{int}(1, 2, 2, 3, 3)
//
val xs = funset_make_list (xs, cmp)
val xs2 = funset2list (xs)
val () = fprintln! (stdout_ref, "xs2 = ", xs2)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ATS1_funset_listord.dats] *)
