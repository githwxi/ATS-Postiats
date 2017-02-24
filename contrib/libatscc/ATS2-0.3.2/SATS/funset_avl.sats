(*
** libatscc-common
*)

(* ****** ****** *)

(*
staload "./../basics.sats"
*)

(* ****** ****** *)
//
abstype
funset_t0ype_type(a:t@ype+)
//
typedef
funset(a:t0p) = funset_t0ype_type(a)
//
(* ****** ****** *)
//
fun
funset_make_nil
  {a:t0p}((*void*)): funset(a) = "mac#%"
//
(* ****** ****** *)
//
fun
funset_is_nil
  {a:t0p}(A: funset(INV(a))): bool = "mac#%"
fun
funset_is_cons
  {a:t0p}(A: funset(INV(a))): bool = "mac#%"
//
(* ****** ****** *)
//
fun
funset_size
  {a:t0p}(A: funset(INV(a))): intGte(0) = "mac#%"
//
(* ****** ****** *)
//
fun{a:t0p}
funset_insert
  (A: funset(INV(a)), x0: a): bool = "mac#%"
fun{a:t0p}
funset_remove
  (A: funset(INV(a)), x0: a): bool = "mac#%"
//
(* ****** ****** *)

fun{a:t0p}
funset_listize
  {a:t0p}(xs: funset(INV(a))):<!wrt> List0 (a)

(* ****** ****** *)
//
fun
funset_fold
  {a:t0p}{res:vt0p}
(
  xs: funset(INV(a))
, fopr: (a, res) -<cloref1> res, sink: res
) : res // end of [funset_fold]
//
(* ****** ****** *)
//
fun
funset_foreach
  {a:t0p}
(
  xs: funset(INV(a)), fwork: (a) -<cloref1> void
) : void // end of [funset_foreach]
//
(* ****** ****** *)

(* end of [funset_avl.sats] *)
