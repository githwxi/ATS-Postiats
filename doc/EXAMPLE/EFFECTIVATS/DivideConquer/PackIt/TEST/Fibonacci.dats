(* ****** ****** *)
(*
** DivideConquer:
** Fibonacci numbers
**
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
//
(*
//
// If the package
// [effectivats-divideconquer]
// is npm-installed,
// please use this version:
//
#include
"{$PATSHOMELOCS}\
/effectivats-divideconquer/mylibies.hats"
//
*)
(* ****** ****** *)

#staload $DivideConquer

(* ****** ****** *)
//
extern
fun Fibonacci(int): int
//
(* ****** ****** *)

assume input_t0ype = int
assume output_t0ype = int

(* ****** ****** *)
//
implement
DC_base_test<>
  (n) =
(
if n >= 2 then false else true
)
//
(* ****** ****** *)
//
implement
DC_base_solve<>
  (n) = n
//
(* ****** ****** *)
//
implement
DC_divide<>(n) =
(
g0ofg1($list{int}(n-1, n-2))
) (* DC_divide *)
//
(* ****** ****** *)

implement
DC_conquer_combine<>
  (_, rs) = r1 + r2 where
{
//
val-list0_cons(r1, rs) = rs
val-list0_cons(r2, rs) = rs
//
}

(* ****** ****** *)

implement
Fibonacci(n) = let
//
val () =
println!
(
  "Fibonacci(", n, ")"
)
in
  DC_solve<>(n)
end // end of [Fibonacci]

(* ****** ****** *)

implement
main0() =
{
//
val () =
println! ("Fibonacci(5) = ", Fibonacci(5))
val () =
println! ("Fibonacci(10) = ", Fibonacci(10))
val () =
println! ("Fibonacci(20) = ", Fibonacci(20))
val () =
println! ("Fibonacci(30) = ", Fibonacci(30))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Fibonacci.dats] *)
