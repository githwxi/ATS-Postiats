(*
** for testing [libats/ML/filebas]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"
staload _ = "libats/ML/DATS/list0.dats"

(* ****** ****** *)

staload "libats/ML/SATS/filebas.sats"

(* ****** ****** *)

val () =
{
val out = stdout_ref
val fnames = dirname_get_fnamelst (".")
val () = fprintln! (out, "fnames(.) = ", fnames)
val out = stdout_ref
val fnames = dirname_get_fnamelst ("..")
val () = fprintln! (out, "fnames(..) = ", fnames)
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_filebas.dats] *)
