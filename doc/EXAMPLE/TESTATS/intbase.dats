//
// Author: Hongwei Xi
// Start Date: July 19, 2014
//
(* ****** ****** *)
//
staload
"prelude/DATS/integer.dats"
//
(* ****** ****** *)

val x_oct = 01234567
val ((*void*)) = println! ("x_oct = ", x_oct)
val x_dec = 123456789l
val ((*void*)) = println! ("x_dec = ", x_dec)
val x_hex = 0x123456789abcdefll
val ((*void*)) = println! ("x_hex = ", x_hex)

(* ****** ****** *)

val x_oct = 01234567u
val ((*void*)) = println! ("x_oct = ", x_oct)
val x_dec = 123456789ul
val ((*void*)) = println! ("x_dec = ", x_dec)
val x_hex = 0x123456789abcdefull
val ((*void*)) = println! ("x_hex = ", x_hex)

(* ****** ****** *)

val () = assertloc (01234 + 01234 = 02470)
val () = assertloc (01234U + 01234U = 02470U)
val () = assertloc (0x1234567 + 0x1234567 = 0x2468ace)
val () = assertloc (0x1234567UL + 0x1234567UL = 0x2468aceUL)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [intbase.dats] *)
