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

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_stacst2.sats"

staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

implement
d2exp_trup_loopexn
  (loc0, knd) = d3exp_loopexn (loc0, knd)
// end of [d2exp_trup_loopexn]

(* ****** ****** *)

extern
fun d2exp_trup_loop_dryrun (
  loc: location, test: d2exp, post: d2expopt, body: d2exp
) : lstbefitmlst // end of [d2exp_trup_loop_dryrun]

implement
d2exp_trup_loop_dryrun (
  loc0, test, post, body
) = let
//
val lsbis = the_d2varenv_save_lstbefitmlst ()
//
val (pfpush1 | ()) = trans3_env_push ()
val (pfpush2 | ()) = the_lamlpenv_push_loop0 ()
//
val test = d2exp_trup (test)
val body = d2exp_trup (body)
//
val post = (
  case+ post of
  | Some d2e => let
      val s2f = s2exp_void_t0ype ()
      val d3e = d2exp_trdn (d2e, s2f)
    in
      Some (d3e)
    end // end of [Some]
  | None () => None ()
) : d3expopt // end of [val]
//
val () = the_lamlpenv_pop (pfpush2 | (*void*))
val s3itms = trans3_env_pop (pfpush1 | (*void*)) // HX: it is a dry-run
val () = list_vt_free (s3itms)
//
fun aux (
  x: lstbefitm
) : lstbefitm = let
  val d2v = x.lstbefitm_var and linval = x.lstbefitm_linval
in
  lstbefitm_make (d2v, linval)
end // end of [aux]
val lsbis2 = list_map_fun (lsbis, aux)
//
in
  list_of_list_vt (lsbis2)
end // end of [d2exp_trup_loop_dryrun]

(* ****** ****** *)

implement
d2exp_trup_loop (
  loc0, i2nv, init, test, post, body
) = let
//
val init = (
  case+ init of
  | Some d2e => let
      val s2f = s2exp_void_t0ype ()
      val d3e = d2exp_trdn (d2e, s2f)
    in
      Some (d3e)
    end // end of [Some]
  | None () => None ()
) : d3expopt // end of [val]
//
val lsbis2 = d2exp_trup_loop_dryrun (loc0, test, post, body)
//
in
  exitloc (1)
end // end of [d2exp_trup_loop]

(* ****** ****** *)

(* end of [pats_trans3_looping.dats] *)
