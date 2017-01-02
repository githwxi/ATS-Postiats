(* ****** ****** *)
//
// Author: HX-2017-01-01
//
// This is a memory clean implementation:
//
(* ****** ****** *)
(*
//
Two integers M and N are said to be amicable pairs if M != N and the
sum of the proper divisors of M (sum(propDivs(M))) equals that of N and
vice versa.
//
Example:
1184 and 1210 are an amicable pair, with proper divisors:
1, 2, 4, 8, 16, 32, 37, 74, 148, 296, 592 and
1, 2, 5, 10, 11, 22, 55, 110, 121, 242, 605 respectively.
//       
Task:
Calculate and show here the Amicable pairs below 20,000; (there are eight). 
//
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
fun
sum_list_vt
  (xs: List_vt(int)): int =
(
  case+ xs of
  | ~list_vt_nil() => 0
  | ~list_vt_cons(x, xs) => x + sum_list_vt(xs)
)
//
(* ****** ****** *)

fun
propDivs
(
  x0: int
) : List0_vt(int) =
  loop(x0, 2, list_vt_sing(1)) where
{
//
fun
loop
(
x0: int, i: int, res: List0_vt(int)
) : List0_vt(int) =
(
if
(i * i) > x0
then
(
  list_vt_reverse(res)
)
else
(
  if x0 % i != 0
    then
      loop(x0, i+1, res)
    // end of [then]
    else let
      val res =
        cons_vt(i, res)
      // end of [val]
      val res =
      (
        if i * i = x0 then res else cons_vt(x0 / i, res)
      ) : List0_vt(int) // end of [val]
    in
      loop(x0, i+1, res)
    end // end of [else]
  // end of [if]
)
) (* end of [loop] *)
//
} // end of [propDivs]

(* ****** ****** *)

fun
sum_propDivs(x: int): int = sum_list_vt(propDivs(x))

(* ****** ****** *)

val
theNat2 = auxmain(2) where
{
fun
auxmain
(
 n: int
) : stream_vt(int) = $ldelay(stream_vt_cons(n, auxmain(n+1)))
}

(* ****** ****** *)
//
val
theAmicable =
(
theNat2.takeLte(20000)
).filter()
(
lam x =>
let
  val x2 = sum_propDivs(x)
in x < x2 && x = sum_propDivs(x2) end
)
//
(* ****** ****** *)

val () =
theAmicable.foreach()
(
  lam x => println! ("(", x, ", ", sum_propDivs(x), ")")
)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [Amicable_pairs.dats] *)
