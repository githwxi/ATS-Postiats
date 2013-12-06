(*
** For staloading ATSLIB/libats/ML
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// AuthorEmail: gmhwxiATgmailCOM
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
staload "libats/ML/SATS/list0.sats"
//
staload "libats/ML/SATS/option0.sats"
//
staload "libats/ML/SATS/array0.sats"
//
staload "libats/ML/SATS/string.sats"
staload "libats/ML/SATS/strarr.sats"
//
staload "libats/ML/SATS/filebas.sats"
//
staload "libats/ML/SATS/stdlib.sats"
//
(* ****** ****** *)

staload _(*anon*) = "libats/ML/DATS/list0.dats"
staload _(*anon*) = "libats/ML/DATS/option0.dats"
staload _(*anon*) = "libats/ML/DATS/array0.dats"
staload _(*anon*) = "libats/ML/DATS/string.dats"
staload _(*anon*) = "libats/ML/DATS/strarr.dats"
staload _(*anon*) = "libats/ML/DATS/filebas.dats"
staload _(*anon*) = "libats/ML/DATS/stdlib.dats"

(* ****** ****** *)

(* end of [atslib_staload_libats_ML.hats] *)
