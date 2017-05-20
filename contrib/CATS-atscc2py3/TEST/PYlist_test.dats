(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Python3
//
(* ****** ****** *)
//
#define
LIBATSCC2PY3_targetloc
"$PATSHOME\
/contrib/libatscc2py3/ATS2-0.3.2"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2PY3}/basics_py.sats"
staload
"{$LIBATSCC2PY3}/SATS/integer.sats"
staload
"{$LIBATSCC2PY3}/SATS/list.sats"
staload
"{$LIBATSCC2PY3}/SATS/PYlist.sats"
//
(* ****** ****** *)

implement
list_reverse{a}(xs) =
(
  list_reverse_append{a}(xs, list_nil(*void*))
) (* end of [list_reverse] *)

(* ****** ****** *)

implement
list_reverse_append
  {a}(xs, ys) = let
//
prval () = lemma_list_param (xs)
prval () = lemma_list_param (ys)
//
fun
loop{i,j:nat}
(
  xs: list(a, i), ys: list(a, j)
) : list(a, i+j) =
(
case+ xs of
| list_nil () => ys
| list_cons (x, xs) => loop (xs, list_cons (x, ys))
) (* end of [loop] *)
//
in
  loop (xs, ys)
end // end of [list_reverse_append]

(* ****** ****** *)
//
extern
fun
PYlist2list
  : {a:t0p} PYlist(a) -> List0(a) = "mac#"
//
implement
PYlist2list{a}(xs) = let
//
val res =
PYlist_reduce{List0(a)}{a}
  (xs, nil(), lam (xs, x) => cons (x, xs))
//
in
  list_reverse(res)
end // end of [PYlist2list]
//
(* ****** ****** *)
//
extern
fun
PYlist2list_rev
  : {a:t0p} PYlist(a) -> List0(a) = "mac#"
//
implement
PYlist2list_rev{a}(xs) =
(
//
PYlist_reduce{List0(a)}{a}
  (xs, nil(), lam (xs, x) => cons (x, xs))
//
) (* end of [PYlist2list_rev] *)
//
(* ****** ****** *)
//
extern
fun
PYlist_evnodd(PYlist(int)): void = "mac#"
//
implement
PYlist_evnodd(xs) =
  PYlist_sort_2(xs, lam(x, y) => (x%2 - y%2))
//
(* ****** ****** *)

%{^
import sys
######
from libatscc2py3_all import *
######
sys.setrecursionlimit(1000000)
######
%} // end of [%{^]

(* ****** ****** *)

%{$

def fromto(m, n):
  res = []
  for i in range(m, n): res.append (i)
  res.reverse
  return res

xs = fromto(0,10); print("xs =", xs)
PYlist_evnodd(xs); print("xs =", xs)
ys = PYlist2list(xs); print("ys =", ys)
ys_rev = PYlist2list_rev(xs); print("ys_rev =", ys_rev)

%} // end of [%{$]

(* ****** ****** *)

(* end of [PYlist_test.dats] *)
