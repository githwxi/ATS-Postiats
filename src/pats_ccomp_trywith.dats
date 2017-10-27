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
// Start Time: June, 2013
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
GLOBAL = "./pats_global.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans2_env.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
hidexp_ccomp_ret_trywith
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val lvl0 = the_d2varlev_get()
val-HDEtrywith
  (hde_try, hicls_with) = hde0.hidexp_node
//
val hse_exn = hisexp_exnconptr
val tmp_exn = tmpvar_make(loc0, hse_exn)
val pmv_exn = primval_make_tmp(loc0, tmp_exn)
//
val res_try = instrseq_make_nil()
//
val
(pfpush | ()) = ccompenv_push(env)
//
// HX-2017-06-21:
// Tail-call optimization is disabled
val f0 = $GLOBAL.the_CCOMPATS_tlcalopt_get()
val () = $GLOBAL.the_CCOMPATS_tlcalopt_set(0)
//
val () = hidexp_ccomp_ret(env, res_try, tmpret, hde_try)
//
// Tail-call optimization is restored
val () = $GLOBAL.the_CCOMPATS_tlcalopt_set(f0)
//
val
((*popped*)) = ccompenv_pop(pfpush | env)
//
val inss_try = instrseq_get_free(res_try)
//
val fail =
  PTCKNTraise(tmpret, pmv_exn)
//
val
ibrs_with =
hiclaulst_ccomp
(
  env, lvl0, list_sing(pmv_exn), hicls_with, tmpret, fail
) (* end of [val] *)
//
val
ins_trywith = instr_trywith(loc0, tmp_exn, inss_try, ibrs_with)
//
val ((*void*)) = instrseq_add(res, ins_trywith)
//
in
  // nothing
end // end of [hidexp_ccomp_ret_case]

(* ****** ****** *)

(* end of [pats_ccomp_trywith.dats] *)
