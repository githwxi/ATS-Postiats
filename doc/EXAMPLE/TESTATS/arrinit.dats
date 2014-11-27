//
// A simple example of
// stack-allocated array
//
// Author: Hongwei Xi (October, 2014)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

implement
main0 () =
{
//
var x: int = 0
//
var A1 = @[int][3]((x:=x+1;x))
var A2 = @[int][3]((x:=x+1;x), (x:=x+1;x))
var A3 = @[int][3]((x:=x+1;x), (x:=x+1;x), (x:=x+1;x))
//
val out = stdout_ref
val () = fprint (out, "A1 = ")
val () = fprint_array (out, A1, i2sz(3))
val () = fprint_newline (out)
//
val () = fprint (out, "A2 = ")
val () = fprint_array (out, A2, i2sz(3))
val () = fprint_newline (out)
//
val () = fprint (out, "A3 = ")
val () = fprint_array (out, A3, i2sz(3))
val () = fprint_newline (out)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [arrinit.dats] *)
