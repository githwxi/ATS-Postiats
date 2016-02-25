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

fun
{a:t@ype}
list_length
(
  xs: List(a)
) : int =
(
//
list_fold_right<a,int>
  (xs, lam(x, xs) => xs + 1, 0)
//
) (* list_length *)

fun
{a:t@ype}
list_append
(
  xs: List(a), ys: List(a)
) : List0(a) = let
//
prval () = lemma_list_param(ys)
//
in
//
list_fold_right<a,List0(a)>
  (xs, lam(x, xs) => list_cons(x, xs), ys)
//
end (* list_append *)

fun
{a:t@ype}
list_reverse
(
  xs: List(a)
) : List0(a) =
(
//
list_fold_right<a,List0(a)>
( xs
, lam(x, xs) =>
  list_append<a>(xs, list_cons(x, list_nil()))
, list_nil((*void*))
) (* end of [list_fold_right] *)
//
) (* list_reverse *)

(* ****** ****** *)

fun
{a:t@ype}
list_find_rightmost
(
  xs: List(a), p: (a) -<cloref1> bool
) : Option(a) = let
//
exception Found of (a)
//
in
//
try let
//
val _ =
list_fold_right<a,int>
( xs
, lam(x, xs) =>
  if p(x) then $raise(Found(x)) else (0)
, 0(*nominal*)
)
//
in
  None((*void*))
end with ~Found(x) => Some(x)
//
end (* end of [list_find_rightmost] *)

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

(* end of [list_fold_right.dats] *)
