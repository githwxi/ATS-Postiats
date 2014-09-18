(*
** for testing [libats/ML/filebas]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/intrange.sats"
staload _ = "libats/ML/DATS/intrange.dats"

(* ****** ****** *)
//
val ((*void*)) =
  repeat(5, $delay(print"Hello!\n"))
val ((*void*)) =
  repeat(5, lam () =<cloref1> print"Hello!\n")
val ((*void*)) =
  foreach (5, lam(i:int) =<cloref1> print!(i, ": Hello!\n"))
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_intrange.dats] *)
