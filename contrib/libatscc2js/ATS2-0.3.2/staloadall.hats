(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)
//
// HX-2014-09-09
//
(* ****** ****** *)
//
#staload "./basics_js.sats"
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
#staload "./SATS/gvalue.sats"
//
(* ****** ****** *)
//
#staload "./SATS/gprint.sats"
#staload _ = "./DATS/gprint.dats"
//
(* ****** ****** *)
//
#staload "./SATS/list.sats"
#staload _ = "./DATS/list.dats"
//
#staload "./SATS/list_vt.sats"
#staload _ = "./DATS/list_vt.dats"
//
(* ****** ****** *)
//
#staload "./SATS/option.sats"
#staload _ = "./DATS/option.dats"
//
(* ****** ****** *)
//
#staload "./SATS/stream.sats"
#staload _ = "./DATS/stream.dats"
//
#staload "./SATS/stream_vt.sats"
#staload _ = "./DATS/stream_vt.dats"
//
(* ****** ****** *)
//
#staload "./SATS/intrange.sats"
#staload "./SATS/arrayref.sats"
#staload "./SATS/matrixref.sats"
#staload "./SATS/reference.sats"
//
(* ****** ****** *)
//
#staload
"./SATS/JSmath.sats" // JSlib
#staload
_(*anon*) = "./DATS/JSmath.dats" // JSlib
//
(* ****** ****** *)

#staload "./SATS/JSdate.sats" // JS library
#staload "./SATS/JSarray.sats" // JS library
#staload "./SATS/JSglobal.sats" // JS library
//
(* ****** ****** *)

#staload "./SATS/slistref.sats" // list-based stack
#staload "./SATS/qlistref.sats" // list-based queue

(* ****** ****** *)
//
#staload
"./SATS/ML/list0.sats" // un-indexed list
#staload
"./SATS/ML/array0.sats" // un-indexed array
#staload
"./SATS/ML/option0.sats" // un-indexed option
#staload
"./SATS/ML/matrix0.sats" // un-indexed matrix
//
#staload
_(*anon*) = "./DATS/ML/list0.dats" // un-indexed list
#staload
_(*anon*) = "./DATS/ML/array0.dats" // un-indexed array
#staload
_(*anon*) = "./DATS/ML/option0.dats" // un-indexed option
#staload
_(*anon*) = "./DATS/ML/matrix0.dats" // un-indexed matrix
//
(* ****** ****** *)

(* end of [staloadall.hats] *)
