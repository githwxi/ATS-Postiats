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
// Start Time: September, 2013
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
hidexp_ccomp_ret_delay
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val-HDEdelay (hde) = hde0.hidexp_node
//
val hse_res = hde.hidexp_type
val hse_fun = hisexp_fun (FUNCLOclo(~1), list_nil, hse_res)
val flab = funlab_make_type (hse_fun)
val pmv0 = primval_make_funlab (loc0, flab)
//
val () = the_funlablst_add (flab)
val () = ccompenv_add_flabsetenv (env, flab)
//
val () = ccompenv_inc_tailcalenv (env, flab)
//
val tmplev = ccompenv_get_tmplevel (env)
val () = if tmplev > 0 then funlab_set_tmpknd (flab, 1)
//
val fent = let
  val imparg = list_nil(*s2vs*)
  val tmparg = list_nil(*s2ess*)
  val ins = instr_funlab (loc0, flab)
  val prolog = list_sing (ins)
in
//
hidexp_ccomp_funlab_arg_body
  (env, flab, imparg, tmparg, prolog, loc0, list_nil, hde)
// end of [hidexp_ccomp_funlab_arg_body]
//
end // end of [val]
val () = funlab_set_funent (flab, Some(fent))
//
val () = ccompenv_dec_tailcalenv (env)
//
val
pmv0_tk =
primval_lamfix(None(*lam*), pmv0)
//
val ins =
instr_move_delay(loc0, tmpret, 0(*lin*), hse_res, pmv0_tk)
//
val ((*void*)) = instrseq_add (res, ins)
//
in
  // nothing
end // end of [hidexp_ccomp_ret_delay]

(* ****** ****** *)

implement
hidexp_ccomp_ret_ldelay
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val-HDEldelay (hde1, hde2) = hde0.hidexp_node
//
val hse_res = hde1.hidexp_type
val hse_arg = hisexp_bool_t0ype ()
val hses_arg = list_cons{hisexp}(hse_arg, list_nil())
val hse_fun = hisexp_fun (FUNCLOclo(1), hses_arg, hse_res)
val flab = funlab_make_type (hse_fun)
val pmv0 = primval_make_funlab (loc0, flab)
//
val d2v_flag = d2var_make_any (loc0)
val ((*void*)) = d2var_inc_utimes (d2v_flag)
val hde_flag = hidexp_var (loc0, hse_arg, d2v_flag)
val hde2 = hidexp_ignore (hde2.hidexp_loc, hse_res, hde2)
val hde12_body = hidexp_if (loc0, hse_res, hde_flag, hde1, hde2)
val hip_arg = hipat_var (loc0, hse_arg, d2v_flag)
val hips_arg = list_cons{hipat}(hip_arg, list_nil())
//
val () = the_funlablst_add (flab)
val () = ccompenv_add_flabsetenv (env, flab)
//
val () = ccompenv_inc_tailcalenv (env, flab)
//
val tmplev = ccompenv_get_tmplevel (env)
val () = if tmplev > 0 then funlab_set_tmpknd (flab, 1)
//
val fent = let
  val imparg = list_nil(*s2vs*)
  val tmparg = list_nil(*s2ess*)
  val ins = instr_funlab (loc0, flab)
  val prolog = list_sing (ins)
in
//
hidexp_ccomp_funlab_arg_body
( env, flab
, imparg, tmparg, prolog, loc0, hips_arg, hde12_body
) // end of [hidexp_ccomp_funlab_arg_body]
//
end // end of [val]
val () = funlab_set_funent (flab, Some(fent))
//
val () = ccompenv_dec_tailcalenv (env)
//
val
pmv0_tk =
primval_lamfix (None(*lam*), pmv0)
//
val ins =
instr_move_delay(loc0, tmpret, 1(*lin*), hse_res, pmv0_tk)
//
val ((*void*)) = instrseq_add (res, ins)
//
in
  // nothing
end // end of [ccomp_exp_lazy_ldelay]

(* ****** ****** *)

implement
hidexp_ccomp_ret_lazyeval
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDElazyeval (lin, hde_lazy) = hde0.hidexp_node
//
val pmv_lazy = hidexp_ccomp (env, res, hde_lazy)
val ins = instr_move_lazyeval (loc0, tmpret, lin, hse0, pmv_lazy)
val ((*void*)) = instrseq_add (res, ins)
//
in
  // nothing
end // end of [hidexp_ccomp_ret_lazyeval]

(* ****** ****** *)

(* end of [pats_ccomp_lazyeval.dats] *)
