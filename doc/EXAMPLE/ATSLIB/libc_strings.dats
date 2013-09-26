(*
** for testing [libc/stdlib]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UNI = "libc/SATS/unistd.sats"

(* ****** ****** *)

staload "libc/SATS/strings.sats"
staload _ = "libc/DATS/strings.dats"

(* ****** ****** *)

val () = {
  val str = "abcde"
  val str2 = "ABCDE"
  val () = assertloc (strcasecmp (str, str2) = 0)
} // end of [val]

(* ****** ****** *)

val () =
{
  val str = "abcde"
  val p0 = string2ptr(str)
  val () = assertloc (strlen (str) = $UNSAFE.cast2size(index (str, 0) - p0))
  val () = assertloc (strlen (str) = $UNSAFE.cast2size(rindex (str, 0) - p0))
}

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_strings.dats] *)
