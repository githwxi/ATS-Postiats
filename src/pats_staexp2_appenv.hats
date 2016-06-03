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

staload "./pats_staexp2.sats"

(* ****** ****** *)
//
extern
fun{}
s2cstlst_app : synent_app (s2cstlst)
//
extern
fun{}
s2varlst_app : synent_app (s2varlst)
//
extern
fun{}
d2conlst_app : synent_app (d2conlst)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
s2cstlst_app
  (xs, env) = synentlst_app (xs, env, s2cst_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
s2varlst_app
  (xs, env) = synentlst_app (xs, env, s2var_app)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
d2conlst_app
  (xs, env) = synentlst_app (xs, env, d2con_app)
//
(* ****** ****** *)
//
extern
fun{}
s2exp_app : synent_app (s2exp)
//
extern
fun{}
s2explst_app : synent_app (s2explst)
extern
fun{}
s2explstlst_app : synent_app (s2explstlst)
//
extern
fun{}
labs2explst_app : synent_app (labs2explst)
extern
fun{}
wths2explst_app : synent_app (wths2explst)
//
extern
fun{}
s2expopt_app : synent_app (s2expopt)
//
(* ****** ****** *)
//
extern
fun{}
s2qualst_app : synent_app (s2qualst)
//
(* ****** ****** *)
//
extern
fun{}
s2zexp_app : synent_app (s2zexp)
extern
fun{}
s2zexplst_app : synent_app (s2zexplst)
extern
fun{}
s2zexplstlst_app : synent_app (s2zexplstlst)
//
extern
fun{}
labs2zexplst_app : synent_app (labs2zexplst)
//
(* ****** ****** *)

implement
{}(*tmp*)
s2exp_app
  (s2e0, env) = let
in
//
case+
s2e0.s2exp_node of
//
| S2Eint _ => ()
| S2Eintinf _ => ()
//
| S2Efloat _ => ()
| S2Estring _ => ()
//
| S2Ecst(s2c) => s2cst_app(s2c, env)
//
| S2Eextype
   (name, s2ess) => s2explstlst_app(s2ess, env)
| S2Eextkind
   (name, s2ess) => s2explstlst_app(s2ess, env)
//
| S2Evar(s2v) => s2var_app(s2v, env)
//
| S2EVar(s2V) => s2Var_app(s2V, env)
//
| S2Ehole(s2hole) => ()
//
| S2Edatcontyp
    (d2c, s2es) => let
    val () = d2con_app (d2c, env)
    val () = s2explst_app (s2es, env)
  in
    // nothing
  end // end of [S2Edatcontyp]
| S2Edatconptr
    (d2c, s2e1, s2es2) => let
    val () = d2con_app (d2c, env)
    val () = s2exp_app (s2e1, env)
    val () = s2explst_app (s2es2, env)
  in
    // nothing    
  end // end of [S2Edatconptr]
//
| S2Eat (s2e1, s2e2) =>
  (
    s2exp_app (s2e1, env); s2exp_app (s2e2, env)
  ) (* end of [S2Eat] *)
//
| S2Esizeof (s2e) => s2exp_app (s2e, env)
//
| S2Eeff _ => ()
//
| S2Eeqeq (s2e1, s2e2) =>
  (
    s2exp_app (s2e1, env); s2exp_app (s2e2, env)
  ) (* end of [S2Eeqeq] *)
//
| S2Eproj
    (s2e1, s2e2, s2ls) =>
  (
    s2exp_app (s2e1, env); s2exp_app (s2e2, env)
  ) (* end of [S2Eproj] *)
//
| S2Eapp
    (s2e1, s2es2) =>
  (
    s2exp_app (s2e1, env); s2explst_app (s2es2, env)
  ) (* end of [S2Eapp] *)
//
| S2Elam
    (s2vs1, s2e2_body) =>
  (
    s2varlst_app (s2vs1, env); s2exp_app (s2e2_body, env)
  ) (* end of [S2Elam] *)
//
| S2Efun
    (fc, lin, s2fe, npf, s2es1_arg, s2e2_res) =>
  (
    s2explst_app (s2es1_arg, env); s2exp_app (s2e2_res, env)
  ) (* end of [S2Efun] *)
//
| S2Emetfun
    (opt, s2es1, s2e2) =>
  (
    s2explst_app (s2es1, env); s2exp_app (s2e2, env)
  ) (* end of [S2Emetfun] *)
| S2Emetdec (s2es1, s2es2) =>
  (
    s2explst_app (s2es1, env); s2explst_app (s2es2, env)
  ) (* end of [S2Emetdec] *)
//
| S2Etop (knd, s2e) => s2exp_app (s2e, env)
| S2Ewithout (s2out) => s2exp_app (s2out, env)
//
| S2Etyarr (s2e1, s2es2) =>
  (
    s2exp_app (s2e1, env); s2explst_app (s2es2, env)
  ) (* end of [S2Etyarr] *)
| S2Etyrec (knd, npf, ls2es) => labs2explst_app (ls2es, env)
//
| S2Einvar (s2e) => s2exp_app (s2e, env)
//
| S2Eexi
    (s2vs, s2ps, s2e_body) =>
  (
    s2varlst_app (s2vs, env);
    s2explst_app (s2ps, env); s2exp_app (s2e_body, env)
  ) (* end of [S2Eexi] *)
| S2Euni
    (s2vs, s2ps, s2e_body) =>
  (
    s2varlst_app (s2vs, env);
    s2explst_app (s2ps, env); s2exp_app (s2e_body, env)
  ) (* end of [S2Euni] *)
//
| S2Erefarg
    (knd, s2e) => s2exp_app (s2e, env)
  // end of [S2Erefarg]
//
| S2Evararg(s2e) => s2exp_app (s2e, env)
//
| S2Ewthtype(s2e, ws2es) =>
  (
    s2exp_app (s2e, env); wths2explst_app (ws2es, env);
  )
//
| S2Eerrexp((*void*)) => ()
//
(*
| _ (* rest-of-s2exp *) => ()
*)
//
end // end of [s2exp_app]

(* ****** ****** *)
//
implement
{}(*tmp*)
s2explst_app
  (xs, env) = synentlst_app (xs, env, s2exp_app)
//
implement
{}(*tmp*)
s2explstlst_app
  (xss, env) = synentlst_app (xss, env, s2explst_app)
//
(* ****** ****** *)

implement
{}(*tmp*)
labs2explst_app
  (lxs, env) = let
in
//
case+ lxs of
| list_nil () => ()
| list_cons
    (lx, lxs) => let
    val+SLABELED(_, _, x) = lx
    val () = s2exp_app (x, env)
  in
    labs2explst_app (lxs, env)
  end // end of [list_cons]
//
end // end of [labs2explst_app]

(* ****** ****** *)

implement
{}(*tmp*)
wths2explst_app
  (wxs, env) = let
in
//
case+ wxs of
| WTHS2EXPLSTnil () => ()
| WTHS2EXPLSTcons_invar(_, x, wxs) =>
  (
    s2exp_app (x, env); wths2explst_app (wxs, env)
  )
| WTHS2EXPLSTcons_trans(_, x, wxs) =>
  (
    s2exp_app (x, env); wths2explst_app (wxs, env)
  )
| WTHS2EXPLSTcons_none (wxs) => wths2explst_app (wxs, env)
//
end // end of [wths2explst_app]

(* ****** ****** *)

implement
{}(*tmp*)
s2expopt_app (opt, env) =
(
//
case+ opt of
| Some (s2e) => s2exp_app (s2e, env) | None () => ()
//
) (* end of [s2expopt] *)

(* ****** ****** *)
  
implement
{}(*tmp*)
s2qualst_app
  (s2qs, env) = let
in
//
case+ s2qs of
| list_nil () => ()
| list_cons (s2q, s2qs) =>
  (
    s2varlst_app (s2q.s2qua_svs, env);
    s2explst_app (s2q.s2qua_sps, env); s2qualst_app (s2qs, env)
  ) (* end of [list_cons] *)
//
end // end of [s2qualst_app]
  
(* ****** ****** *)

implement
{}(*tmp*)
s2zexp_app
  (x0, env) =
(
//
case+ x0 of
//
| S2ZEprf () => ()
| S2ZEptr () => ()
//
| S2ZEcst (s2c) => s2cst_app (s2c, env)
| S2ZEvar (s2v) => s2var_app (s2v, env)
| S2ZEVar (s2V) => s2Var_app (s2V, env)
//
| S2ZEextype (name, xss) => s2zexplstlst_app (xss, env)
| S2ZEextkind (name, xss) => s2zexplstlst_app (xss, env)
//
| S2ZEapp (x1, xs2) =>
  (
    s2zexp_app (x1, env); s2zexplst_app (xs2, env)
  )
| S2ZEtyarr (x1, s2es_dim) =>
  (
    s2zexp_app (x1, env); s2explst_app (s2es_dim, env)
  )
| S2ZEtyrec (knd, lxs) => labs2zexplst_app (lxs, env)
//
| S2ZEclo () => ()
//
| S2ZEbot () => ()
//
) (* end of [s2zexp_app] *)

(* ****** ****** *)
//
implement
{}(*tmp*)
s2zexplst_app
  (xs, env) = synentlst_app (xs, env, s2zexp_app)
//
implement
{}(*tmp*)
s2zexplstlst_app
  (xss, env) = synentlst_app (xss, env, s2zexplst_app)
//
(* ****** ****** *)

implement
{}(*tmp*)
labs2zexplst_app
  (lxs, env) = (
//
case+ lxs of
| list_nil () => ()
| list_cons (lx, lxs) => let
    val SZLABELED(l, x) = lx
    val ((*void*)) = s2zexp_app (x, env)
  in
    labs2zexplst_app (lxs, env)
  end // end of [list_cons]
//
) (* end of [labs2zexplst_app] *)

(* ****** ****** *)

(* end of [pats_staexp2_appenv.dats] *)
