(*
** fix-expression as function definition
*)

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

(* end of [bug-2013-10-11-2.dats] *)
