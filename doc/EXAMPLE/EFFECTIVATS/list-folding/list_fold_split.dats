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
list_fold_split
(
  xs: List(a)
, fopr: (b, b) -<cloref1> b
, sink0: b, fsink1: (a) -<cloref1> b
) : b // end-of-function

(* ****** ****** *)

implement
{a,b}(*tmp*)
list_fold_split
  (xs, fopr, sink0, fsink1) = let
//
fun
auxmain
{ n1,n2:nat
| n1 >= n2 } .<n2>.
(
  xs: list(a, n1), n2: int(n2)
) : b =
(
if
(n2 >= 2)
then let
  val n21 = half(n2)
in
//
fopr(
  auxmain(xs, n21)
, auxmain(list_drop(xs, n21), n2-n21)
) (* fopr *)
//
end // end of [then]
else (
//
case+ xs of
| list_nil() => sink0
| list_cons(x, _) => fsink1(x)
//
) (* end of [else] *)
//
) (* end of [auxmain] *)
//
prval () = lemma_list_param(xs)
//
in
  auxmain(xs, length(xs))
end // end of [list_fold_split]

(* ****** ****** *)
//
val
fact =
lam{n:nat}(n: int(n)) =>
list_fold_split<int,int>
(
  list_vt2t(xs)
, lam(r1, r2) => r1*r2, 1, lam(x) => x+1
) where
{
  val xs = list_make_intrange(0, n)
}
//
(* ****** ****** *)

fun
{a:t@ype}
list_reverse
(
  xs: List(a)
) : List0(a) =
(
//
list_fold_split<a,List0(a)>
( xs
, lam(xs, ys) => list_append(ys, xs)
, list_nil, lam(x) => list_cons(x, list_nil)
) (* list_fold_split *)
//
) (* list_reverse *)

(* ****** ****** *)

local
//
fun{
a:t@ype
} merge
(
  xs0: list0(a)
, ys0: list0(a)
) : list0(a) =
(
case+ (xs0, ys0) of
| (list0_nil(), _) => ys0
| (_, list0_nil()) => xs0
| (list0_cons(x0, xs1), 
   list0_cons(y0, ys1)) => let
    val sgn = gcompare_val_val<a>(x0, y0)
  in
    if sgn <= 0
      then list0_cons(x0, merge(xs1, ys0))
      else list0_cons(y0, merge(xs0, ys1))
  end // end of [cons _, cons _]
)
//
in (* in-of-local *)
//
fun
{a:t@ype}
mergesort(xs: List(a)) =
list_fold_split<a,list0(a)>
( xs
, lam(xs, ys) => merge<a>(xs, ys)
, list0_nil(), lam(x) => list0_sing(x)
)
//
end // end of [local]

(* ****** ****** *)

staload UN = $UNSAFE
staload "libc/SATS/time.sats"
staload "libc/SATS/stdlib.sats"

(* ****** ****** *)

implement
main0((*void*)) =
{
//
val () =
assertloc(fact(10) = 1*2*3*4*5*6*7*8*9*10)
//
val () = srandom($UN.cast2uint(time()))
//
val xs = list_vt2t(list_tabulate_fun<int>(10, lam(_) => randint(10)))
//
val () = println! ("xs = ", xs)
val () = println! ("xs(sorted) = ", mergesort<int>(xs))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [list_fold_split.dats] *)
