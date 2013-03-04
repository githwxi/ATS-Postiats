(*
** for testing [prelude/string]
*)

(* ****** ****** *)

staload "prelude/DATS/basics.dats"

staload "prelude/DATS/integer.dats"
staload "prelude/DATS/pointer.dats"

staload "prelude/DATS/char.dats"

staload "prelude/DATS/string.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/string0.sats"

(* ****** ****** *)

val alphabet0 = (string0)"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_string0.dats] *)
