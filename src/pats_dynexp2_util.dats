(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: May, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)
//
staload
LAB = "./pats_label.sats"
//
(* ****** ****** *)
//
staload
LOC =
"./pats_location.sats"
//
overload + with $LOC.location_combine
//
(* ****** ****** *)
//
staload
SYN = "./pats_syntax.sats"
//
(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
p2atlst_tupize
  (p2ts) = let
//
fun
aux
(
  p2ts: p2atlst, n: int
) : labp2atlst =
  case+ p2ts of
  | list_cons
      (p2t, p2ts) => let
      val loc = p2t.p2at_loc
      val l = $LAB.label_make_int (n)
      val l0 = $SYN.l0ab_make_label (loc, l)
      val lp2t = LABP2ATnorm (l0, p2t)
    in
      list_cons (lp2t, aux (p2ts, n+1))
    end // end of [list_vt_cons]
  | list_nil ((*void*)) => list_nil ()
// end of [aux]
//
in
  aux (p2ts, 0)
end // end of [p2atlst_tupize]

(* ****** ****** *)

implement
d2exp_is_lam
  (d2e0) = let
//
fun
aux
(
  d2e0: d2exp
) : bool = let
in
//
case+
d2e0.d2exp_node
of // case+
| D2Elam_dyn _ => true
//
| D2Elam_sta
    (_, _, d2e) => aux(d2e)
//
| D2Elam_met
    (_, _, d2e) => aux(d2e)
//
| D2Efix(_, _, d2e) => aux(d2e)
//
| D2Esing(d2e) => aux(d2e)
//
| D2Eann_type (d2e, _) => aux(d2e)
| D2Eann_seff (d2e, _) => aux(d2e)
| D2Eann_funclo (d2e, _) => aux(d2e)
//
| _ (*rest-of-d2exp*) => false
//
end // end of [aux]
//
in
  aux(d2e0)
end // end of [d2exp_is_lam]

(* ****** ****** *)

implement
d2exp_is_varlamcst
  (d2e0) = let
//
fun
aux
(
  d2e0: d2exp
) : bool = let
in
//
case+
d2e0.d2exp_node
of // case+
//
| D2Evar d2v =>
  (
    if d2var_is_mutabl(d2v) then false else true
  ) // end of [D2Evar]
//
| D2Elam_dyn _ => true
//
| D2Elam_sta _ => true
| D2Elam_met _ => true
(*
//
// HX: not good for typechecking
//
| D2Elam_sta (_, _, d2e) => aux(d2e)
| D2Elam_met (_, _, d2e) => aux(d2e)
*)
//
| D2Efix _ => true
//
| D2Eint _ => true
| D2Ebool _ => true
| D2Echar _ => true
| D2Estring _ => true
| D2Ei0nt _ => true
| D2Ec0har _ => true
| D2Es0tring _ => true
//
| D2Etop _ => true
//
| D2Esing(d2e) => aux(d2e)
//
| D2Etup(knd, npf, d2es) => auxlst(d2es)
| D2Erec(knd, npf, ld2es) => auxlablst(ld2es)
//
| D2Eexist(s2as, d2e) => aux (d2e)
//
| _ (*rest-of-d2exp*) => false
//
end // end of [aux]
//
and
auxlst
(
  d2es: d2explst
) : bool =
(
case+ d2es of
| list_nil () => true
| list_cons (d2e, d2es) =>
    if aux(d2e) then auxlst(d2es) else false
  // end of [list_cons]
)
//
and
auxlablst
(
  ld2es: labd2explst
) : bool =
(
case+ ld2es of
| list_nil () => true
| list_cons
    (ld2e, ld2es) => let
    val $SYN.DL0ABELED(l, d2e) = ld2e
  in
    if aux(d2e) then auxlablst(ld2es) else false
  end // end of [list_cons]
)
//
in
  aux(d2e0)
end // end of [d2exp_is_varlamcst]

(* ****** ****** *)

implement
d2con_select_arity
  (d2cs, n) = let
  val nd2cs = list_length (d2cs)
in
//
if
nd2cs >= 2
then let
//
  var !p_clo =
  @lam (
    pf: !unit_v | d2c: d2con
  ) : bool =<clo1> d2con_get_arity_full (d2c) = n
//
  prval pfu = unit_v ()
  val d2cs2 = list_filter_vclo{unit_v}(pfu | d2cs, !p_clo)
  prval unit_v () = pfu
//
  val d2cs2 = (l2l)d2cs2
//
in
  case+ d2cs2 of list_cons _ => d2cs2 | list_nil () => d2cs
end // end of [then]
else d2cs // end of [else]
//
end // end of [d2con_select_arity]

(* ****** ****** *)

local

fun
d2exp_d2var_lvalize
(
  d2e0: d2exp, d2v: d2var, d2ls: d2lablst
) : d2lval =
  case+ 0 of
  | _ when d2var_is_linear (d2v) => D2LVALvar_lin (d2v, d2ls)
  | _ when d2var_is_mutabl (d2v) => D2LVALvar_mut (d2v, d2ls)
  | _ => D2LVALnone (d2e0) // end of [_]
// end of [d2var_lvalize]

in (* in-of-local *)

implement
d2exp_lvalize
  (d2e0) = let
(*
val () = (
  println! ("d2exp_lvalize: d2e0 = ", d2e0)
) // end of [val]
*)
in
//
case+
d2e0.d2exp_node
of // case+
//
| D2Evar(d2v) =>
  d2exp_d2var_lvalize(d2e0, d2v, list_nil)
//
| D2Ederef
    (_(*!*), d2e) => D2LVALderef(d2e, list_nil)
  // end of [D2Ederef]
//
| D2Eselab
  (
    d2e, d2ls
  ) => (
  case+
  d2e.d2exp_node
  of (* case+ *)
  | D2Evar(d2v) =>
      d2exp_d2var_lvalize(d2e0, d2v, d2ls)
    // end of [D2Evar]
  | D2Ederef(_(*!*), d2e) => D2LVALderef(d2e, d2ls)
  | _ (*rest-of-d2exp*) => D2LVALnone (d2e0)
  ) (* end of [D2Esel] *)
//
| D2Eviewat (d2e) => D2LVALviewat (d2e)
//
| D2Earrsub (
    d2s, arr, loc_ind, ind
  ) => D2LVALarrsub (d2s, arr, loc_ind, ind)
//
| D2Esing (d2e) => d2exp_lvalize (d2e)
//
| _ (*rest-of-d2exp*) => D2LVALnone (d2e0)
//
end // end of [d2exp_lvalize]

end // end of [val]

(* ****** ****** *)

local

typedef intlst = List (int)

fn p1at_arity
  (p1t: p1at): int =
(
  case+ p1t.p1at_node of
  | P1Tlist (npf, p1ts) => list_length (p1ts) | _ => 1
) (* end of [p1at_arity] *)

fn aritest
  (d1e: d1exp, ns: intlst): bool = let
  fn* loop1
  (
    d1e: d1exp, ns: intlst
  ) : bool =
    case+ ns of
    | list_nil () => true
    | list_cons (n, ns) => loop2 (d1e, n, ns)
  // end of [loop1]
  and loop2
  (
    d1e: d1exp, n: int, ns: intlst
  ) : bool =
    case+ d1e.d1exp_node of
    | D1Elam_dyn
        (_(*lin*), p1t, d1e) =>
      (
        if n = p1at_arity (p1t) then loop1 (d1e, ns) else false
      )
    | D1Elam_met (_, _, d1e) => loop2 (d1e, n, ns)
    | D1Elam_sta_ana (_, _, d1e) => loop2 (d1e, n, ns)
    | D1Elam_sta_syn (_, _, d1e) => loop2 (d1e, n, ns)
    | _ (*non-D1Elam*) => false
  // end of [loop2]
in
  loop1 (d1e, ns)
end // end of [aritest]

in (* in-of-local *)

implement
d2cst_match_def
  (d2c, def) = let
  val ns = d2cst_get_artylst (d2c) in aritest (def, ns)
end // end of [d2cst_match_def]

end // end of [local]

(* ****** ****** *)

implement
d2exp_get_seloverld
  (d2e0) = let
//
fun aux
  (d2ls: d2lablst) : d2symopt =
(
  case+ d2ls of
  | list_nil () => None((*void*))
  | list_cons (d2l, d2ls) => aux2 (d2l, d2ls)
) (* end of [aux] *)
//
and aux2
(
  d2l: d2lab, d2ls: d2lablst
) : d2symopt =
(
case+ d2ls of
| list_nil () => d2l.d2lab_overld
| list_cons (d2l, d2ls) => aux2 (d2l, d2ls)
) (* end of [aux2] *)
//
in
//
case+ d2e0.d2exp_node of
  D2Eselab (d2e, d2ls) => aux (d2ls) | _ => None()
//
end // end of [d2exp_get_seloverld]

(* ****** ****** *)

implement
d2exp_get_seloverld_root
  (d2e0) = let
//
val-D2Eselab
  (d2e, d2ls) = d2e0.d2exp_node
//
val-list_cons (d2l1, d2ls) = d2ls
//
fun aux
(
  d2e: d2exp
, d2l1: d2lab
, d2l2: d2lab
, d2ls: d2lablst
, res: List_vt(d2lab)
) : d2exp =
(
case+ d2ls of
| list_nil () => let
    val loc =
      d2e.d2exp_loc + d2l1.d2lab_loc
    // end of [val]
    val res = list_vt_cons (d2l1, res)
  in
    d2exp_selab (loc, d2e, l2l(list_vt_reverse(res)))
  end // end of [list_nil]
| list_cons (d2l3, d2ls) =>
  (
    aux (d2e, d2l2, d2l3, d2ls, list_vt_cons (d2l1, res))
  ) (* end of [list_cons] *)
)
//
in
//
case+ d2ls of
| list_nil () => d2e
| list_cons (d2l2, d2ls) =>
  (
    aux (d2e, d2l1, d2l2, d2ls, list_vt_nil())
  ) (* end of [list_cons] *)
//
end // end of [d2exp_get_seloverld_root]

(* ****** ****** *)

(* end of [pats_dynexp2_util.dats] *)
