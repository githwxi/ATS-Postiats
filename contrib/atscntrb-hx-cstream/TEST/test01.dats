(*
** stream of characters
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

%{^
#define \
atstyarr_field_undef(fname) fname[]
%} // end of [%{]

(* ****** ****** *)
//
staload
STDLIB =
"libats/libc/SATS/stdio.sats"
//
(* ****** ****** *)

staload "./../SATS/cstream.sats"
staload _ = "./../DATS/cstream.dats"

(* ****** ****** *)

#define i2c int2char0

(* ****** ****** *)

implement
main0 ((*void*)) =
{
//
val Hello = "Hello"
//
val cs =
cstream_make_string (Hello)
val c0 = cstream_get_char (cs)
val c1 = cstream_get_char (cs)
val c2 = cstream_get_char (cs)
val c3 = cstream_get_char (cs)
val c4 = cstream_get_char (cs)
//
val () = print! ((i2c)c0)
val () = print! ((i2c)c1)
val () = print! ((i2c)c2)
val () = print! ((i2c)c3)
val () = print! ((i2c)c4)
val () = println! ((*void*))
//
val str =
  cstream_get_range (cs, 0, 5)
val () = fprintln! (stdout_ref, "range(0, 5) = ", str)
val ((*void*)) = strptr_free (str)
//
val ((*void*)) = cstream_free (cs)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
