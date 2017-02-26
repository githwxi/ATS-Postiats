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
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
#staload $DivideConquer // opening it
//
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
DivideConquer$base_test<>
  (n) =
(
if n >= 2 then false else true
)
//
(* ****** ****** *)
//
implement
DivideConquer$base_solve<>
  (n) = n
//
(* ****** ****** *)
//
implement
DivideConquer$divide<>
  (n) = $list_vt{int}(n-1, n-2)
//
(* ****** ****** *)

implement
DivideConquer$conquer$combine<>
  (_, rs) = r1 + r2 where
{
//
val-~list_vt_cons(r1, rs) = rs
val-~list_vt_cons(r2, rs) = rs
val-~list_vt_nil((*void*)) = rs
//
}

(* ****** ****** *)

implement
Fibonacci(n) = let
//
(*
implement
DivideConquer$solve_rec<>
  (n) = Fibonacci(n)
*)
//
in
  DivideConquer$solve<>(n)
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

(* end of [test01.dats] *)
