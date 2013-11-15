(*
** Implementing UTFPL
** with substitution-based evaluation
*)

(* ****** ****** *)

staload "./../utfpl.sats"

(* ****** ****** *)
//
// HX-2013-11:
// [d2e] is assumed to be closed
// d2exp_subst(d2e0, d2v, d2e) = d2e0[d2v->d2e]
//
extern
fun
d2exp_subst
  (d2e0: d2exp, d2v: d2var, d2e: d2exp): d2exp
//
(* ****** ****** *)

implement
d2exp_subst
(
  d2e0, d2v, d2e
) = let
//
fun aux
(
  d2e0: d2exp, flag: &int >> _
) : d2exp = let
  val loc0 = d2e0.d2exp_loc
in
//
case+
d2e0.d2exp_node of
//
| D2Evar (d2v1) =>
    if d2v = d2v1
      then let val () = flag := flag + 1 in d2e end
      else d2e0 // end of [else]
    // end of [if]
| D2Ecst _ => d2e0
| D2Eapp (d2e1, d2es2) => let
    val flag0 = flag
    val d2e1 = aux (d2e1, flag)
    val d2es2 = auxlst (d2es2, flag)
  in
    if flag > flag0 then d2exp_app (loc0, d2e1, d2es2) else d2e0
  end // end of [D2Eapp]
| _ =>
  (
    let val () = assertloc (false) in exit (1) end
  ) // end of [_]
//
end // end of [aux]
//
and auxlst
(
  d2es0: d2explst, flag: &int >> _
) : d2explst = let
in
//
case+ d2es0 of
| list_cons
    (d2e, d2es) => let
    val flag0 = flag
    val d2e = aux (d2e, flag)
    val d2es = auxlst (d2es, flag)
  in
    if flag > flag0 then list_cons{d2exp}(d2e, d2es) else d2es0
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxlst]
//
var flag: int = 0
//
in
  aux (d2e0, flag)
end // end of [d2exp_subst]

(* ****** ****** *)

(* end of [eval_subst.dats] *)
