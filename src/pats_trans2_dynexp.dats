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

(*
** HX: dynamic special identifier
*)
datatype dynspecid =
  | SPDIDassgn | SPDIDderef | SPDIDnone
// end of [dynspecid]

fn dynspecid_of_dqid
  (dq: d0ynq, id: symbol): dynspecid =
  case+ dq.d0ynq_node of
  | $SYN.D0YNQnone () => (case+ 0 of
    | _ when id = $SYM.symbol_BANG => SPDIDderef ()
    | _ when id = $SYM.symbol_COLONEQ => SPDIDassgn ()
    | _ => SPDIDnone ()        
    ) // end of [D0YNQnone]
  | _ => SPDIDnone ()
// end of [dynspecid_of_dqid]

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

extern
fun d1exp_tr_app_dyn (
  d1e0: d1exp
, d1e_fun: d1exp
, locarg: location, npf: int, darg: d1explst
) : d2exp // end of [d1exp_tr_app_dyn]
extern
fun d1exp_tr_app_sta_dyn (
  d1e0: d1exp
, d1e1: d1exp
, d1e_fun: d1exp
, sarg: s1exparglst
, locarg: location, npf: int, darg: d1explst
) : d2exp // end of [d1exp_tr_app_sta_dyn]

(* ****** ****** *)

fun
d1exp_tr_app_dyn_dqid (
  d1e0: d1exp, d1e1: d1exp
, dq: d0ynq, id: symbol
, locarg: location, npf: int, darg: d1explst 
) : d2exp = let
//
val spdid = dynspecid_of_dqid (dq, id) 
//
in
//
case+ spdid of
(*
| SPDIDassgn
| SPDIDderef
*)
| _ (*SPDIDnone*) => let
    val ans = the_d2expenv_find_qua (dq, id)
  in
    case+ ans of
    | ~Some_vt d2i => let
        val sarg = list_nil ()
      in
        d1exp_tr_app_sta_dyn_dqid_itm (d1e0, d1e1, d1e1, dq, id, d2i, sarg, locarg, npf, darg)
      end // end of [Some_vt]
    | ~None_vt () => let
        val () = prerr_error2_loc (d1e1.d1exp_loc)
        val () = filprerr_ifdebug "d1exp_tr_app_dyn_dqid"
        val () = prerr ": unrecognized dynamic identifier ["
        val () = ($SYN.prerr_d0ynq dq; $SYM.prerr_symbol id)
        val () = prerr "]."
        val () = prerr_newline ()
      in
        d2exp_err (d1e0.d1exp_loc)
      end
  end // end of [_]
//
end // end of [d1exp_tr_app_dyn_dqid]

and
d1exp_tr_app_sta_dyn_dqid (
  d1e0: d1exp
, d1e1: d1exp
, d1e2: d1exp
, dq: d0ynq, id: symbol
, sarg: s1exparglst
, locarg: location, npf: int, darg: d1explst 
) : d2exp = let
  val ans = the_d2expenv_find_qua (dq, id)
in
//
case+ ans of
| ~Some_vt d2i => let
    val sarg = list_nil ()
  in
    d1exp_tr_app_sta_dyn_dqid_itm (d1e0, d1e1, d1e1, dq, id, d2i, sarg, locarg, npf, darg)
  end // end of [Some_vt]
| ~None_vt () => let
    val () = prerr_error2_loc (d1e1.d1exp_loc)
    val () = filprerr_ifdebug "d1exp_tr_app_sta_dyn_dqid"
    val () = prerr ": unrecognized dynamic identifier ["
    val () = ($SYN.prerr_d0ynq dq; $SYM.prerr_symbol id)
    val () = prerr "]."
    val () = prerr_newline ()
  in
    d2exp_err (d1e0.d1exp_loc)
  end
end // end of [d1exp_tr_app_sta_dyn_dqid]

and
d1exp_tr_app_sta_dyn_dqid_itm (
  d1e0: d1exp
, d1e1: d1exp
, d1e2: d1exp
, dq: d0ynq, id: symbol
, d2i: d2itm
, sarg: s1exparglst
, locarg: location, npf: int, darg: d1explst 
) : d2exp = let
in
//
case+ d2i of
| D2ITMcon d2cs => let
    val loc0 = d1e0.d1exp_loc
    val d2cs = d2con_select_arity (d2cs, 0)
    val- list_cons (d2c, _) = d2cs
    val sarg = s1exparglst_tr (sarg)
    val darg = d1explst_tr (darg)
  in
    d2exp_con (loc0, d2c, sarg, npf, darg)
  end // end of [D2ITEMcon]
| D2ITMcst d2c => let
    val d2e_fun =
      d2exp_cst (d1e2.d1exp_loc, d2c)
    // end of [val]
    val sarg = s1exparglst_tr (sarg)
    val darg = d1explst_tr (darg)
  in
    d2exp_app_sta_dyn (d1e0.d1exp_loc, d1e1.d1exp_loc, d2e_fun, sarg, locarg, npf, darg)
  end // end of [D2ITMcst]
| D2ITMvar d2v => let
    val d2e_fun = d2exp_var (d1e2.d1exp_loc, d2v)
    val sarg = s1exparglst_tr (sarg)
    val darg = d1explst_tr (darg)
  in
    d2exp_app_sta_dyn (d1e0.d1exp_loc, d1e1.d1exp_loc, d2e_fun, sarg, locarg, npf, darg)
  end // end of [D2ITMvar]
| _ => let
    val () = prerr_error2_loc (d1e2.d1exp_loc)
  in
    d2exp_err (d1e0.d1exp_loc)
  end (* end of [_] *)
//
end // end of [d1exp_tr_app_sta_dyn_dqid_itm]

(* ****** ****** *)

implement
d1exp_tr_app_dyn (
  d1e0, d1e_fun, locarg, npf, darg
) = let
(*
  val () = begin
    print "d1exp_tr_app_dyn: d1e0 = "; print_d1exp d1e0; print_newline ()
  end // end of [val]
*)
in
//
case+ d1e_fun.d1exp_node of
| D1Eide (id) => let
    val dq = $SYN.the_d0ynq_none in
    d1exp_tr_app_dyn_dqid (d1e0, d1e_fun, dq, id, locarg, npf, darg)
  end
| D1Edqid (dq, id) =>
    d1exp_tr_app_dyn_dqid (d1e0, d1e_fun, dq, id, locarg, npf, darg)
| _ => let
    val d2e_fun = d1exp_tr (d1e_fun)
    val darg = d1explst_tr (darg)
  in
    d2exp_app_dyn (d1e0.d1exp_loc, d2e_fun, locarg, npf, darg)
  end // end of [_]
//
end // end of [d1exp_tr_app_dyn]

implement
d1exp_tr_app_sta_dyn (
  d1e0, d1e1, d1e_fun, sarg, locarg, npf, darg
) = let
(*
  val () = begin
    print "d1exp_tr_app_sta_dyn: d1e0 = "; print_d1exp d1e0; print_newline ()
  end // end of [val]
*)
in
//
case+ d1e_fun.d1exp_node of
| D1Eide (id) => let
    val dq = $SYN.the_d0ynq_none in
    d1exp_tr_app_sta_dyn_dqid (d1e0, d1e1, d1e_fun, dq, id, sarg, locarg, npf, darg)
  end
| D1Edqid (dq, id) =>
    d1exp_tr_app_sta_dyn_dqid (d1e0, d1e1, d1e_fun, dq, id, sarg, locarg, npf, darg)
| _ => let
    val d2e_fun = d1exp_tr (d1e_fun)
    val sarg = s1exparglst_tr (sarg)
    val darg = d1explst_tr (darg)
  in
    d2exp_app_sta_dyn (d1e0.d1exp_loc, d1e1.d1exp_loc, d2e_fun, sarg, locarg, npf, darg)
  end // end of [_]
//
end // end of [d1exp_tr_app_sta_dyn]

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
| D1Eint (rep) => d2exp_int (loc0, rep)
| D1Echar (c) => d2exp_char (loc0, c)
| D1Estring (s) => d2exp_string (loc0, s)
| D1Efloat (rep) => d2exp_float (loc0, rep)
//
| D1Ei0nt (x) => d2exp_i0nt (loc0, x)
| D1Ec0har (x) => d2exp_c0har (loc0, x)
| D1Ef0loat (x) => d2exp_f0loat (loc0, x)
| D1Es0tring (x) => d2exp_s0tring (loc0, x)
//
| D1Eapp_dyn (
    d1e1, locarg, npf, darg
  ) => (
    case+ d1e1.d1exp_node of
    | D1Eapp_sta (d1e_fun, sarg) =>
        d1exp_tr_app_sta_dyn (d1e0, d1e1, d1e_fun, sarg, locarg, npf, darg)
      // end of [P1Tapp_sta]
    | _ => d1exp_tr_app_dyn (d1e0, d1e1, locarg, npf, darg)
  ) // end of [D1Eapp_dyn]
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
