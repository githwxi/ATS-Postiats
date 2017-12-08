(* ****** ****** *)
(*
** DivideConquerPar:
** Fibonacci numbers
**
*)
(* ****** ****** *)
//
%{^
//
#include <pthread.h>
//
#ifdef ATS_MEMALLOC_GCBDW
#undef GC_H
#define GC_THREADS
#include <gc/gc.h>
#endif // #if(ATS_MEMALLOC_GCBDW)
//
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
#include "./../mydepies.hats"
#include "./../mylibies.hats"
//
#staload $DivideConquer
#staload $DivideConquerPar
//
#staload FWS = $FWORKSHOP_channel
//
(* ****** ****** *)
//
extern
fun{}
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
if n >= 20 then false else true
)
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

implement
{}(*tmp*)
Fibonacci(n) =
DivideConquer$solve<>(n)

(* ****** ****** *)

implement
main0() =
{
//
implement
$FWS.fws$store_capacity<>
  ((*void*)) = 1024
//
val
fws =
$FWS.fworkshop_create_exn()
//
val err =
  $FWS.fworkshop_add_worker(fws)
val err =
  $FWS.fworkshop_add_worker(fws)
//
val () = $tempenver(fws)
//
implement
{}(*tmp*)
DivideConquerPar$fworkshop
  ((*void*)) = FWORKSHOP_channel(fws)
//
val Fibonacci_ = Fibonacci<>
//
val () =
println! ("Fibonacci(10) = ", Fibonacci_(10))
val () =
println! ("Fibonacci(20) = ", Fibonacci_(20))
val () =
println! ("Fibonacci(30) = ", Fibonacci_(30))
val () =
println! ("Fibonacci(31) = ", Fibonacci_(31))
val () =
println! ("Fibonacci(32) = ", Fibonacci_(32))
val () =
println! ("Fibonacci(33) = ", Fibonacci_(33))
val () =
println! ("Fibonacci(34) = ", Fibonacci_(34))
val () =
println! ("Fibonacci(35) = ", Fibonacci_(35))
val () =
println! ("Fibonacci(40) = ", Fibonacci_(40))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test03.dats] *)
