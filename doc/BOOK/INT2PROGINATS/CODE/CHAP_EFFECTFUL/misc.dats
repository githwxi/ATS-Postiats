(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)

(*
** Example: Testing for Braun Trees
**
** Author: Hongwei Xi
** Authoremail hwxiATcsDOTbuDOTedu
** Time: January, 2011
*)

(* ****** ****** *)

(*
** Ported to ATS2 by HX-2013-09
*)

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)

fun listprod1
  (xs: list0 (int)): int = case+ xs of
  | list0_cons (x, xs) => x * listprod1 (xs) | list0_nil () => 1
// end of [listprod1]

fun listprod2
  (xs: list0 (int)): int = case+ xs of
  | list0_cons (x, xs) => if x = 0 then 0 else x * listprod2 (xs)
  | list0_nil () => 1
// end of [listprod2]

fun listprod3
  (xs: list0 (int)): int = let
  exception ZERO of ()
  fun aux (xs: list0 (int)): int =
    case+ xs of
    | list0_cons (x, xs) =>
        if x = 0 then $raise ZERO() else x * aux (xs)
    | list0_nil () => 1
  // end of [aux]
in
  try aux (xs) with ~ZERO () => 0
end // end of [listprod3]

(* ****** ****** *)

val r = ref<int> (0) // creating a reference and init. it with 0
val () = assertloc (!r = 0)
val () = !r := !r + 1 // increasing the value stored at [r] by 1
val () = assertloc (!r = 1)

(* ****** ****** *)
//
// HX: this one is done in a deplorable style
//
fun sum
  (n: int): int = let
//
  val i = ref<int> (1)
  val res = ref<int> (0)
//
  fun loop ():<cloref1> void =
    if !i <= n then (!res := !res + !i; !i := !i + 1; loop ())
  // end of [loop]
in
  loop (); !res
end // end of [sum]

(* ****** ****** *)

typedef
counter = '{
  get= () -<cloref1> int
, inc= () -<cloref1> void
, reset= () -<cloref1> void
} // end of [counter]

fun newCounter
  (): counter = let
  val count = ref<int> (0)
in '{
  get= lam () => !count
, inc= lam () => !count := !count + 1
, reset= lam () => !count := 0
} end // end of [newCounter]

(* ****** ****** *)

staload "libc/SATS/stdlib.sats"

(* ****** ****** *)

staload "{$LIBATSHWXI}/testing/SATS/randgen.sats"
staload _(*anon*) = "{$LIBATSHWXI}/testing/DATS/randgen.dats"

(* ****** ****** *)

typedef T = double
implement randgen_val<T> () = drand48 ()

(* ****** ****** *)

implement
main0 () =
{
//
val xs =
$list{int}(1, 3, 5, 7, 9, 0, 2, 4, 6, 8)
val xs = g0ofg1_list (xs)
//
val ((*void*)) = assertloc (listprod1 (xs) = 0)
val ((*void*)) = assertloc (listprod2 (xs) = 0)
val ((*void*)) = assertloc (listprod3 (xs) = 0)
//
#define N 1000
val ((*void*)) = assertloc (sum (N) = N * (N+1) / 2)
//
} // end of [main]

(* ****** ****** *)

(* end of [misc.dats] *)
