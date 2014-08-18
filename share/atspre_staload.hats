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
//
#define PATSHOME_targetloc "$PATSHOME"
//
(* ****** ****** *)
//
staload _ =
  "{$PATSHOME}/prelude/DATS/basics.dats"
//
(* ****** ****** *)
//
staload _ =
  "{$PATSHOME}/prelude/DATS/pointer.dats"
//
(* ****** ****** *)
//
staload _ =
  "{$PATSHOME}/prelude/DATS/integer.dats"
staload _ =
  "{$PATSHOME}/prelude/DATS/integer_fixed.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSHOME}/prelude/DATS/char.dats"
staload _ = "{$PATSHOME}/prelude/DATS/bool.dats"
staload _ = "{$PATSHOME}/prelude/DATS/float.dats"
//
(* ****** ****** *)

staload _ = "{$PATSHOME}/prelude/DATS/tuple.dats"

(* ****** ****** *)

staload _ = "{$PATSHOME}/prelude/DATS/memory.dats"

(* ****** ****** *)

staload _ = "{$PATSHOME}/prelude/DATS/string.dats"
staload _ = "{$PATSHOME}/prelude/DATS/strptr.dats"

(* ****** ****** *)

staload _ = "{$PATSHOME}/prelude/DATS/reference.dats"

(* ****** ****** *)

staload _ = "{$PATSHOME}/prelude/DATS/filebas.dats"
staload _ = "{$PATSHOME}/prelude/DATS/intrange.dats"

(* ****** ****** *)

staload _ = "{$PATSHOME}/prelude/DATS/gorder.dats"
staload _ = "{$PATSHOME}/prelude/DATS/gnumber.dats"

(* ****** ****** *)
//
staload _ = "{$PATSHOME}/prelude/DATS/list.dats"
//
staload _ = "{$PATSHOME}/prelude/DATS/list_vt.dats"
staload _ = "{$PATSHOME}/prelude/DATS/list_vt_mergesort.dats"
staload _ = "{$PATSHOME}/prelude/DATS/list_vt_quicksort.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSHOME}/prelude/DATS/option.dats"
staload _ = "{$PATSHOME}/prelude/DATS/option_vt.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSHOME}/prelude/DATS/array.dats"
staload _ = "{$PATSHOME}/prelude/DATS/array_bsearch.dats"
staload _ = "{$PATSHOME}/prelude/DATS/array_quicksort.dats"
//
staload _ = "{$PATSHOME}/prelude/DATS/arrayptr.dats"
staload _ = "{$PATSHOME}/prelude/DATS/arrayref.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSHOME}/prelude/DATS/matrix.dats"
staload _ = "{$PATSHOME}/prelude/DATS/matrixptr.dats"
staload _ = "{$PATSHOME}/prelude/DATS/matrixref.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSHOME}/prelude/DATS/stream.dats"
staload _ = "{$PATSHOME}/prelude/DATS/stream_vt.dats"
//
(* ****** ****** *)

staload _ = "{$PATSHOME}/prelude/DATS/gprint.dats"

(* ****** ****** *)
//
staload UNSAFE = "{$PATSHOME}/prelude/SATS/unsafe.sats"
//
staload _(*UNSAFE*) = "{$PATSHOME}/prelude/DATS/unsafe.dats"
//
(* ****** ****** *)

staload _(*CHECKAST*) = "{$PATSHOME}/prelude/DATS/checkast.dats"

(* ****** ****** *)

#endif // end of [#ifndef SHARE_ATSPRE_STALOAD]

(* ****** ****** *)

(* end of [atspre_staload.hats] *)
