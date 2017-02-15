(*
** For writing ATS code
** that translates into Pythod
*)

(* ****** ****** *)
//
// HX-2014-09-09
//
(* ****** ****** *)
//
#staload "./basics_py.sats"
#staload _ = "./DATS/basics.dats"
//
(* ****** ****** *)
//
#staload "./SATS/integer.sats"
//
(* ****** ****** *)
//
#staload "./SATS/bool.sats"
#staload "./SATS/char.sats"
#staload "./SATS/float.sats"
#staload "./SATS/string.sats"
//
(* ****** ****** *)
//
#staload "./SATS/print.sats"
#staload "./SATS/filebas.sats"
//
#staload _ = "./DATS/print.dats"
//
(* ****** ****** *)

#staload "./SATS/gprint.sats"
#staload _ = "./DATS/gprint.dats"

(* ****** ****** *)
//
#staload "./SATS/list.sats"
#staload _ = "./DATS/list.dats"
//
#staload "./SATS/PYlist.sats"
#staload _ = "./DATS/PYlist.dats"
//
(* ****** ****** *)
//
#staload "./SATS/stream.sats"
#staload _ = "./DATS/stream.dats"
//
(* ****** ****** *)
//
#staload "./SATS/stream_vt.sats"
#staload _ = "./DATS/stream_vt.dats"
//
(* ****** ****** *)
//
#staload "./SATS/intrange.sats"
//
(* ****** ****** *)
//
#staload "./SATS/arrayref.sats"
#staload "./SATS/matrixref.sats"
#staload "./SATS/reference.sats"
//
(* ****** ****** *)
//
#staload "./SATS/slistref.sats"
#staload "./SATS/qlistref.sats"
//
(* ****** ****** *)
//
// HX: un-indexed list
// HX: un-indexed array
//
#staload "./SATS/ML/list0.sats"
#staload "./SATS/ML/array0.sats"
//
#staload _ = "./DATS/ML/list0.dats"
#staload _ = "./DATS/ML/array0.dats"
//
(* ****** ****** *)

(* end of [staloadall.hats] *)

