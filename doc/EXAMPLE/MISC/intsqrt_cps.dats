//usr/bin/env myatscc "$0"; exit
(* ****** ****** *)
//
// HX-2016-10-17:
// For answering
// a question on StackOverflow
//
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

(*
fun
intsqrt(n: int): int = 
if
(n >= 1)
then let
  val n4 = n / 4
  val res = 2 * intsqrt(n4) + 1
in
  if (res * res <= n) then res else 2*intsqrt(n4)
end // end of [then]
else (n)
*)

(* ****** ****** *)
//
// HX:
// Every allocated byte is freed.
// Please try to valgrind to verify it!
//
(* ****** ****** *)

fun
square(x: int): int = x * x

fun
applin
(
  k: int -<lincloptr1> int, x: int
) : int = res where
{
  val res = k(x)
  val ((*freed*)) = cloptr_free($UNSAFE.castvwtp0(k))
} (* end of [applin] *)

fun
intsqrt_cps
(
  n: int, k: int -<lincloptr1> int
) : int = 
if
(n >= 1)
then let
  val n4 = n / 4
in
//
intsqrt_cps
( n4
, llam(res) =>
  applin(k, if square(2*res+1) <= n then 2*res+1 else 2*res)
) (* intsqrt_cps *)
//
end // end of [then]
else applin(k, 0) // end of [else]

fun intsqrt(n:int): int = intsqrt_cps(n, llam(x) => x)

(* ****** ****** *)

implement
main0() =
{
  val () = println! ("intsqrt(1023) = ", intsqrt(1023))
  val () = println! ("intsqrt(1024) = ", intsqrt(1024))
} (* end of [main0] *)

(* ****** ****** *)

(* end of [intsqrt_cps.dats] *)
