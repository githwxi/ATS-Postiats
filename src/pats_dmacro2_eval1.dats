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
ATSPRE =
"./pats_atspre.dats"
//
(* ****** ****** *)
//
staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
//
implement
prerr_FILENAME<> () = prerr "pats_dmacro2_eval1"
//
(* ****** ****** *)

staload LOC = "./pats_location.sats"
overload print with $LOC.print_location

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"

(* ****** ****** *)

staload "./pats_dmacro2.sats"

(* ****** ****** *)
//
extern
fun
d2var_rename
(
loc0: location, d2v: d2var
) : d2var // end-of-fun
implement
d2var_rename(loc0, d2v) = d2v // HX: is this okay?
//
(* ****** ****** *)
//
extern fun eval1_s2exp : eval1_type(s2exp)
extern fun eval1_s2explst : eval1_type(s2explst)
extern fun eval1_s2expopt : eval1_type(s2expopt)
//
extern fun eval1_s2exparg : eval1_type(s2exparg)
extern fun eval1_s2exparglst : eval1_type(s2exparglst)
//
extern fun eval1_t2mpmarg : eval1_type(t2mpmarg)
extern fun eval1_t2mpmarglst : eval1_type(t2mpmarglst)
//
(* ****** ****** *)

extern fun eval1_d2var : eval1_type(d2var)

(* ****** ****** *)

extern fun eval1_i2nvarg : eval1_type(i2nvarg)
extern fun eval1_i2nvarglst : eval1_type(i2nvarglst)
extern fun eval1_i2nvresstate : eval1_type(i2nvresstate)

(* ****** ****** *)
//
extern fun eval1_p2at : eval1_type(p2at)
extern fun eval1_p2atlst : eval1_type(p2atlst)
extern fun eval1_p2atopt : eval1_type(p2atopt)
//
extern fun eval1_labp2at : eval1_type(labp2at)
extern fun eval1_labp2atlst : eval1_type(labp2atlst)
//
(* ****** ****** *)
//
extern fun eval1_d2explst : eval1_type(d2explst)
extern fun eval1_d2expopt : eval1_type(d2expopt)
//
extern fun eval1_labd2exp : eval1_type(labd2exp)
extern fun eval1_labd2explst : eval1_type(labd2explst)
//
extern fun eval1_d2lablst : eval1_type(d2lablst)
//
extern fun eval1_d2exparg : eval1_type(d2exparg)
extern fun eval1_d2exparglst : eval1_type(d2exparglst)
//
(* ****** ****** *)
//
extern fun eval1_d2exp_applst : eval1_type(d2exp)
extern fun eval1_d2exp_macsyn : eval1_type(d2exp)
//
(* ****** ****** *)

extern fun eval1_gm2at : eval1_type(gm2at)
extern fun eval1_gm2atlst : eval1_type(gm2atlst)

extern fun eval1_c2lau : eval1_type(c2lau)
extern fun eval1_c2laulst : eval1_type(c2laulst)

(* ****** ****** *)
//
extern fun eval1_d2ecl : eval1_type(d2ecl)
extern fun eval1_d2eclist : eval1_type(d2eclist)
//
(* ****** ****** *)

implement
eval1_listmap
(
loc0, ctx, env, xs, fopr
) = (
//
case+ xs of
//
| list_nil() => list_nil()
//
| list_cons(x, xs) => let
    val x = fopr(loc0, ctx, env, x)
    val xs = eval1_listmap(loc0, ctx, env, xs, fopr)
  in
    list_cons(x, xs)
  end // end of [list_cons]
) (* end of [eval1_listmap] *)

(* ****** ****** *)

implement
eval1_s2exp
(
  loc0, ctx, env, s2e
) = s2e where
{
(*
val () =
println!
("eval1_s2exp: s2e(bef) = ", s2e)
*)
val
sub =
stasub_make_evalctx(ctx)
val
s2e = s2exp_subst(sub, s2e)
//
val () = stasub_free(sub)
(*
val () =
println!
("eval1_s2exp: s2e(aft) = ", s2e)
*)
} (* end of [eval1_s2exp] *)

(* ****** ****** *)

implement
eval1_s2explst
  (loc0, ctx, env, s2es) =
  eval1_listmap (loc0, ctx, env, s2es, eval1_s2exp)
// end of [eval1_s2explst]

implement
eval1_s2expopt
(
loc0, ctx, env, opt
) = (
  case+ opt of
  | None() => None()
  | Some(s2e) => Some(eval1_s2exp(loc0, ctx, env, s2e))
) // end of [eval1_s2expopt]

(* ****** ****** *)

implement
eval1_s2exparg
(
loc0, ctx, env, s2a
) = let
//
val s2an = s2a.s2exparg_node
//
in
//
case+ s2an of
| S2EXPARGone() => s2exparg_one(loc0)
| S2EXPARGall() => s2exparg_all(loc0)
| S2EXPARGseq(s2es) =>
  s2exparg_seq
    (loc0, eval1_s2explst(loc0, ctx, env, s2es))
  // end of [S2EXPARGseq]
//
end // end of [eval1_s2exparg]

implement
eval1_s2exparglst
  (loc0, ctx, env, s2as) =
  eval1_listmap(loc0, ctx, env, s2as, eval1_s2exparg)
// end of [eval1_s2exparglst]

(* ****** ****** *)

implement
eval1_t2mpmarg
(
loc0, ctx, env, t2ma
) = let
//
val s2es = 
  eval1_s2explst(loc0, ctx, env, t2ma.t2mpmarg_arg)
//
in
  t2mpmarg_make (loc0, s2es)
end // end of [eval1_t2mpmarg]

implement
eval1_t2mpmarglst
  (loc0, ctx, env, t2mas) =
  eval1_listmap(loc0, ctx, env, t2mas, eval1_t2mpmarg)
// end of [eval1_t2mpmarglst]

(* ****** ****** *)

implement
eval1_d2var
  (loc0, ctx, env, d2v) = let
  val opt = alphenv_dfind (env, d2v)
in
  case+ opt of
  | ~Some_vt(d2v) => d2v | ~None_vt () => d2v
end // end of [eval1_d2var]

(* ****** ****** *)

implement
eval1_i2nvarg
(
loc0, ctx, env, arg
) = let
//
val d2v =
  eval1_d2var(loc0, ctx, env, arg.i2nvarg_var)
val opt =
  eval1_s2expopt(loc0, ctx, env, arg.i2nvarg_type)
//
in
  i2nvarg_make(d2v, opt)
end // end of [eval1_i2nvarg]

implement
eval1_i2nvarglst
  (loc0, ctx, env, args) =
  eval1_listmap(loc0, ctx, env, args, eval1_i2nvarg)
// end of [eval1_i2nvarglst]

implement
eval1_i2nvresstate
  (loc0, ctx, env, inv) = let
  val svs = inv.i2nvresstate_svs
  val gua = inv.i2nvresstate_gua
  val arg = eval1_i2nvarglst(loc0, ctx, env, inv.i2nvresstate_arg)
  val met = inv.i2nvresstate_met
in
  i2nvresstate_make_met (svs, gua, arg, met)
end // end of [eval1_i2nvresstate]

(* ****** ****** *)

implement
eval1_p2at 
(
loc0, ctx, env, p2t0
) = let
(*
val () =
println!
("eval1_p2at: p2t0 = ", p2t0)
*)
in
//
case+
p2t0.p2at_node
of (* case+ *)
//
| P2Tany _ =>
  p2at_any(loc0)
//
| P2Tvar(d2v) => let
    val d2v_new =
      d2var_rename(loc0, d2v)
    val () =
      alphenv_dadd(env, d2v, d2v_new)
    // end of [val]
  in
    p2at_var(loc0, d2v_new)
  end // end of [P2Tvar]
//
| P2Tcon
  (
    knd, d2c
  , s2qs, s2e_con, npf, p2ts_arg
  ) => let
    val
    p2ts_arg =
    eval1_p2atlst(loc0, ctx, env, p2ts_arg)
  in
    p2at_con(loc0, knd, d2c, s2qs, s2e_con, npf, p2ts_arg)
  end // end of [P2Tcon]
//
| P2Tempty() =>
  p2at_empty(loc0)
//
| P2Tlst(lin, p2ts) => let
    val
    p2ts =
    eval1_p2atlst(loc0, ctx, env, p2ts)
  in
    p2at_lst(loc0, lin, p2ts)
  end // end of [P2Tlst]
//
| P2Trec(knd, npf, lp2ts) => let
    val
    lp2ts =
    eval1_labp2atlst(loc0, ctx, env, lp2ts)
  in
    p2at_rec(loc0, knd, npf, lp2ts)
  end // end of [P2Trec]
//
| P2Tann(p2t, s2e) =>
  p2at_ann(loc0, p2t, s2e) where
  {
    val p2t = eval1_p2at(loc0, ctx, env, p2t)
    val s2e = eval1_s2exp(loc0, ctx, env, s2e)
  } (* end of [P2Tann] *)
//
| _ (*P2T-rest*) =>
    exitloc(1) where // HX: exit with loc-info
  {
    val () =
    println! (
      "eval1_p2at: not implemented yet: p2t0 = ", p2t0
    ) (* println! *)
  } (* [rest-of-p2at] *)
//
end // end of [eval1_p2at]

(* ****** ****** *)

implement
eval1_p2atlst
  (loc0, ctx, env, p2ts) =
  eval1_listmap(loc0, ctx, env, p2ts, eval1_p2at)
// end of [eval1_p2atlst]

implement
eval1_p2atopt
  (loc0, ctx, env, opt) = let
in
  case+ opt of
  | Some (p2t) => Some (eval1_p2at (loc0, ctx, env, p2t))
  | None ((*void*)) => None ()
end // end of [eval1_p2atopt]

(* ****** ****** *)

implement
eval1_labp2at
  (loc0, ctx, env, lp2t) = let
in
//
case+ lp2t of
| LABP2ATnorm (l, p2t) => let
    val p2t = eval1_p2at (loc0, ctx, env, p2t)
  in
    LABP2ATnorm (l, p2t)
  end // end of [LABP2ATnor]
| LABP2ATomit _ => LABP2ATomit (loc0)
//
end // end of [eval1_labp2at]

implement
eval1_labp2atlst
  (loc0, ctx, env, lp2ts) =
  eval1_listmap (loc0, ctx, env, lp2ts, eval1_labp2at)
// end of [eval1_labp2atlst]

(* ****** ****** *)

implement
eval1_d2explst
  (loc0, ctx, env, d2es) =
  eval1_listmap (loc0, ctx, env, d2es, eval1_d2exp)
// end of [eval1_d2explst]

implement
eval1_d2expopt
  (loc0, ctx, env, opt) = (
  case+ opt of
  | Some (d2e) => Some (eval1_d2exp (loc0, ctx, env, d2e))
  | None () => None ()
) // end of [eval1_d2expopt]

(* ****** ****** *)

implement
eval1_labd2exp (
  loc0, ctx, env, ld2e
) = let
  val $SYN.DL0ABELED (l, d2e) = ld2e
in
  $SYN.DL0ABELED (l, eval1_d2exp (loc0, ctx, env, d2e))
end // end of [eval1_labd2exp]

implement
eval1_labd2explst
  (loc0, ctx, env, ld2es) =
  eval1_listmap (loc0, ctx, env, ld2es, eval1_labd2exp)
// end of [eval1_labd2explst]

(* ****** ****** *)

implement
eval1_d2lablst
  (loc0, ctx, env, d2ls) = let
in
//
case+ d2ls of
| list_cons
    (d2l, d2ls) => let
    val d2l = (
      case+ d2l.d2lab_node of
      | D2LABlab _ => d2l
      | D2LABind (ind) =>
          d2lab_ind (loc0, eval1_d2explst (loc0, ctx, env, ind))
    ) : d2lab // end of [val]
    val d2ls = eval1_d2lablst (loc0, ctx, env, d2ls)
  in
    list_cons (d2l, d2ls)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [eval1_d2lablst]

(* ****** ****** *)
  
implement
eval1_d2exparg
  (loc0, ctx, env, d2a) = let
in
//
case+ d2a of
| D2EXPARGsta
    (locarg, s2as) => D2EXPARGsta (loc0, s2as)
| D2EXPARGdyn
    (npf, locarg, d2es) => let
    val d2es = eval1_d2explst (loc0, ctx, env, d2es)
  in
    D2EXPARGdyn (npf, loc0, d2es)
  end // end of [D2EXPARGdyn]
//
end // end of [eval1_d2exparg]

implement
eval1_d2exparglst
  (loc0, ctx, env, d2as) =
  eval1_listmap (loc0, ctx, env, d2as, eval1_d2exparg)
// end of [eval1_d2exparglst]

(* ****** ****** *)

implement
eval1_d2exp_applst (
  loc0, ctx, env, d2e0
) = let
//
val-D2Eapplst
  (d2e, d2as) = d2e0.d2exp_node
val loc = d2e.d2exp_loc
//
fun auxerr (
  loc0: location, d2e0: d2exp, d2m: d2mac
) : void = let
  val () = prerr_errmac_loc (loc0)
  val () = prerr ": the dynamic symbol ["
  val () = prerr_d2mac (d2m)
  val () = prerr "] at (";
  val () = $LOC.prerr_location (d2e0.d2exp_loc)
  val () = prerr ") refers to a macrodef (to be called inside ,(...))."
  val () = prerr_newline ();
in
  the_trans3errlst_add (T3E_dmacro_eval1_d2exp (loc0, d2e0))
end // end of [auxerr]
//
val d2e = eval1_d2exp (loc0, ctx, env, d2e)
val d2as = eval1_d2exparglst (loc0, ctx, env, d2as)
//
in
//
case+
d2e.d2exp_node
of // case+
| D2Emac (d2m) => let
    val knd = d2mac_get_kind (d2m)
  in
    if knd = 0 then ( // [d2m] is of short form
      eval0_app_mac_short (loc0, d2m, ctx, env, d2as)
    ) else let
      val () =
        auxerr (loc0, d2e0, d2m) in d2exp_errexp (loc0)
      // end of [val]
    end // end of [if]
  end // end of [D2Emac]
| D2Eapplst
    (d2e1, d2as1) => (
    d2exp_applst (loc0, d2e1, list_append (d2as1, d2as))
  ) // end of [D2Eapplst]
//
| _ => d2exp_applst (loc0, d2e, d2as)
//
end // end of [eval1_d2exp_applst]

(* ****** ****** *)

implement
eval1_d2exp_macsyn (
  loc0, ctx, env, d2e0
) = let
  val-D2Emacsyn (knd, d2e) = d2e0.d2exp_node
in
//
case+ knd of
| $SYN.MSKdecode () => let
    val m2v = eval0_d2exp (loc0, ctx, env, d2e)
  in
    case+ m2v of
    | M2Vdcode (d2e_new) => d2e_new
    | _ => let
        val () = prerr_errmac_loc (loc0)
        val () = prerr ": the expansion of the dynamic expression at (";
        val () = $LOC.prerr_location (d2e.d2exp_loc)
        val ()= prerr ") is expected to return code (AST) but it does not.";
(*
        val () = prerr "expanded exp: d2e = "; prerr_d2exp (d2e); prerr_newline ();
        val () = prerr "returned val: m2v = "; prerr_m2val (m2v); prerr_newline ();
*)
        val () = prerr_newline ()
      in
        d2exp_errexp (loc0)
      end // end of [_]
  end // end of [MSKdecode]
| $SYN.MSKxstage () => let
    val m2v = eval0_d2exp (loc0, ctx, env, d2e)
  in
    liftval2dexp (loc0, m2v)
  end // end of [MSKxstage]
| _ => let
    val () =
      prerr_errmac_loc (loc0)
    val () = prerr ": macro syntax is used incorrectly: "
    val () = prerr_d2exp (d2e0)
    val () = prerr_newline ()
  in
    d2exp_errexp (loc0)
  end // end of [_]
//
end // end of [eval1_d2exp_macsyn]

(* ****** ****** *)

implement
eval1_d2exp
  (loc0, ctx, env, d2e0) = let
(*
val () = (
  println! ("eval1_d2exp: loc0 = ", loc0);
  println! ("eval1_d2exp: d2e0 = ", d2e0);
) (* end of [val] *)
*)
val d2en0 = d2e0.d2exp_node
//
macdef reloc () = d2exp_make_node (loc0, d2en0)
//
macdef eval1sexp (x) = eval1_s2exp (loc0, ctx, env, ,(x))
macdef eval1sexplst (xs) = eval1_s2explst (loc0, ctx, env, ,(xs))
macdef eval1sexpopt (opt) = eval1_s2expopt (loc0, ctx, env, ,(opt))
//
macdef eval1sexparg (x) = eval1_s2exparg (loc0, ctx, env, ,(x))
macdef eval1sexparglst (xs) = eval1_s2exparglst (loc0, ctx, env, ,(xs))
//
macdef eval1tmpmarg (x) = eval1_t2mpmarg (loc0, ctx, env, ,(x))
macdef eval1tmpmarglst (xs) = eval1_t2mpmarglst (loc0, ctx, env, ,(xs))
//
macdef eval1dvar (x) = eval1_d2var (loc0, ctx, env, ,(x))
//
macdef eval1dexp (x) = eval1_d2exp (loc0, ctx, env, ,(x))
macdef eval1dexplst (xs) = eval1_d2explst (loc0, ctx, env, ,(xs))
macdef eval1dexpopt (opt) = eval1_d2expopt (loc0, ctx, env, ,(opt))
//
macdef eval1labdexp (x) = eval1_labd2exp (loc0, ctx, env, ,(x))
macdef eval1labdexplst (xs) = eval1_labd2explst (loc0, ctx, env, ,(xs))
//
macdef eval1dlablst (xs) = eval1_d2lablst (loc0, ctx, env, ,(xs))
//
macdef eval1invres (inv) = eval1_i2nvresstate (loc0, ctx, env, ,(inv))
//
macdef eval1claulst (c2ls) = eval1_c2laulst (loc0, ctx, env, ,(c2ls))
//
in
//
case+ d2en0 of
//
| D2Evar (d2v) =>
    d2exp_var (loc0, eval1dvar (d2v))
  // end of [D2Evar]
//
| D2Ecst _ => reloc ()
//
| D2Eint _ => reloc ()
| D2Eintrep _ => reloc ()
| D2Echar _ => reloc ()
| D2Estring _ => reloc ()
| D2Efloat _ => reloc ()
//
| D2Ei0nt _ => reloc ()
| D2Ec0har _ => reloc ()
| D2Es0tring _ => reloc ()
| D2Ef0loat _ => reloc ()
//
| D2Ecstsp _ => reloc ()
//
| D2Etop _ => reloc ()
| D2Eempty _ => reloc ()
//
| D2Eextval (s2e, rep) =>
    d2exp_extval (loc0, eval1sexp (s2e), rep)
  (* end of [D2Eextval] *)
//
| D2Eextfcall
    (res, _fun, _arg) => let
    val res = eval1sexp (res)
    val _arg = eval1dexplst (_arg)
  in
    d2exp_extfcall (loc0, res, _fun, _arg)
  end // end of [D2Eextfcall]
| D2Eextmcall
    (res, _obj, _mtd, _arg) => let
    val res = eval1sexp (res)
    val _obj = eval1dexp(_obj)
    val _arg = eval1dexplst (_arg)
  in
    d2exp_extmcall (loc0, res, _obj, _mtd, _arg)
  end // end of [D2Eextmcall]
//
| D2Econ
  (
    d2c, locfun, s2as, npf, locarg, d2es
  ) => let
    val s2as =
      eval1sexparglst (s2as)
    // end of [val]
    val d2es = eval1dexplst (d2es)
  in
    d2exp_con (loc0, d2c, locfun, s2as, npf, locarg, d2es)
  end // end of [D2Econ]
//
| D2Esym _ => reloc ()
//
| D2Etmpid (
    d2e_id, t2mas
  ) => let
    val d2en = d2e_id.d2exp_node
    val d2e_id = d2exp_make_node (loc0, d2en)
    val t2mas = eval1tmpmarglst (t2mas)
  in
    d2exp_tmpid (loc0, d2e_id, t2mas)
  end // end of [D2Etmpid]
//
| D2Elet (d2cs, d2e) => let
    val () = alphenv_push (env)
    val d2cs = eval1_d2eclist (loc0, ctx, env, d2cs)
    val d2e = eval1dexp (d2e)
    val () = alphenv_pop (env)
  in
    d2exp_let (loc0, d2cs, d2e)
  end // end of [D2Elet]
| D2Ewhere (d2e, d2cs) => let
    val () = alphenv_push (env)
    val d2cs = eval1_d2eclist (loc0, ctx, env, d2cs)
    val d2e = eval1dexp (d2e)
    val () = alphenv_pop (env)
  in
    d2exp_where (loc0, d2e, d2cs)
  end // end of [D2Ewhere]
//
| D2Eapplst _ =>
    eval1_d2exp_applst (loc0, ctx, env, d2e0)
  // end of [D2Eapplst]
//
| D2Eifhead
  (
    inv, _test, _then, _else
  ) => let
    val inv = eval1invres (inv)
    val _test = eval1dexp (_test)
    val _then = eval1dexp (_then)
    val _else = eval1dexpopt (_else)
  in
    d2exp_ifhead (loc0, inv, _test, _then, _else)
  end // end of [D2Eifhead]
| D2Esifhead
  (
    inv, _test, _then, _else
  ) => let
    val inv = eval1invres (inv)
    val _test = eval1sexp (_test)
    val _then = eval1dexp (_then)
    val _else = eval1dexp (_else)
  in
    d2exp_sifhead (loc0, inv, _test, _then, _else)
  end // end of [D2Esifhead]
//
| D2Ecasehead
  (
    knd, inv, d2es, c2ls
  ) => let
    val inv = eval1invres (inv)
    val d2es = eval1dexplst (d2es)
    val c2ls = eval1claulst (c2ls)
  in
    d2exp_casehead (loc0, knd, inv, d2es, c2ls)
  end // end of [D2Ecasehead]
//
| D2Esing (d2e) =>
    d2exp_sing(loc0, eval1dexp (d2e))
| D2Elist (npf, d2es) =>
    d2exp_list(loc0, npf, eval1dexplst (d2es))
//
| D2Elst
    (lin, opt, d2es) => d2exp_lst
  (
    loc0, lin, eval1sexpopt (opt), eval1dexplst (d2es)
  ) (* end of [D2Elst] *)
//
| D2Etup (knd, npf, d2es) =>
    d2exp_tup (loc0, knd, npf, eval1dexplst (d2es))
| D2Erec (knd, npf, ld2es) =>
    d2exp_rec (loc0, knd, npf, eval1labdexplst (ld2es))
//
| D2Eseq (d2es) => d2exp_seq (loc0, eval1dexplst (d2es))
//
| D2Eselab (d2e, d2ls) =>
    d2exp_selab (loc0, eval1dexp (d2e), eval1dlablst (d2ls))
//
| D2Eptrof (d2e) =>
    d2exp_ptrof (loc0, eval1dexp (d2e))
| D2Eviewat (d2e) =>
    d2exp_viewat (loc0, eval1dexp (d2e))
//
| D2Ederef(d2s, d2e) =>
    d2exp_deref(loc0, d2s, eval1dexp(d2e))
//
| D2Eassgn(d2e_l, d2e_r) =>
    d2exp_assgn(loc0, eval1dexp(d2e_l), eval1dexp(d2e_r))
| D2Exchng(d2e_l, d2e_r) =>
    d2exp_xchng(loc0, eval1dexp(d2e_l), eval1dexp(d2e_r))
//
| D2Earrsub (
    d2s, d2e, locind, ind
  ) => d2exp_arrsub (
    loc0, d2s, eval1dexp (d2e), loc0, eval1dexplst (ind)
  ) // end of [D2Earrsub]
| D2Earrinit
    (elt, asz, ini) => d2exp_arrinit
  (
    loc0
  , eval1sexp (elt), eval1dexpopt (asz), eval1dexplst (ini)
  ) // end of [D2Earrinit]
| D2Earrpsz (opt, d2es) =>
    d2exp_arrpsz (loc0, eval1sexpopt (opt), eval1dexplst (d2es))
  // end of [D2Earrpsz]
//
| D2Eraise (d2e) => d2exp_raise (loc0, eval1dexp (d2e))
| D2Eshowtype (d2e) => d2exp_showtype (loc0, eval1dexp (d2e))
//
| D2Eexist (s2a, d2e) =>
    d2exp_exist (loc0, eval1sexparg (s2a), eval1dexp (d2e))
  // end of [D2Eexist]
//
| D2Elam_dyn
    (lin, npf, p2ts, d2e) => let
    val p2ts = eval1_p2atlst (loc0, ctx, env, p2ts)
  in
    d2exp_lam_dyn (loc0, lin, npf, p2ts, eval1dexp (d2e))
  end // end of [D2Elam_dyn]
//
| D2Edelay (d2e) => d2exp_delay (loc0, eval1dexp (d2e))
| D2Eldelay (d2e, opt) => // (eval, free)
    d2exp_ldelay (loc0, eval1dexp (d2e), eval1dexpopt (opt))
  // end of [D2Eldelay]
//
| D2Emac _ => reloc () // HX-2012-12: right?
| D2Emacsyn _ => eval1_d2exp_macsyn (loc0, ctx, env, d2e0)
//
| D2Eann_type (d2e, s2e) =>
    d2exp_ann_type (loc0, eval1dexp (d2e), eval1sexp (s2e))
  // end of [D2Eann_type]
| D2Eann_seff (d2e, s2fe) =>
    d2exp_ann_seff (loc0, eval1dexp (d2e), s2fe)
  // end of [D2Eann_seff]
| D2Eann_funclo (d2e, funclo) =>
    d2exp_ann_funclo (loc0, eval1dexp (d2e), funclo)
  // end of [D2Eann_funclo]
//
| _ (*rest-of-d2exp*) => d2exp_errexp (loc0)
//
end // end of [eval1_d2exp]

(* ****** ****** *)

implement
eval1_gm2at
  (loc0, ctx, env, gm2t) = let
//
val d2e = eval1_d2exp (loc0, ctx, env, gm2t.gm2at_exp)
val opt = eval1_p2atopt (loc0, ctx, env, gm2t.gm2at_pat)
//
in
  gm2at_make (loc0, d2e, opt)
end // end of [eval1_gm2at]

implement
eval1_gm2atlst
  (loc0, ctx, env, gm2ts) =
  eval1_listmap (loc0, ctx, env, gm2ts, eval1_gm2at)
// end of [eval1_gm2atlst]

(* ****** ****** *)

implement
eval1_c2lau
  (loc0, ctx, env, c2l) = let
//
val p2ts = eval1_p2atlst (loc0, ctx, env, c2l.c2lau_pat)
val gm2ts = eval1_gm2atlst (loc0, ctx, env, c2l.c2lau_gua)
val d2e_body = eval1_d2exp (loc0, ctx, env, c2l.c2lau_body)
//
in
  c2lau_make (loc0, p2ts, gm2ts, c2l.c2lau_seq, c2l.c2lau_neg, d2e_body)
end // end of [eval1_c2lau]

implement
eval1_c2laulst
  (loc0, ctx, env, c2ls) =
  eval1_listmap (loc0, ctx, env, c2ls, eval1_c2lau)
// end of [eval1_c2laulst]

(* ****** ****** *)

extern fun eval1_v2aldeclst : eval1_type (v2aldeclst)
extern fun eval1_v2aldeclst_rec : eval1_type (v2aldeclst)

(* ****** ****** *)

implement
eval1_d2ecl (
  loc0, ctx, env, d2c0
) = let
in
//
case+
d2c0.d2ecl_node of
//
| D2Cnone (
  ) => d2ecl_none (loc0)
//
| D2Clist (d2cs) => let
    val d2cs = eval1_d2eclist (loc0, ctx, env, d2cs)
  in
    d2ecl_list (loc0, d2cs)
  end // end of [D2Clist]
//
| D2Cvaldecs (knd, d2cs) => let
    val d2cs = eval1_v2aldeclst (loc0, ctx, env, d2cs)
  in
    d2ecl_valdecs (loc0, knd, d2cs)
  end // end of [D2Cvaldecs]
| D2Cvaldecs_rec (knd, d2cs) => let
    val d2cs = eval1_v2aldeclst_rec (loc0, ctx, env, d2cs)
  in
    d2ecl_valdecs_rec (loc0, knd, d2cs)
  end // end of [D2Cvaldecs_rec]
//
| _(*not-handled*) => d2ecl_errdec (loc0)
//
end // end of [eval1_d2ecl]

(* ****** ****** *)

implement
eval1_d2eclist
  (loc0, ctx, env, d2cs) =
  eval1_listmap (loc0, ctx, env, d2cs, eval1_d2ecl)
// end of [eval1_d2eclist]

(* ****** ****** *)

implement
eval1_v2aldeclst
(
  loc0, ctx, env, d2cs
) = let
//
fun auxlst1
(
  loc0: location
, ctx: !evalctx, env: &alphenv
, d2cs: v2aldeclst
) : d2explst = (
  case+ d2cs of
  | list_cons
      (d2c, d2cs) => let
      val d2e =
        eval1_d2exp (loc0, ctx, env, d2c.v2aldec_def)
      val d2es = auxlst1 (loc0, ctx, env, d2cs)
    in
      list_cons (d2e, d2es)
    end // end of [list_cons]
  | list_nil () => list_nil ()
) // end of [auxlst1]
val d2es = auxlst1 (loc0, ctx, env, d2cs)
//
fun auxlst2 (
  loc0: location
, ctx: !evalctx, env: &alphenv
, d2cs: v2aldeclst, d2es: d2explst
) : v2aldeclst = let
in
//
case+ d2cs of
| list_cons 
    (d2c, d2cs) => let
    val p2t =
      eval1_p2at (loc0, ctx, env, d2c.v2aldec_pat)
    val-list_cons (d2e, d2es) = d2es
    val ann =
      eval1_s2expopt (loc0, ctx, env, d2c.v2aldec_ann)
    val d2c = v2aldec_make (loc0, p2t, d2e, ann)
    val d2cs = auxlst2 (loc0, ctx, env, d2cs, d2es)
  in
    list_cons (d2c, d2cs)
  end // end of [list_cons]
| list_nil () => list_nil ()
end // end of [auxlst2]
//
in
  auxlst2 (loc0, ctx, env, d2cs, d2es)
end // end of [eval1_v2aldeclst]

(* ****** ****** *)

implement
eval1_v2aldeclst_rec (
  loc0, ctx, env, d2cs
) = let
//
fun auxlst1 (
  loc0: location
, ctx: !evalctx, env: &alphenv, d2cs: v2aldeclst
) : p2atlst = (
  case+ d2cs of
  | list_cons
      (d2c, d2cs) => let
      val p2t = eval1_p2at (loc0, ctx, env, d2c.v2aldec_pat)
      val p2ts = auxlst1 (loc0, ctx, env, d2cs)
    in
      list_cons (p2t, p2ts)
    end // end of [list_cons]
  | list_nil () => list_nil ()
) // end of [auxlst1]
val p2ts = auxlst1 (loc0, ctx, env, d2cs)
//
fun auxlst2 (
  loc0: location
, ctx: !evalctx, env: &alphenv
, d2cs: v2aldeclst, p2ts: p2atlst
) : v2aldeclst = (
  case+ d2cs of
  | list_cons (d2c, d2cs) => let
      val d2e = eval1_d2exp (loc0, ctx, env, d2c.v2aldec_def)
      val-list_cons (p2t, p2ts) = p2ts
      val ann = eval1_s2expopt (loc0, ctx, env, d2c.v2aldec_ann)
      val d2c = v2aldec_make (loc0, p2t, d2e, ann)
      val d2cs = auxlst2 (loc0, ctx, env, d2cs, p2ts)
    in
      list_cons (d2c, d2cs)
    end
  | list_nil () => list_nil ()
) // end of [auxlst2]
//
in
  auxlst2 (loc0, ctx, env, d2cs, p2ts)
end // end of [eval1_v2aldeclst_rec]

(* ****** ****** *)

(* end of [pats_dmacro2_eval1.dats] *)
