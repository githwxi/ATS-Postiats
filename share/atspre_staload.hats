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
#define
PATSPRE_targetloc "$PATSHOME/prelude"
//
(* ****** ****** *)
//
staload _ = "{$PATSPRE}/DATS/basics.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSPRE}/DATS/integer.dats"
staload _ = "{$PATSPRE}/DATS/pointer.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSPRE}/DATS/integer_long.dats"
staload _ = "{$PATSPRE}/DATS/integer_size.dats"
staload _ = "{$PATSPRE}/DATS/integer_short.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSPRE}/DATS/char.dats"
//
staload _ = "{$PATSPRE}/DATS/bool.dats"
//
staload _ = "{$PATSPRE}/DATS/float.dats"
//
staload _ = "{$PATSPRE}/DATS/string.dats"
staload _ = "{$PATSPRE}/DATS/strptr.dats"
//
staload _ = "{$PATSPRE}/DATS/integer_ptr.dats"
staload _ = "{$PATSPRE}/DATS/integer_fixed.dats"
//
(* ****** ****** *)

staload _ = "{$PATSPRE}/DATS/tuple.dats"

(* ****** ****** *)

staload _ = "{$PATSPRE}/DATS/memory.dats"
staload _ = "{$PATSPRE}/DATS/reference.dats"

(* ****** ****** *)

staload _ = "{$PATSPRE}/DATS/filebas.dats"
staload _ = "{$PATSPRE}/DATS/intrange.dats"

(* ****** ****** *)

staload _ = "{$PATSPRE}/DATS/gorder.dats"
staload _ = "{$PATSPRE}/DATS/gnumber.dats"
staload _ = "{$PATSPRE}/DATS/grandom.dats"

(* ****** ****** *)
//
staload _ = "{$PATSPRE}/DATS/list.dats"
staload _ = "{$PATSPRE}/DATS/list_vt.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSPRE}/DATS/option.dats"
staload _ = "{$PATSPRE}/DATS/option_vt.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSPRE}/DATS/array.dats"
staload _ = "{$PATSPRE}/DATS/arrayptr.dats"
staload _ = "{$PATSPRE}/DATS/arrayref.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSPRE}/DATS/matrix.dats"
staload _ = "{$PATSPRE}/DATS/matrixptr.dats"
staload _ = "{$PATSPRE}/DATS/matrixref.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSPRE}/DATS/stream.dats"
staload _ = "{$PATSPRE}/DATS/stream_vt.dats"
//
(* ****** ****** *)
//
staload _ = "{$PATSPRE}/DATS/gprint.dats"
//
staload _ = "{$PATSPRE}/DATS/tostring.dats"
//
(* ****** ****** *)
//
staload UNSAFE = "{$PATSPRE}/SATS/unsafe.sats"
//
staload _(*UNSAFE*) = "{$PATSPRE}/DATS/unsafe.dats"
//
(* ****** ****** *)

staload _(*CHECKAST*) = "{$PATSPRE}/DATS/checkast.dats"

(* ****** ****** *)

#endif // end of [#ifndef SHARE_ATSPRE_STALOAD]

(* ****** ****** *)

(* end of [atspre_staload.hats] *)
