(* ****** ****** *)
//
// HX-2014-03-30
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

(*
//
// This one does not pass typechecking:
//
fun fact{n:nat}
  (x: int n): [r:nat] int r = if x > 0 then x * fact (x-1) else 1
// end of [fact]
*)

(* ****** ****** *)

fun
fact{n:nat}
(
  x: int n
) : [r:nat] int r =
(
if x > 0
  then let
    val [r1:int] r1 = fact (x-1)
    prval () = mul_gte_gte_gte {n,r1} ()
  in
    x * r1
  end // end of [then]
  else 1 // end of [else]
) (* end of [if] *)

(* ****** ****** *)

implement
main0 () =
{
  val N = 10
  val () = println! ("fact(", N, ") = ", fact(N))
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-244.dats] *)
