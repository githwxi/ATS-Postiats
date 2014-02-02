(* ****** ****** *)
//
// HX-2014-01-25:
// stampseq-indexed arrays
//
(* ****** ****** *)

staload "./stampseq.sats"

(* ****** ****** *)
//
abstype T(x:stamp)
//
(* ****** ****** *)
//
fun lt_T_T
  {x1,x2:stamp} (T(x1), T(x2)): bool (x1 < x2)
fun lte_T_T
  {x1,x2:stamp} (T(x1), T(x2)): bool (x1 <= x2)
fun gt_T_T
  {x1,x2:stamp} (T(x1), T(x2)): bool (x1 > x2)
fun gte_T_T
  {x1,x2:stamp} (T(x1), T(x2)): bool (x1 >= x2)
fun compare_T_T
  {x1,x2:stamp} (T(x1), T(x2)): int (sgn(x1-x2))
//
overload < with lt_T_T
overload <= with lte_T_T
overload > with gt_T_T
overload >= with gte_T_T
//
overload compare with compare_T_T
//
(* ****** ****** *)
//
fun add_ptr_int
  {l:addr}{i:int} (ptr l, int i):<> ptr (l+i)
fun sub_ptr_int
  {l:addr}{i:int} (ptr l, int i):<> ptr (l-i)
//
overload + with add_ptr_int
overload - with sub_ptr_int
//
(* ****** ****** *)

dataview
array_v
  (addr, stmsq, int) =
  | {l:addr}{xs:stmsq}
    array_v_nil (l, nil, 0) of ()
  | {l:addr}{xs:stmsq}{x:stamp}{n:int}
    array_v_cons (l, cons (x, xs), n+1) of (T(x) @ l, array_v (l+1, xs, n))
// end of [array_v]

(* ****** ****** *)

prfun
array_v_split
  {l:addr}{xs:stmsq}
  {n:int}{i:nat | i <= n}
(
  pf: array_v(l, xs, n), i: int (i)
) : (
  array_v (l, take(xs, i), i)
, array_v (l+i, drop(xs, i), n-i)
) (* end of [array_v_split] *)

(* ****** ****** *)

prfun
array_v_unsplit
  {l:addr}
  {xs1,xs2:stmsq}
  {n1,n2:int}
(
  pf1: array_v(l, xs1, n1)
, pf2: array_v(l+n1, xs2, n2)
) :
(
  array_v (l, append (xs1, n1, xs2, n2), n1+n2)
) (* end of [array_v_unsplit] *)

(* ****** ****** *)

fun array_ptrget
  {l:addr}{xs:stmsq}
  {n:int}{i:nat | i < n}
  (pf: !array_v(l, xs, n) | p: ptr(l+i)) : T(select(xs, i))
// end of [array_ptrget]

fun array_ptrset
  {l:addr}
  {xs:stmsq}{x:stamp}
  {n:int}{i:nat | i < n}
(
  pf: !array_v(l, xs, n) >> array_v (l, update (xs, i, x), n) | p: ptr(l+i), x: T(x)
) : void // end of [array_ptrset]

(* ****** ****** *)
//
fun array_get_at
  {l:addr}{xs:stmsq}
  {n:int}{i:nat | i < n}
  (pf: !array_v(l, xs, n) | p: ptr(l), i: int i) : T(select(xs, i))
// end of [array_get_at]
//
fun array_set_at
  {l:addr}
  {xs:stmsq}{x:stamp}
  {n:int}{i:nat | i < n}
(
  pf: !array_v(l, xs, n) >> array_v (l, update(xs, i, x), n) | p: ptr(l), i: int i, x: T(x)
) : void // end of [array_set_at]
//
(* ****** ****** *)

fun array_ptrswap
  {l:addr}
  {xs:stmsq}{x:stamp}
  {n:int}{i,j:nat | i < n}
(
  pf: !array_v(l, xs, n) >> array_v (l, swap_at(xs, i, j), n) | p1: ptr(l+i), p2: ptr(l+j)
) : void // end of [array_ptrswap

(* ****** ****** *)

(* end of [array.sats] *)
