(*
//
// For use in Effective ATS
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

extern
fun
{a,b:t@ype}
list_fold_left
(
  xs: List(a)
, init: b, fopr: (b, a) -<cloref1> b
) : b // end-of-function

(* ****** ****** *)

implement
{a,b}(*tmp*)
list_fold_left
  (xs, init, fopr) = let
//
fun
auxmain
{n:nat} .<n>.
(
  init: b, xs: list(a, n)
) : b = (
//
case+ xs of
| list_nil() => init
| list_cons(x, xs) => auxmain(fopr(init, x), xs)
//
) (* auxmain *)
//
prval () = lemma_list_param(xs)
//
in
  auxmain(init, xs)
end // end of [list_fold_left]

(* ****** ****** *)
//
val
fact =
lam
{n:nat}(n: int(n)) =>
list_fold_left<int,int>
(list_vt2t(list_make_intrange(0, n)), 1, lam(r, x) => r*(x+1))
//
(* ****** ****** *)

implement
main0((*void*)) =
{
//
val () =
assertloc(fact(10) = 1*2*3*4*5*6*7*8*9*10)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [list-fold-left.dats] *)
