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

staload "pats_basics.sats"

(* ****** ****** *)

staload LOC = "pats_location.sats"
macdef print_location = $LOC.print_location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_stacst2.sats"
staload "pats_staexp2_util.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

macdef unhnf = s2exp_of_s2hnf
macdef unhnflst = s2explst_of_s2hnflst

(* ****** ****** *)

fun d2exp_trup_bool
  (d2e0: d2exp, b: bool): d3exp = let
  val loc0 = d2e0.d2exp_loc
  val s2f = s2exp_bool_bool_t0ype (b) in d3exp_bool (loc0, s2f, b)
end // end of [d2exp_trup_bool]

fun d2exp_trup_char
  (d2e0: d2exp, c: char): d3exp = let
  val loc0 = d2e0.d2exp_loc
  val s2f = s2exp_char_char_t0ype (c) in d3exp_char (loc0, s2f, c)
end // end of [d2exp_trup_char]

(* ****** ****** *)

extern
fun d2exp_trup_arg_body (
  loc0: location, fc0: funclo, lin: int, npf: int, p2ts: p2atlst, d2e: d2exp
) : (s2hnf, p3atlst, d3exp)

(* ****** ****** *)

implement
d2exp_trup
  (d2e0) = let
//
  val loc0 = d2e0.d2exp_loc
// (*
val () = begin
  print "d2exp_trup: d2e0 = "; print_d2exp d2e0; print_newline ()
end // end of [val]
// *)
val d3e0 = (
case+ d2e0.d2exp_node of
//
| D2Ebool (b(*bool*)) => d2exp_trup_bool (d2e0, b)
| D2Echar (c(*char*)) => d2exp_trup_char (d2e0, c)
//
| D2Elam_dyn (
    lin, npf, p2ts_arg, d2e_body
  ) => let
    val fc0 = FUNCLOfun () // default
    val s2ep3tsd3e = d2exp_trup_arg_body (loc0, fc0, lin, npf, p2ts_arg, d2e_body)
    val s2f_fun = s2ep3tsd3e.0
    val p3ts_arg = s2ep3tsd3e.1
    val d3e_body = s2ep3tsd3e.2
  in
    d3exp_lam_dyn (loc0, s2f_fun, lin, npf, p3ts_arg, d3e_body)
  end // end of [D2Elam_dyn]
| D2Elaminit_dyn (
    lin, npf, p2ts_arg, d2e_body
  ) => let
    val fc0 = FUNCLOclo (0) // default
    val s2ep3tsd3e = d2exp_trup_arg_body (loc0, fc0, lin, npf, p2ts_arg, d2e_body)
    val s2f_fun = s2ep3tsd3e.0
    val p3ts_arg = s2ep3tsd3e.1
    val d3e_body = s2ep3tsd3e.2
    val s2e_fun = (unhnf)s2f_fun
    val () = (
      case+ s2e_fun.s2exp_node of
      | S2Efun (fc, _, _, _, _, _) => (case+ fc of
        | FUNCLOclo 0 => ()
        | _ => the_trans3errlst_add (T3E_d2exp_tr_laminit_fc (d2e0, fc))
        ) // end of [S2Efun]
      | _ => () // HX: deadcode
    ) : void // end of [val]
  in
    d3exp_laminit_dyn (loc0, s2f_fun, lin, npf, p3ts_arg, d3e_body)
  end // end of [D2Elam_dyn]
//
| _ => let val () = assertloc (false) in exit (1) end
//
) : d3exp // end of [val]
in
//
d3e0 // the return value
//
end // end of [d2exp_trup]

(* ****** ****** *)

implement
d2explst_trup
  (d2es) = l2l (list_map_fun (d2es, d2exp_trup))
// end of [d2explst_trup]

implement
d2explstlst_trup
  (d2ess) = l2l (list_map_fun (d2ess, d2explst_trup))
// end of [d2explstlst_trup]

(* ****** ****** *)

implement
d2exp_trup_arg_body (
  loc0
, fc0, lin, npf
, p2ts_arg, d2e_body
) = let
// (*
val () = (
  print "d2exp_trup_arg_body: arg =";
  print_p2atlst (p2ts_arg); print_newline ()
) // end of [val]
val () = (
  print "d2exp_trup_arg_body: body ="; print_d2exp (d2e_body); print_newline ()
) // end of [val]
// *)
val (pfpush | ()) = trans3_env_push ()
//
var fc: funclo = fc0
var s2fe: s2eff = S2EFFnil ()
val d2e_body = d2exp_s2eff_of_d2exp (d2e_body, s2fe)
//
val s2fs_arg = p2atlst_syn_type (p2ts_arg)
val p3ts_arg = p2atlst_trup_arg (npf, p2ts_arg)
val d3e_body = d2exp_trup (d2e_body)
//
val () = trans3_env_pop_and_add_main (pfpush | (*none*))
//
val s2f_res = d3e_body.d3exp_type
val isprf = s2exp_is_prf ((unhnf)s2f_res)
val islin = lin > 0
val s2t_fun = s2rt_prf_lin_fc (loc0, isprf, islin, fc)
val s2e_fun = s2exp_fun_srt (
  s2t_fun, fc, lin, s2fe, npf, (unhnflst)s2fs_arg, (unhnf)s2f_res
) // end of [val]
//
in
//
(s2e_fun, p3ts_arg, d3e_body)
//
end // end of [d2exp_trup_arg_body]

(* ****** ****** *)

(* end of [pats_trans3_exp_up.dats] *)
