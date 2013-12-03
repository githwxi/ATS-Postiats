(*
** Implementing UTFPL
** with substitution-based evaluation
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "./../utfpl.sats"

(* ****** ****** *)

staload "./eval_subst.sats"

(* ****** ****** *)

extern
fun
d2varlst_contains (d2varlst, d2var): bool

implement
d2varlst_contains
  (d2vs, d2v0) = let
//
implement
list_exists$pred<d2var> (d2v) = d2v0 = d2v
//
in
  list_exists<d2var> (d2vs)
end // end of [d2varlst_contains]

(* ****** ****** *)

extern
fun
subst_d2varlst_find
  (subst, d2varlst, d2var): Option_vt (d2exp)
// end of [subst_d2varlst_find]

implement
subst_d2varlst_find
  (sub, d2vs, d2v0) = let
//
val isexi = d2varlst_contains (d2vs, d2v0)
//
in
  if isexi then None_vt(*void*) else subst_find (sub, d2v0)
end // end of [subst_d2varlst_find]

(* ****** ****** *)

fun d2varlst_add_p2at
(
  d2vs: d2varlst, p2t0: p2at
) : d2varlst = let
in
//
case+
p2t0.p2at_node of
//
| P2Tany _ => d2vs
| P2Tvar (d2v) =>
    list_cons{d2var}(d2v, d2vs)
//
| P2Tpat p2t => d2varlst_add_p2at (d2vs, p2t)
//
| P2Tignored _ => d2vs
//
end // end of [d2varlst_add_p2atlst]

and d2varlst_add_p2atlst
(
  d2vs: d2varlst, p2ts: p2atlst
) : d2varlst = let
in
//
case+ p2ts of
| list_cons
    (p2t, p2ts) => let
    val d2vs =
      d2varlst_add_p2at (d2vs, p2t)
    // end of [val]
  in
    d2varlst_add_p2atlst (d2vs, p2ts)
  end // end of [list_cons]
| list_nil ((*void*)) => d2vs
//
end // end of [d2varlst_add_p2atlst]

(* ****** ****** *)

implement
subst_d2exp
  (d2e0, sub) = let
//
fun aux
(
  d2e0: d2exp
, d2vs0: d2varlst, flag: &int >> _
) : d2exp = let
  val loc0 = d2e0.d2exp_loc
in
//
case+
d2e0.d2exp_node of
//
| D2Evar (d2v) => let
    val opt =
      subst_d2varlst_find (sub, d2vs0, d2v)
    // end of [val]
  in
    case+ opt of
    | ~None_vt () => d2e0
    | ~Some_vt (d2e) => (flag := flag + 1; d2e)
  end // end of [D2Evar]
| D2Ecst _ => d2e0
//
| D2Eint _ => d2e0
| D2Echar _ => d2e0
| D2Efloat _ => d2e0
| D2Estring _ => d2e0
//
| D2Eempty _ => d2e0
//
| D2Eexp (d2e) => let
    val flag0 = flag
    val d2e = aux (d2e, d2vs0, flag)
  in
    if flag > flag0 then d2exp_exp (loc0, d2e) else d2e0
  end // end of [D2Eexp]
//
| D2Eifopt
    (_test, _then, _else) => let
    val flag0 = flag
    val _test = aux (_test, d2vs0, flag)
    val _then = aux (_then, d2vs0, flag)
    val _else = auxopt (_else, d2vs0, flag)
  in
    if flag > flag0 then d2exp_ifopt (loc0, _test, _then, _else) else d2e0
  end // end of [D2Eifopt]
//
| D2Eapplst
    (d2e1, d2as2) => let
    val flag0 = flag
    val d2e1 = aux (d2e1, d2vs0, flag)
    val d2as2 = auxarglst (d2as2, d2vs0, flag)
  in
    if flag > flag0 then d2exp_applst (loc0, d2e1, d2as2) else d2e0
  end // end of [D2Eapp]
//
| D2Elam
    (p2ts, d2e) => let
    val flag0 = flag
    val d2vs0 =
      d2varlst_add_p2atlst (d2vs0, p2ts)
    val d2e = aux (d2e, d2vs0, flag)
  in
    if flag > flag0 then d2exp_lam (loc0, p2ts, d2e) else d2e0
  end // end of [D2Elam]
//
| _ =>
  (
    let val () = assertloc (false) in exit (1) end
  ) // end of [_]
//
end // end of [aux]
//
and auxlst
(
  d2es0: d2explst, d2vs0: d2varlst, flag: &int >> _
) : d2explst = let
in
//
case+ d2es0 of
| list_cons
    (d2e, d2es) => let
    val flag0 = flag
    val d2e = aux (d2e, d2vs0, flag)
    val d2es = auxlst (d2es, d2vs0, flag)
  in
    if flag > flag0 then list_cons{d2exp}(d2e, d2es) else d2es0
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxlst]
//
and auxopt
(
  opt0: d2expopt, d2vs0: d2varlst, flag: &int >> _
) : d2expopt = let
in
//
case+ opt0 of
| Some (d2e) => let
    val flag0 = flag
    val d2e = aux (d2e, d2vs0, flag)
  in
    if flag0 > flag then Some{d2exp}(d2e) else opt0
  end // end of [Some]
| None () => None ()
//
end // end of [auxopt]
//
and auxarg
(
  d2a0: d2exparg, d2vs0: d2varlst, flag: &int >> _
) : d2exparg = let
in
//
case+ d2a0 of
| D2EXPARGsta _ => d2a0
| D2EXPARGdyn (knd, loc, d2es) => let
    val flag0 = flag
    val d2es = auxlst (d2es, d2vs0, flag)
  in
    if flag > flag0 then D2EXPARGdyn (knd, loc, d2es) else d2a0
  end // end of [D2EXPARGarg]
//
end // end of [auxarg]
//
and auxarglst
(
  d2as0: d2exparglst, d2vs0: d2varlst, flag: &int >> _
) : d2exparglst = let
in
//
case+ d2as0 of
| list_cons
    (d2a, d2as) => let
    val flag0 = flag
    val d2a = auxarg (d2a, d2vs0, flag)
    val d2as = auxarglst (d2as, d2vs0, flag)
  in
    if flag > flag0 then list_cons{d2exparg}(d2a, d2as) else d2as0
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxarglst]
//
var flag: int = 0
//
in
  aux (d2e0, list_nil(*d2vs*), flag)
end // end of [subst_d2exp]

(* ****** ****** *)

local
//
typedef
d2varexp = @(d2var, d2exp)
//
assume subst_type = List0 (d2varexp)
//
in (* end of [local] *)

implement
subst_find (sub, d2v0) = let
//
fun loop
(
  xs: List0(d2varexp)
) : Option_vt (d2exp) =
  case+ xs of
  | list_cons (x, xs) =>
      if d2v0 = x.0 then Some_vt{d2exp}(x.1) else loop (xs)
  | list_nil ((*void*)) => None_vt ()
//
in
  loop (sub)
end // end of [subst_find]

end // end of [local]

(* ****** ****** *)

(* end of [subst.dats] *)
