//
// fixed-point operators
//
// Author: Hongwei Xi (2013-09)
// Authoremail: gmhwxiATgmailDOTcom
//

(* ****** ****** *)

val fact =
  fix f (x: int): int =>
    if x > 0 then x * f (x-1) else 1
  // end of [fix]

(* ****** ****** *)

val () = println! ("fact(10) = ", fact(10))

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [fixedpoint.dats] *)
