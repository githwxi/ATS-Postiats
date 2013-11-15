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

(* end of [eval_subst.sats] *)
