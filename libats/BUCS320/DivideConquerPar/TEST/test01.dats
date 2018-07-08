(* ****** ****** *)
(*
** DivideConquerPar:
** Fibonacci numbers
**
*)
(* ****** ****** *)
//
%{^
#include <pthread.h>
%} // end of [%{^]
//
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
#include
"./../mydepies.hats"
//
#staload $DivideConquer
#staload $DivideConquer_cont
//
#staload
"./../DATS/DivideConquerPar.dats"
//
(* ****** ****** *)
//
extern
fun
Fibonacci(int): int
//
(* ****** ****** *)

fun
fib
(
n0:int
) : int =
(
fix f(n:int):int =>
  if n >= 2 then f(n-1)+f(n-2) else n
)(n0) // end of [fib]

(* ****** ****** *)

assume input_t0ype = int
assume output_t0ype = int

(* ****** ****** *)
//
implement
DivideConquer$base_test<>
  (n) =
(
if n >= 20 then false else true
)
//
(* ****** ****** *)
//
implement
DivideConquer$base_solve<>
  (n) = fib(n)
//
(* ****** ****** *)
//
implement
DivideConquer$divide<>
  (n) =
(
g0ofg1($list{int}(n-1, n-2))
)
//
(* ****** ****** *)

implement
DivideConquer$conquer$combine<>
  (_, rs) = r1 + r2 where
{
//
val-list0_cons(r1, rs) = rs
val-list0_cons(r2, rs) = rs
//
}

(* ****** ****** *)
//
implement
DivideConquerPar$submit<>
  (fwork) =
{
  val () = fwork()
  val () = cloptr_free($UN.castvwtp0{cloptr(void)}(fwork))
}
//
(* ****** ****** *)

implement
Fibonacci(n) = DivideConquer$solve<>(n)

(* ****** ****** *)

implement
main0() =
{
//
val () =
println! ("Fibonacci(10) = ", Fibonacci(10))
val () =
println! ("Fibonacci(20) = ", Fibonacci(20))
val () =
println! ("Fibonacci(30) = ", Fibonacci(30))
val () =
println! ("Fibonacci(31) = ", Fibonacci(31))
val () =
println! ("Fibonacci(32) = ", Fibonacci(32))
val () =
println! ("Fibonacci(33) = ", Fibonacci(33))
val () =
println! ("Fibonacci(34) = ", Fibonacci(34))
val () =
println! ("Fibonacci(35) = ", Fibonacci(35))
val () =
println! ("Fibonacci(40) = ", Fibonacci(40))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
