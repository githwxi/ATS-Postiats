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
(* ****** ****** *)
//
fun//{}
list_stdev
  (xs: List2(double)): double
//
(* ****** ****** *)
//
fun//{}
list_smooth
  (xs: List0(double), k: intGte(1)): stream_vt(double)
//
(* ****** ****** *)

(* end of [andes_comp.sats] *)
