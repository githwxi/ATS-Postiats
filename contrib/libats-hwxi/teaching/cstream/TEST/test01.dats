(*
** stream of characters
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
STDLIB = "libc/SATS/stdio.sats"

(* ****** ****** *)

staload "./../SATS/cstream.sats"

(* ****** ****** *)

implement
main0 ((*void*)) =
{
//
(*
val cs =
cstream_make_fun
  (lam () => $STDLIB.getchar0 ())
val c1 = cstream_get_char (cs)
val () = fprintln! (stdout_ref, "c1 = ", c1)
val ((*void*)) = cstream_free (cs)
*)
//
macdef i2c(c) = int2char0(,(c))
//
val cs =
cstream_make_string ("Hello")
val c0 = cstream_get_char (cs)
val c1 = cstream_get_char (cs)
val c2 = cstream_get_char (cs)
val c3 = cstream_get_char (cs)
val c4 = cstream_get_char (cs)
val () = fprintln! (stdout_ref, (i2c)c0, (i2c)c1, (i2c)c2, (i2c)c3, (i2c)c4)
val ((*void*)) = cstream_free (cs)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
