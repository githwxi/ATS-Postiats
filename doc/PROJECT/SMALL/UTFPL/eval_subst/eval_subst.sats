(*
** Implementing UTFPL
** with substitution-based evaluation
*)

(* ****** ****** *)

staload "./../utfpl.sats"

(* ****** ****** *)

abstype subst_type = ptr
typedef subst = subst_type

(* ****** ****** *)
//
// HX-2013-11:
// [d2e] is assumed to be closed
// d2exp_subst(d2e0, d2v, d2e) = d2e0[d2v->d2e]
//
fun d2exp_subst
  (d2e0: d2exp, sub: subst): d2exp
//
(* ****** ****** *)

fun subst_find
  (sub: subst, d2v: d2var): Option_vt(d2exp)
// end of [subst_find]

(* ****** ****** *)

(* end of [eval_subst.sats] *)
