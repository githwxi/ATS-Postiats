(*
** Some code used in the INT2PROGINTATS book
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val _3 = 3.
val PI = 31416E-4

(* ****** ****** *)

val x = 1 + 2

(* ****** ****** *)

val PI = 3.14 and radius = 10.0
val area = PI * radius * radius

(* ****** ****** *)

val area = let
  val PI = 3.14 and radius = 10.0 in PI * radius * radius
end // end of [let]

val area =
  PI * radius * radius where {
  val PI = 3.14 and radius = 10.0 // simultaneous bindings
} // end of [where] // end of [val]

(* ****** ****** *)

local

val PI = 3.14 and radius = 10.0

in (* in of [local] *)

val area = PI * radius * radius

end // end of [local]

(* ****** ****** *)

val _ = let
  val PI = 3.14 and radius2 = 10.0 * 10.0 in PI * radius2
end // end of [val]

(* ****** ****** *)

val x = 1
val x_abs = (if (x >= 0) then x else ~x): int

(* ****** ****** *)

val xyz = ('A', 1, 2.0)
val x = xyz.0 and y = xyz.1 and z = xyz.2
val xyz = ( 'A', 1, 2.0 )
val (x, y, z) = xyz // x = 'A'; y = 1; z = 2.0

(* ****** ****** *)

val xyz = '( 'A', 1, 2.0 )
val x = xyz.0 and y = xyz.1 and z = xyz.2
val xyz = '( 'A', 1, 2.0 )
val '(x, y, z) = xyz // x = 'A'; y = 1; z = 2.0

(* ****** ****** *)

typedef
point2D = @{ x= double, y= double }

(* ****** ****** *)

val theOrigin = @{ x= 0.0, y= 0.0 } : point2D

(* ****** ****** *)

val theOrigin_x = theOrigin.x
and theOrigin_y = theOrigin.y

(* ****** ****** *)

val @{ x= theOrigin_x, y= theOrigin_y } = theOrigin
val @{ x= theOrigin_x, ... } = theOrigin
val @{ y= theOrigin_y, ... } = theOrigin

(* ****** ****** *)

val () = assertloc (theOrigin.x = theOrigin_x)
val () = assertloc (theOrigin.y = theOrigin_y)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [misc.dats] *)
