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

fn
fact(x: int): int =
  if x > 0 then x * fact(x-1) else 1
(* end of [fact] *)

(* ****** ****** *)
//
val
rec
fact : int -> int =
  lam (x) => if x > 0 then x * fact(x-1) else 1
//
(* ****** ****** *)

val
fact = ref<int->int>($UNSAFE.cast(0))
val () =
!fact :=
(
  lam (x:int):int => if x > 0 then x * !fact(x-1) else 1
) (* end of [val] *)

(* ****** ****** *)

val
fact =
fix f(x: int): int =>
  if x > 0 then x * f(x-1) else 1
(* end of [fact] *)

(* ****** ****** *)
  
val double = lam(x:int):int => x + x  
val double = fix _(x:int):int => x + x  
  
(* ****** ****** *)
//
extern fun fact (x: int): int
implmnt fact(x) = if x > 0 then x * fact(x-1) else 1
//
extern fun fact2 (x: int): int
implement fact2(x) = if x > 0 then x * fact2(x-1) else 1
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [chap_recursion.dats] *)

