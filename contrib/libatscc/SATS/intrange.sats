(* ****** ****** *)
(*
** libatscc-common
*)
(* ****** ****** *)

(*
staload "./../basics.sats"
*)

(* ****** ****** *)
//
// HX-2013-04:
// intrange (l, r) is for
// integers i satisfying l <= i < r
//
(* ****** ****** *)
//
fun
int_repeat_lazy
  (n: int, f: lazy(void)): void = "mac#%"
fun
int_repeat_cloref
  (n: int, f: cfun0(void)): void = "mac#%"
fun
int_repeat_method
  (n: int)(f: cfun0(void)): void = "mac#%"
//
overload * with int_repeat_lazy of 100
//
overload repeat with int_repeat_lazy of 100
overload repeat with int_repeat_cloref of 100
overload .repeat with int_repeat_method of 100
//
(* ****** ****** *)
//
fun
int_exists_cloref
  (n: int, f: cfun1(int, bool)): bool = "mac#%"
fun
int_exists_method
  (n: int) (f: cfun1(int, bool)): bool = "mac#%"
//
fun
int_forall_cloref
  (n: int, f: cfun1(int, bool)): bool = "mac#%"
fun
int_forall_method
  (n: int) (f: cfun1(int, bool)): bool = "mac#%"
//
overload .exists with int_exists_method of 100
overload .forall with int_forall_method of 100
//
(* ****** ****** *)
//
fun
int_foreach_cloref
  (n: int, f: cfun1(int, void)): void = "mac#%"
fun
int_foreach_method
  (n: int) (f: cfun1(int, void)): void = "mac#%"
//
overload .foreach with int_foreach_method of 100
//
(* ****** ****** *)
//
fun
int_rforeach_cloref
  (n: int, f: cfun1(int, void)): void = "mac#%"
fun
int_rforeach_method
  (n: int) (f: cfun1(int, void)): void = "mac#%"
//
overload .rforeach with int_rforeach_method of 100
//
(* ****** ****** *)
//
fun
int_foldleft_cloref
  {res:t0p}
(
n0: int
,
ini: res, fopr: cfun2(res, int, res)
) : res = "mac#%" // end of [int_foldleft_cloref]
//
fun
int_foldleft_method
  {res:t0p}
(
n0: int, _: TYPE(res)
)
(
ini: res, fopr: cfun2(res, int, res)
) : res = "mac#%" // end of [int_foldleft_method]
//
overload
.foldleft with int_foldleft_method of 100
//
(* ****** ****** *)
//
fun
int_foldright_cloref
  {res:t0p}
(
n0: int
,
fopr: cfun2(int, res, res), snk: res
) : res = "mac#%" // end of [int_foldright_cloref]
//
fun
int_foldright_method
  {res:t0p}
(
n0: int, _: TYPE(res)
)
(
fopr: cfun2(int, res, res), snk: res
) : res = "mac#%" // end of [int_foldright_method]
//
overload
.foldright with int_foldright_method of 100
//
(* ****** ****** *)
//
fun
int_list_map_cloref
  {a:t0p}{n:nat}
(
 n: int(n), fopr: cfun(int, a)
) : list(a, n) = "mac#%" // end-of-fun
fun
int_list_map_method
  {a:t0p}{n:nat}
(
 n: int(n), _: TYPE(a))(fopr: cfun(int, a)
) : list(a, n) = "mac#%" // end-of-function
//
overload .list_map with int_list_map_method
//
(* ****** ****** *)
//
fun
int_list0_map_cloref
  {a:t0p}
  (int, fopr: cfun(int, a)): list0(a) = "mac#%"
//
fun
int_list0_map_method
  {a:t0p}
  (int, TYPE(a))(fopr: cfun(int, a)): list0(a) = "mac#%"
//
overload .list0_map with int_list0_map_method
//
(* ****** ****** *)
//
fun
int_stream_map_cloref
  {a:t0p}{n:nat}
(
n0: int(n), fopr: cfun1(natLt(n), a)
) : stream(a) = "mac#%"
fun
int_stream_map_method
  {a:t0p}{n:nat}
  (int(n), TYPE(a))
: (cfun1(natLt(n), a)) -<cloref1> stream(a) = "mac#%"
//
overload .stream_map with int_stream_map_method
//
(* ****** ****** *)
//
fun
int_stream_vt_map_cloref
  {a:vt0p}{n:nat}
(
n0: int(n), fopr: cfun1(natLt(n), a)
) : stream_vt(a) = "mac#%" // end-of-function
fun
int_stream_vt_map_method
  {a:vt0p}{n:nat}
  (int(n), TYPE(a))
: (cfun1(natLt(n), a)) -<lincloptr1> stream_vt(a) = "mac#%"
//
overload .stream_vt_map with int_stream_vt_map_method
//
(* ****** ****** *)
//
// HX-2016-07-27:
// no overloading for these int2-functions
//
fun
int2_exists_cloref
( n1: int, n2: int
, pred: cfun2(int, int, bool)): bool = "mac#%"
fun
int2_forall_cloref
( n1: int, n2: int
, pred: cfun2(int, int, bool)): bool = "mac#%"
//
fun
int2_foreach_cloref
( n1: int, n2: int
, fwork: cfun2(int, int, void)): void = "mac#%"
//
(* ****** ****** *)
//
fun
int_cross_exists_method
  (n1: int, n2: int)
  (pred: cfun2(int, int, bool)): bool = "mac#%"
fun
int_cross_forall_method
  (n1: int, n2: int)
  (pred: cfun2(int, int, bool)): bool = "mac#%"
//
overload .cross_exists with int_cross_exists_method
overload .cross_forall with int_cross_forall_method
//
(* ****** ****** *)
//
fun
int_cross_foreach_method
  (n1: int, n2: int)
  (fwork: cfun2(int, int, void)): void = "mac#%"
//
overload .cross_foreach with int_cross_foreach_method
//
(* ****** ****** *)
//
fun
intrange_exists_cloref
  (l: int, r: int, f: cfun1(int, bool)): bool = "mac#%"
fun
intrange_exists_method
  (lr: $tup(int, int))(pred: cfun(int, bool)): bool = "mac#%"
//
fun
intrange_forall_cloref
  (l: int, r: int, pred: cfun1(int, bool)): bool = "mac#%"
fun
intrange_forall_method
  (lr: $tup(int, int))(pred: cfun(int, bool)): bool = "mac#%"
//
overload .exists with intrange_exists_method
overload .forall with intrange_forall_method
//
(* ****** ****** *)
//
fun
intrange_foreach_cloref
  (l: int, r: int, fwork: cfun1(int, void)): void = "mac#%"
fun
intrange_foreach_method
  (lr: $tup(int, int))(fwork: cfun(int, void)): void = "mac#%"
//
overload .foreach with intrange_foreach_method
//
(* ****** ****** *)
//
fun
intrange_rforeach_cloref
  (l: int, r: int, fwork: cfun1(int, void)): void = "mac#%"
fun
intrange_rforeach_method
  (lr: $tup(int, int))(fwork: cfun(int, void)): void = "mac#%"
//
overload .rforeach with intrange_rforeach_method
//
(* ****** ****** *)
//
fun
intrange_foldleft_cloref
  {res:t@ype}
(
 l: int, r: int, ini: res, fopr: cfun2(res, int, res)
) : res = "mac#%" // end of [intrange_foldleft_cloref]
fun
intrange_foldleft_method
  {res:t@ype}
(
  lr: $tup(int, int), _: TYPE(res)
)(ini: res, fopr: cfun2(res, int, res)): res = "mac#%"
//
overload .foldleft with intrange_foldleft_method of 100
//
(* ****** ****** *)
//
fun
intrange_foldright_cloref
  {res:t@ype}
(
 l: int, r: int, fopr: cfun2(int, res, res), snk: res
) : res = "mac#%" // end of [intrange_foldright_cloref]
fun
intrange_foldright_method
  {res:t@ype}
(
lr: $tup(int, int), _: TYPE(res)
)(fopr: cfun2(int, res, res), snk: res): res = "mac#%"
//
overload .foldright with intrange_foldright_method of 100
//
(* ****** ****** *)
//
// HX-2016-07-27:
// no overloading for these intrange2-functions
//
fun
intrange2_exists_cloref
(
  l1: int, r1: int, l2: int, r2: int, f: cfun2(int, int, bool)
) : bool = "mac#%" // end of [intrange2_exists_cloref]
fun
intrange2_forall_cloref
(
  l1: int, r1: int, l2: int, r2: int, f: cfun2(int, int, bool)
) : bool = "mac#%" // end of [intrange2_forall_cloref]
//
fun
intrange2_foreach_cloref
(
  l1: int, r1: int, l2: int, r2: int, f: cfun2(int, int, void)
) : void = "mac#%" // end of [intrange2_foreach_cloref]
//
(* ****** ****** *)

(* end of [intrange.sats] *)
