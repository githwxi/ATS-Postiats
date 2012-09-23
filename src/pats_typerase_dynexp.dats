(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: September, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload LAB = "pats_label.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_typerase.sats"

(* ****** ****** *)

extern
fun labhipatlst_get_labhisexplst (lxs: labhipatlst): labhisexplst
implement
labhipatlst_get_labhisexplst
  (lxs) = let
//
  fun f (lx: labhipat): labhisexp = let
    val LABHIPAT (l, x) = lx
  in
    HSLABELED (l, None(*name*), x.hipat_type)
  end // end of [f]
//
  val lhses = list_map_fun (lxs, f)
//
in
  list_of_list_vt (lhses)
end // end of [labhipatlst_get_labhisexplst]

(* ****** ****** *)

extern
fun p3atlst_npf_tyer (npf: int, p3ts: p3atlst): hipatlst
extern
fun labp3atlst_npf_tyer (npf: int, lp3ts: labp3atlst): labhipatlst

(* ****** ****** *)

implement
p3at_tyer (p3t0) = let
//
val loc0 = p3t0.p3at_loc
val s2e0 = p3at_get_type (p3t0)
val hse0 = s2exp_tyer_shallow (loc0, s2e0)
//
(*
val () = println! ("p3at_tyer: p3t0 = ", p3t0)
val () = println! ("p3at_tyer: s2e0 = ", s2e0)
val () = println! ("p3at_tyer: hse0 = ", hse0)
*)
//
in
//
case+ p3t0.p3at_node of
//
| P3Tany (d2v) => hipat_any (loc0, hse0)
| P3Tvar (d2v) => hipat_var (loc0, hse0, d2v)
//
| P3Tint (i) => hipat_int (loc0, hse0, i)
//
| P3Tbool (b) => hipat_bool (loc0, hse0, b)
| P3Tchar (c) => hipat_char (loc0, hse0, c)
| P3Tstring (str) => hipat_string (loc0, hse0, str)
//
| P3Tempty () => hipat_empty (loc0, hse0)
//
| P3Trec (
    knd, npf, lp3ts
  ) => let
    val lhips =
      labp3atlst_npf_tyer (npf, lp3ts)
    val lhses = labhipatlst_get_labhisexplst (lhips)
    val recknd = (
      if knd > 0 then TYRECKINDbox() else TYRECKINDflt0()
    ) : tyreckind
    val hse_rec = hisexp_tyrec (recknd, lhses)
  in
    hipat_rec (loc0, hse0, knd, lhips, hse_rec)
  end // end of [P3Trec]
| P3Tlst (
    lin, s2e_elt, p3ts
  ) => let
    val hse_elt =
      s2exp_tyer_shallow (loc0, s2e_elt)
    val hips = p3atlst_tyer (p3ts)
  in
    hipat_lst (loc0, hse0, hse_elt, hips)
  end // end of [P3Tlst]
//
| P3Tann
    (p3t, s2e_ann) => let
    val hip = p3at_tyer (p3t)
    val hse_ann = s2exp_tyer_shallow (loc0, s2e_ann)
  in
    hipat_ann (loc0, hse0, hip, hse_ann)
  end // end of [P3Tann]
//
| _ => let
    val () = println! ("p3at_tyer: p3t0 = ", p3t0)
  in
    exitloc (1)
  end // end of [_]
//
end // endof [p3at_tyer]

(* ****** ****** *)

implement
p3atlst_tyer
  (p3ts) = let
  val hips =
    list_map_fun (p3ts, p3at_tyer)
  // end of [val]
in
  list_of_list_vt (hips)
end // end of [p3atlst_tyer]

(* ****** ****** *)

implement
p3atlst_npf_tyer
  (npf, p3ts) = let
in
  if npf > 0 then let
    val- list_cons (_, p3ts) = p3ts
  in
    p3atlst_npf_tyer (npf-1, p3ts)
  end else
    p3atlst_tyer (p3ts)
  // end of [if]
end // end of [p3atlst_npf_tyer]

(* ****** ****** *)

local

fun labp3atlst_tyer
  (lxs: labp3atlst): labhipatlst = let
//
  fun f (
    lx: labp3at
  ) : labhipat = let
    val LABP3AT (l, x) = lx
  in
    LABHIPAT (l, p3at_tyer (x))
  end // end of [f]
//
  val lhips = list_map_fun (lxs, f)
in
  list_of_list_vt (lhips)
end // end of [labp3atlst_tyer]

in // in of [local]

implement
labp3atlst_npf_tyer
  (npf, lp3ts) = let
in
  if npf > 0 then let
    val- list_cons (_, lp3ts) = lp3ts
  in
    labp3atlst_npf_tyer (npf-1, lp3ts)
  end else
    labp3atlst_tyer (lp3ts)
  // end of [if]
end // end of [labp3atlst_npf_tyer]

end // end of [local]

(* ****** ****** *)

extern
fun d3exp_tyer_tmpcst (
  loc0: location, hse0: hisexp, d2c: d2cst, t2mas: t2mpmarglst
) : hidexp // end of [d3exp_tyer_tmpcst]
extern
fun d3exp_tyer_tmpvar (
  loc0: location, hse0: hisexp, d2v: d2var, t2mas: t2mpmarglst
) : hidexp // end of [d3exp_tyer_tmpvar]

extern
fun d3explst_npf_tyer (npf: int, d3es: d3explst): hidexplst
extern
fun d3explst_npf_tyer_recize (npf: int, d3es: d3explst): labhidexplst

(* ****** ****** *)

implement
d3exp_tyer
  (d3e0) = let
  val loc0 = d3e0.d3exp_loc
  val s2e0 = d3exp_get_type (d3e0)
  val hse0 = s2exp_tyer_shallow (loc0, s2e0)
in
//
case+
  d3e0.d3exp_node of
//
| D3Evar (d2v) => let
    val () = d2var_inc_utimes (d2v)
  in
    hidexp_var (loc0, hse0, d2v)
  end // end of [D3Evar]
//
| D3Ebool (b) =>
    hidexp_bool (loc0, hse0, b)
| D3Echar (c) =>
    hidexp_char (loc0, hse0, c)
| D3Estring (str) =>
    hidexp_string (loc0, hse0, str)
//
| D3Ei0nt (tok) =>
    hidexp_i0nt (loc0, hse0, tok)
| D3Ef0loat (tok) =>
    hidexp_f0loat (loc0, hse0, tok)
//
| D3Eextval (name) => hidexp_extval (loc0, hse0, name)
//
| D3Elet (d3cs, d3e_scope) => let
    val hids = d3eclist_tyer (d3cs)
    val hde_scope = d3exp_tyer (d3e_scope)
  in
    hidexp_let_simplify (loc0, hse0, hids, hde_scope)
  end // end of [D3Elet]
//
| D3Eapp_dyn (
    d3e_fun, npf, d3es_arg
  ) => let
    val s2e_fun = d3exp_get_type (d3e_fun)
    val hse_fun = s2exp_tyer_deep (loc0, s2e_fun)
    val hde_fun = d3exp_tyer (d3e_fun)
    val hdes_arg = d3explst_npf_tyer (npf, d3es_arg)
  in
    hidexp_app (loc0, hse0, hse_fun, hde_fun, hdes_arg)
  end // end of [D3Eapp_dyn]
| D3Eapp_sta (d3e) => d3exp_tyer (d3e)
//
| D3Etup (
    knd, npf, d3es
  ) => let
    val hse_rec =
       s2exp_tyer_deep (loc0, s2e0)
    // end of [val]
    val lhdes = d3explst_npf_tyer_recize (npf, d3es)
  in
    hidexp_rec (loc0, hse0, knd, lhdes, hse_rec)
  end // end of [D3Etup]
//
| D3Elam_dyn (
    lin, npf, p3ts_arg, d3e_body
  ) => let
    val hse_fun = s2exp_tyer_deep (loc0, s2e0)
    val hips_arg = p3atlst_npf_tyer (npf, p3ts_arg)
    val hde_body = d3exp_tyer (d3e_body)
  in
    hidexp_lam (loc0, hse_fun, hips_arg, hde_body)
  end // end of [D3Elam_dyn]
| D3Elam_met (_(*met*), d3e) => d3exp_tyer (d3e)
//
| D3Etmpcst (
    d2c, t2mas
  ) => d3exp_tyer_tmpcst (loc0, hse0, d2c, t2mas)
| D3Etmpvar (
    d2v, t2mas
  ) => d3exp_tyer_tmpvar (loc0, hse0, d2v, t2mas)
//
| D3Eann_type (d3e, _(*ann*)) => d3exp_tyer (d3e)
//
| _ => let
    val () = println! ("d3exp_tyer: d3e0 = ", d3e0)
  in
    exitloc (1)
  end // end of [_]
//
end // endof [d3exp_tyer]

(* ****** ****** *)

implement
d3explst_tyer
  (d3es) = let
in
//
case+ d3es of
| list_cons
    (d3e, d3es) => let
    val isprf = d3exp_is_prf (d3e)
  in
    if isprf then
      d3explst_tyer (d3es)
    else let
      val hde = d3exp_tyer (d3e)
    in
      list_cons (hde, d3explst_tyer (d3es))
    end // end of [if]
  end
| list_nil () => list_nil ()
//
end // end of [d3explst_tyer]

implement
d3explst_npf_tyer
  (npf, d3es) = let
in
//
if npf > 0 then let
  val- list_cons (_, d3es) = d3es in d3explst_npf_tyer (npf, d3es)
end else
  d3explst_tyer (d3es)
// end of [if]
//
end // end of [d3explst_npf_tyer]

implement
d3explst_npf_tyer_recize
  (npf, d3es) = let
//
fun aux1 (
  npf: int, d3es: d3explst
) : d3explst =
  if npf > 0 then let
    val- list_cons (_, d3es) = d3es in aux1 (npf-1, d3es)
  end else d3es // end of [aux1]
//
fun aux2 (
  i: int, d3es: d3explst
) : labhidexplst = let
in
//
case+ d3es of
| list_cons
    (d3e, d3es) => let
    val isprf = d3exp_is_prf (d3e)
  in
    if isprf then
      aux2 (i+1, d3es)
    else let
      val l =
        $LAB.label_make_int (i)
      val hde = d3exp_tyer (d3e)
      val lhde = LABHIDEXP (l, hde)
    in
      list_cons (lhde, aux2 (i+1, d3es))
    end // end of [if]
  end
| list_nil () => list_nil ()
//
end // end of [aux2]
//
val i0 = (if npf >= 0 then npf else 0): int
//
in
  aux2 (i0, aux1 (npf, d3es))
end // end of [d3explst_npf_tyer_recize]

(* ****** ****** *)

implement
d3exp_tyer_tmpcst (
  loc0, hse0, d2c, t2mas
) = let
  val hses_tmp = t2mpmarglst_tyer (t2mas)
in
  hidexp_tmpcst (loc0, hse0, d2c, hses_tmp)
end // end of [d3exp_tyer_tmpcst]

implement
d3exp_tyer_tmpvar (
  loc0, hse0, d2v, t2mas
) = let
  val hses_tmp = t2mpmarglst_tyer (t2mas)
in
  hidexp_tmpvar (loc0, hse0, d2v, hses_tmp)
end // end of [d3exp_tyer_tmpvar]

(* ****** ****** *)

(* end of [pats_typerase_dynexp.dats] *)
