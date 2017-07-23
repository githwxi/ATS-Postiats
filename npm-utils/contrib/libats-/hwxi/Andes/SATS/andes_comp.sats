(* ****** ****** *)
(*
** For Andes
** computational aspect
*)
(* ****** ****** *)

typedef
List1(a:t@ype) = listGte(a, 1)
typedef
List2(a:t@ype) = listGte(a, 2)

(* ****** ****** *)
//
fun//{}
list_mean
  (xs: List1(double)): double
//
fun//{}
listpre_mean
  (xs: List1(double), n0: intGte(1)): double
//
(* ****** ****** *)
//
fun//{}
list_stdev
  (xs: List2(double)): double
//
fun//{}
listpre_stdev
  (xs: List2(double), n0: intGte(2)): double
//
(* ****** ****** *)
//
fun//{}
list_ratios
  (xs: listGte(double, 1)): stream_vt(double)
fun//{}
list_change_ratios
  (xs: listGte(double, 1)): stream_vt(double)
//
(* ****** ****** *)
//
fun
{a:t@ype}
list_rolling
  (xs: List(INV(a)), width: intGte(0)): stream_vt(List1(a))
//
(* ****** ****** *)
//
fun//{}
list_smooth_bef
  (xs: List(double), n: intGte(1)): stream_vt(double)
fun//{}
list_smooth_aft
  (xs: List(double), n: intGte(1)): stream_vt(double)
//
(* ****** ****** *)

(* end of [andes_comp.sats] *)
