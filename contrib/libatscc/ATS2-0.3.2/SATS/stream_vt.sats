(*
** libatscc-common
*)

(* ****** ****** *)

(*
staload "./../basics.sats"
*)

(* ****** ****** *)
//
fun{}
stream_vt_make_nil
  {a:vt0p}(): stream_vt(a) = "mac#%"
fun{}
stream_vt_make_sing
  {a:t0p}(x0: a): stream_vt(a) = "mac#%"
//
(* ****** ****** *)
//
fun
stream_vt_free
  {a:vt0p}
  (stream_vt(a)):<!wrt> void = "mac#%"
//
(* ****** ****** *)
//
fun
stream_vt2t
  {a:t0p}
(
xs: stream_vt(INV(a))
) :<!wrt> stream(a) = "mac#%" // endfun
//
(* ****** ****** *)
//
fun
stream_vt_length
  {a:t0p}
  (stream_vt(INV(a))): intGte(0) = "mac#%"
//
(* ****** ****** *)
//
fun
stream_vt_takeLte
  {a:vt0p}
(
xs: stream_vt(INV(a)), n0: intGte(0)
) :<> stream_vt(a) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
stream2list_vt
  {a:vt0p}
  (stream_vt(INV(a))): List0_vt(a) = "mac#%"
fun
stream2list_vt_rev
  {a:vt0p}
  (stream_vt(INV(a))): List0_vt(a) = "mac#%"
//
(* ****** ****** *)
//
fun
stream_vt_append
  {a:vt0p}
(
  stream_vt(INV(a)), stream_vt(a)
) :<> stream_vt(a) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
stream_vt_concat
  {a:vt0p}
(
  xss: stream_vt(stream_vt(INV(a)))
) :<> stream_vt(a) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
stream_vt_map_cloref
  {a:vt0p}{b:vt0p}
(
  xs: stream_vt(INV(a)), fopr: (a) -<cloref1> b
) : stream_vt(b) = "mac#%" // end-of-function
fun
stream_vt_map_method
  {a:vt0p}{b:vt0p}
(
xs: stream_vt(INV(a)), TYPE(b)
) :
(
 (a) -<cloref1> b
) -<lincloptr1> stream_vt(b) = "mac#%" // endfun
//
(* ****** ****** *)
//
fun
stream_vt_filter_cloref
  {a:t0ype}
(
  xs: stream_vt(INV(a)), pred: (a) -<cloref1> bool
) : stream_vt(a) = "mac#%" // end-of-function
fun
stream_vt_filter_method
  {a:t0ype}
(
xs: stream_vt(INV(a))
) :
(
  (a) -<cloref1> bool
) -<lincloptr1> stream_vt(a) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
stream_vt_exists_cloref
  {a:t0ype}
(
stream_vt(INV(a)), pred: (a) -<cloref1> bool
) : bool = "mac#%" // end-of-function
fun
stream_vt_exists_method
  {a:t0ype}
(
xs: stream_vt(INV(a))
) : ((a) -<cloref1> bool) -<lincloptr1> bool = "mac#%"
//
(* ****** ****** *)
//
fun
stream_vt_forall_cloref
  {a:t0ype}
(
stream_vt(INV(a)), pred: (a) -<cloref1> bool
) : bool = "mac#%" // end-of-function
fun
stream_vt_forall_method
  {a:t0ype}
(
xs: stream_vt(INV(a))
) : ((a) -<cloref1> bool) -<lincloptr1> bool = "mac#%"
//
(* ****** ****** *)
//
fun
stream_vt_foreach_cloref
  {a:vt0ype}
(
xs: stream_vt(INV(a)), fwork: (a) -<cloref1> void
) : void = "mac#%" // end-of-function
fun
stream_vt_foreach_method
  {a:vt0ype}
(
xs: stream_vt(INV(a))
) :<> ((a) -<cloref1> void) -<lincloptr1> void = "mac#%"
//
(* ****** ****** *)
//
fun
stream_vt_iforeach_cloref
  {a:vt0ype}
(
xs: stream_vt(INV(a)), fwork: (Nat, a) -<cloref1> void
) : void = "mac#%" // end-of-function
fun
stream_vt_iforeach_method
  {a:vt0ype}
(
xs: stream_vt(INV(a))
) :<> ((Nat, a) -<cloref1> void) -<lincloptr1> void = "mac#%"
//
(* ****** ****** *)
//
fun
stream_vt_rforeach_cloref
  {a:vt0ype}
(
xs: stream_vt(INV(a)), fwork: (a) -<cloref1> void
) : void = "mac#%" // end-of-function
fun
stream_vt_rforeach_method
  {a:vt0ype}
(
xs: stream_vt(INV(a))
) :<> ((a) -<cloref1> void) -<lincloptr1> void = "mac#%"
//
(* ****** ****** *)
//
fun
stream_vt_tabulate_cloref
  {a:t0p}
  (fopr: intGte(0) -<cloref1> a): stream_vt(a) = "mac#%"
//
(* ****** ****** *)
//
overload length with stream_vt_length of 100
overload append with stream_vt_append of 100
overload concat with stream_vt_concat of 100
//
overload .takeLte with stream_vt_takeLte of 100
//
overload .map with stream_vt_map_method of 100
overload .filter with stream_vt_filter_method of 100
overload .foreach with stream_vt_foreach_method of 100
overload .iforeach with stream_vt_iforeach_method of 100
overload .rforeach with stream_vt_rforeach_method of 100
//
(* ****** ****** *)

(* end of [stream_vt.sats] *)
