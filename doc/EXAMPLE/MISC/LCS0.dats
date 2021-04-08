(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
implement main0() = {}
(* ****** ****** *)
//
fun
OPT0
(xs0: list0(int)): int =
(
case- xs0 of
|
list0_cons(x1, xs1) =>
(
case+ xs1 of
|
list0_nil() => x1
|
list0_cons _ =>
max(OPT0(xs1), OPT1(xs0))
)
) (* end of [OPT0] *)
//
and
OPT1
(xs0: list0(int)): int =
(
case- xs0 of
|
list0_cons(x1, xs1) =>
(
case+ xs1 of
|
list0_nil() => x1
|
list0_cons _ =>
let
val
sum = OPT1(xs1)
in
  if sum > 0 then x1 + sum else x1
end
)
) (* end of [OPT1] *)
//
(* ****** ****** *)

#define :: list0_cons
#define nil list0_nil
#define cons list0_cons

(* ****** ****** *)

val theInput =
(
   ~2 :: 4 :: ~3 :: 5
:: ~2 :: 3 ::  1 :: ~5
::  5 :: 2 :: ~4 :: list0_nil{int}()
)
val theInput = list0_reverse(theInput)

(* ****** ****** *)

val i0 =
auxlst(theInput) where
{
fun
auxlst
(xs0: list0(int)): int =
(
case+ xs0 of
| list0_nil() => 0
| list0_cons(x1, xs1) =>
  (i0 + 1) where
  {
    val i0 = auxlst(xs1)
    val () =
    println!("OPT1(", i0+1, ") = ", OPT1(xs0))
  }
)
} (* end of [val] *)

(* ****** ****** *)

val i0 =
auxlst(theInput) where
{
fun
auxlst
(xs0: list0(int)): int =
(
case+ xs0 of
| list0_nil() => 0
| list0_cons(x1, xs1) =>
  (i0 + 1) where
  {
    val i0 = auxlst(xs1)
    val () =
    println!("OPT0(", i0+1, ") = ", OPT0(xs0))
  }
)
} (* end of [val] *)

(* ****** ****** *)

val () =
println!("OPT0(theInput) = ", OPT0(theInput))

(* ****** ****** *)

(* end of [LCS0.dats] *)
