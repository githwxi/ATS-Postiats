(*
** fix-expression as function definition
*)

(* ****** ****** *)

(*
** Status: it is not yet fixed (HX-2013-10-12)
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern fun fact (x: int): int

(* ****** ****** *)
//
// HX-2013-10-11:
// the following code could not be properly compiled
//
implement fact =
  fix f (x: int): int => if x > 0 then x * f (x-1) else 1
//
(* ****** ****** *)

implement
main0 () =
{
//
#define N 12
//
val () = println! ("fact(", N, ") = ", fact(N))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [bug-2013-10-11-2.dats] *)
