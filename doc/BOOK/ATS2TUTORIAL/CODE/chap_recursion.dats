(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun fact (x: int): int =
  if x > 0 then x * fact(x-1) else 1
//
(* ****** ****** *)
//
fn square(x: int): int = x * x
//
val square = lam (x: int): int => x * x
//
(* ****** ****** *)

val
fact = lam (x) =>
  if x > 0 then x * fact(x-1) else 1
(* end of [fact] *)

(* ****** ****** *)

val
rec
fact = lam (x) =>
  if x > 0 then x * fact(x-1) else 1
(* end of [fact] *)

(* ****** ****** *)

val
fact =
fix f(x: int): int =>
  if x > 0 then x * fact(x-1) else 1
(* end of [fact] *)

(* ****** ****** *)
//
extern fun fact (x: int): int
//
implmnt fact(x) = if x > 0 then x * fact(x-1) else 1
//
(* ****** ****** *)

(* end of [chap_recursion.dats] *)

