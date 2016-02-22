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
list_fold_right
(
  xs: List(a)
, fopr: (a, b) -<cloref1> b, sink: b
) : b // end-of-function

(* ****** ****** *)

implement
{a,b}(*tmp*)
list_fold_right
  (xs, fopr, sink) = let
//
fun
auxmain
{n:nat} .<n>.
(
  xs: list(a, n)
) : b = (
//
case+ xs of
| list_nil() => sink
| list_cons(x, xs) => fopr(x, auxmain(xs))
//
) (* auxmain *)
//
prval () = lemma_list_param(xs)
//
in
  auxmain(xs)
end // end of [list_fold_right]

(* ****** ****** *)
//
val
fact =
lam
{n:nat}(n: int(n)) =>
list_fold_right<int,int>
(list_vt2t(list_make_intrange(0, n)), lam(x, r) => (x+1)*r, 1)
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

(* end of [list-fold-right.dats] *)
