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

staload ERRNO = "libc/SATS/errno.sats"
staload _(*ERRNO*) = "libc/DATS/errno.dats"

(* ****** ****** *)

staload MATH = "libc/SATS/math.sats"
staload _(*MATH*) = "libc/DATS/math.dats"

(* ****** ****** *)

staload STDDEF = "libc/SATS/stddef.sats"

(* ****** ****** *)

staload STDIO = "libc/SATS/stdio.sats"
staload _(*STDIO*) = "libc/DATS/stdio.dats"

(* ****** ****** *)

staload STDLIB = "libc/SATS/stdlib.sats"
staload _(*STDLIB*) = "libc/DATS/stdlib.dats"

(* ****** ****** *)

staload STRING = "libc/SATS/string.sats"
staload _(*STRING*) = "libc/DATS/string.dats"
staload STRINGS = "libc/SATS/strings.sats"
staload _(*STRINGS*) = "libc/DATS/strings.dats"

(* ****** ****** *)

staload TIME = "libc/SATS/time.sats"
staload _(*TIME*) = "libc/DATS/time.dats"

(* ****** ****** *)

staload UNISTD = "libc/SATS/unistd.sats"
staload _(*UNISTD*) = "libc/DATS/unistd.dats"

(* ****** ****** *)

(* end of [atslib_staload_libc.hats] *)
