(*
** For staloading
** some commonly used libc packages
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// AuthorEmail: gmhwxiATgmailCOM
//
(* ****** ****** *)

#ifndef
SHARE_ATSLIB_STALOAD_LIBATS_LIBC
#define
SHARE_ATSLIB_STALOAD_LIBATS_LIBC 1

(* ****** ****** *)
//
#define
PATSLIBATS_targetloc "$PATSHOME/libats"
//
(* ****** ****** *)

staload
ERRNO =
"{$PATSLIBATS}/libc/SATS/errno.sats"
staload
_(*ERRNO*) =
"{$PATSLIBATS}/libc/DATS/errno.dats"

(* ****** ****** *)

staload
DIRENT =
"{$PATSLIBATS}/libc/SATS/dirent.sats"
staload
_(*DIRENT*) =
"{$PATSLIBATS}/libc/DATS/dirent.dats"

(* ****** ****** *)

staload
MATH =
"{$PATSLIBATS}/libc/SATS/math.sats"
staload
_(*MATH*) =
"{$PATSLIBATS}/libc/DATS/math.dats"

(* ****** ****** *)

staload
FLOAT =
"{$PATSLIBATS}/libc/SATS/float.sats"
staload
_(*FLOAT*) =
"{$PATSLIBATS}/libc/DATS/float.dats"

(* ****** ****** *)

staload
SIGNAL =
"{$PATSLIBATS}/libc/SATS/signal.sats"

(* ****** ****** *)

staload
STDDEF =
"{$PATSLIBATS}/libc/SATS/stddef.sats"

(* ****** ****** *)

staload
STDIO =
"{$PATSLIBATS}/libc/SATS/stdio.sats"
staload
_(*STDIO*) =
"{$PATSLIBATS}/libc/DATS/stdio.dats"

(* ****** ****** *)

staload
STDLIB =
"{$PATSLIBATS}/libc/SATS/stdlib.sats"
staload
_(*STDLIB*) =
"{$PATSLIBATS}/libc/DATS/stdlib.dats"

(* ****** ****** *)
//
staload
STRING =
"{$PATSLIBATS}/libc/SATS/string.sats"
staload
_(*STRING*) =
"{$PATSLIBATS}/libc/DATS/string.dats"
//
staload
STRINGS =
"{$PATSLIBATS}/libc/SATS/strings.sats"
staload
_(*STRINGS*) =
"{$PATSLIBATS}/libc/DATS/strings.dats"
//
(* ****** ****** *)
//
staload
TIME =
"{$PATSLIBATS}/libc/SATS/time.sats"
staload
_(*TIME*) =
"{$PATSLIBATS}/libc/DATS/time.dats"
//
(* ****** ****** *)
//
staload
UNISTD =
"{$PATSLIBATS}/libc/SATS/unistd.sats"
staload
_(*UNISTD*) =
"{$PATSLIBATS}/libc/DATS/unistd.dats"
//
(* ****** ****** *)

#endif // SHARE_ATSLIB_STALOAD_LIBATS_LIBC

(* ****** ****** *)

(* end of [atslib_staload_libats_libc.hats] *)
