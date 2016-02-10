(*
** Author: Hongwei Xi
** Ahthoremail: hwxiATcsDOTbuDOTedu
** Time: February 9, 2016
*)

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"libats/SATS/ilist_prf.sats"
//
staload "libats/SATS/gflist.sats"
//
(* ****** ****** *)
//
typedef
cmp(a:t@ype) = cmpval_fun (a)
//
(* ****** ****** *)

extern
fun{a:t@ype}
mergesort_lst{xs:ilist}
(
  xs: gflist (a, xs), cmp: cmp a
) : gflist (a, ilist_sort(xs))

(* ****** ****** *)

stacst
ilist_merge : (ilist, ilist) -> ilist

(* ****** ****** *)
//
extern
praxi
lemma_ilist_merge_sort :
{xs,ys:ilist}((*void*)) ->
  ILISTEQ(ilist_sort(ilist_append(xs, ys)), ilist_merge(ilist_sort(xs), ilist_sort(ys)))
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
mergesort_lst(xs, cmp) = let
//
extern
fun
split
{ xs:ilist }
{ n1:nat
| n1 <= ilist_length(xs)
} (xs: gflist(a, xs), n1: int(n1))
:
( gflist(a, ilist_take(xs, n1))
, gflist(a, ilist_drop(xs, n1)))
//
extern
fun
merge
{xs,ys:ilist}
(
  xs: gflist(a, xs)
, ys: gflist(a, ys)
) : gflist(a, ilist_merge(xs, ys))
//
fun
msort
{xs:ilist}
(
  xs: gflist(a, xs)
, n0: int(ilist_length(xs))
) : gflist(a, ilist_sort(xs)) =
(
//
if
n0 >= 2
then let
  val n1 = half(n0)
  val (xs1, xs2) = split(xs, n1)
//
  stadef n0 =
  ilist_length(xs)
  stadef n1 = n0 / 2
  stadef n2 = n0 - n1
//
  stadef xs1 = ilist_take(xs, n1)
  stadef xs2 = ilist_drop(xs, n1)
  stadef xs12 = ilist_append(xs1,xs2)
//
  prval
  EQINT() =
  $UN.eqint_assert
  {n1,ilist_length(xs1)}((*void*))
  prval
  EQINT() =
  $UN.eqint_assert
  {n2,ilist_length(xs2)}((*void*))
  prval
  ILISTEQ() =
  $UN.proof_assert{ILISTEQ(xs,xs12)}()
  prval
  ILISTEQ() = lemma_ilist_merge_sort{xs1,xs2}()
//
in
  merge(msort(xs1, n1), msort(xs2, n0-n1))
end // [then]
else (xs) where
{
  prval
  ILISTEQ() =
  $UN.proof_assert{ILISTEQ(xs,ilist_sort(xs))}()
} (* end of [else] *)
//
) (* end of [msort] *)
//
val (pf | n0) = gflist_length(xs)
prval unit_p() = lemma_length_p2b(pf)
//
in
  msort(xs, n0)
end // end of [msort]

(* ****** ****** *)

(* end of [mergesort_lst.dat] *)
