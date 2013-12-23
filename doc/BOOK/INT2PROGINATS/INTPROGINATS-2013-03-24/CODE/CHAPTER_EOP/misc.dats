(*
** Some code used in the book
*)

(* ****** ****** *)

val _3 = 3.
val PI = 31416E-4

(* ****** ****** *)

val x = 1
val x_abs = (if (x >= 0) then x else ~x): int

(* ****** ****** *)

typedef point2D = @{ x= double, y= double }
val theOrigin = @{ x= 0.0, y= 0.0 } : point2D
val theOrigin_x = theOrigin.x and theOrigin_y = theOrigin.y
val @{ x= theOrigin_x, y= theOrigin_y } = theOrigin
val @{ x= theOrigin_x, ... } = theOrigin
val @{ y= theOrigin_y, ... } = theOrigin

(* ****** ****** *)

implement main () = ()

(* ****** ****** *)

(* end of [misc.dats] *)
