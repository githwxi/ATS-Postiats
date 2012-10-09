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

staload "pats_trans2_env.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

typedef
hidexp_ccomp_funtype =
  (!ccompenv, !instrseq, hidexp) -> primval
// end of [hidexp_ccomp_funtype]

extern fun hidexp_ccomp_var : hidexp_ccomp_funtype

extern fun hidexp_ccomp_seq : hidexp_ccomp_funtype

extern fun hidexp_ccomp_assgn_var : hidexp_ccomp_funtype
extern fun hidexp_ccomp_assgn_ptr : hidexp_ccomp_funtype

extern fun hidexp_ccomp_lam : hidexp_ccomp_funtype

(* ****** ****** *)

extern
fun hilab_ccomp
  (env: !ccompenv, res: !instrseq, hil: hilab): primlab
// end of [fun hilab_ccomp]
extern
fun hilablst_ccomp
  (env: !ccompenv, res: !instrseq, hils: hilablst): primlablst
// end of [fun hilablst_ccomp]

(* ****** ****** *)

typedef
hidexp_ccomp_ret_funtype =
  (!ccompenv, !instrseq, tmpvar(*ret*), hidexp) -> void
// end of [hidexp_ccomp_ret_funtype]

extern
fun hidexp_ccomp_ret_app : hidexp_ccomp_ret_funtype

extern
fun hidexp_ccomp_ret_if : hidexp_ccomp_ret_funtype
(*
extern
fun hidexp_ccomp_ret_sif : hidexp_ccomp_ret_funtype
*)

extern fun hidexp_ccomp_ret_seq : hidexp_ccomp_ret_funtype

(* ****** ****** *)

local

fun auxret (
  env: !ccompenv
, res: !instrseq
, hde0: hidexp
) : primval = let
  val loc0 = hde0.hidexp_loc
  val hse0 = hde0.hidexp_type
  val tmpret = tmpvar_make (loc0, hse0)
  val () = hidexp_ccomp_ret (env, res, tmpret, hde0)
in
  primval_tmp (loc0, hse0, tmpret)
end // end of [auxret]

in // in of [local]

implement
hidexp_ccomp
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
in
//
case+ hde0.hidexp_node of
//
| HDEvar _ =>
    hidexp_ccomp_var (env, res, hde0)
  // end of [HDEvar]
//
| HDEcst (d2c) => primval_cst (loc0, hse0, d2c)
//
| HDEint (i) => primval_int (loc0, hse0, i)
| HDEbool (b) => primval_bool (loc0, hse0, b)
| HDEchar (c) => primval_char (loc0, hse0, c)
| HDEstring (str) => primval_string (loc0, hse0, str)
//
| HDEi0nt (tok) => primval_i0nt (loc0, hse0, tok)
| HDEf0loat (tok) => primval_f0loat (loc0, hse0, tok)
//
| HDEempty () => primval_empty (loc0, hse0)
//
| HDEextval (name) => primval_extval (loc0, hse0, name)
//
| HDEtmpcst (d2c, t2mas) => primval_tmpcst (loc0, hse0, d2c, t2mas)
| HDEtmpvar (d2v, t2mas) => primval_tmpvar (loc0, hse0, d2v, t2mas)
//
| HDElet (hids, hde_scope) => let
    val (
      pfpush | ()
    ) = ccompenv_push (env)
    val pmds = hideclist_ccomp (env, res, hids)
    val pmv_scope = hidexp_ccomp (env, res, hde_scope)
    val () = ccompenv_pop (pfpush | env)
  in
    primval_let (loc0, hse0, pmds, pmv_scope)
  end // end of [HDElet]
//
| HDEapp _ => auxret (env, res, hde0)
//
| HDEif _ => auxret (env, res, hde0)
//
| HDEseq _ => hidexp_ccomp_seq (env, res, hde0)
//
| HDEselab _ => auxret (env, res, hde0)
//
| HDEassgn_var _ => hidexp_ccomp_assgn_var (env, res, hde0)
| HDEassgn_ptr _ => hidexp_ccomp_assgn_ptr (env, res, hde0)
//
| HDElam _ => hidexp_ccomp_lam (env, res, hde0)
//
| _ => let
    val () = println! ("hidexp_ccomp: hde0 = ", hde0)
  in
    exitloc (1)
  end // end of [_]
//
end // end of [hidexp_ccomp]

end // end of [local]

(* ****** ****** *)

implement
hidexplst_ccomp
  (env, res, hdes) = let
//
fun loop (
  env: !ccompenv
, res: !instrseq
, hdes: hidexplst
, pmvs: &primvalist_vt? >> primvalist_vt
) : void = let
in
//
case+ hdes of
| list_cons
    (hde, hdes) => let
    val pmv =
      hidexp_ccomp (env, res, hde)
    val () = pmvs := list_vt_cons {..}{0} (pmv, ?)
    val list_vt_cons (_, !p_pmvs) = pmvs
    val () = loop (env, res, hdes, !p_pmvs)
    val () = fold@ (pmvs)
  in
    // nothing
  end // end of [list_cons]
| list_nil () => let
    val () = pmvs := list_vt_nil () in (*nothing*)
  end // end of [list_nil]
//
end // end of [loop]
//
var pmvs: primvalist_vt
val () = loop (env, res, hdes, pmvs)
//
in
//
list_of_list_vt (pmvs)
//
end // end of [hidexplst_ccomp]

(* ****** ****** *)

local

fun auxval (
  env: !ccompenv
, res: !instrseq
, tmpret: tmpvar
, hde0: hidexp
) : void = let
  val loc0 = hde0.hidexp_loc
  val pmv = hidexp_ccomp (env, res, hde0)
  val ins = instr_move_val (loc0, tmpret, pmv)
in
  instrseq_add (res, ins)
end // end of [auxval]

in // in of [local]

implement
hidexp_ccomp_ret (
  env, res, tmpret, hde0
) = let
  val loc0 = hde0.hidexp_loc
  val hse0 = hde0.hidexp_type
in
//
case+ hde0.hidexp_node of
//
| HDEvar _ => auxval (env, res, tmpret, hde0)
| HDEcst _ => auxval (env, res, tmpret, hde0)
//
| HDEint _ => auxval (env, res, tmpret, hde0)
| HDEbool _ => auxval (env, res, tmpret, hde0)
| HDEchar _ => auxval (env, res, tmpret, hde0)
| HDEstring _ => auxval (env, res, tmpret, hde0)
//
| HDEi0nt _ => auxval (env, res, tmpret, hde0)
| HDEf0loat _ => auxval (env, res, tmpret, hde0)
//
| HDEempty _ => auxval (env, res, tmpret, hde0)
//
| HDEextval _ => auxval (env, res, tmpret, hde0)
//
| HDEapp _ => hidexp_ccomp_ret_app (env, res, tmpret, hde0)
//
| HDEif _ => hidexp_ccomp_ret_if (env, res, tmpret, hde0)
//
| HDEseq _ => hidexp_ccomp_ret_seq (env, res, tmpret, hde0)
//
| HDElam _ => auxval (env, res, tmpret, hde0)
//
| _ => let
    val () = println! ("hidexp_ccomp_ret: hde0 = ", hde0)
  in
    exitloc (1)
  end // end of [_]
//
end // end of [hidexp_ccomp_ret]

end // end of [local]

(* ****** ****** *)

implement
hilab_ccomp
  (env, res, hil) = let
  val loc = hil.hilab_loc
in
//
case+ hil.hilab_node of
| HILlab (lab) =>
    primlab_lab (loc, lab)
  // end of [HILlab]
| HILind (hdes_ind) => let
    val pmvs_ind = hidexplst_ccomp (env, res, hdes_ind)
  in
    primlab_ind (loc, pmvs_ind)
  end // end of [HILind]
//
end // end of [hilab_ccomp]

implement
hilablst_ccomp
  (env, res, hils) = let
in
//
case hils of
| list_cons (hil, hils) => let
    val pml = hilab_ccomp (env, res, hil)
    val pmls = hilablst_ccomp (env, res, hils)
  in
    list_cons (pml, pmls)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [hilablst_ccomp]

(* ****** ****** *)

implement
hidexp_ccomp_var
  (env, res, hde0) = let
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val- HDEvar (d2v) = hde0.hidexp_node
val opt = ccompenv_find_varbind (env, d2v)
//
in
//
case+ opt of
| ~Some_vt (pmv) => let
  in
    pmv
  end // end of [Some_vt]
| ~None_vt () => primval_var (loc0, hse0, d2v)
//
end // end of [hidexp_ccomp_var]

(* ****** ****** *)

implement
hidexp_ccomp_seq
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
val- HDEseq (hdes) = hde0.hidexp_node
//
fun loop (
  env: !ccompenv
, res: !instrseq
, hde0: hidexp, hdes: hidexplst
) : primval = let
in
//
case+ hdes of
| list_cons
    (hde, hdes) => let
    val _(*void*) =
      hidexp_ccomp (env, res, hde0)
    // end of [list_cons]
  in
    loop (env, res, hde, hdes)
  end // end of [list_cons]
| list_nil () => hidexp_ccomp (env, res, hde0)
//
end // end of [loop]
//
in
//
case+ hdes of
| list_cons
     (hde, hdes) => loop (env, res, hde, hdes)
| list_nil () => primval_empty (loc0, hse0)
//
end // end of [hidexp_ccomp_seq]

(* ****** ****** *)

implement
hidexp_ccomp_assgn_var
  (env, res, hde0) = let
  val loc0 = hde0.hidexp_loc
  val hse0 = hde0.hidexp_type
  val- HDEassgn_var
    (d2v_l, hils, hde_r) = hde0.hidexp_node
  // end of [val]
  val ofs = hilablst_ccomp (env, res, hils)
  val pmv_r = hidexp_ccomp (env, res, hde_r)
  val ins = instr_assgn_varofs (loc0, d2v_l, ofs, pmv_r)
  val () = instrseq_add (res, ins)
in
  primval_empty (loc0, hse0)
end // end of [hidexp_ccomp_assgn_var]

implement
hidexp_ccomp_assgn_ptr
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val- HDEassgn_ptr
  (hde_l, hils, hde_r) = hde0.hidexp_node
// end of [val]
val pmv_l = hidexp_ccomp (env, res, hde_l)
val ofs = hilablst_ccomp (env, res, hils)
val pmv_r = hidexp_ccomp (env, res, hde_r)
val ins = instr_assgn_ptrofs (loc0, pmv_l, ofs, pmv_r)
val () = instrseq_add (res, ins)
//
in
  primval_empty (loc0, hse0)
end // end of [hidexp_ccomp_assgn_ptr]

(* ****** ****** *)

implement
hidexp_ccomp_ret_app
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val- HDEapp (hse_fun, hde_fun, hdes_arg) = hde0.hidexp_node
//
val pmv_fun = hidexp_ccomp (env, res, hde_fun)
val pmvs_arg = hidexplst_ccomp (env, res, hdes_arg)
//
val ins = instr_funcall (loc0, tmpret, hse_fun, pmv_fun, pmvs_arg)
//
in
  instrseq_add (res, ins)
end // end of [hidexp_ccomp_ret_app]

(* ****** ****** *)

implement
hidexp_ccomp_ret_if
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val- HDEif (hde_cond, hde_then, hde_else) = hde0.hidexp_node
//
val pmv_cond = hidexp_ccomp (env, res, hde_cond)
//
val tmpret_then = tmpret
val res_then = instrseq_make_nil ()
val (pfpush | ()) = ccompenv_push (env)
val () = hidexp_ccomp_ret (env, res_then, tmpret_then, hde_then)
val () = ccompenv_pop (pfpush | env)
val inss_then = instrseq_get_free (res_then)
//
val tmpret_else = tmpret
val res_else = instrseq_make_nil ()
val (pfpush | ()) = ccompenv_push (env)
val () = hidexp_ccomp_ret (env, res_else, tmpret_else, hde_else)
val () = ccompenv_pop (pfpush | env)
val inss_else = instrseq_get_free (res_else)
//
val ins = instr_cond (loc0, pmv_cond, inss_then, inss_else)
//
in
  instrseq_add (res, ins)
end // end of [hidexp_ccomp_ret_if]

(* ****** ****** *)

implement
hidexp_ccomp_ret_seq
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
val- HDEseq (hdes) = hde0.hidexp_node
//
fun loop (
  env: !ccompenv
, res: !instrseq
, hde0: hidexp, hdes: hidexplst
, tmpret: tmpvar
) : void = let
in
//
case+ hdes of
| list_cons
    (hde, hdes) => let
    val _(*void*) =
      hidexp_ccomp (env, res, hde0)
    // end of [list_cons]
  in
    loop (env, res, hde, hdes, tmpret)
  end // end of [list_cons]
| list_nil () => hidexp_ccomp_ret (env, res, tmpret, hde0)
//
end // end of [loop]
//
in
//
case+ hdes of
| list_cons (
    hde, hdes
  ) => loop (env, res, hde, hdes, tmpret)
| list_nil () => ()
//
end // end of [hidexp_ccomp_ret_seq]

(* ****** ****** *)

implement
hidexp_ccomp_funlab_arg_body (
  env
, fl
, imparg
, tmparg
, prolog
, loc_fun
, hips_arg
, hde_body
) = let
(*
val () = begin
  println! ("hidexp_ccomp_funlab_arg_body: fl = ", fl)
end // end of [val]
*)
//
val lev0 = the_d2varlev_get ()
//
val res = instrseq_make_nil ()
val ((*void*)) = instrseq_addlst (res, prolog)
//
val (pfinc | ()) = the_d2varlev_inc ()
val () = let
  val lev1 = the_d2varlev_get () in
  hifunarg_ccomp (env, res, fl, lev1, loc_fun, hips_arg)
end // end of [val]
val loc_body = hde_body.hidexp_loc
val hse_body = hde_body.hidexp_type
val tmpret = tmpvar_make_ret (loc_body, hse_body)
val () = hidexp_ccomp_ret (env, res, tmpret, hde_body)
val () = the_d2varlev_dec (pfinc | (*none*))
//
val inss = instrseq_get_free (res)
//
val fent = funent_make (loc_fun, fl, lev0, imparg, tmparg, tmpret, inss)
//
in
  fent
end // end of [hidexp_ccomp_funlab_arg_body]

(* ****** ****** *)

implement
hidexp_ccomp_lam
  (env, res, hde0)  = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val- HDElam (
  hips_arg, hde_body
) = hde0.hidexp_node
val fl = funlab_make_type (hse0)
val fent = let
  val imparg = list_nil(*s2vs*)
  val tmparg = list_nil(*s2ess*)
  val ins = instr_funlab (loc0, fl)
  val prolog = list_sing (ins)
in
  hidexp_ccomp_funlab_arg_body
    (env, fl, imparg, tmparg, prolog, loc0, hips_arg, hde_body)
  // end of [hidexp_ccomp_funlab_arg_body]
end // end of [val]
//
val () = println! ("hidexp_ccomp_lam: fent=", fent)
//
in
  primval_make_funlab (loc0, fl)
end // end of [hidexp_ccomp_lam]

(* ****** ****** *)

(* end of [pats_ccomp_dynexp.dats] *)
