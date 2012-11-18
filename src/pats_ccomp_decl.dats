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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans2_env.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_typerase.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

extern
fun hiimpdec_ccomp (
  env: !ccompenv, res: !instrseq, level: int, impdec: hiimpdec
) : d2cst // end of [hiimpdec_ccomp]

(* ****** ****** *)

extern
fun hifundeclst_ccomp (
  env: !ccompenv, res: !instrseq
, level: int, knd: funkind, decarg: s2qualst, hfds: hifundeclst
) : d2varlst // end of [hifundeclst_ccomp]

(* ****** ****** *)

extern
fun hivaldeclst_ccomp (
  env: !ccompenv, res: !instrseq
, level: int, knd: valkind, hvds: hivaldeclst
) : hipatlst // end of [hivaldeclst_ccomp]

extern
fun hivaldeclst_ccomp_rec (
  env: !ccompenv, res: !instrseq
, level: int, knd: valkind, hvds: hivaldeclst
) : hipatlst // end of [hivaldeclst_ccomp_rec]

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
| HIDdcstdecs
    (knd, d2cs) => primdec_none (loc)
//
| HIDimpdec
    (knd, impdec) => let
    val lev0 = the_d2varlev_get ()
    val d2c = impdec.hiimpdec_cst
    val imparg = impdec.hiimpdec_imparg
    val tmparg = impdec.hiimpdec_tmparg
    val _(*d2c*) = hiimpdec_ccomp (env, res, lev0, impdec)
  in
    primdec_impdec (loc, d2c, imparg, tmparg)
  end // end of [HIDimpdec]
//
| HIDfundecs
    (knd, decarg, hfds) => let
    val lev0 = the_d2varlev_get ()
    val d2vs =
      hifundeclst_ccomp (env, res, lev0, knd, decarg, hfds)
    // end of [val]
  in
    primdec_fundecs (loc, d2vs)
  end // end of [HIDfundecs]
//
| HIDvaldecs (knd, hvds) => let
    val lev0 = the_d2varlev_get ()
    val hips = hivaldeclst_ccomp (env, res, lev0, knd, hvds)
  in
    primdec_valdecs (loc, knd, hips)
  end // end of [HIDvaldecs]
| HIDvaldecs_rec (knd, hvds) => let
    val lev0 = the_d2varlev_get ()
    val hips = hivaldeclst_ccomp_rec (env, res, lev0, knd, hvds)
  in
    primdec_valdecs_rec (loc, knd, hips)
  end // end of [HIDvaldecs_rec]
//
| HIDvardecs (hvds) => let
    val lev0 = the_d2varlev_get ()
    val d2vs = hivardeclst_ccomp (env, res, lev0, hvds)
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

fun auxlam (
  env: !ccompenv
, res: !instrseq
, loc0: location
, d2c: d2cst
, imparg: s2varlst
, tmparg: s2explstlst
, hde0: hidexp
) : void = let
  val loc_fun = hde0.hidexp_loc
  val hse_fun = hde0.hidexp_type
  val- HDElam
    (hips_arg, hde_body) = hde0.hidexp_node
  val fl = funlab_make_dcst_type (d2c, hse_fun)
  val pmv_lam = primval_make_funlab (loc0, fl)
//
  val fent = let
    val ins =
      instr_funlab (loc0, fl)
    // end of [val]
    val prolog = list_sing (ins)
  in
    hidexp_ccomp_funlab_arg_body
      (env, fl, imparg, tmparg, prolog, loc_fun, hips_arg, hde_body)
    // end of [hidexp_ccomp_funlab_arg_body]
  end // end of [val]
//
  val () = the_funlablst_add (fl)
  val () = funlab_set_entry (fl, Some (fent))
//
  val () = println! ("hiimpdec_ccomp: auxlam: fent = ", fent)
//
in
  // nothing
end // end of [auxlam]

fun auxmain (
  env: !ccompenv
, res: !instrseq
, loc0: location
, d2c: d2cst
, imparg: s2varlst
, tmparg: s2explstlst
, hde0: hidexp
) : void = let
in
//
case+ hde0.hidexp_node of
| HDElam _ =>
    auxlam (env, res, loc0, d2c, imparg, tmparg, hde0)
  // end of [HDElam]
| _ => let
    val () =
      println! ("hiimpdec_ccomp: auxmain: hde0 = ", hde0)
    // end of [val]
  in
    exitloc (1)
  end // end of [_]
//
end // end of [auxmain]

in // in of [local]

implement
hiimpdec_ccomp (
  env, res, lev0, impdec
) = let
//
val d2c = impdec.hiimpdec_cst
val () = println! ("hiimpdec_ccomp: auxlam: d2c = ", d2c)
//
in
//
case+ 0 of
(*
| _ when
    d2cst_is_castfn d2c => ()
*)
| _ => let
    val loc0 = impdec.hiimpdec_loc
    val imparg = impdec.hiimpdec_imparg
    val tmparg = impdec.hiimpdec_tmparg
    val hde_def = impdec.hiimpdec_def
//
    val () = (
      case+ tmparg of
      | list_cons _ => ccompenv_add_impdec (env, impdec)
      | list_nil () => ()
    ) : void // end of [val]
//
    val () =
      auxmain (env, res, loc0, d2c, imparg, tmparg, hde_def)
    // end of [val]
  in
    d2c
  end // end of [if]
//
end // end of [hiimpdec_ccomp]

end // end of [local]

(* ****** ****** *)

local

fun auxinit
  {n:nat} .<n>. (
  env: !ccompenv
, lev0: int, decarg: s2qualst, hfds: list (hifundec, n)
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
    val fl = funlab_make_dvar_type (d2v, hse)
    val pmv = primval_make_funlab (loc, fl)
    val () = ccompenv_add_varbind (env, d2v, pmv)
//
    val () = (
      case+ decarg of
      | list_cons _ => ccompenv_add_fundec (env, hfd)
      | list_nil () => ()
    ) : void // end of [val]
//
    val fls = auxinit (env, lev0, decarg, hfds)
  in
    list_vt_cons (fl, fls)
  end // end of [list_cons]
| list_nil () => list_vt_nil ()
//
end (* end of [auxinit] *)

fun auxmain
  {n:nat} .<n>. (
  env: !ccompenv
, knd: funkind, decarg: s2qualst
, hfds: list (hifundec, n), fls: list_vt (funlab, n)
) : d2varlst = let
in
//
case+ hfds of
| list_cons
    (hfd, hfds) => let
    val loc = hfd.hifundec_loc
    val d2v = hfd.hifundec_var
    val imparg = hfd.hifundec_imparg
    val hde_def = hfd.hifundec_def
    val- HDElam (hips_arg, hde_body) = hde_def.hidexp_node
    val+ ~list_vt_cons (fl, fls) = fls
    val tmparg = list_nil(*s2ess*)
    val ins = instr_funlab (loc, fl)
    val prolog = list_sing (ins)
    val fent =
      hidexp_ccomp_funlab_arg_body (
      env, fl, imparg, tmparg, prolog, loc, hips_arg, hde_body
    ) // end of [val]
//
    val () = println! ("auxmain: fent=", fent)
//
    val () = funlab_set_entry (fl, Some (fent))
//
    val d2vs = auxmain (env, knd, decarg, hfds, fls)
  in
    list_cons (d2v, d2vs)
  end // end of [list_vt_cons]
| list_nil () => let
    val+ ~list_vt_nil () = fls in list_nil ()
  end // end of [list_nil]
//
end (* end of [auxmain] *)

in // in of [local]

implement
hifundeclst_ccomp (
  env, res, lev0, knd, decarg, hfds
) = let
  val fls =
    auxinit (env, lev0, decarg, hfds)
  // end of [val]
  val () = the_funlablst_addlst ($UN.castvwtp1{funlablst}(fls))
in
  auxmain (env, knd, decarg, hfds, fls)
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
  val () = hipatck_ccomp (env, res, fail, hip, pmv_def)
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

fun auxinit
  {n:nat} .<n>. (
  env: !ccompenv
, res: !instrseq
, lev0: int
, hvds: list (hivaldec, n)
) : list_vt (tmpvar, n) = let
in
//
case+ hvds of
| list_cons
    (hvd, hvds) => let
    val hip = hvd.hivaldec_pat
    val loc = hip.hipat_loc
    val hse = hip.hipat_type
    val tmp = tmpvar_make (loc, hse)
    val pmv = primval_tmp (loc, hse, tmp)
    val () = himatch_ccomp (env, res, lev0, hip, pmv)
    val tmps = auxinit (env, res, lev0, hvds)
  in
    list_vt_cons (tmp, tmps)
  end // end of [list_cons]
| list_nil () => list_vt_nil ()
//
end // end of [auxinit]

fun auxmain
  {n:nat} (
  env: !ccompenv
, res: !instrseq
, hvds: list (hivaldec, n)
, tmps: list_vt (tmpvar, n)
) : hipatlst = let
in
//
case+ hvds of
| list_cons
    (hvd, hvds) => let
    val hip = hvd.hivaldec_pat
    val hde_def = hvd.hivaldec_def
    val+ ~list_vt_cons (tmp, tmps) = tmps
    val () = hidexp_ccomp_ret (env, res, tmp, hde_def)
    val hips = auxmain (env, res, hvds, tmps)
  in
    list_cons (hip, hips)
  end // end of [list_cons]
| list_nil () => let
    val+ ~list_vt_nil () = tmps in list_nil ()
  end // end of [list_nil]
//
end // end of [auxmain]

in // in of [local]

implement
hivaldeclst_ccomp_rec (
  env, res, lev0, knd, hvds
) = let
//
val tmps =
  auxinit (env, res, lev0, hvds)
in
  auxmain (env, res, hvds, tmps)
end // end of [hivaldeclst_ccomp_rec]

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
val ((*void*)) = ccompenv_add_varbind (env, d2v, pmv)
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
