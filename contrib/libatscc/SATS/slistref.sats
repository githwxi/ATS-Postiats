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
slistref_type(a:vt@ype)
//
typedef
slistref(a:vt@ype) = slistref_type(a)
//
(* ****** ****** *)

fun
slistref_make_nil
  {a:vt0p}(): slistref(a) = "mac#"

(* ****** ****** *)
//
fun
slistref_length
  {a:vt0p}(slistref(a)): intGte(0) = "mac#"
//
(* ****** ****** *)
//
fun
slistref_push
  {a:vt0p}(slistref(a), x0: a): void = "mac#"
//
(* ****** ****** *)
//
fun
slistref_pop_exn
  {a:vt0p}(slistref(a)): (a) = "mac#"
fun
slistref_pop_opt
  {a:vt0p}(slistref(a)): Option_vt(a) = "mac#"
//
(* ****** ****** *)
//
fun
slistref_foldleft
  {res:vt0p}{a:t0p}
(
  slistref(a), init: res, fopr: (res, a) -<cloref1> res
) : res = "mac#" // end of [slistref_foldleft]
//
fun
slistref_foldright
  {a:t0p}{res:vt0p}
(
  slistref(a), fopr: (a, res) -<cloref1> res, sink: res
) : res = "mac#" // end of [slistref_foldright]
//
(* ****** ****** *)

(* end of [slistref.sats] *)
