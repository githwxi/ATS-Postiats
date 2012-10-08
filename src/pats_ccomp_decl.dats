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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_trans2_env.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_typerase.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

extern
fun hifundeclst_ccomp (
  env: !ccompenv, res: !instrseq
, level: int, knd: funkind, hfds: hifundeclst
) : d2varlst // end of [hifundeclst_ccomp]

(* ****** ****** *)

extern
fun hivaldeclst_ccomp (
  env: !ccompenv, res: !instrseq
, level: int, lnd: valkind, hvds: hivaldeclst
) : hipatlst // end of [hivaldeclst_ccomp]

extern
fun hivardeclst_ccomp (
  env: !ccompenv, res: !instrseq, level: int, hvds: hivardeclst
) : d2varlst // end of [hivardeclst_ccomp]

(* ****** ****** *)

implement
hidecl_ccomp
  (env, res, hid) = let
  val loc = hid.hidecl_loc
in
//
case+ hid.hidecl_node of
//
| HIDdcstdecs (knd, d2cs) => primdec_none (loc)
//
| HIDfundecs
    (knd, decarg, hfds) => let
    val level = the_d2varlev_get ()
    val d2vs = hifundeclst_ccomp (env, res, level, knd, hfds)
  in
    primdec_fundecs (loc, d2vs)
  end // end of [HIDfundecs]
//
| HIDvaldecs (knd, hvds) => let
    val level = the_d2varlev_get ()
    val hips = hivaldeclst_ccomp (env, res, level, knd, hvds)
  in
    primdec_valdecs (loc, hips)
  end // end of [HIDvaldecs]
//
| HIDvardecs (hvds) => let
    val level = the_d2varlev_get ()
    val d2vs = hivardeclst_ccomp (env, res, level, hvds)
  in
    primdec_vardecs (loc, d2vs)
  end // end of [HIDvardecs]
//
| _ => let
    val () = println! ("hidecl_ccomp: hid = ", hid)
  in
    exitloc (1)
  end // end of [_]
//
end // end of [hidecl_ccomp]

(* ****** ****** *)

implement
hideclist_ccomp
  (env, res, hids) = let
//
fun loop (
  env: !ccompenv
, res: !instrseq
, hids: hideclist
, pmds: &primdeclst_vt? >> primdeclst_vt
) : void = let
in
//
case+ hids of
| list_cons
    (hid, hids) => let
    val pmd =
      hidecl_ccomp (env, res, hid)
    val () = pmds := list_vt_cons {..}{0} (pmd, ?)
    val list_vt_cons (_, !p_pmds) = pmds
    val () = loop (env, res, hids, !p_pmds)
    val () = fold@ (pmds)
  in
    // nothing
  end // end of [list_cons]
| list_nil () => let
    val () = pmds := list_vt_nil () in (*nothing*)
  end // end of [list_nil]
//
end // end of [loop]
//
var pmds: primdeclst_vt
val () = loop (env, res, hids, pmds)
//
in
//
list_of_list_vt (pmds)
//
end // end of [hideclist_ccomp]

(* ****** ****** *)

implement
hideclist_ccomp0
  (hids) = let
  val env = ccompenv_make ()
  val res = instrseq_make_nil ()
  val pmds = hideclist_ccomp (env, res, hids)
  val () = ccompenv_free (env)
  val inss = instrseq_get_free (res)
in
  (inss, pmds)
end // end of [hideclist_ccomp0]

(* ****** ****** *)

local

fun auxinit
  {n:nat} .<n>. (
  lev0: int, hfds: list (hifundec, n)
) : list_vt (funlab, n) = let
in
//
case+ hfds of
| list_cons
    (hfd, hfds) => let
    val loc = hfd.hifundec_loc
    val d2v = hfd.hifundec_var
    val () = d2var_set_level (d2v, lev0)
    val- Some (s2e) = d2var_get_mastype (d2v)
    val hse = s2exp_tyer_deep (loc, s2e)
    val fl = funlab_make_vartype (d2v, hse)
    val pmv = primval_make_funlab (loc, fl)
    val fls = auxinit (lev0, hfds)
  in
    list_vt_cons (fl, fls)
  end // end of [list_cons]
| list_nil () => list_vt_nil ()
//
end (* end of [auxinit] *)

fun auxmain
  {n:nat} .<n>. (
  env: !ccompenv
, hfds: list (hifundec, n), fls: list_vt (funlab, n)
) : void = let
in
//
case+ hfds of
| list_cons
    (hfd, hfds) => let
    val loc = hfd.hifundec_loc
    val hde_def = hfd.hifundec_def
    val- HDElam (hips_arg, hde_body) = hde_def.hidexp_node
    val+ ~list_vt_cons (fl, fls) = fls
    val ins = instr_funlab (loc, fl)
    val prolog = list_sing (ins)
    val fent =
      hidexp_ccomp_funlab_arg_body (env, fl, prolog, loc, hips_arg, hde_body)
    // end of [val]
//
    val () = println! ("auxmain: fent=", fent)
//
  in
    auxmain (env, hfds, fls)
  end // end of [list_vt_cons]
| list_nil () => let
    val+ ~list_vt_nil () = fls in (*nothing*)
  end // end of [list_nil]
//
end (* end of [auxmain] *)

in // in of [local]

implement
hifundeclst_ccomp (
  env, res, lev0, knd, hfds
) = let
  val fls = auxinit (lev0, hfds)
  val ((*void*)) = auxmain (env, hfds, fls)
  val d2vs = list_map_fun<hifundec><d2var> (hfds, lam (hfd) =<1> hfd.hifundec_var)
  val d2vs = list_of_list_vt (d2vs)
in
  d2vs
end // end of [hifundeclst_ccomp]

end // end of [local]

(* ****** ****** *)

local

fun hivaldec_ccomp (
  env: !ccompenv, res: !instrseq
, lev0: int, knd: valkind, hvd: hivaldec
) : hipat = let
  val loc = hvd.hivaldec_loc
  val hde_def = hvd.hivaldec_def
  val pmv_def = hidexp_ccomp (env, res, hde_def)
  val hip = hvd.hivaldec_pat
  val fail = (
    case+ knd of
    | VK_val_pos () => PTCKNTnone () | _ => PTCKNTcaseof_fail (loc)
  ) : patckont // end of [val]
  val () = hipatck_ccomp (res, fail, hip, pmv_def)
  val () = himatch_ccomp (env, res, lev0, hip, pmv_def)
in
  hip
end // end of [hivaldec_ccomp]

in // in of [local]

implement
hivaldeclst_ccomp (
  env, res, lev0, knd, hvds
) = let
in
//
case+ hvds of
| list_cons (hvd, hvds) => let
    val hip = hivaldec_ccomp (env, res, lev0, knd, hvd)
    val hips = hivaldeclst_ccomp (env, res, lev0, knd, hvds)
  in
    list_cons (hip, hips)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [hivardeclst_ccomp]

end // end of [local]

(* ****** ****** *)

local

fun hivardec_ccomp (
  env: !ccompenv, res: !instrseq, lev0: int, hvd: hivardec
) : d2var = let
//
val loc = hvd.hivardec_loc
val d2v = hvd.hivardec_dvar_ptr
val d2vw = hvd.hivardec_dvar_view
val loc_d2v = d2var_get_loc (d2v)
val () = d2var_set_level (d2v, lev0)
val s2at = d2var_get_type_some (loc_d2v, d2vw)
val- S2Eat (s2e_elt, _) = s2at.s2exp_node
val hse_elt = s2exp_tyer_shallow (loc_d2v, s2e_elt)
val tmp = tmpvar_make (loc_d2v, hse_elt)
val () = (
  case+ hvd.hivardec_ini of
  | Some (hde) => hidexp_ccomp_ret (env, res, tmp, hde) | None () => ()
) : void // end of [val]
//
val pmv = primval_tmpref (loc, hse_elt, tmp)
val () = ccompenv_add_varbind (env, d2v, pmv)
//
in
  d2v
end // end of [hivardec_ccomp]

in // in of [local]

implement
hivardeclst_ccomp (
  env, res, level, hvds
) = let
in
//
case+ hvds of
| list_cons (hvd, hvds) => let
    val d2v = hivardec_ccomp (env, res, level, hvd)
    val d2vs = hivardeclst_ccomp (env, res, level, hvds)
  in
    list_cons (d2v, d2vs)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [hivardeclst_ccomp]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_decl.dats] *)
