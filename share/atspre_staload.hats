(*
** This is mostly for staloading
** template code in ATSLIB/prelude
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// AuthorEmail: gmhwxiATgmailCOM
//
(* ****** ****** *)

#ifndef SHARE_ATSPRE_STALOAD
#define SHARE_ATSPRE_STALOAD 1

(* ****** ****** *)

staload _ = "prelude/DATS/basics.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/pointer.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/integer.dats"
staload _ = "prelude/DATS/integer_fixed.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/char.dats"
staload _ = "prelude/DATS/bool.dats"
staload _ = "prelude/DATS/float.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/tuple.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/memory.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/string.dats"
staload _ = "prelude/DATS/strptr.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/filebas.dats"
staload _ = "prelude/DATS/intrange.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/gorder.dats"
staload _ = "prelude/DATS/gnumber.dats"

(* ****** ****** *)
//
staload _ = "prelude/DATS/list.dats"
//
staload _ = "prelude/DATS/list_vt.dats"
staload _ = "prelude/DATS/list_vt_mergesort.dats"
staload _ = "prelude/DATS/list_vt_quicksort.dats"
//
(* ****** ****** *)
//
staload _ = "prelude/DATS/option.dats"
staload _ = "prelude/DATS/option_vt.dats"
//
(* ****** ****** *)
//
staload _ = "prelude/DATS/array.dats"
staload _ = "prelude/DATS/array_bsearch.dats"
staload _ = "prelude/DATS/array_quicksort.dats"
//
staload _ = "prelude/DATS/arrayptr.dats"
staload _ = "prelude/DATS/arrayref.dats"
//
(* ****** ****** *)
//
staload _ = "prelude/DATS/matrix.dats"
staload _ = "prelude/DATS/matrixptr.dats"
staload _ = "prelude/DATS/matrixref.dats"
//
(* ****** ****** *)
//
staload _ = "prelude/DATS/stream.dats"
staload _ = "prelude/DATS/stream_vt.dats"
//
(* ****** ****** *)

staload _ = "prelude/DATS/gprint.dats"

(* ****** ****** *)
//
staload UNSAFE = "prelude/SATS/unsafe.sats"
//
staload _(*UNSAFE*) = "prelude/DATS/unsafe.dats"
//
(* ****** ****** *)

staload _(*CHECKAST*) = "prelude/DATS/checkast.dats"

(* ****** ****** *)

#endif // end of [#ifndef SHARE_ATSPRE_STALOAD]

(* ****** ****** *)

(* end of [atspre_staload.hats] *)
