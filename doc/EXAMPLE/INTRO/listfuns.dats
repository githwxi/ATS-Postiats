//
// Some common list-functions
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start time: June, 2013
// 
(* ****** ****** *)
//
// HX-2013-06-19:
// For the first time, the ATS2 compiler (ATS/Postiats)
// is able to properly handle case-expressions, generating
// *highly* optimized code. Voila!
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

fun fromto
  (l: int, r: int): List0 (int) =
(
  if l < r then cons{int}(l, fromto (l+1, r)) else nil ()
) // end of [fromto]

(* ****** ****** *)

fun{a:t0p}
length (xs: List0 (INV(a))): int =
(
case+ xs of
| cons (_, xs) => 1 + length (xs) | nil () => 0
) // end of [length]

(* ****** ****** *)

fun zip{n:int}
(
  xs: list (int, n)
, ys: list (int, n)
) : list ((int, int), n) = let
in
//
case+ (xs, ys) of
| (cons (x, xs),
   cons (y, ys)) => cons{(int,int)}((x, y), zip (xs, ys))
| (nil (), nil ()) => nil ()
//
end // end of [zip]

(* ****** ****** *)

implement
main0 () =
{
//
#define N 10
//
val out = stdout_ref
val xs = fromto (0, N)
val () = assertloc (length (xs) = N)
val xxs = zip (xs, xs)
val () = assertloc (length (xxs) = N)
//
} // end of [main0]

(* ****** ****** *)

(* end of [listfuns.dats] *)
