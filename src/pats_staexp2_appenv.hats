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
fun s2cst_app : synent_app (s2cst)
extern
fun s2cstlst_app : synent_app (s2cstlst)
//
(* ****** ****** *)
//
extern
fun s2var_app : synent_app (s2var)
extern
fun s2varlst_app : synent_app (s2varlst)
//
(* ****** ****** *)
//
extern
fun d2con_app : synent_app (d2con)
extern
fun d2conlst_app : synent_app (d2conlst)
//
(* ****** ****** *)
//
implement
s2cstlst_app
  (xs, env) = let
in
//
case+ xs of
| list_nil () => ()
| list_cons (x, xs) =>
  (
    s2cst_app(x, env); s2cstlst_app(xs, env)
  ) (* end of [list_cons] *)
//
end (* end of [s2cstlst_app] *)
//
(* ****** ****** *)
//
implement
s2varlst_app
  (xs, env) = let
in
//
case+ xs of
| list_nil () => ()
| list_cons (x, xs) =>
  (
    s2var_app(x, env); s2varlst_app(xs, env)
  ) (* end of [list_cons] *)
//
end (* end of [s2varlst_app] *)
//
(* ****** ****** *)
//
implement
d2conlst_app
  (xs, env) = let
in
//
case+ xs of
| list_nil () => ()
| list_cons (x, xs) =>
  (
    d2con_app(x, env); d2conlst_app(xs, env)
  ) (* end of [list_cons] *)
//
end (* end of [d2conlst_app] *)
//
(* ****** ****** *)
//
extern
fun s2exp_app : synent_app (s2exp)
//
extern
fun s2explst_app : synent_app (s2explst)
extern
fun s2explstlst_app : synent_app (s2explstlst)
//
extern
fun labs2explst_app : synent_app (labs2explst)
extern
fun wths2explst_app : synent_app (wths2explst)
//
(* ****** ****** *)

implement
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
| S2Ecst (s2c) => s2cst_app (s2c, env)
//
| S2Eextype
   (name, s2ess) => s2explstlst_app (s2ess, env)
| S2Eextkind
   (name, s2ess) => s2explstlst_app (s2ess, env)
//
| S2Evar (s2v) => s2var_app (s2v, env)
//
| S2EVar _ => ()
| S2Ehole _ => ()
//
| S2Edatcontyp
    (d2c, s2es) => let
    val () =
      d2con_app (d2c, env)
    // end of [val]
  in
    s2explst_app (s2es, env)
  end // end of [S2Edatcontyp]
| S2Edatconptr
    (d2c, s2e1, s2es2) => let
    val () =
      d2con_app (d2c, env)
    // end of [val]
  in
    s2exp_app (s2e1, env);
    s2explst_app (s2es2, env)
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
| S2Evararg (s2e) => s2exp_app (s2e, env)
//
| S2Ewthtype (s2e, ws2es) =>
  (
    s2exp_app (s2e, env); wths2explst_app (ws2es, env);
  )
//
| S2Eerr () => ()
//
(*
| _ (* rest-of-s2exp *) => ()
*)
//
end // end of [s2exp_app]

(* ****** ****** *)
//
implement
s2explst_app
  (xs, env) = let
in
//
case+ xs of
| list_nil () => ()
| list_cons (x, xs) =>
  (
    s2exp_app(x, env); s2explst_app(xs, env)
  ) (* end of [list_cons] *)
//
end (* end of [s2explst_app] *)
//
implement
s2explstlst_app
  (xss, env) = let
in
//
case+ xss of
| list_nil () => ()
| list_cons (xs, xss) =>
  (
    s2explst_app(xs, env); s2explstlst_app(xss, env)
  ) (* end of [list_cons] *)
//
end (* end of [s2explstlst_app] *)
//
(* ****** ****** *)

implement
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

(* end of [pats_staexp2_appenv.hats] *)
