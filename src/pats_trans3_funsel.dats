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

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_funsel"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

extern
fun aritest_d2exparglst_s2exp
  (d2as: d2exparglst, s2e: s2exp): bool
(*
** HX: for handling dynamic overloading
*)
local

fun loop (
  d2as: d2exparglst, s2e: s2exp, npf: int, d2es: d2explst
) : bool = let
  val s2e = s2exp_hnfize (s2e)
in
  case+ s2e.s2exp_node of
  | S2Efun (_(*fc*), _(*lin*), _(*eff*), npf1, s2es_arg, s2e_res) =>
      if (npf = npf1) then let
        val sgn = list_length_compare (d2es, s2es_arg) in
        if sgn = 0 then aritest_d2exparglst_s2exp (d2as, s2e_res) else false
      end else false
    // end of [S2Efun]
  | S2Eexi (_(*s2vs*), _(*s2ps*), s2e) => loop (d2as, s2e, npf, d2es)
  | S2Euni (_(*s2vs*), _(*s2ps*), s2e) => loop (d2as, s2e, npf, d2es)
  | S2Emetfn (_(*stamp*), _(*met*), s2e) => loop (d2as, s2e, npf, d2es)
  | _ => false // end of [_]
end // end of [aux3_app]

in // in of [local]

implement
aritest_d2exparglst_s2exp
  (d2as, s2e) = case+ d2as of
  | list_cons (d2a, d2as) => (
    case+ d2a of
    | D2EXPARGdyn (
        npf, _(*loc*), d2es
      ) => loop (d2as, s2e, npf, d2es)
    | D2EXPARGsta _ =>
        aritest_d2exparglst_s2exp (d2as, s2e)
    ) // end of [list_cons]
  | list_nil () => true
// end of [aritest_d2exparglst_s2exp]

end // end of [local]

(* ****** ****** *)

fun d2exp_trup_item (
  loc0: location, d2i: d2itm
) : d3exp = let
in
//
case+ d2i of
| D2ITMcst d2c => d2exp_trup_cst (loc0, d2c)
| D2ITMvar d2v => d2exp_trup_var (loc0, d2v)
| _ => let
    val () = prerr_error3_loc (loc0)
    val () = filprerr_ifdebug "d2exp_trup_item"
    val () = prerr ": a dynamic constant or variable is expected."
    val () = prerr_newline ()
  in
    d3exp_err (loc0)
  end // end of [_]
//
end // end of [d2exp_trup_item]

(* ****** ****** *)

datatype d3exparg = 
  | D3EXPARGdyn of
      (int(*npf*), location(*arg*), d3explst)
  | D3EXPARGsta of s2exparglst
typedef d3exparglst = List d3exparg

(* ****** ****** *)

(* end of [pats_trans3_funsel.dats] *)
