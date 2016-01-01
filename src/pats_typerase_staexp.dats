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
// Start Time: July, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"

(* ****** ****** *)

staload "./pats_typerase.sats"

(* ****** ****** *)

extern
fun s2cst_tyer
  (loc: location, flag: int, s2c: s2cst): hisexp
// end of [s2cst_tyer]

(* ****** ****** *)

extern
fun s2hnf_tyer
  (loc: location, flag: int, s2f: s2hnf): hisexp
// end of [s2hnf_tyer]

(* ****** ****** *)

extern
fun
s2exp_tyer_app
(
  loc: location, flag: int, s2t: s2rt, _fun: s2exp, _arg: s2explst
) : hisexp // end of [s2exp_tyer_app]
extern
fun
s2exp_tyer_app2
(
  loc: location, flag: int, s2t: s2rt, _fun: s2exp, _arg: s2explst
) : hisexp // end of [s2exp_tyer_app2]
extern
fun
s2exp_tyer_apphnf
(
  loc: location, flag: int, s2t: s2rt, _fun: s2hnf, _arg: s2explst
) : hisexp // end of [s2exp_tyer_apphnf]
extern
fun
s2exp_tyer_appcst
(
  loc: location, flag: int, s2t: s2rt, _fun: s2cst, _arg: s2explst
) : hisexp // end of [s2exp_tyer_appcst]

(* ****** ****** *)

extern
fun s2explst_tyer_arglst (loc: location, s2es: s2explst): hisexplst

(* ****** ****** *)

extern
fun s2exp_tyer_fun
  (loc: location, flag: int, s2e: s2exp): hisexp
// end of [s2exp_tyer_fun]

(* ****** ****** *)

extern
fun s2exp_tyer_datconptr
  (loc: location, flag: int, s2e: s2exp): hisexp
// end of [s2exp_tyer_datconptr]

extern
fun s2exp_tyer_datcontyp
  (loc: location, flag: int, s2e: s2exp): hisexp
// end of [s2exp_tyer_datcontyp]

(* ****** ****** *)

extern
fun s2exp_tyer_tyarr
  (loc: location, flag: int, s2e: s2exp): hisexp
// end of [s2exp_tyer_tyarr]

extern
fun s2exp_tyer_tyrec
  (loc: location, flag: int, s2e: s2exp): hisexp
// end of [s2exp_tyer_tyrec]

(* ****** ****** *)

extern
fun s2explst_tyer
  (loc: location, s2es: s2explst): hisexplst
extern
fun s2explst_npf_tyer
  (loc: location, npf: int, s2es: s2explst): hisexplst
extern
fun s2explst_npf_tyer_labize
  (loc: location, npf: int, s2es: s2explst): labhisexplst

extern
fun labs2explst_tyer
 (loc: location, flag: int, ls2es: labs2explst): labhisexplst
// end of [labs2explst_tyer]
extern
fun labs2explst_npf_tyer
  (loc: location, flag: int, npf: int, ls2es: labs2explst): labhisexplst
// end of [labs2explst_npf_tyer]

(* ****** ****** *)
//
extern
fun s2zexp_tyer_app
  (loc: location, _fun: s2zexp, _arg: s2zexplst): hisexp
extern
fun s2zexp_tyer_appcst (loc: location, s2c: s2cst, _arg: s2zexplst): hisexp
extern
fun s2zexplst_tyer_arglst (loc: location, s2zes: s2zexplst): hisexplst
//
(* ****** ****** *)

extern
fun s2zexp_tyer_tyrec (loc: location, s2ze: s2zexp): hisexp

(* ****** ****** *)

extern
fun labs2zexplst_tyer (loc: location, ls2zes: labs2zexplst): labhisexplst

(* ****** ****** *)

implement
s2cst_tyer
  (loc0, flag, s2c) = let
//
val opt = s2cst_get_isabs (s2c)
//
in
//
case+ opt of
| Some (opt2) => (
  case+ opt2 of
  | Some (s2e) =>
      s2exp_tyer (loc0, flag, s2e)
    // end of [val
  | None () => hisexp_cst (s2c)
  ) // end of [Some]
| None () => hisexp_cst (s2c)
//
end // end of [s2cst_tyer]

(* ****** ****** *)

implement
s2exp_tyer
(
  loc0, flag, s2e0
) = let
  val s2f0 = s2exp2hnf (s2e0)
in
  s2hnf_tyer (loc0, flag, s2f0)
end // end of [s2hnf_tyer]

(* ****** ****** *)

implement
s2exp_tyer_deep
  (loc0, s2e0) = s2exp_tyer (loc0, 1(*flag*), s2e0)
// end of [s2exp_tyer_deep]

implement
s2exp_tyer_shallow
  (loc0, s2e0) = s2exp_tyer (loc0, 0(*flag*), s2e0)
// end of [s2exp_tyer_shallow]

(* ****** ****** *)

implement
s2hnf_tyer
  (loc0, flag, s2f0) = let
//
val s2e0 = s2hnf2exp (s2f0)
//
(*
val () = println! ("s2hnf_tyer: s2e0 = ", s2e0)
*)
//
in
//
case+
  s2e0.s2exp_node of
//
| S2Ecst (s2c) =>
    s2cst_tyer (loc0, flag, s2c)
//
| S2Evar (s2v) => hisexp_tyvar (s2v)
//
| S2EVar (s2V) => // HX: use type-size
  s2zexp_tyer (loc0, s2Var_get_szexp (s2V))
  (* end of [S2EVar] *)
//
| S2Edatconptr _ =>
    s2exp_tyer_datconptr (loc0, flag, s2e0)
| S2Edatcontyp _ =>
    s2exp_tyer_datcontyp (loc0, flag, s2e0)
//
| S2Eapp (
    s2e_fun, s2es_arg
  ) => let
    val s2t0 = s2e0.s2exp_srt
  in
    s2exp_tyer_app (loc0, flag, s2t0, s2e_fun, s2es_arg)
  end // end of [S2Eapp]
| S2Elam (_, s2e_body) => s2exp_tyer (loc0, flag, s2e_body)
//
| S2Efun _ => s2exp_tyer_fun (loc0, flag, s2e0)
| S2Emetfun (_, _, s2e_body) => s2exp_tyer (loc0, flag, s2e_body)
//
| S2Etop (_, s2e) => s2exp_tyer (loc0, flag, s2e)
| S2Ewithout (s2e) => s2exp_tyer (loc0, flag, s2e)
//
| S2Etyarr _ => s2exp_tyer_tyarr (loc0, flag, s2e0)
| S2Etyrec _ => s2exp_tyer_tyrec (loc0, flag, s2e0)
//
| S2Einvar (s2e) => s2exp_tyer (loc0, flag, s2e)
//
| S2Eexi (_, _, s2e) => s2exp_tyer (loc0, flag, s2e)
| S2Euni (_, _, s2e) => s2exp_tyer (loc0, flag, s2e)
//
| S2Erefarg
    (knd, s2e) => let
    val hse = s2exp_tyer_shallow (loc0, s2e)
  in
    hisexp_refarg (knd, hse)
  end // end of [S2Erefarg]
//
| S2Evararg (s2e) => hisexp_vararg (s2e)
//
| S2Ewthtype (s2e, _(*ws2es*)) => s2exp_tyer (loc0, flag, s2e)
//
| _ => hisexp_s2exp (s2e0)
//
end // end of [s2hnf_tyer]

(* ****** ****** *)

implement
s2exp_tyer_app
(
  loc0, flag, s2t0, s2e_fun, s2es_arg
) = let
  val s2f_fun = s2exp2hnf (s2e_fun)
  val s2e_fun = s2hnf2exp (s2f_fun)
in
//
case+
s2e_fun.s2exp_node
of // case+
| S2Ecst (s2c) =>
    s2exp_tyer_appcst (loc0, flag, s2t0, s2c, s2es_arg)
| _ (*hnf*) => 
    s2exp_tyer_apphnf (loc0, flag, s2t0, s2f_fun, s2es_arg)
  // end of [_]
//
end // end of [s2exp_tyer_app]

implement
s2exp_tyer_app2 (
  loc0, flag, s2t0, s2e_fun, s2es_arg
) = let
//
val s2f_fun = s2exp2hnf (s2e_fun)
val s2e_fun = s2hnf2exp (s2f_fun)
//
(*
val () = println! ("s2exp_typer_app2: s2e_fun = ", s2e_fun)
val () = println! ("s2exp_typer_app2: s2es_arg = ", s2es_arg)
*)
//
in
//
case+
  s2e_fun.s2exp_node of
| S2Elam (
    s2vs_arg, s2e_body
  ) => let
    var sub = stasub_make_nil ()
    val err = stasub_addlst (sub, s2vs_arg, s2es_arg)
    val s2e_body = s2exp_subst (sub, s2e_body)
    val () = stasub_free (sub)
  in
    s2exp_tyer (loc0, flag, s2e_body)  
  end // end of [S2Elam]
| _ (*hnf*) =>
    s2exp_tyer_apphnf (loc0, flag, s2t0, s2f_fun, s2es_arg)
  // end of [_]
//
end // end of [s2exp_tyer_app2]

(* ****** ****** *)

implement
s2exp_tyer_apphnf
(
  loc0, flag, s2t0, s2f_fun, s2es_arg
) = let
  val hse_fun = s2hnf_tyer (loc0, flag, s2f_fun)
  val hses_arg = s2explst_tyer_arglst (loc0, s2es_arg)
in
  hisexp_app (hse_fun, hses_arg)
end // end of [s2exp_tyer_apphnf]

(* ****** ****** *)

implement
s2exp_tyer_appcst
(
  loc0, flag, s2t0, s2c, s2es_arg
) = let
  val opt = s2cst_get_isabs (s2c)
in
//
case+ opt of
| Some (opt2) => (
  case+ opt2 of
  | Some (_fun) =>
      s2exp_tyer_app2 (
      loc0, flag, s2t0, _fun, s2es_arg
    ) // end of [Some]
  | None () => let
      val hse_fun = s2cst_tyer (loc0, flag, s2c)
      val hses_arg = s2explst_tyer_arglst (loc0, s2es_arg)
    in
      hisexp_app (hse_fun, hses_arg)
    end // end of [None]
  ) (* end of [Some] *)
| None () => hisexp_make_srt (s2t0)
//
end // end of [s2exp_tyer_appcst]

(* ****** ****** *)

implement
s2exp_tyer_fun
  (loc0, flag, s2e0) = let
//
(*
val () =
println!
  ("s2exp_tyer_fun: flag = ", flag)
val () =
println!
  ("s2exp_tyer_fun: s2e0 = ", s2e0)
*)
//
val-
S2Efun
(
  fc, lin, s2fe, npf, s2es_arg, s2e_res
) = s2e0.s2exp_node
//
in
//
if
flag > 0
then let
//
val
hses_arg =
s2explst_npf_tyer(loc0, npf, s2es_arg)
//
val hse_res = s2exp_tyer_shallow(loc0, s2e_res)
//
in
  hisexp_fun (fc, hses_arg, hse_res)
end // end of [then]
else (
  case+ fc of
  | FUNCLOfun() => hisexp_funptr
  | FUNCLOclo(knd) =>
      if knd = 0 then hisexp_clotyp else hisexp_cloptr
    // end of [FUNCLOclo]
) (* end of [else] *)
//
end // end of [s2exp_tyer_fun]

(* ****** ****** *)
//
implement
s2exp_tyer_datconptr
  (loc0, flag, s2e0) = hisexp_datconptr
//
(* ****** ****** *)

implement
s2exp_tyer_datcontyp
  (loc0, flag, s2e0) = let
//
val-S2Edatcontyp
  (d2c, s2es) = s2e0.s2exp_node
//
in
//
if flag > 0 then let
  val npf = d2con_get_npf (d2c)
  val lhses = s2explst_npf_tyer_labize (loc0, npf, s2es)
in
  hisexp_tysum (d2c, lhses)
end else hisexp_datcontyp
//
end // end of [s2exp_tyer_datcontyp]

(* ****** ****** *)

implement
s2exp_tyer_tyarr
  (loc0, flag, s2e0) = let
//
val-S2Etyarr
  (s2e_elt, dim) = s2e0.s2exp_node
val hse_elt = s2exp_tyer (loc0, flag, s2e_elt)
//
in
  hisexp_tyarr (hse_elt, dim)
end // end of [s2exp_tyer_tyarr]

(* ****** ****** *)

implement
s2exp_tyer_tyrec
  (loc0, flag, s2e0) = let
//
val-S2Etyrec
  (knd, npf, ls2es) = s2e0.s2exp_node
val lhses =
  labs2explst_npf_tyer (loc0, flag, npf, ls2es)
//
in
//
case knd of
//
| TYRECKINDbox () =>
  (
    if flag > 0 then
      hisexp_tyrec (knd, lhses) else hisexp_tybox
  ) // end of [TYRECKINDbox]
//
| TYRECKINDflt_ext _ => hisexp_tyrec (knd, lhses)
//
| _ (*TYRECKINDflt0/1*) => let
  in
    case+ lhses of
    | list_cons
      (
        lhse, list_nil()
      ) => hisexp_tyrecsin (lhse)
    | _(*non-sing*) => hisexp_tyrec (knd, lhses)
  end // end of [TYRECKINDflt0/1]
//
end // end of [s2exp_tyer_tyrec]

(* ****** ****** *)

implement
s2explst_tyer
  (loc0, s2es) = let
in
//
case+ s2es of
| list_cons
    (s2e, s2es) => let
    val isprf = s2exp_is_prf (s2e)
  in
    if isprf then
      s2explst_tyer (loc0, s2es)
    else let
      val hse =
        s2exp_tyer_shallow (loc0, s2e)
      // end of [val]
      val hses = s2explst_tyer (loc0, s2es)
    in
      list_cons (hse, hses)
    end // end of [if]
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [s2explst_tyer]

(* ****** ****** *)

implement
s2explst_npf_tyer
  (loc0, npf, s2es) = let
in
//
if npf > 0 then let
  val-list_cons (_, s2es) = s2es
in
  s2explst_npf_tyer (loc0, npf-1, s2es)
end else
  s2explst_tyer (loc0, s2es)
// end of [if]
//
end // end of [s2explst_npf_tyer]

(* ****** ****** *)

implement
s2explst_npf_tyer_labize
  (loc0, npf, s2es) = let
//
fun auxlst (
  loc0: location
, npf: int, s2es: s2explst, i: int
) : labhisexplst = let
in
//
if npf > 0 then let
  val-list_cons (_, s2es) = s2es
in
  auxlst (loc0, npf-1, s2es, i+1)
end else ( // HX-2013-01: npf <= 0
//
case+ s2es of
| list_cons
    (s2e, s2es) => let
    val isprf = s2exp_is_prf (s2e)
  in
    if isprf then
      auxlst (loc0, npf, s2es, i+1)  
    else let
      val lab =
        $LAB.label_make_int (i)
      val hse =
        s2exp_tyer_shallow (loc0, s2e)
      val lhse = HSLABELED (lab, None, hse)
      val lhses = auxlst (loc0, npf, s2es, i+1)
    in
      list_cons (lhse, lhses)
    end // end of [if]
  end // end of [list_cons]
| list_nil () => list_nil ()
//
) // end of [if]
//
end // end of [auxlst]
//
in
  auxlst (loc0, npf, s2es, 0)
end // end of [s2explst_npf_tyer_labize]

(* ****** ****** *)

implement
labs2explst_tyer
  (loc0, flag, ls2es) = let
in
//
case+ ls2es of
| list_cons
    (ls2e, ls2es) => let
    val SLABELED
      (l, name, s2e) = ls2e
    // end of [val]
    val isprf = s2exp_is_prf (s2e)
  in
    if isprf then
      labs2explst_tyer (loc0, flag, ls2es)
    else let
      val hse = s2exp_tyer (loc0, flag, s2e)
      val lhse = HSLABELED (l, name, hse)
      val lhses = labs2explst_tyer (loc0, flag, ls2es)
    in
      list_cons (lhse, lhses)
    end (* end of [if] *)
  end
| list_nil () => list_nil ()
//
end // end of [labs2explst_tyer]

(* ****** ****** *)

implement
labs2explst_npf_tyer
  (loc0, flag, npf, ls2es) = let
in
//
if npf > 0 then let
  val-list_cons (_, ls2es) = ls2es
in
  labs2explst_npf_tyer (loc0, flag, npf-1, ls2es)
end else
  labs2explst_tyer (loc0, flag, ls2es)
// end of [if]
//
end // end of [labs2explst_npf_tyer]

(* ****** ****** *)

implement
s2explst_tyer_arglst
  (loc0, s2es) = let
in
//
case+ s2es of
| list_cons
    (s2e, s2es) => let
    val s2t = s2e.s2exp_srt
    val keep = s2rt_is_prgm (s2t)
    val keep = (
      if keep then true else s2rt_is_tkind (s2t)
    ) : bool // end of [val]
  in
    if keep then let
      val hse = s2exp_tyer_shallow (loc0, s2e)
      val hses = s2explst_tyer_arglst (loc0, s2es)
    in
      list_cons (hse, hses)
    end else
      s2explst_tyer_arglst (loc0, s2es)
    // end of [if]
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [s2explst_tyer_arglst]

(* ****** ****** *)

implement
s2zexp_tyer
  (loc0, s2ze0) = let
//
(*
val () =
println!
  ("s2zexp_tyer: s2ze0 = ", s2ze0)
*)
//
in
//
case+ s2ze0 of
//
| S2ZEptr () => hisexp_tybox
//
| S2ZEcst (s2c) =>
    s2cst_tyer (loc0, 0(*flag*), s2c)
  // end of [S2ZEcst]
//
| S2ZEvar (s2v) => hisexp_tyvar (s2v)
//
| S2ZEapp (s2ze1, s2zes2) =>
    s2zexp_tyer_app (loc0, s2ze1, s2zes2)
//
| S2ZEtyrec _ => s2zexp_tyer_tyrec (loc0, s2ze0)
//
// HX-2015-01-30:
// is this the right way to go?
| S2ZEVar (s2V) => hisexp_undefined
//
| _ (*S2ZE-rest*) => hisexp_s2zexp (s2ze0)
//
end // end of [s2zexp_tyer]

(* ****** ****** *)

implement
s2zexp_tyer_app
(
  loc0, s2ze1, s2zes2
) = let
//
val hse_fun =
  s2zexp_tyer (loc0, s2ze1)
val hses_arg =
  s2zexplst_tyer_arglst (loc0, s2zes2)
//
in
  hisexp_app (hse_fun, hses_arg)
end // end of [s2exp_tyer_app]

(* ****** ****** *)

implement
s2zexplst_tyer_arglst
  (loc0, s2zes) = let
in
//
case+ s2zes of
| list_cons
    (s2ze, s2zes) => (
  case+ s2ze of
  | S2ZEprf () =>
      s2zexplst_tyer_arglst (loc0, s2zes)
  | _ (*non-proof*) => let
      val hse = s2zexp_tyer (loc0, s2ze)
      val hses = s2zexplst_tyer_arglst (loc0, s2zes)
    in
      list_cons (hse, hses)
    end // end of [_]
  ) (* end of [list_cons] *)
| list_nil () => list_nil ()
//
end // end of [s2zexplst_tyer_arglst]

(* ****** ****** *)

implement
s2zexp_tyer_tyrec
  (loc0, s2ze0) = let
//
val-S2ZEtyrec
  (knd, ls2zes) = s2ze0
//
val lhses = labs2zexplst_tyer (loc0, ls2zes)
//
in
//
case knd of
| TYRECKINDbox () => hisexp_tybox
| TYRECKINDflt_ext _ => hisexp_tyrec (knd, lhses)
| _ (*TYRECKINDflt0/1*) => let
  in
    case+ lhses of
    | list_cons
      (
        lhse, list_nil()
      ) => hisexp_tyrecsin (lhse)
    | _(*non-sing*) => hisexp_tyrec (knd, lhses)
  end // end of [TYRECKINDflt0/1]
//
end // end of [s2exp_tyer_tyrec]

(* ****** ****** *)

implement
labs2zexplst_tyer
  (loc0, ls2zes) = let
in
//
case+ ls2zes of
| list_cons
    (ls2ze, ls2zes) => let
    val SZLABELED (l, s2ze) = ls2ze
  in
    case+ s2ze of
    | S2ZEprf () =>
        labs2zexplst_tyer (loc0, ls2zes)
    | _(*non-proof*) => let
        val hse = s2zexp_tyer (loc0, s2ze)
        val lhse = HSLABELED (l, None(*name*), hse)
        val lhses = labs2zexplst_tyer (loc0, ls2zes)
      in
        list_cons (lhse, lhses)
      end // end of [_]
  end (* end of [list_cons] *)
| list_nil ((*void*)) => list_nil ()
//
end // end of [labs2zexplst_tyer]

(* ****** ****** *)

implement
t2mpmarg_tyer (t2ma) = let
//
val loc0 = t2ma.t2mpmarg_loc
//
fun aux (
  loc0: location, s2es: s2explst
) : hisexplst = let
in
//
case+ s2es of
| list_cons
    (s2e, s2es) => let
    val hse =
      s2exp_tyer_shallow (loc0, s2e)
    // end of [val]
  in
    list_cons (hse, aux (loc0, s2es))
  end
| list_nil () => list_nil ()
//
end // end of [aux]
//
in
  aux (loc0, t2ma.t2mpmarg_arg)
end // end of [t2mpmarg_tyer]

implement
t2mpmarglst_tyer (t2mas) = let
  val h2ess = list_map_fun (t2mas, t2mpmarg_tyer)
in
  list_of_list_vt (h2ess)
end // end of [t2mpmarglst_tyer]

(* ****** ****** *)

implement
t2mpmarg_mhnfize
  (t2ma) = let
  val loc = t2ma.t2mpmarg_loc
  val s2es = t2ma.t2mpmarg_arg
  val s2es = s2explst_mhnfize (s2es)
in
  t2mpmarg_make (loc, s2es)
end // end of [t2mpmarg_mhnfize]

implement
t2mpmarglst_mhnfize
  (t2mas) = let
//
val t2mas = list_map_fun (t2mas, t2mpmarg_mhnfize)
//
in
  list_of_list_vt (t2mas)
end // end of [t2mpmarglst_mhnfize]

(* ****** ****** *)

(* end of [pats_typerase_staexp.dats] *)
