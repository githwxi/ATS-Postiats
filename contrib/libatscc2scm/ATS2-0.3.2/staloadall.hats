(*
** For writing ATS code
** that translates into Scheme
*)

(* ****** ****** *)
//
// HX-2014-07
//
(* ****** ****** *)
//
staload "./basics_scm.sats"
//
(* ****** ****** *)
//
staload "./SATS/integer.sats"
//
(* ****** ****** *)
//
staload "./SATS/bool.sats"
staload "./SATS/float.sats"
//
(* ****** ****** *)
//
staload "./SATS/print.sats"
staload "./SATS/filebas.sats"
//
staload _(*anon*) = "./DATS/print.dats"
//
(* ****** ****** *)
//
staload "./SATS/list.sats"
//
(* ****** ****** *)
//
staload "./SATS/stream.sats"
staload "./SATS/stream_vt.sats"
//
(* ****** ****** *)
//
staload "./SATS/reference.sats"
//
(* ****** ****** *)
//
staload _(*anon*) = "./DATS/list.dats"
//
staload _(*anon*) = "./DATS/stream.dats"
staload _(*anon*) = "./DATS/stream_vt.dats"
//
(* ****** ****** *)
//
staload "./SATS/intrange.sats"
(*
staload _(*anon*) = "./DATS/intrange.dats"
*)
//
(* ****** ****** *)
//
// HX-2016:
// one-list-based stack
// two-list-based queue
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
