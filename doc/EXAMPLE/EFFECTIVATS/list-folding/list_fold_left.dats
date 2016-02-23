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
| list_cons(x, xs) =>
    auxmain(fopr(init, x), xs)
  // end of [list_cons]
//
) (* auxmain *)
//
prval () = lemma_list_param(xs)
//
in
  auxmain(init, xs)
end // end of [list_fold_left]

(* ****** ****** *)

fun
{a:t@ype}
list_length
(
  xs: List(a)
) : int =
(
//
list_fold_left<a,int>
  (xs, 0, lam(xs, x) => xs + 1)
//
) (* list_length *)

fun
{a:t@ype}
list_reverse
(
  xs: List(a)
) : List0(a) =
(
//
list_fold_left<a,List0(a)>
  (xs, list_nil(), lam(xs, x) => list_cons(x, xs))
//
) (* list_reverse *)

(* ****** ****** *)
//
val
fact =
lam
{n:nat}(n: int(n)) =>
list_fold_left<int,int>
(
  list_vt2t(xs)
, 1, lam(r, x) => r*(x+1)
) where
{
  val xs = list_make_intrange(0, n)
}
//
(* ****** ****** *)

implement
main0((*void*)) =
{
//
val () = assertloc(fact(10) = 1*2*3*4*5*6*7*8*9*10)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [list_fold_left.dats] *)
