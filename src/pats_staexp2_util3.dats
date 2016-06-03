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

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

local

fun
aux_s2exp
(
  s2e0: s2exp, fvs: &s2varset_vt
) : void = let
in
//
case+
s2e0.s2exp_node
of // case+
//
| S2Eint _ => ()
| S2Eintinf _ => ()
//
| S2Efloat _ => ()
| S2Estring _ => ()
//
| S2Ecst _ => ()
//
| S2Eextype (_(*name*), s2ess) => aux_s2explstlst (s2ess, fvs)
| S2Eextkind (_(*name*), s2ess) => aux_s2explstlst (s2ess, fvs)
//
| S2Evar s2v => {
    val () = fvs := s2varset_vt_add (fvs, s2v)
  } (* end of [S2Evar] *)
//
| S2EVar s2V => aux_s2Var (s2V, fvs)
//
| S2Ehole _ => ()
//
| S2Edatcontyp
    (d2c, arg) => aux_s2explst (arg, fvs)
| S2Edatconptr
    (d2c, rt, arg) => (
    aux_s2exp (rt, fvs); aux_s2explst (arg, fvs)
  ) (* end of [S2Edatconptr] *)
//
| S2Eat(s2e1, s2e2) => (
    aux_s2exp (s2e1, fvs); aux_s2exp (s2e2, fvs)
  ) (* end of [s2Eat] *)
//
| S2Eeff(s2fe) => aux_s2eff (s2fe, fvs)
//
| S2Esizeof(s2e) => aux_s2exp (s2e, fvs)
//
| S2Eeqeq(s2e1, s2e2) => (
    aux_s2exp (s2e1, fvs); aux_s2exp (s2e2, fvs)
  ) (* end of [S2Eeqeq] *)
//
| S2Eproj
    (s2ae, s2te, s2ls) =>
  {
    val () = aux_s2exp (s2ae, fvs)
    val () = aux_s2exp (s2te, fvs)
    val () = aux_s2lablst (s2ls, fvs)
  } (* end of [S2Eproj] *)
//
| S2Eapp(s2e, s2es_arg) =>
  {
    val () = aux_s2exp (s2e, fvs)
    val () = aux_s2explst (s2es_arg, fvs)
  } (* end of [S2Eapp] *)
//
| S2Elam(s2vs, s2e_body) => let
    var fvs1 = s2varset_vt_nil ()
    val () = aux_s2exp (s2e_body, fvs1)
    val () = fvs1 := s2varset_vt_delist (fvs1, s2vs)
  in
    fvs := s2varset_vt_union (fvs, fvs1)
  end // end of [S2Elam]
//
| S2Efun (
    fc,  lin, s2fe
  , npf, s2es_arg, s2e_res
  ) => {
    val () = aux_s2eff (s2fe, fvs)
    val () = (
      aux_s2explst (s2es_arg, fvs); aux_s2exp (s2e_res, fvs)
    ) (* end of [val] *)
  } (* end of [S2Efun] *)
//
| S2Emetfun
    (opt, s2es, s2e) =>
  (
    aux_s2explst (s2es, fvs); aux_s2exp (s2e, fvs)
  ) (* end of [S2Emetfun] *)
//
| S2Emetdec
    (s2es1, s2es2) => (
    aux_s2explst (s2es1, fvs); aux_s2explst (s2es2, fvs)
  ) (* end of [S2Emetdec] *)
//
| S2Etop(knd, s2e) => aux_s2exp (s2e, fvs)
//
| S2Ewithout(s2e_elt) => aux_s2exp (s2e_elt, fvs) // taken-out
//
| S2Etyarr
    (s2e_elt, s2es_dim) =>
  (
    aux_s2exp (s2e_elt, fvs); aux_s2explst (s2es_dim, fvs)
  ) (* end of [S2Etyarr] *)
//
| S2Etyrec(knd, npf, ls2es) => aux_labs2explst (ls2es, fvs)
//
| S2Einvar (s2e) => aux_s2exp (s2e, fvs)
//
| S2Erefarg (_, s2e) => aux_s2exp (s2e, fvs)
//
| S2Eexi(s2vs, s2ps, s2e) => aux_s2exp_exiuni (s2vs, s2ps, s2e, fvs)
| S2Euni(s2vs, s2ps, s2e) => aux_s2exp_exiuni (s2vs, s2ps, s2e, fvs)
//
| S2Evararg s2e => aux_s2exp (s2e, fvs)
//
| S2Ewthtype
    (s2e, ws2es) => (
    aux_s2exp (s2e, fvs); aux_wths2explst (ws2es, fvs)
  ) (* end of [S2Ewthtype] *)
//
| S2Eerrexp((*void*)) => ()
//
end // end of [aux_s2exp]

and
aux_s2explst
(
  s2es0: s2explst, fvs: &s2varset_vt
) : void = case+ s2es0 of
  | list_cons (s2e, s2es) => (
      aux_s2exp (s2e, fvs); aux_s2explst (s2es, fvs)
    ) // end of [list_cons]
  | list_nil () => ()
// end of [aux_s2explst]

and
aux_s2explstlst
(
  s2ess0: s2explstlst, fvs: &s2varset_vt
) : void = case+ s2ess0 of
  | list_cons (s2es, s2ess) => (
      aux_s2explst (s2es, fvs); aux_s2explstlst (s2ess, fvs)
    ) // end of [list_cons]
  | list_nil () => ()
// end of [aux_s2explstlst]

and
aux_labs2explst
(
  ls2es0: labs2explst, fvs: &s2varset_vt
) : void = case+ ls2es0 of
  | list_cons (ls2e, ls2es) => let
      val SLABELED (_, _, s2e) = ls2e
      val () = aux_s2exp (s2e, fvs)
    in
      aux_labs2explst (ls2es, fvs)
    end // end of [list_cons]
  | list_nil () => ()
// end of [aux_labs2explst]

and
aux_wths2explst
(
  ws2es0: wths2explst, fvs: &s2varset_vt
) : void = (
  case+ ws2es0 of
  | WTHS2EXPLSTnil () => ()
  | WTHS2EXPLSTcons_invar
      (_, s2e, ws2es) => (
      aux_s2exp (s2e, fvs); aux_wths2explst (ws2es, fvs)
    ) // end of [WTHS2EXPLSTcons_invar]
  | WTHS2EXPLSTcons_trans
      (_, s2e, ws2es) => (
      aux_s2exp (s2e, fvs); aux_wths2explst (ws2es, fvs)
    ) // end of [WTHS2EXPLSTcons_trans]
  | WTHS2EXPLSTcons_none
      (ws2es) => aux_wths2explst (ws2es, fvs)
) // end of [aux_wths2explst]

and
aux_s2Var
(
  s2V: s2Var, fvs: &s2varset_vt
) : void = let
  val opt = s2Var_get_link(s2V)
in
  case+ opt of
  | Some s2e => aux_s2exp (s2e, fvs)
  | None () => let
      val s2t = s2Var_get_srt(s2V)
    in
      s2Var_set_link(s2V, Some(s2exp_errexp(s2t)))
    end // end of [None]
end // end of [aux_s2Var]

and
aux_s2exp_exiuni
(
  s2vs: s2varlst
, s2ps: s2explst
, s2e_body: s2exp
, fvs: &s2varset_vt
) : void = let
  var fvs1 = s2varset_vt_nil ()
  val () = aux_s2explst (s2ps, fvs1)
  val () = aux_s2exp (s2e_body, fvs1)
  val () = fvs1 := s2varset_vt_delist (fvs1, s2vs)
in
  fvs := s2varset_vt_union (fvs, fvs1)
end // end of [aux_s2exp_exiuni]

and
aux_s2lab (
  s2l: s2lab, fvs: &s2varset_vt
) : void =
  case+ s2l of
  | S2LABlab _ => ()
  | S2LABind (ind) => aux_s2explst (ind, fvs)
// end of [aux_s2lab]

and
aux_s2lablst (
  s2ls: s2lablst, fvs: &s2varset_vt
) : void =
  case+ s2ls of
  | list_cons (s2l, s2ls) => (
      aux_s2lab (s2l, fvs); aux_s2lablst (s2ls, fvs)
    ) // end of [list_cons]
  | list_nil () => ()
// end of [aux_s2lablst]

and
aux_s2eff (
  s2fe: s2eff, fvs: &s2varset_vt
) : void =
  case+ s2fe of
  | S2EFFset _ => ()
  | S2EFFexp (s2e) => aux_s2exp (s2e, fvs)
  | S2EFFadd (s2fe1, s2fe2) => let
      val () = aux_s2eff (s2fe1, fvs) in aux_s2eff (s2fe2, fvs)
    end // end of [S2EFFadd]
// end of [aux_s2eff]

in (* in of [local] *)

implement
s2exp_freevars
  (s2e0) = fvs where {
  var fvs = s2varset_vt_nil ()
  val () = aux_s2exp (s2e0, fvs)
} // end of [s2exp_freevars]

end // end of [local]

(* ****** ****** *)

local

fun
loop (
  xs: s2Varlst, s2Vs2: s2Varset
) : bool = (
  case+ xs of
  | list_cons (x, xs) => let
      val ismem = s2Varset_ismem (s2Vs2, x)
    in
      if ismem then true else loop (xs, s2Vs2)
    end
  | list_nil () => false
) // end of [loop]

in (* in of [loop] *)

fun
s2Var_occurcheck_s2cst
  (s2V0: s2Var, s2c: s2cst): bool = let
//
val s2Vs2 =
  s2cst_get_sVarset (s2c)
//
val ismem = s2Varset_ismem (s2Vs2, s2V0)
//
in
//
if ismem then true else loop (s2Var_get_sVarlst (s2V0), s2Vs2)
//
end // end of [s2Var_occurcheck_s2cst]

fun
s2Var_occurcheck_s2var
  (s2V0: s2Var, s2v: s2var): bool = let
(*
val () = println! ("s2Var_occurcheck_s2cst: s2v = ", s2v)
*)
val s2Vs2 = s2var_get_sVarset (s2v)
(*
val () = println! ("s2Var_occurcheck_s2cst: s2Vs2 = ", s2Vs2)
*)
val ismem = s2Varset_ismem (s2Vs2, s2V0)
//
in
//
if ismem then true else loop (s2Var_get_sVarlst (s2V0), s2Vs2)
//
end // end of [s2Var_occurcheck_s2var]

end // end of [local]

(* ****** ****** *)

local

typedef
aux2_type(a:type) =
  (s2Var, a, &int, &s2cstlst, &s2varlst, &s2Varlst) -> void
// end of [typedef]

extern fun aux2_s2cst : aux2_type (s2cst)
extern fun aux2_s2var : aux2_type (s2var)
extern fun aux2_s2Var : aux2_type (s2Var)

extern fun aux2_s2exp : aux2_type (s2exp)
extern fun aux2_s2explst : aux2_type (s2explst)
extern fun aux2_s2explstlst : aux2_type (s2explstlst)

extern fun aux2_s2eff : aux2_type (s2eff)

extern fun aux2_s2lab : aux2_type (s2lab)
extern fun aux2_s2lablst : aux2_type (s2lablst)

extern fun aux2_labs2exp : aux2_type (labs2exp)
extern fun aux2_labs2explst : aux2_type (labs2explst)

extern fun aux2_wths2explst : aux2_type (wths2explst)

(* ****** ****** *)

fun
auxlst
{a:type}
(
  s2V0: s2Var
, xs: List(a)
, ans: &int, s2cs: &s2cstlst, s2vs: &s2varlst, s2Vs: &s2Varlst
, fwork: aux2_type (a)
) : void = let
//
(*
val = println! ("auxlst: s2V0 = ", s2V0)
*)
//
in
//
case+ xs of
| list_cons (x, xs) => let
    val () =
      fwork (s2V0, x, ans, s2cs, s2vs, s2Vs)
    // end of [val]
  in
    auxlst (s2V0, xs, ans, s2cs, s2vs, s2Vs, fwork)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlst]

(* ****** ****** *)

implement
aux2_s2cst (
  s2V0, s2c, ans, s2cs, s2vs, s2Vs
) = let
  val found =
    s2Var_occurcheck_s2cst (s2V0, s2c)
  // end of [val]
in
  if found then let
    val () = ans := ans + 1
  in
    s2cs := list_cons (s2c, s2cs)
  end else () // end of [if]
end // end of [aux2_s2cst]

implement
aux2_s2var (
  s2V0, s2v, ans, s2cs, s2vs, s2Vs
) = let
  val found = s2Var_occurcheck_s2var (s2V0, s2v)
in
  if found then let
    val () = ans := ans + 1
  in
    s2vs := list_cons (s2v, s2vs)
  end else () // end of [if]
end // end of [aux2_s2var]

implement
aux2_s2Var (
  s2V0, s2V, ans, s2cs, s2vs, s2Vs
) = let
  val opt = s2Var_get_link (s2V)
in
//
case+ opt of
| Some (s2e) =>
    aux2_s2exp (s2V0, s2e, ans, s2cs, s2vs, s2Vs)
| None () => let
    val iseq = eq_s2Var_s2Var (s2V0, s2V)
  in
    if iseq then (ans := ans + 1) else s2Vs := list_cons (s2V, s2Vs)
  end // end of [None]
//
end // end of [aux2_s2Var]

(* ****** ****** *)

implement
aux2_s2exp (
  s2V0, s2e, ans, s2cs, s2vs, s2Vs
) = let
//
macdef
f_s2cst (x) =
  aux2_s2cst (s2V0, ,(x), ans, s2cs, s2vs, s2Vs)
macdef
f_s2var (x) =
  aux2_s2var (s2V0, ,(x), ans, s2cs, s2vs, s2Vs)
macdef
f_s2Var (x) =
  aux2_s2Var (s2V0, ,(x), ans, s2cs, s2vs, s2Vs)
macdef
f_s2exp (x) =
  aux2_s2exp (s2V0, ,(x), ans, s2cs, s2vs, s2Vs)
macdef
f_s2explst (x) =
  aux2_s2explst (s2V0, ,(x), ans, s2cs, s2vs, s2Vs)
macdef
f_s2explstlst (x) =
  aux2_s2explstlst (s2V0, ,(x), ans, s2cs, s2vs, s2Vs)
macdef
f_s2eff (x) =
  aux2_s2eff (s2V0, ,(x), ans, s2cs, s2vs, s2Vs)
macdef
f_s2lablst (x) =
  aux2_s2lablst (s2V0, ,(x), ans, s2cs, s2vs, s2Vs)
macdef
f_labs2explst (x) =
  aux2_labs2explst (s2V0, ,(x), ans, s2cs, s2vs, s2Vs)
macdef
f_wths2explst (x) =
  aux2_wths2explst (s2V0, ,(x), ans, s2cs, s2vs, s2Vs)
//
(*
val () = println! ("aux2_s2exp: s2V0 = ", s2V0)
val () = println! ("aux2_s2exp: s2e = ", s2e)
val () = println! ("aux2_s2exp: ans = ", ans)
val () = println! ("aux2_s2exp: s2cs = ", s2cs)
val () = println! ("aux2_s2exp: s2vs = ", s2vs)
val () = println! ("aux2_s2exp: s2Vs = ", s2Vs)
*)
//
in (* in of [let] *)
//
case+ s2e.s2exp_node of
//
| S2Eint _ => ()
| S2Eintinf _ => ()
//
| S2Efloat _ => ()
| S2Estring _ => ()
//
| S2Ecst s2c => f_s2cst (s2c)
//
| S2Eextype (_(*name*), s2ess) => f_s2explstlst (s2ess)
| S2Eextkind (_(*name*), s2ess) => f_s2explstlst (s2ess)
//
| S2Evar s2v => f_s2var (s2v)
| S2EVar s2V => f_s2Var (s2V)
//
| S2Ehole _ => ()
//
| S2Edatcontyp (d2c, s2es_arg) => f_s2explst (s2es_arg)
| S2Edatconptr (
    d2c, s2e_rt, s2es_arg
  ) => {
    val () = f_s2exp (s2e_rt)
    val () = f_s2explst (s2es_arg)
  } // end of [S2Edatconptr]
//
| S2Eat (s2e1, s2e2) => (f_s2exp (s2e1); f_s2exp (s2e2))
//
| S2Esizeof (s2e) => f_s2exp (s2e)
//
| S2Eeff (s2fe) => f_s2eff (s2fe)
| S2Eeqeq (s2e1, s2e2) => (f_s2exp (s2e1); f_s2exp (s2e2))
| S2Eproj (
    s2ae, s2te, s2ls
  ) => (f_s2exp (s2ae); f_s2exp (s2te); f_s2lablst (s2ls))
//
| S2Eapp (
    s2e_fun, s2es_arg
  ) => {
    val () = f_s2exp (s2e_fun)
    val () = f_s2explst (s2es_arg)
  } // end of [S2Eapp]
//
| S2Elam (s2vs, s2e) => f_s2exp (s2e)
//
| S2Efun
  (
    fc,  lin, s2fe, npf, s2es_arg, s2e_res
  ) => (
    f_s2eff(s2fe); f_s2explst(s2es_arg); f_s2exp(s2e_res)
  ) (* end of [S2Efun] *)
| S2Emetfun
    (opt, s2es, s2e) => (f_s2explst (s2es); f_s2exp (s2e))
  // end of [S2Emetfun]
//
| S2Emetdec
    (s2es1, s2es2) => (f_s2explst(s2es1); f_s2explst(s2es2))
  // end of [S2Emetdec]
//
| S2Etop(_(*knd*), s2e) => f_s2exp (s2e)
| S2Ewithout(s2e) => f_s2exp (s2e) // taken out by [view@]
//
| S2Etyarr
  (
    s2e_elt, s2es_dim
  ) => (f_s2exp (s2e_elt); f_s2explst (s2es_dim))
| S2Etyrec(knd, npf, ls2es) => f_labs2explst (ls2es)
//
| S2Einvar(s2e) => f_s2exp (s2e)
//
| S2Erefarg(_, s2e) => f_s2exp (s2e)
//
| S2Eexi(s2vs, s2ps, s2e) => (f_s2explst(s2ps); f_s2exp(s2e))
| S2Euni(s2vs, s2ps, s2e) => (f_s2explst(s2ps); f_s2exp(s2e))
//
| S2Evararg s2e => f_s2exp (s2e)
//
| S2Ewthtype(s2e, ws2es) => (f_s2exp(s2e); f_wths2explst(ws2es))
//
| S2Eerrexp((*void*)) => ((*void*))
//
end // end of [aux2_s2exp]

implement
aux2_s2explst
  (s2V0, xs, ans, s2cs, s2vs, s2Vs) =
  auxlst (s2V0, xs, ans, s2cs, s2vs, s2Vs, aux2_s2exp)
// end of [aux2_s2explst]

implement
aux2_s2explstlst
  (s2V0, xss, ans, s2cs, s2vs, s2Vs) =
  auxlst (s2V0, xss, ans, s2cs, s2vs, s2Vs, aux2_s2explst)
// end of [aux2_s2explstlst]

(* ****** ****** *)

implement
aux2_s2eff
  (s2V0, s2fe, ans, s2cs, s2vs, s2Vs) = let
(*
  val () = println! ("aux2_s2eff: s2V0 = ", s2V0)
*)
in
//
case+ s2fe of
| S2EFFset _ => ()
| S2EFFexp (s2e) =>
    aux2_s2exp (s2V0, s2e, ans, s2cs, s2vs, s2Vs)
| S2EFFadd (s2fe1, s2fe2) => let
    val () =
      aux2_s2eff (s2V0, s2fe1, ans, s2cs, s2vs, s2Vs)
    // end of [val]
    val () =
      aux2_s2eff (s2V0, s2fe2, ans, s2cs, s2vs, s2Vs)
    // end of [val]
  in
    // nothing
  end // end of [S2EFFadd]
//
end // end of [aux2_s2eff]

(* ****** ****** *)

implement
aux2_s2lab (
  s2V0, s2l, ans, s2cs, s2vs, s2Vs
) = let
in
//
case+ s2l of
| S2LABlab _ => ()
| S2LABind (ind) =>
    aux2_s2explst (s2V0, ind, ans, s2cs, s2vs, s2Vs)
  // end of [S2LABind]
//
end // end of [aux2_s2lab]

implement
aux2_s2lablst
  (s2V0, s2ls, ans, s2cs, s2vs, s2Vs) =
  auxlst (s2V0, s2ls, ans, s2cs, s2vs, s2Vs, aux2_s2lab)
// end of [aux2_s2lablst]

(* ****** ****** *)

implement
aux2_labs2exp (
  s2V0, ls2e, ans, s2cs, s2vs, s2Vs
) = let
  val SLABELED (l, name, s2e) = ls2e
in
  aux2_s2exp (s2V0, s2e, ans, s2cs, s2vs, s2Vs)
end // end of [aux2_labs2exp]

implement
aux2_labs2explst
  (s2V0, xs, ans, s2cs, s2vs, s2Vs) =  
  auxlst (s2V0, xs, ans, s2cs, s2vs, s2Vs, aux2_labs2exp)
// end of [aux2_labs2explst]

(* ****** ****** *)

implement
aux2_wths2explst
(
  s2V0, ws2es, ans, s2cs, s2vs, s2Vs
) = let
//
(*
val () =
println!
  ("aux2_wths2explst: s2V0 = ", s2V0)
val () =
println!
  ("aux2_wths2explst: ws2es = ", ws2es)
*)
//
in
//
case+ ws2es of
| WTHS2EXPLSTnil () => ()
| WTHS2EXPLSTcons_invar
    (_, s2e, ws2es) => let
    val () =
      aux2_s2exp (s2V0, s2e, ans, s2cs, s2vs, s2Vs)
    // end of [val]
  in
    aux2_wths2explst (s2V0, ws2es, ans, s2cs, s2vs, s2Vs)
  end
| WTHS2EXPLSTcons_trans
    (_, s2e, ws2es) => let
    val () =
      aux2_s2exp (s2V0, s2e, ans, s2cs, s2vs, s2Vs)
    // end of [val]
  in
    aux2_wths2explst (s2V0, ws2es, ans, s2cs, s2vs, s2Vs)
  end
| WTHS2EXPLSTcons_none (ws2es) =>
    aux2_wths2explst (s2V0, ws2es, ans, s2cs, s2vs, s2Vs)
//
end // end of [aux2_wths2explst]

in (* in of [local] *)

implement
s2Var_occurcheck_s2exp
  (s2V0, s2e) = let
//
  var ans: int = 0 // recording violations
  var s2cs: s2cstlst = list_nil () // collecting violating s2cs
  var s2vs: s2varlst = list_nil () // collecting violating s2vs
  var s2Vs: s2Varlst = list_nil () // collecting unsolved s2Vs in s2e
//
  val () = aux2_s2exp (s2V0, s2e, ans, s2cs, s2vs, s2Vs)
//
in
  @(ans, s2cs, s2vs, s2Vs)
end // end of [s2Var_occurcheck_s2exp]

end // end of [local]

(* ****** ****** *)

local

fun
ismem (
  s2vs: s2varlst, s2v0: s2var
) : bool = let
in
  case+ s2vs of
  | list_cons
      (s2v, s2vs) =>
      if s2v = s2v0 then true else ismem (s2vs, s2v0)
    // end of [list_cons]
  | list_nil () => false
end // end of [ismem]

in (* in of [local] *)

implement
s2exp_isbot
  (s2e0) = let
in
//
case+
s2e0.s2exp_node
of // case+
//
| S2Euni (
    s2vs, s2ps, s2e2
  ) => let
    val isnil = list_is_nil (s2ps)
  in
    if isnil
      then (
      case+ s2e2.s2exp_node of
      | S2Evar (s2v) => ismem (s2vs, s2v) | _ => false
    ) else false // end of [if]
  end // end of [S2Euni]
//
| _ (* non-S2Euni *) => false
//
end // end of [s2exp_isbot]

end // end of [local]

implement
s2exp_fun_isbot (s2e) = let
in
//
case+
s2e.s2exp_node
of // case+
//
| S2Efun (
    _, _, _, _, _, s2e_res
  ) => s2exp_isbot (s2e_res)
//
| S2Euni (_, _, s2e) => s2exp_fun_isbot (s2e)
| S2Emetfun (_, _, s2e) => s2exp_fun_isbot (s2e)
//
| _ (* rest-of-S2E *) => false
//
end // end of [s2exp_fun_isbot]

(* ****** ****** *)

(* end of [pats_staexp2_util3.dats] *)
