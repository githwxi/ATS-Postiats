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

implement main0 () = ()

(* ****** ****** *)

(* end of [intbase.dats] *)
