(*
** for testing [libc/stdlib]
*)

(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UNI = "libc/SATS/unistd.sats"

(* ****** ****** *)

staload "libc/SATS/string.sats"
staload _ = "libc/DATS/string.dats"

(* ****** ****** *)

val () = {
//
val str = "abcde"
val (pf | str2) = strdup (str)
val () = assertloc (str = $UNSAFE.castvwtp1{string}(str2))
val () = strdup_free (pf | str2)
//
val (pf | str2) = strdupa (str)
val () = assertloc (str = $UNSAFE.castvwtp1{string}(str2))
val () = strdupa_free (pf | str2)
//
} // end f [val]

(* ****** ****** *)

val () = {
//
val str = "abcde"
val str2 = "abcdef"
//
val () = assertloc (strcmp (str, str2) < 0)
val () = assertloc (strcmp (str2, str) > 0)
val () = assertloc (strncmp (str, str2, strlen (str)) = 0)
//
val () = assertloc (strspn (str, str) = 5)
val () = assertloc (strcspn (str, str) = 0)
//
val _0 = i2sz(0)
val () = assertloc (_0 = strnlen (str, _0))
val () = assertloc (strlen (str) = strnlen (str, i2sz(1000000)))
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_string.dats] *)
