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

fun subst_find
  (sub: subst, d2v: d2var): Option_vt(d2exp)
// end of [subst_find]

(* ****** ****** *)
//
// HX-2013-11:
// [sub] is assumed to be closed
//
fun subst_d2exp
  (d2e0: d2exp, sub: subst): d2exp
//
(* ****** ****** *)

fun eval_subst (d2exp): d2exp

(* ****** ****** *)

(* end of [eval_subst.sats] *)
