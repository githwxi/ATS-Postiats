(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"

#staload "libats/libc/SATS/math.sats"
#staload _ = "libats/libc/DATS/math.dats"

(* ****** ****** *)
//
#staload FC =
"libats/ATS2/SATS/fcntainer.sats"
//
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer/main.dats"
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer/integer.dats"
//
(* ****** ****** *)

fun
isPrime
(k : intGte(2)) : bool =
$FC.forall<int><int>(intsqrt(k)-1) where
{
  implement $FC.forall$test<int>(i) = k % (i+2) > 0
} (* end of [isPrime] *)

(* ****** ****** *)

implement main0() =
{
//
#define _1M_ 1000000
//
  val np = 
  $FC.foldleft<int><int><int>
  (_1M_-2, 0) where
  {
   implement
   $FC.foldleft$fopr<int><int>(res, x) =
   if isPrime($UNSAFE.cast{intGte(2)}(x+2)) then res+1 else res
  }
  val () = println! ("The number of primes < 1000000 = ", np)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [isPrime.dats] *)
