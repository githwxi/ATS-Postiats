(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author:
// Hongwei Xi
// Authoremail:
// gmhwxiATgmailDOTcom
// Start Time: December, 2014
//
(* ****** ****** *)
//
// HX-2014-12-09:
// This one implements a standard [app] function over the level-2 syntax tree
// Note that [app] is often referred to as [foreach]
//
(* ****** ****** *)
//
staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"
//
(* ****** ****** *)
//
extern
fun{}
d2cstlst_app : synent_app (d2cstlst)
//
extern
fun{}
d2varlst_app : synent_app (d2varlst)
extern
fun{}
d2varopt_app : synent_app (d2varopt)
//  
(* ****** ****** *)
//
extern
fun{}
d2itm_app : synent_app (d2itm)
extern
fun{}
d2itmlst_app : synent_app (d2itmlst)
extern
fun{}
d2itmopt_app : synent_app (d2itmopt)
//
extern
fun{}
d2pitm_app : synent_app (d2pitm)
extern
fun{}
d2pitmlst_app : synent_app (d2pitmlst)
//
(* ****** ****** *)
//
extern
fun{}
d2atdecs_app : synent_app (s2cstlst)
//
extern
fun{}
d2cstdecs_app : synent_app (d2cstlst)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
d2cstlst_app
  (xs, env) = synentlst_app (xs, env, d2cst_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
d2varlst_app
  (xs, env) = synentlst_app (xs, env, d2var_app)
//
(* ****** ****** *)

implement
{}(*tmp*)
d2varopt_app
  (opt, env) =
(
case+ opt of
| Some (d2v) => d2var_app (d2v, env) | None () => ()
) (* end of [d2varopt_app] *)

(* ****** ****** *)
  
implement
{}(*tmp*)
d2itm_app
  (d2i, env) = let
in
//
case d2i of
| D2ITMcst (d2c) => d2cst_app (d2c, env)
| D2ITMvar (d2v) => d2var_app (d2v, env)
| D2ITMcon (d2cs) => d2conlst_app (d2cs, env)
| D2ITMe1xp (e1xp) => ()
| D2ITMsymdef (sym, d2pis) => d2pitmlst_app (d2pis, env)
| D2ITMmacdef (d2m) => ()
| D2ITMmacvar (d2v) => d2var_app (d2v, env)
//
end // end of [d2itm_app]
  
(* ****** ****** *)
//
implement
{}(*tmp*)
d2itmlst_app
  (xs, env) = synentlst_app (xs, env, d2itm_app)
//
(* ****** ****** *)

implement
{}(*tmp*)
d2itmopt_app
  (opt, env) =
(
case+ opt of
| Some (x) => d2itm_app (x, env) | None () => ()
) (* end of [d2itmopt_app] *)

(* ****** ****** *)

implement
{}(*tmp*)
d2pitm_app
  (d2pi, env) = let
//
val+D2PITM(pval, d2i) = d2pi in d2itm_app (d2i, env)
//
end // end of [d2pitm_app]

(* ****** ****** *)
//
implement
{}(*tmp*)
d2pitmlst_app
  (xs, env) = synentlst_app (xs, env, d2pitm_app)
//
(* ****** ****** *)

implement
{}(*tmp*)
d2atdecs_app
  (s2cs, env) = let
//
fun
auxlst_dcon
(
  d2cs: d2conlst, env: !appenv
) : void = 
(
case+ d2cs of
| list_nil () => ()
| list_cons
    (d2c, d2cs) => let
    val () = d2con_app (d2c, env)
    val s2e = d2con_get_type (d2c)
    val () = s2exp_app (s2e, env)
  in
    auxlst_dcon (d2cs, env)
  end // end of [list_cons]
) (* end of [auxlst_dcon] *)
//
fun
auxlst_scst
(
  s2cs: s2cstlst, env: !appenv
) : void = 
(
case+ s2cs of
| list_nil () => ()
| list_cons
    (s2c, s2cs) => let
    val opt = s2cst_get_dconlst(s2c)
    val ((*void*)) =
    (
      case+ opt of
      | None () => ()
      | Some (d2cs) => auxlst_dcon (d2cs, env)
    ) (* end of [val] *)
  in
    auxlst_scst (s2cs, env)
  end // end of [list_cons]
) (* end of [auxlst_scst] *)
//
val () = s2cstlst_app (s2cs, env)
//
in
  auxlst_scst (s2cs, env)
end // end of [d2atdecs_app]

(* ****** ****** *)

implement
{}(*tmp*)
d2cstdecs_app
  (d2cs, env) = let
//
(*
fun
auxlst
(
  d2cs: d2cstlst, env: !appenv
) : void = (
//
case+ d2cs of
| list_nil
    ((*void*)) => ()
| list_cons
    (d2c, d2cs) => let
    val s2e = d2cst_get_type(d2c)
  in
    s2exp_app(s2e, env); auxlst(d2cs, env)
  end (* end of [list_cons] *)
) (* end of [auxlst] *)
val () = auxlst(d2cs, env)
*)
val () = d2cstlst_app(d2cs, env)
//
in
  // nothing
end // end of [d2cstdecs_app]

(* ****** ****** *)

extern
fun{}
sp2at_app : synent_app (sp2at)

(* ****** ****** *)

extern
fun{}
s2exparg_app : synent_app (s2exparg)
extern
fun{}
s2exparglst_app : synent_app (s2exparglst)

(* ****** ****** *)

extern
fun{}
t2mpmarg_app : synent_app (t2mpmarg)
extern
fun{}
t2mpmarglst_app : synent_app (t2mpmarglst)

(* ****** ****** *)
//
extern
fun{}
p2at_app : synent_app (p2at)
extern
fun{}
p2atlst_app : synent_app (p2atlst)
extern
fun{}
labp2atlst_app : synent_app (labp2atlst)
//
extern
fun{}
p2atopt_app : synent_app (p2atopt)
//
(* ****** ****** *)
//
extern
fun{}
d2exp_app : synent_app (d2exp)
extern
fun{}
d2explst_app : synent_app (d2explst)
extern
fun{}
labd2explst_app : synent_app (labd2explst)
//
extern
fun{}
d2expopt_app : synent_app (d2expopt)
//
(* ****** ****** *)

extern
fun{}
d2lab_app : synent_app (d2lab)
extern
fun{}
d2lablst_app : synent_app (d2lablst)

(* ****** ****** *)

extern
fun{}
d2exparg_app : synent_app (d2exparg)
extern
fun{}
d2exparglst_app : synent_app (d2exparglst)

(* ****** ****** *)
//
extern
fun{}
i2fcl_app : synent_app (i2fcl)
extern
fun{}
i2fclist_app : synent_app (i2fclist)
//
(* ****** ****** *)
//
extern
fun{}
gm2at_app : synent_app (gm2at)
extern
fun{}
gm2atlst_app : synent_app (gm2atlst)
//
(* ****** ****** *)
//
extern
fun{}
c2lau_app : synent_app (c2lau)
extern
fun{}
c2laulst_app : synent_app (c2laulst)
//
extern
fun{}
sc2lau_app : synent_app (sc2lau)
extern
fun{}
sc2laulst_app : synent_app (sc2laulst)
//
(* ****** ****** *)
//
extern
fun{}
d2ecl_app : synent_app (d2ecl)
extern
fun{}
d2eclist_app : synent_app (d2eclist)
//
(* ****** ****** *)

extern
fun{}
i2mpdec_app : synent_app (i2mpdec)

(* ****** ****** *)
//
extern
fun{}
f2undec_app : synent_app (f2undec)
extern
fun{}
f2undeclst_app : synent_app (f2undeclst)
//
extern
fun{}
v2aldec_app : synent_app (v2aldec)
extern
fun{}
v2aldeclst_app : synent_app (v2aldeclst)
//
(* ****** ****** *)
//
extern
fun{}
v2ardec_app : synent_app (v2ardec)
extern
fun{}
v2ardeclst_app : synent_app (v2ardeclst)
//
extern
fun{}
prv2ardec_app : synent_app (prv2ardec)
extern
fun{}
prv2ardeclst_app : synent_app (prv2ardeclst)
//
(* ****** ****** *)

implement
{}(*tmp*)
sp2at_app
  (sp2t, env) = let
in
//
case+
sp2t.sp2at_node of
| SP2Tcon
    (s2c, s2vs) =>
  (
    s2cst_app (s2c, env); s2varlst_app (s2vs, env)
  ) (* end of [SP2Tcon] *)
| SP2Terr ((*void*)) => ()
//
end // end of [sp2at_app]

(* ****** ****** *)
  
implement
{}(*tmp*)
s2exparg_app
  (s2a0, env) = let
in
//
case+
s2a0.s2exparg_node of
| S2EXPARGone () => ()
| S2EXPARGall () => ()
| S2EXPARGseq (s2es) => s2explst_app (s2es, env)
//
end // end of [s2exparg_app]
  
(* ****** ****** *)
//
implement
{}(*tmp*)
s2exparglst_app
  (xs, env) =
  synentlst_app (xs, env, s2exparg_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
t2mpmarg_app
  (t2ma, env) =
  s2explst_app (t2ma.t2mpmarg_arg, env)
//
implement
{}(*tmp*)
t2mpmarglst_app
  (xs, env) =
  synentlst_app (xs, env, t2mpmarg_app)
//
(* ****** ****** *)

implement
{}(*tmp*)
p2at_app
  (p2t0, env) = let
in
//
case+
p2t0.p2at_node of
//
| P2Tany () => ()
| P2Tvar (d2v) =>
    d2var_app (d2v, env)
//
| P2Tcon
  (
    knd, d2c, s2qs
  , s2e_con, npf, p2ts_arg
  ) => let
    val () = d2con_app (d2c, env)
    val () = s2qualst_app (s2qs, env)
    val () = s2exp_app (s2e_con, env)
  in
    p2atlst_app (p2ts_arg, env)
  end // end of [P2Tcon]
//
| P2Tint _ => ()
| P2Tintrep _ => ()
//
| P2Tbool _ => ()
| P2Tchar _ => ()
| P2Tfloat _ => ()
| P2Tstring _ => ()
//
| P2Ti0nt _ => ()
| P2Tf0loat _ => ()
//
| P2Tempty () => ()
//
| P2Tlst (lin, p2ts) => p2atlst_app (p2ts, env)
| P2Trec (knd, npf, lp2ts) => labp2atlst_app (lp2ts, env)
//
| P2Trefas (d2v, p2t) =>
  (
    d2var_app (d2v, env); p2at_app (p2t, env)
  ) (* end of [P2Trefas] *)
//
| P2Texist (s2vs, p2t) =>
  (
    s2varlst_app (s2vs, env); p2at_app (p2t, env)
  ) (* end of [P2Texist] *)
//
| P2Tvbox (d2v) => d2var_app (d2v, env)
//
| P2Tann (p2t, s2e) =>
  (
    p2at_app (p2t, env); s2exp_app (s2e, env)
  )
//
| P2Tlist (npf, p2ts) => p2atlst_app (p2ts, env)
//
| P2Terrpat () => ()
//
end // end of [p2at_app]

(* ****** ****** *)
//
implement
{}(*tmp*)
p2atlst_app
  (xs, env) = synentlst_app (xs, env, p2at_app)
//
(* ****** ****** *)

implement
{}(*tmp*)
labp2atlst_app
  (lxs, env) = let
in
//
case+ lxs of
| list_cons 
    (lx, lxs) => let
    val () = (
      case+ lx of
      | LABP2ATnorm
          (l, x) => p2at_app (x, env)
      | LABP2ATomit (loc) => ()
    ) : void // end of [val]
  in
    labp2atlst_app (lxs, env)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [labp2atlst_app]

(* ****** ****** *)

implement
{}(*tmp*)
p2atopt_app
  (opt, env) =
(
case+ opt of
| Some (x) => p2at_app (x, env) | None () => ()
) (* end of [p2atopt_app] *)

(* ****** ****** *)

implement
{}(*tmp*)
d2exp_app
  (d2e0, env) = let
in
//
case+
d2e0.d2exp_node of
//
| D2Ecst (d2c) => d2cst_app (d2c, env)
| D2Evar (d2v) => d2var_app (d2v, env)
//
| D2Eint _ => ()
| D2Eintrep _ => ()
| D2Ebool _ => ()
| D2Echar _ => ()
| D2Efloat _ => ()
| D2Estring _ => ()
//
| D2Ei0nt _ => ()
| D2Ec0har _ => ()
| D2Ef0loat _ => ()
| D2Es0tring _ => ()
//
| D2Etop () => ()
| D2Etop2 (s2e) => s2exp_app (s2e, env)
| D2Eempty () => ()
//
| D2Ecstsp _ => ()
| D2Etyrep (s2e) => s2exp_app (s2e, env)
| D2Eliteral _ => ()
//
| D2Eextval (s2e, name) => s2exp_app (s2e, env)
//
| D2Eextfcall
    (s2e_res, _fun, d2es_arg) =>
  (
    s2exp_app (s2e_res, env); d2explst_app (d2es_arg, env)
  ) (* end of [D2Eextfcall] *)
| D2Eextmcall
    (s2e_res, d2e_obj, _mtd, d2es_arg) =>
  (
    s2exp_app (s2e_res, env);
    d2exp_app (d2e_obj, env); d2explst_app (d2es_arg, env)
  ) (* end of [D2Eextmcall] *)
//
| D2Econ
  (
    d2c, loc1, s2as, npf, loc2, d2es_arg
  ) => (
    d2con_app (d2c, env);
    s2exparglst_app (s2as, env); d2explst_app (d2es_arg, env)
  ) (* end of [D2Econ] *)
//
| D2Esym (d2s) => d2sym_app (d2s, env)
//
| D2Efoldat (s2as, d2e) =>
  (
    s2exparglst_app (s2as, env); d2exp_app (d2e, env)
  ) (* D2Efoldat *)
| D2Efreeat (s2as, d2e) =>
  (
    s2exparglst_app (s2as, env); d2exp_app (d2e, env)
  ) (* D2Efreeat *)
//
| D2Etmpid (d2e_id, t2mas) =>
  (
    d2exp_app (d2e_id, env); t2mpmarglst_app (t2mas, env)
  ) (* end of [D2Etmpid] *)
//
| D2Elet (d2cs, d2e) =>
  (
    d2eclist_app (d2cs, env); d2exp_app (d2e, env)
  )
| D2Ewhere (d2e, d2cs) =>
  (
    d2eclist_app (d2cs, env); d2exp_app (d2e, env)
  )
//
| D2Eapplst (d2e_fun, d2as) =>
  (
    d2exp_app (d2e_fun, env); d2exparglst_app (d2as, env)
  )
//
| D2Eifhead
    (invres, _test, _then, _else) =>
  (
    d2exp_app (_test, env);
    d2exp_app (_then, env); d2expopt_app (_else, env);
  ) (* end of [D2Eifhead] *)
| D2Esifhead
    (invres, _test, _then, _else) =>
  (
    s2exp_app (_test, env);
    d2exp_app (_then, env); d2exp_app (_else, env);
  ) (* end of [D2Esifhead] *)
//
| D2Eifcasehd
    (knd, invres, ifcls) => i2fclist_app (ifcls, env)
//
| D2Ecasehead
    (knd, invres, d2es, c2ls) =>
  (
    d2explst_app (d2es, env); c2laulst_app (c2ls, env)
  ) (* end of [D2Ecaseof] *)
| D2Escasehead
    (invres, s2e, sc2ls) => let
    val () = s2exp_app (s2e, env) in sc2laulst_app (sc2ls, env)
  end // end of [D2Escasehead]
//
| D2Esing (d2e) => d2exp_app (d2e, env)
| D2Elist (npf, d2es) => d2explst_app (d2es, env)
//
| D2Elst (lin, opt, d2es) =>
  (
    s2expopt_app (opt, env); d2explst_app (d2es, env)
  ) (* end of [D2Elst] *)
| D2Etup (knd, npf, d2es) => d2explst_app (d2es, env)
| D2Erec (knd, npf, ld2es) => labd2explst_app (ld2es, env)
| D2Eseq (d2es) => d2explst_app (d2es, env)
//
| D2Eselab (d2e, d2ls) =>
  (
    d2exp_app (d2e, env); d2lablst_app (d2ls, env)
  ) (* end of [D2Eselab] *)
//
| D2Eptrof (d2lval) => d2exp_app (d2lval, env)
| D2Eviewat (d2lval) => d2exp_app (d2lval, env)
//
| D2Eann_type (d2e, s2e_ann) =>
  (
    d2exp_app (d2e, env); s2exp_app (s2e_ann, env)
  ) (* end of [D2Eapp_type] *)
| D2Eann_seff (d2e, s2fe) => d2exp_app (d2e, env)
| D2Eann_funclo (d2e, funclo) => d2exp_app (d2e, env)
//
| D2Ederef (d2s, d2e) =>
  (
    d2sym_app(d2s, env); d2exp_app (d2e, env)
  )
| D2Eassgn (d2e_l, d2e_r) =>
  (
    d2exp_app (d2e_l, env); d2exp_app (d2e_r, env)
  ) (* end of [D2Eassgn] *)
| D2Exchng (d2e_l, d2e_r) =>
  (
    d2exp_app (d2e_l, env); d2exp_app (d2e_r, env)
  ) (* end of [D2Exchng] *)
//
| D2Earrsub
  (
    d2s, d2e, loc, d2es_ind
  ) => (
    d2sym_app (d2s, env);
    d2exp_app (d2e, env); d2explst_app (d2es_ind, env)
  ) (* end of [D2Earrsub] *)
| D2Earrpsz
    (opt, d2es_elt) =>
  (
    s2expopt_app (opt, env); d2explst_app (d2es_elt, env)
  ) (* end of [D2Earrpsz] *)
| D2Earrinit
    (s2e, asz, d2es_ini) =>
  (
    s2exp_app (s2e, env);
    d2expopt_app (asz, env); d2explst_app (d2es_ini, env)
  ) (* end of [D2Earrinit] *)
//
| D2Eraise(d2e) => d2exp_app(d2e, env)
//
| D2Eeffmask(s2fe, d2e) => d2exp_app(d2e, env)
//
| D2Evararg(d2es) => d2explst_app(d2es, env)
//
| D2Evcopyenv(knd, d2e) => d2exp_app(d2e, env)
//
| D2Eshowtype(d2e) => d2exp_app(d2e, env)
//
| D2Etempenver(d2vs) => d2varlst_app(d2vs, env)
//
| D2Eexist(s2a, d2e) =>
  (
    s2exparg_app (s2a, env); d2exp_app (d2e, env)
  ) (* end of [D2Eexist] *)
//
| D2Elam_dyn
    (lin, npf, p2ts, d2e) =>
  (
    p2atlst_app (p2ts, env); d2exp_app (d2e, env)
  ) (* end of [D2Elam_dyn] *)
| D2Elaminit_dyn
    (lin, npf, p2ts, d2e) =>
  (
    p2atlst_app (p2ts, env); d2exp_app (d2e, env)
  ) (* end of [D2Elaminit_dyn] *)
| D2Elam_met
    (ref, s2es_met, d2e) =>
  (
    d2varlst_app (!ref, env);
    s2explst_app (s2es_met, env); d2exp_app (d2e, env)
  ) (* end of [D2Elam_met] *)
| D2Elam_sta
    (s2vs, s2ps_gua, d2e) =>
  (
    s2varlst_app (s2vs, env);
    s2explst_app (s2ps_gua, env); d2exp_app (d2e, env)
  ) (* end of [D2Elam_sta] *)
//
| D2Efix
    (knd, d2v_fix, d2e_body) =>
  (
    d2var_app (d2v_fix, env); d2exp_app (d2e_body, env)
  ) (* end of [D2Efix] *)
//
| D2Edelay (d2e) => d2exp_app (d2e, env)
| D2Eldelay
    (d2e1, d2eopt2) =>
  (
    d2exp_app (d2e1, env); d2expopt_app (d2eopt2, env)
  ) (* end of [D2Eldelay] *)
//
| D2Efor
  (
    loopinv
  , d2e_init, d2e_test, d2e_post, d2e_body
  ) =>
  {
    val () = d2exp_app (d2e_init, env)
    val () = d2exp_app (d2e_test, env)
    val () = d2exp_app (d2e_post, env)
    val () = d2exp_app (d2e_body, env)
  } (* end of [D2Efor] *)
| D2Ewhile
    (loopinv, d2e_test, d2e_body) =>
  {
    val () = d2exp_app (d2e_test, env)
    val () = d2exp_app (d2e_body, env)
  } (* end of [D2Ewhile] *)
//
| D2Eloopexn (knd) => ()
//
| D2Etrywith
    (invres, d2e, c2ls) =>
  (
    d2exp_app (d2e, env); c2laulst_app (c2ls, env)
  )
//
| D2Esolverify(s2e) => ()
| D2Esolassert(d2e) => d2exp_app (d2e, env)
//
| D2Emac (d2mac) => ()
| D2Emacsyn (knd, d2e) => d2exp_app (d2e, env)
| D2Emacfun (name, d2es) => d2explst_app (d2es, env)
//
| D2Eerrexp ((*void*)) => ()
//
end // end of [d2exp_app]

(* ****** ****** *)

implement
{}(*tmp*)
d2explst_app
  (xs, env) = let
in
//
case+ xs of
| list_nil () => ()
| list_cons (x, xs) =>
  (
    d2exp_app(x, env); d2explst_app(xs, env)
  ) (* end of [list_cons] *)
//
end (* end of [d2explst_app] *)

(* ****** ****** *)

implement
{}(*tmp*)
labd2explst_app
  (lxs, env) = (
//
case+ lxs of
| list_nil () => ()
| list_cons (lx, lxs) => let
    val+$SYN.DL0ABELED(l, x) = lx
  in
    d2exp_app (x, env); labd2explst_app (lxs, env)
  end // end of [list_cons]
//
) (* end of [labd2exp_app] *)
  
(* ****** ****** *)

implement
{}(*tmp*)
d2expopt_app
  (opt, env) =
(
case+ opt of
| Some (x) => d2exp_app (x, env) | None () => ()
) (* end of [d2expopt_app] *)

(* ****** ****** *)

implement
{}(*tmp*)
d2lab_app
  (d2l0, env) = let
in
//
case+
d2l0.d2lab_node of
| D2LABlab (lab) => ()
| D2LABind (d2es) => d2explst_app (d2es, env)
//
end // end of [d2lab_app]

(* ****** ****** *)
//
implement
{}(*tmp*)
d2lablst_app
  (xs, env) = synentlst_app (xs, env, d2lab_app)
//
(* ****** ****** *)

implement
{}(*tmp*)
d2exparg_app
  (d2a0, env) = let
in
//
case+ d2a0 of
| D2EXPARGsta (loc, s2as) => s2exparglst_app (s2as, env)
| D2EXPARGdyn (npf, loc, d2es) => d2explst_app (d2es, env)
//
end // end of [d2exparg_app]

(* ****** ****** *)
//
implement
{}(*tmp*)
d2exparglst_app
  (xs, env) = synentlst_app (xs,env, d2exparg_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
i2fcl_app
  (ifcl, env) =
{
  val () = d2exp_app (ifcl.i2fcl_test, env)
  val () = d2exp_app (ifcl.i2fcl_body, env)
} (* end of [i2fcl_app] *)
//
implement
{}(*tmp*)
i2fclist_app
  (xs, env) = synentlst_app (xs, env, i2fcl_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
gm2at_app
  (gua, env) =
{
  val () = d2exp_app (gua.gm2at_exp, env)
  val () = p2atopt_app (gua.gm2at_pat, env)
} (* end of [gm2at] *)
//
implement
{}(*tmp*)
gm2atlst_app
  (xs, env) = synentlst_app (xs,env, gm2at_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
c2lau_app
  (c2l, env) =
{
  val () = p2atlst_app (c2l.c2lau_pat, env)
  val () = gm2atlst_app (c2l.c2lau_gua, env)
  val () = d2exp_app (c2l.c2lau_body, env)
} (* end of [c2lau_app] *)
//
implement
{}(*tmp*)
c2laulst_app
  (xs, env) = synentlst_app (xs, env, c2lau_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
sc2lau_app
  (sc2l, env) =
{
  val () = sp2at_app (sc2l.sc2lau_pat, env)
  val () = d2exp_app (sc2l.sc2lau_body, env)
} (* end of [sc2lau_app] *)
//
implement
{}(*tmp*)
sc2laulst_app
  (xs, env) = synentlst_app (xs, env, sc2lau_app)
//
(* ****** ****** *)

implement
{}(*tmp*)
d2ecl_app
  (d2c0, env) = let
in
//
case+
d2c0.d2ecl_node of
//
| D2Cnone () => ()
| D2Clist (d2cs) => d2eclist_app (d2cs, env)
//
| D2Csymintr (ids) => ()
| D2Csymelim (ids) => ()
//
| D2Coverload
    (id, pval, opt) => d2itmopt_app (opt, env)
//
| D2Cstacsts (s2cs) => s2cstlst_app (s2cs, env)
| D2Cstacons (knd, s2cs) => s2cstlst_app (s2cs, env)
//
(*
| D2Csaspdec of s2aspdec (* for static assumption *)
*)
//
| D2Cextype(name, s2e) => s2exp_app(s2e, env)
| D2Cextvar(name, d2e) => d2exp_app(d2e, env)
| D2Cextcode(knd, pos, code) => ((*void*))
//
| D2Cdatdecs(int, s2cs) => d2atdecs_app(s2cs, env)
| D2Cexndecs( d2cs_exn ) => d2conlst_app(d2cs_exn, env)
//
| D2Cdcstdecs
    (staext, knd, d2cs) => d2cstdecs_app(d2cs, env)
  // end of [D2Cdcstdecs]
//
| D2Cimpdec (knd, impdec) => i2mpdec_app (impdec, env)
//
| D2Cfundecs (knd, s2qs, f2ds) =>
  (
    s2qualst_app (s2qs, env); f2undeclst_app (f2ds, env)
  ) (* end of [D2Cfundecs] *)
//
| D2Cvaldecs (knd, v2ds) => v2aldeclst_app (v2ds, env)
| D2Cvaldecs_rec (knd, v2ds) => v2aldeclst_app (v2ds, env)
//
| D2Cvardecs (v2ds) => v2ardeclst_app (v2ds, env)
| D2Cprvardecs (pv2ds) => prv2ardeclst_app (pv2ds, env)
//
| D2Cinclude _ => ()
//
| D2Cstaload _ => ()
| D2Cstaloadloc _ => ()
| D2Cdynload _ => ()
//
| D2Clocal (d2cs1, d2cs2) =>
  (
    d2eclist_app (d2cs1, env); d2eclist_app (d2cs2, env)
  ) (* end of [D2Clocal] *)
//
| D2Cerrdec ((*void*)) => ()
//
| _ => ()
//
end // end of [d2ecl_app]

(*
//
//
*)
(* ****** ****** *)

implement
{}(*tmp*)
d2eclist_app
  (xs, env) = let
in
//
case+ xs of
| list_nil () => ()
| list_cons (x, xs) =>
  (
    d2ecl_app(x, env); d2eclist_app(xs, env)
  ) (* end of [list_cons] *)
//
end (* end of [d2eclist_app] *)

(* ****** ****** *)

implement
{}(*tmp*)
i2mpdec_app
  (impdec, env) =
{
//
val () = d2cst_app (impdec.i2mpdec_cst, env)
val () = s2varlst_app (impdec.i2mpdec_imparg, env)
val () = s2explstlst_app (impdec.i2mpdec_tmparg, env)
val () = s2explstlst_app (impdec.i2mpdec_tmpgua, env)
val () = d2exp_app (impdec.i2mpdec_def, env)
//
} // end of [i2mpdec_app]

(* ****** ****** *)
//
implement
{}(*tmp*)
f2undec_app
  (f2d, env) =
{
//
val () = d2var_app (f2d.f2undec_var, env)
val () = d2exp_app (f2d.f2undec_def, env)
val () = s2expopt_app (f2d.f2undec_ann, env)
//
} (* end of [f2undec_app] *)
//
implement
{}(*tmp*)
f2undeclst_app
  (xs, env) = synentlst_app (xs, env, f2undec_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
v2aldec_app
  (v2d, env) =
{
//
val () = p2at_app (v2d.v2aldec_pat, env)
val () = d2exp_app (v2d.v2aldec_def, env)
val () = s2expopt_app (v2d.v2aldec_ann, env)
//
} (* end of [v2aldec_app] *)
//
implement
{}(*tmp*)
v2aldeclst_app
  (xs, env) = synentlst_app (xs, env, v2aldec_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
v2ardec_app
  (v2d, env) =
{
//
val () = s2var_app (v2d.v2ardec_svar, env)
val () = d2var_app (v2d.v2ardec_dvar, env)
val () = d2varopt_app (v2d.v2ardec_pfat, env)
val () = s2expopt_app (v2d.v2ardec_type, env)
val () = d2expopt_app (v2d.v2ardec_init, env)
val () = d2varopt_app (v2d.v2ardec_dvaropt, env)
//
} (* end of [v2ardec_app] *)
//
implement
{}(*tmp*)
v2ardeclst_app
  (xs, env) = synentlst_app (xs, env, v2ardec_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
prv2ardec_app
  (pv2d, env) =
{
//
val () = d2var_app (pv2d.prv2ardec_dvar, env)
val () = s2expopt_app (pv2d.prv2ardec_type, env)
val () = d2expopt_app (pv2d.prv2ardec_init, env)
//
} (* end of [prv2ardec_val] *)
//
implement
{}(*tmp*)
prv2ardeclst_app
  (xs, env) = synentlst_app (xs, env, prv2ardec_app)
//
(* ****** ****** *)

(* end of [pats_dynexp2_appenv.dats] *)
