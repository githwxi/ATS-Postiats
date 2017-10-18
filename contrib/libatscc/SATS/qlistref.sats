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
abstype
qlistref_type(a:vt@ype)
//
typedef
qlistref(a:vt@ype) = qlistref_type(a)
//
(* ****** ****** *)

fun
qlistref_make_nil
  {a:vt0p}((*void*)): qlistref(a) = "mac#%"

(* ****** ****** *)
//
fun
qlistref_length
  {a:vt0p}(qlistref(a)): intGte(0) = "mac#%"
//
(* ****** ****** *)
//
fun
qlistref_enqueue
  {a:vt0p}(qlistref(a), x0: a): void = "mac#%"
//
(* ****** ****** *)
//
fun
qlistref_dequeue_exn
  {a:vt0p}(qlistref(a)): (a) = "mac#%"
fun
qlistref_dequeue_opt
  {a:vt0p}(qlistref(a)): Option_vt(a) = "mac#%"
//
(* ****** ****** *)
//
fun
qlistref_foldleft
  {res:vt0p}{a:t0p}
(
  qlistref(a), init: res, fopr: (res, a) -<cloref1> res
) : res = "mac#%" // end of [qlistref_foldleft]
//
fun
qlistref_foldright
  {a:t0p}{res:vt0p}
(
  qlistref(a), fopr: (a, res) -<cloref1> res, sink: res
) : res = "mac#%" // end of [qlistref_foldright]
//
(* ****** ****** *)

(* end of [qlistref.sats] *)
