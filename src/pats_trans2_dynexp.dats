(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: May, 2011
//
(* ****** ****** *)

staload ERR = "pats_error.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans2_dynexp"

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
overload = with $SYM.eq_symbol_symbol

staload SYN = "pats_syntax.sats"
typedef d0ynq = $SYN.d0ynq

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"
staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp2_util.sats"

(* ****** ****** *)

staload "pats_trans2.sats"
staload "pats_trans2_env.sats"

(* ****** ****** *)

#include "pats_basics.hats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fn d1exp_tr_dqid (
  d1e0: d1exp, dq: d0ynq, id: symbol
) : d2exp = let
  val loc0 = d1e0.d1exp_loc
  val ans = the_d2expenv_find_qua (dq, id)
in
//
case+ ans of
| ~Some_vt d2i => begin case+ d2i of
  | D2ITMcon d2cs => let
      val d2cs = d2con_select_arity (d2cs, 0)
      val- list_cons (d2c, _) = d2cs
    in
      d2exp_con (loc0, d2c, list_nil(*sarg*), ~1(*npf*), list_nil(*darg*))
    end // end of [D2ITEMcon]
  | D2ITMcst d2c => d2exp_cst (loc0, d2c)
  | D2ITMe1xp e1xp => let
      val d1e = d1exp_make_e1xp (loc0, e1xp) in d1exp_tr (d1e)
    end // end of [D2ITMe1xp]
  | D2ITMvar d2v => d2exp_var (loc0, d2v)
  | _ => d2exp_err (loc0)
  end // end of [Some_vt]
| ~None_vt () => let
    val () = prerr_error2_loc (loc0)
    val () = filprerr_ifdebug ": d1exp_tr_dqid"
    val () = prerr ": the dynamic identifier ["
    val () = ($SYN.prerr_d0ynq dq; $SYM.prerr_symbol (id))
    val () = prerr "] is unrecognized."
    val () = prerr_newline ()
  in
    d2exp_err (loc0)
  end // end of [None_vt]
end // end of [d1exp_tr_dqid]

(* ****** ****** *)

implement
d1exp_tr (d1e0) = let
// (*
  val () = begin
    print "d1exp_tr: d1e0 = "; print_d1exp d1e0; print_newline ()
  end // end of [val]
// *)
  val loc0 = d1e0.d1exp_loc
in
//
case+ d1e0.d1exp_node of
//
| D1Eide (id) =>
    d1exp_tr_dqid (d1e0, $SYN.the_d0ynq_none, id)
  // end of [D1Eide]
| D1Edqid (dq, id) => d1exp_tr_dqid (d1e0, dq, id)
//
| D1Ei0nt (x) => d2exp_i0nt (loc0, x)
| D1Ec0har (x) => d2exp_c0har (loc0, x)
| D1Ef0loat (x) => d2exp_f0loat (loc0, x)
| D1Es0tring (x) => d2exp_s0tring (loc0, x)
//
| D1Elist (npf, d1es) => (
  case+ d1es of
  | list_cons _ => let
      val knd = TYTUPKIND_flt // HX: flat tuple
      val d2es = d1explst_tr (d1es)
    in
      d2exp_tup (loc0, knd, npf, d2es)
    end // end of [list_cons]
  | list_nil () => d2exp_empty (loc0)
  ) // end of [D1Elist]
| D1Elet (d1cs, d1e) => let
    val (pfenv | ()) = the_trans2_env_push ()
    val d2cs = d1eclist_tr (d1cs); val d2e = d1exp_tr (d1e)
    val () = the_trans2_env_pop (pfenv | (*none*))
  in
    d2exp_let (loc0, d2cs, d2e)
  end // end of [D1Elet]
| D1Ewhere (d1e, d1cs) => let
    val (pfenv | ()) = the_trans2_env_push ()
    val d2cs = d1eclist_tr (d1cs); val d2e = d1exp_tr (d1e)
    val () = the_trans2_env_pop (pfenv | (*none*))
  in
    d2exp_where (loc0, d2e, d2cs)
  end // end of [D1Ewhere]
| D1Eann_type (d1e, s1e) => let
    val d2e = d1exp_tr d1e
    val s2e = s1exp_trdn_impredicative (s1e)
  in
    d2exp_ann_type (loc0, d2e, s2e)
  end // end of [D1Eann_type]
| _ => let
    val () = prerr_interror_loc (loc0)
    val () = prerr ": d1exp_tr: not yet implemented: d1e0 = "
    val () = prerr_d1exp (d1e0)
    val () = prerr "]"
    val () = prerr_newline ()
  in
    $ERR.abort {d2exp} ()
  end // end of [_]
//
end // end of [d1exp_tr]

(* ****** ****** *)

implement d1explst_tr (d1es) = l2l (list_map_fun (d1es, d1exp_tr))

(* ****** ****** *)

(* end of [pats_trans2_dynexp.dats] *)
