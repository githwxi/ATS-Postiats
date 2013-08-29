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
// Start Time: March, 2013
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
hidexp_ccomp_loop
  (env, res, hde0)  = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEloop (init, test, post, body) = hde0.hidexp_node
//
val res_init =
(
case+ init of
| Some (hde) => let
    var res = instrseq_make_nil ()
    val _(*void*) = hidexp_ccomp (env, res, hde)
  in
    instrseq_get_free (res)
  end // end of [Some]
| None () => list_nil ()
) : instrlst // end of [val]
//
val tlab_init = tmplab_make (loc0)
val tlab_fini = tmplab_make (loc0)
val tlab_cont =
(
case+ post of
| Some _ => tmplab_make (loc0) | None _ => tlab_init
) : tmplab // end of [val]
//
val (
) = ccompenv_inc_loopexnenv
  (env, tlab_init, tlab_fini, tlab_cont)
//
val res_test = instrseq_make_nil ()
val pmv_test = hidexp_ccomp (env, res_test, test)
val res_test = instrseq_get_free (res_test)
//
val res_post =
(
case+ post of
| Some (hde) => let
    var res = instrseq_make_nil ()
    val _(*void*) = hidexp_ccomp (env, res, hde)
  in
    instrseq_get_free (res)
  end // end of [Some]
| None () => list_nil ()
) : instrlst // end of [val]
//
val res_body = instrseq_make_nil ()
val pmv_body = hidexp_ccomp (env, res_body, body)
val res_body = instrseq_get_free (res_body)
//
val () = ccompenv_dec_loopexnenv (env)
//
val
ins_loop = instr_loop
(
  loc0, tlab_init, tlab_fini, tlab_cont
, res_init, pmv_test, res_test, res_post, res_body
) // end of [instr_loop]
val () = instrseq_add (res, ins_loop)
//
in
  primval_empty (loc0, hse0)
end // end of [hidexp_ccomp_loop]

(* ****** ****** *)

implement
hidexp_ccomp_loopexn
  (env, res, hde0)  = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEloopexn (knd) =  hde0.hidexp_node
//
val tlab =
(
if knd = 0
  then ccompenv_get_loopfini (env)
  else ccompenv_get_loopcont (env)
// end of [if]
) : tmplab // end of [val]
//
val ins_lpxn = instr_loopexn (loc0, knd, tlab)
//
val () = instrseq_add (res, ins_lpxn)
//
in
  primval_empty (loc0, hse0)
end // end of [hidexp_ccomp_loopexn]

(* ****** ****** *)

(* end of [pats_ccomp_looping.dats] *)
