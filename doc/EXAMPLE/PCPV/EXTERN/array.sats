(* ****** ****** *)
//
// HX-2014-01-25:
// infseq-indexed arrays
//
(* ****** ****** *)

staload "./infseq.sats"

(* ****** ****** *)
//
abstype T(x:stamp)
//
(* ****** ****** *)

dataview
array_v
  (addr, infseq, int) =
  | {l:addr}{xs:infseq}
    array_v_nil (l, xs, 0) of ()
  | {l:addr}{xs:infseq}{x:stamp}{n:int}
    array_v_cons (l, cons (x, xs), n+1) of (T(x) @ l, array_v (l+1, xs, n))
// end of [array_v]

(* ****** ****** *)

prfun
array_v_split
  {l:addr}{xs:infseq}
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
  {xs1,xs2:infseq}
  {n1,n2:int}
(
  pf1: array_v(l, xs1, n1)
, pf2: array_v(l+n1, xs2, n2)
) :
(
  array_v (l, append (xs1, n1, xs2, n2), n1+n2)
) (* end of [array_v_unsplit] *)

(* ****** ****** *)
//
fun array_get_at
  {l:addr}{xs:infseq}
  {n:int}{i:nat | i < n}
  (pf: !array_v(l, xs, n) | p: ptr(l), i: int i) : T(select(xs, i))
// end of [array_get_at]
//
fun array_set_at
  {l:addr}
  {xs:infseq}{x:stamp}
  {n:int}{i:nat | i < n}
(
  pf: !array_v(l, xs, n) >> array_v (l, update (xs, i, x), n) | p: ptr(l), i: int i, x: T(x)
) : void // end of [array_set_at]
//
(* ****** ****** *)

(* end of [array.sats] *)
