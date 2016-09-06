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

#define
PATSLIBATSC_targetloc "$PATSHOME/libats/libc"

(* ****** ****** *)

staload
ERRNO = "{$PATSLIBATSC}/SATS/errno.sats"
staload
_(*ERRNO*) = "{$PATSLIBATSC}/DATS/errno.dats"

(* ****** ****** *)

staload
DIRENT = "{$PATSLIBATSC}/SATS/dirent.sats"
staload
_(*DIRENT*) = "{$PATSLIBATSC}/DATS/dirent.dats"

(* ****** ****** *)

staload
MATH = "{$PATSLIBATSC}/SATS/math.sats"
staload
_(*MATH*) = "{$PATSLIBATSC}/DATS/math.dats"

(* ****** ****** *)

staload
FLOAT = "{$PATSLIBATSC}/SATS/float.sats"
staload
_(*FLOAT*) = "{$PATSLIBATSC}/DATS/float.dats"

(* ****** ****** *)

staload
SIGNAL = "{$PATSLIBATSC}/SATS/signal.sats"

(* ****** ****** *)

staload
STDDEF = "{$PATSLIBATSC}/SATS/stddef.sats"

(* ****** ****** *)

staload
STDIO = "{$PATSLIBATSC}/SATS/stdio.sats"
staload
_(*STDIO*) = "{$PATSLIBATSC}/DATS/stdio.dats"

(* ****** ****** *)

staload
STDLIB = "{$PATSLIBATSC}/SATS/stdlib.sats"
staload
_(*STDLIB*) = "{$PATSLIBATSC}/DATS/stdlib.dats"

(* ****** ****** *)
//
staload
STRING = "{$PATSLIBATSC}/SATS/string.sats"
staload
_(*STRING*) = "{$PATSLIBATSC}/DATS/string.dats"
//
staload
STRINGS = "{$PATSLIBATSC}/SATS/strings.sats"
staload
_(*STRINGS*) = "{$PATSLIBATSC}/DATS/strings.dats"
//
(* ****** ****** *)
//
staload
TIME = "{$PATSLIBATSC}/SATS/time.sats"
staload
_(*TIME*) = "{$PATSLIBATSC}/DATS/time.dats"
//
(* ****** ****** *)
//
staload
UNISTD = "{$PATSLIBATSC}/SATS/unistd.sats"
staload
_(*UNISTD*) = "{$PATSLIBATSC}/DATS/unistd.dats"
//
(* ****** ****** *)

#endif // SHARE_ATSLIB_STALOAD_LIBATS_LIBC

(* ****** ****** *)

(* end of [atslib_staload_libats_libc.hats] *)
