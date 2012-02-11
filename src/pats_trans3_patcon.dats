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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: February, 2012
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_patcon"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_error.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "pats_staexp2_solve.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

dataviewtype patcontrup =
  PATCONTRUP of (p2atlst, s2explst(*arg*), s2exp(*res*))
(* end of [patcontrup] *)

(* ****** ****** *)

extern
fun p2at_trup_con (p2t0: p2at): patcontrup
implement
p2at_trup_con
  (p2t0) = let
//
val loc0 = p2t0.p2at_loc
val- P2Tcon (
  freeknd, d2c, s2qs, s2e_con, npf, p2ts_arg
) = p2t0.p2at_node
//
val () = let
  fun loop (s2qs: s2qualst): void =
    case+ s2qs of
    | list_cons (s2q, s2qs) => let
        val () = trans3_env_add_svarlst (s2q.s2qua_svs)
      in
        loop (s2qs)
      end // end of [list_cons]
    | list_nil () => ()
  // end of [loop]
in
  loop (s2qs)
end // end of [val]
//
val () = let
  fun loop (
    loc0: location, s2qs: s2qualst
  ) : void = case+ s2qs of
    | list_cons (s2q, s2qs) => let
        val () = trans3_env_hypadd_proplst (loc0, s2q.s2qua_sps)
      in
        loop (loc0, s2qs)
      end // end of [list_cons]
    | list_nil () => ()
  // end of [loop]
in
  loop (loc0, s2qs)
end // end of [val]
//
in
//
case+ s2e_con.s2exp_node of
| S2Efun (
    fc, lin, s2fe, npf_con, s2es_arg, s2e_res
  ) => let
    val err = $SOL.pfarity_equal_solve (loc0, npf, npf_con)
    val () = if err > 0 then {
      val () = prerr_error3_loc (loc0)
      val () = filprerr_ifdebug "p2at_trup_con"
      val () = prerr ": proof arity mismatch: the constructor ["
      val () = prerr_d2con (d2c)
      val () = prerrf ("] requires [%i] arguments.", @(npf_con))
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
      val () = the_trans3errlst_add (T3E_p2at_trup_con (p2t0))
    } // end of [val]
  in
    PATCONTRUP (p2ts_arg, s2es_arg, s2e_res)
  end // end of [S2Efun]
| _ => let
    val () = prerr_error3_loc (loc0)
    val () = filprerr_ifdebug "p2at_trup_con"
    val () = prerr ": the constructor pattern is ill-typed."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_p2at_trup_con (p2t0))
    val s2es_arg =
      aux (p2ts_arg) where {
      fun aux (
        p2ts: p2atlst
      ) : s2explst =
        case+ p2ts of
        | list_cons (_, p2ts) => let
            val s2e = s2exp_err (s2rt_t0ype) in list_cons (s2e, aux p2ts)
          end // end of [list_cons]
        | list_nil () => list_nil ()
      // end of [aux]
    } // end of [val]
    val s2e_res = s2exp_err (s2rt_type)
  in
    PATCONTRUP (p2ts_arg, s2es_arg, s2e_res)
  end // end of [_]
//
end // end of [p2at_trup_con]

(* ****** ****** *)

implement
p2at_trdn_con
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val- P2Tcon (
  freeknd, d2c, s2qs, s2e_con, npf, p2ts_arg
) = p2t0.p2at_node
//
val s2c = d2con_get_scst (d2c)
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
val s2f = s2exp2hnf (s2e)
val s2e = s2hnf2exp (s2f)
val s2f_head = s2hnf_get_head (s2f)
val s2e_head = s2hnf2exp (s2f_head)
//
var flag: int = ~1 (*error*)
var s2es_arg_alt: s2explst = list_nil ()
val () = (
case+ s2e_head.s2exp_node of
| S2Ecst (s2c1) =>
    if eq_s2cst_s2cst (s2c, s2c1) then flag := 0
| S2Edatcontyp (d2c1, s2es) =>
    if eq_d2con_d2con (d2c, d2c1) then (flag := 1; s2es_arg_alt := s2es)
| _ => ()
) // end of [val]
val () = if (flag < 0) then {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the constructor pattern cannot be assigned the type ["
  val () = prerr_s2exp (s2e)
  val () = prerr "]."
  val () = prerr_newline ()
  val s2e0 = s2hnf2exp (s2f0)
  val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
} // end of [val]
//
val flag_vwtp = (if flag > 0 then 1 else d2con_get_vwtp (d2c)): int
//
val p3t0 = (case+ 0 of
| _ when flag = 0 => let
    val ~PATCONTRUP
      (p2ts, s2es_arg, s2e_res) = p2at_trup_con (p2t0)
    val () = $SOL.s2exp_hypequal_solve (loc0, s2e_res, s2e)
    var serr: int = 0
    val p3ts_arg = p2atlst_trdn (loc0, p2ts_arg, s2es_arg, serr)
    val () = if (serr != 0) then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": arity mismatch"
      val () = if serr > 0 then prerr ": less arguments are expected."
      val () = if serr < 0 then prerr ": more arguments are expected."
      val () = prerr_newline ()
      val () = the_trans3errlst_add (T3E_p2at_trdn_con_arity (p2t0, serr))
    } // end of [val]
  in
    p3at_con (loc0, s2e, freeknd, d2c, npf, p3ts_arg)
  end // end of [S2Ecst]
| _ when flag > 0 => exitloc (1)
| _ => let
    val () = assertloc (false) in p3at_err (loc0, s2e)
  end // end of [val]
) : p3at // end of [val]
//
in
  p3t0
end // end of [p2at_trdn_con]

(* ****** ****** *)

(* end of [pats_trans3_patcon.dats] *)
