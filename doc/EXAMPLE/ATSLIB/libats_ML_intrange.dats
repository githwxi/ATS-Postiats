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
val () = (5).repeat($delay(println! ("Hello!")))
//
val () = (5).foreach(lam (i:int) =<cloref1> println! (i, ": Hello!"))
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_intrange.dats] *)
