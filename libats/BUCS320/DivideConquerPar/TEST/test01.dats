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
  (n) =
(
g0ofg1($list{int}(n-1, n-2))
)
//
(* ****** ****** *)

implement
DivideConquer$conquer$combine<>
  (rs) = r1 + r2 where
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
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
