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
  (infseq, addr, int) =
  | {xs:infseq}{l:addr}
    array_v_nil (xs, l, 0) of ()
  | {xs:infseq}{x:stamp}{l:addr}{n:int}
    array_v_cons (cons (x, xs), l, n+1) of (T(x) @ l, array_v (xs, l+1, n))
// end of [array_v]

(* ****** ****** *)

prfun
array_v_split
  {xs:infseq}{l:addr}
  {n:int}{i:nat | i <= n}
(
  pf: array_v(xs, l, n), i: int (i)
) : (
  array_v (take(xs, i), l, i)
, array_v (drop(xs, i), l+i, n-i)
) (* end of [array_v_split] *)

(* ****** ****** *)

prfun
array_v_unsplit
  {xs1,xs2:infseq}
  {l:addr}{n1,n2:int}
(
  pf1: array_v(xs1, l, n1)
, pf2: array_v(xs2, l+n1, n2)
) :
(
  array_v (append (xs1, n1, xs2, n2), l, n1+n2)
) (* end of [array_v_unsplit] *)

(* ****** ****** *)
//
fun array_get_at
  {xs:infseq}{l:addr}
  {n:int}{i:nat | i < n}
  (pf: !array_v(xs, l, n) | p: ptr(l), i: int i) : T(select(xs, i))
// end of [array_get_at]
//
fun array_set_at
  {xs:infseq}{x:stamp}
  {l:addr}{n:int}{i:nat | i < n}
(
  pf: !array_v(xs, l, n) >> array_v (update (xs, i, x), l, n) | p: ptr(l), i: int i, x: T(x)
) : void // end of [array_set_at]
//
(* ****** ****** *)

(* end of [array.sats] *)
