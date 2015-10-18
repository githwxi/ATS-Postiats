//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#define
ATS_EXTERN_PREFIX "ATSJS_"
//
(* ****** ****** *)
//
extern
fun
fact(n:int): int = "mac#ATSJS_fact_"
//
(* ****** ****** *)
//
implement
fact(n) = res where
{
//
fun
loop
(
  n: int, res: int
) : int =
(
  if n > 0
    then loop(n - 1, n * res) else res
  // end of [if]
) (* end of [loop] *)
//
val res = loop(n, 1)
//
(*
val () = println! ("fact(", n, ") = ", res)
*)
//
} (* end of [fact] *)
//
(* ****** ****** *)

(* end of [fact2.dats] *)
