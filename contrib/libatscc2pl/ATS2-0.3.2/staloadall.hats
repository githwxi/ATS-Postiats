(*
** For writing ATS code
** that translates into Perl
*)

(* ****** ****** *)
//
// HX-2014-09-09
//
(* ****** ****** *)
//
staload "./basics_pl.sats"
//
(* ****** ****** *)
//
staload "./SATS/integer.sats"
//
(* ****** ****** *)
//
staload "./SATS/bool.sats"
staload "./SATS/float.sats"
staload "./SATS/string.sats"
//
(* ****** ****** *)
//
staload "./SATS/print.sats"
staload _ = "./DATS/print.dats"
//
(* ****** ****** *)
//
staload "./SATS/filebas.sats"
//
(* ****** ****** *)

staload "./SATS/PLarray.sats"

(* ****** ****** *)
//
staload "./SATS/list.sats"
staload _ = "./DATS/list.dats"
//
(* ****** ****** *)
//
staload "./SATS/option.sats"
staload _ = "./DATS/option.dats"
//
(* ****** ****** *)
//
staload "./SATS/stream.sats"
staload "./SATS/stream_vt.sats"
//
staload _ = "./DATS/stream.dats"
staload _ = "./DATS/stream_vt.dats"
//
(* ****** ****** *)
//
staload "./SATS/intrange.sats"
(*
staload _(*anon*) = "./DATS/intrange.dats"
*)
//
(* ****** ****** *)

staload "./SATS/reference.sats"

(* ****** ****** *)
//
// HX: one-list-based
// HX: two-list-based
//
staload "./SATS/slistref.sats"
staload "./SATS/qlistref.sats"
//
(* ****** ****** *)
//
// HX: un-indexed list
//
staload "./SATS/ML/list0.sats"
staload _(*anon*) = "./DATS/ML/list0.dats"
//
(* ****** ****** *)

(* end of [staloadall.hats] *)
