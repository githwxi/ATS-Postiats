(* ****** ****** *)
//
// HX-2014-01-25:
// stampseq-indexed lists
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
datavtype
list_vt (stmsq, int) =
  | list_vt_nil (nil, 0)
  | {xs:stmsq}{x:stamp}{n:nat}
    list_vt_cons (cons (x, xs), n+1) of (T(x), list_vt (xs, n))
//
(* ****** ****** *)

fun list_vt_nth
  {xs:stmsq}{n:int}{i:nat | i < n}
  (xs: !list_vt (xs, n), i: int (i)): T (select(xs, i))
// end of [list_vt_nth]

(* ****** ****** *)

fun list_vt_append
  {xs,ys:stmsq}{m,n:nat}
  (list_vt (xs, m), list_vt (ys, n)) : list_vt (append(xs, m, ys, n), m+n)

(* ****** ****** *)

(* end of [list_vt.sats] *)
