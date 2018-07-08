(* ****** ****** *)
(*
** Computing
** Fibonacci Numbers
** in Parallel
*)
(* ****** ****** *)

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

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#include
"$PATSHOMELOCS\
/atscntrb-bucs320-divideconquerpar/mydepies.hats"
#include
"$PATSHOMELOCS\
/atscntrb-bucs320-divideconquerpar/mylibies.hats"
//
(* ****** ****** *)
//
#staload $DivideConquer // for opening namespace
#staload $DivideConquerPar // for opening namespace
//
(* ****** ****** *)
//
#staload FWS = $FWORKSHOP_chanlst // for list-based channels
//
(* ****** ****** *)
//
fun
Fibo(n: int): int =
if
(n >= 2)
then Fibo(n-1)+Fibo(n-2) else (n)
//
(* ****** ****** *)
//
assume input_t0ype = int
assume output_t0ype = int
//
(* ****** ****** *)
//
#define CUTOFF 20
//
(* ****** ****** *)
//
typedef
fworkshop = $FWS.fworkshop
//
extern
fun
ParFibo
(fws: fworkshop, n: int): int
//
(* ****** ****** *)

implement
ParFibo
(fws, n) =
DivideConquer$solve<>(n) where
{
//
val () = $tempenver(fws)
//
implement
DivideConquer$base_test<>(n) =
  (n <= CUTOFF)
implement
DivideConquer$base_solve<>(n) =
  Fibo(   n   )
//
implement
DivideConquer$divide<>(n) = g0ofg1($list{int}(n-1, n-2))
implement
DivideConquer$conquer$combine<>(_(*n*), rs) = rs[0] + rs[1]
//
implement
DivideConquerPar$fworkshop<>((*void*)) = FWORKSHOP_chanlst(fws)
//
} (* end of [ParFibo] *)

(* ****** ****** *)

implement
main0(argc, argv) =
{
//
#define N 2
//
val
fws =
$FWS.fworkshop_create_exn()
//
val
added = $FWS.fworkshop_add_nworker(fws, N)
val () =
prerrln!("the number of workers = ", added)
//
val
n0 =
(
if argc >= 2
  then g0string2int(argv[1]) else 45
) : int // end of [root]
//
val () =
println!("ParFibo(", n0, ") = ", ParFibo(fws, n0))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [ParFibo.dats] *)
