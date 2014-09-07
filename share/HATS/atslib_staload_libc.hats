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

#ifndef SHARE_ATSLIB_STALOAD_LIBC
#define SHARE_ATSLIB_STALOAD_LIBC 1

(* ****** ****** *)

#define
PATSLIBC_targetloc "$PATSHOME/libc"

(* ****** ****** *)

staload ERRNO = "{$PATSLIBC}/SATS/errno.sats"
staload _(*ERRNO*) = "{$PATSLIBC}/DATS/errno.dats"

(* ****** ****** *)

staload DIRENT = "{$PATSLIBC}/SATS/dirent.sats"
staload _(*DIRENT*) = "{$PATSLIBC}/DATS/dirent.dats"

(* ****** ****** *)

staload MATH = "{$PATSLIBC}/SATS/math.sats"
staload _(*MATH*) = "{$PATSLIBC}/DATS/math.dats"

(* ****** ****** *)

staload SIGNAL = "{$PATSLIBC}/SATS/signal.sats"

(* ****** ****** *)

staload STDDEF = "{$PATSLIBC}/SATS/stddef.sats"

(* ****** ****** *)

staload STDIO = "{$PATSLIBC}/SATS/stdio.sats"
staload _(*STDIO*) = "{$PATSLIBC}/DATS/stdio.dats"

(* ****** ****** *)

staload STDLIB = "{$PATSLIBC}/SATS/stdlib.sats"
staload _(*STDLIB*) = "{$PATSLIBC}/DATS/stdlib.dats"

(* ****** ****** *)

staload STRING = "{$PATSLIBC}/SATS/string.sats"
staload _(*STRING*) = "{$PATSLIBC}/DATS/string.dats"
staload STRINGS = "{$PATSLIBC}/SATS/strings.sats"
staload _(*STRINGS*) = "{$PATSLIBC}/DATS/strings.dats"

(* ****** ****** *)

staload TIME = "{$PATSLIBC}/SATS/time.sats"
staload _(*TIME*) = "{$PATSLIBC}/DATS/time.dats"

(* ****** ****** *)

staload UNISTD = "{$PATSLIBC}/SATS/unistd.sats"
staload _(*UNISTD*) = "{$PATSLIBC}/DATS/unistd.dats"

(* ****** ****** *)

#endif // SHARE_ATSLIB_STALOAD_LIBC

(* ****** ****** *)

(* end of [atslib_staload_libc.hats] *)
