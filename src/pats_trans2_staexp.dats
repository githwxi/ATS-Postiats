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

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload ERR = "pats_error.sats"
staload INT = "pats_intinf.sats"

(* ****** ****** *)

staload "pats_basics.sats"
macdef isdebug () = (debug_flag_get () > 0)

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
overload = with $SYM.eq_symbol_symbol

staload SYN = "pats_syntax.sats"
typedef s0taq = $SYN.s0taq

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_e1xpval.sats"
staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_trans2_env.sats"
staload "pats_trans2.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fn prerr_loc_error2
  (loc: location): void = (
  $LOC.prerr_location loc; prerr ": error(2)"
) // end of [prerr_loc_error2]
fn prerr_interror () = prerr "INTERROR(pats_trans2_staexp)"
fn prerr_loc_interror (loc: location) = begin
  $LOC.prerr_location loc; prerr ": INTERROR(pats_trans2_staexp)"
end // end of [prerr_loc_interror]

(* ****** ****** *)

(*
** HX: static special identifier
*)
datatype staspecid = SPSIDarrow | SPSIDnone

fn staspecid_of_qid
  (q: s0taq, id: symbol): staspecid = begin
  case+ q.s0taq_node of
  | $SYN.S0TAQnone () => begin
      if id = $SYM.symbol_MINUSGT then SPSIDarrow () else SPSIDnone ()
    end // end of [S0TAQnone]
  | _ => SPSIDnone ()
end // end of [staspecid_of_qid]

(* ****** ****** *)

implement
s2var_check_tmplev (loc, s2v) = let
  val s2v_tmplev = s2var_get_tmplev (s2v)
in
  case+ 0 of
  | _ when s2v_tmplev > 0 => let
      val tmplev = the_tmplev_get ()
    in
      if s2v_tmplev < tmplev then {
        val () = prerr_loc_error2 (loc)
        val () = prerr ": the static variable ["
        val () = prerr_s2var (s2v)
        val () = prerr "] is out of scope."
        val () = prerr_newline ()
      } // end of [if]
    end // end of [_ when s2v_tmplev > 0]
  | _ => () // not a template variable
end // end of [s2var_tmplev_check]

(* ****** ****** *)

fn s1exp_trup_qid (
  s1e0: s1exp, q: $SYN.s0taq, id: symbol
) : s2exp = let
  val loc0 = s1e0.s1exp_loc
  val ans = the_s2expenv_find_qua (q, id)
in
//
case+ ans of
| ~Some_vt s2i => begin case+ s2i of
  | S2ITMcst s2cs => let
      val- list_cons (s2c, _) = s2cs
      val s2e0 = s2exp_cst (s2c)
    in
      case+ s2cst_get_srt (s2c) of
      | S2RTfun (list_nil (), _res) when s2rt_is_dat _res =>
          s2exp_app_srt (_res, s2e0, list_nil ()) // HX: automatically applied
        // S2RTfun
      | _ => s2e0
    end // end of [S2ITMcst]
  | S2ITMe1xp e1xp => let
      val e1xp = e1xp_normalize (e1xp)
      val s1e = s1exp_make_e1xp (loc0, e1xp)
    in
      s1exp_trup (s1e)
    end // end of [S1ITMe1xp]
  | S2ITMvar s2v => let
      val () = s2var_check_tmplev (loc0, s2v) in s2exp_var (s2v)
    end // end of [S2ITMvar]
  | _ => s2exp_err (s2t) where {
      val s2t = s2rt_err ()
      val () = prerr_loc_interror (loc0)
      val () = prerr ": s1exp_qid_tr_up: s2i = "
      val () = prerr_s2itm (s2i)
      val () = prerr_newline ()
    } // end of [_]
  end // end of [Some_vt]
| ~None_vt () => s2exp_err (s2t) where {
    val s2t = s2rt_err ()
    val () = the_tran2errlst_add (T2E_s1exp_qid (s1e0))
    val () = prerr_loc_error2 (loc0)
    val () = if isdebug () then prerr ": s1exp_trup_qid"
    val () = prerr ": the static identifier ["
    val () = ($SYN.prerr_s0taq q; $SYM.prerr_symbol id)
    val () = prerr "] is unrecognized."
    val () = prerr_newline ()
  } // end of [None_vt]
//
end // end of [s1exp_qid_tr_up]

(* ****** ****** *)

fun s1exp_app_unwind (
  s1e: s1exp, s1ess: &List_vt (s1explst)
) : s1exp = begin
  case+ s1e.s1exp_node of
  | S1Eapp (s1e, _(*loc_arg*), s1es) => let
      val () = s1ess := list_vt_cons (s1es, s1ess)
    in
      s1exp_app_unwind (s1e, s1ess)
    end // end of [S1Eapp]
  | S1Esqid (q, id) => begin case+ q.s0taq_node of
    | $SYN.S0TAQnone () => let
        val ans = the_s2expenv_find id
      in
        case+ ans of
        | ~Some_vt s2i => begin case+ s2i of
(*
          | S2ITMe1xp e1xp => let
              val s1e_new = s1exp_make_e1xp (s1e.s1exp_loc, e1xp)
            in
              s1exp_app_unwind (s1e_new, s1ess)
            end (* end of [S2ITMe1xp] *)
*)
          | _ => s1e
          end // end of [Some_vt]
        | ~None_vt () => s1e
      end // end of [$Syn.S0TAQnone]
    | _ => s1e
    end (* end of [S1Eqid] *)
  | _ => s1e // end of [_]
end // end of [s1exp_app_unwind]

(* ****** ****** *)

fn s1exp_trup_app (
  loc_fun: location
, s2e_fun: s2exp, s1ess_arg: List_vt (s1explst)
) : s2exp = let
//
fun loop (
  s2e_fun: s2exp
, s1ess_arg: List_vt (s1explst)
) :<cloref1> s2exp = begin
  case+ s1ess_arg of
  | ~list_vt_cons (
      s1es_arg, s1ess_arg
    ) => let
      val s2t_fun = s2e_fun.s2exp_srt
    in
      if s2rt_is_fun (s2t_fun) then let
        val- S2RTfun (s2ts_arg, s2t_res) = s2t_fun
        var err: int = 0
        val s2es_arg = s1explst_trdn_err (s1es_arg, s2ts_arg, err)
      in
        case+ 0 of
        | _ when err = 0 => let
            val s2e_fun = s2exp_app_srt (s2t_res, s2e_fun, s2es_arg)
          in
            loop (s2e_fun, s1ess_arg)
          end // end of [_ when err = 0]
        | _ => s2exp_err (s2t_res) where {
            val () = list_vt_free (s1ess_arg)
//
            val () = prerr_loc_error2 (loc_fun)
            val () = if isdebug () then prerr ": s1exp_trup_app"
            val () = prerr ": the static function needs "
            val () = prerr_string (if err > 0 then "less" else "more")
            val () = prerr " arguments."
            val () = prerr_newline ()
//
          } // end of [_ when err != 0]
        // end of [case]
      end else let
        val () = list_vt_free (s1ess_arg)
//
        val () = prerr_loc_error2 (loc_fun)
        val () = if isdebug () then prerr ": s1exp_trup_app"
        val () = prerr ": the static expresstion ["
        val () = prerr_s2exp (s2e_fun)
        val () = prerr "] is expected to be of a functional sort but it is assigned the sort [";
        val () = prerr_s2rt (s2t_fun)
        val () = prerr "]."
        val () = prerr_newline ()
//
      in
        s2exp_err (s2t_fun)
      end // end of [if]
    end (* end of [list_cons] *)
  | ~list_vt_nil _ => s2e_fun
end // end of [loop]
//
in
  loop (s2e_fun, s1ess_arg)
end // end of [s1exp_trup_app]

(* ****** ****** *)

implement
s1exp_trup (s1e0) = let
(*
  val () = begin
    print "s1exp_tr_up: s1e0 = "; print s1e0; print_newline ()
  end // end of [val]
*)
  val loc0 = s1e0.s1exp_loc
in
//
case+ s1e0.s1exp_node of
| S1Eint (rep) => let
    val int = $INT.intinf_make_string (rep) in s2exp_intinf (int)
  end // end of [S1Eint]
| S1Echar (char) => s2exp_char (char)
| S1Esqid (q, id) => s1exp_trup_qid (s1e0, q, id)
| S1Eapp _ => let
    var s1ess_arg: List_vt (s1explst) = list_vt_nil
    val s1e_opr = s1exp_app_unwind (s1e0, s1ess_arg)
  in
    case+ s1e_opr.s1exp_node of
(*
    | S1Eqid (q, id) =>
        s1exp_trup_app_qid (s1e0, s1e_opr, q, id, s1ess_arg)
*)
    | _ => let
        val loc_opr = s1e_opr.s1exp_loc
        val s2e_opr = s1exp_trup (s1e_opr)
      in
        s1exp_trup_app (loc_opr, s2e_opr, s1ess_arg)
      end // end of [_]
  end (* end of [S1Eapp] *)
| _ => let
    val () = prerr_loc_interror (loc0)
    val () = prerr ": not yet implemented: ["
    val () = prerr_s1exp (s1e0)
    val () = prerr "]"
    val () = prerr_newline ()
  in
    $ERR.abort ()
  end // end of [_]
end // end of [s1exp_trup]

(* ****** ****** *)

implement
s1exp_trdn
  (s1e0, s2t0) = let
  val s2e0 = s1exp_trup (s1e0)
  val s2t0_new = s2e0.s2exp_srt
  val test = s2rt_ltmat (s2t0_new, s2t0)
in
  if test then s2e0 else let
    val () = prerr_loc_error2 (s1e0.s1exp_loc)
    val () = if isdebug () then prerr ": s1exp_tr_dn"
    val () = prerr ": the static expression is of sort ["
    val () = prerr_s2rt (s2t0_new)
    val () = prerr "] but it is expectecd to be of sort ["
    val () = prerr_s2rt (s2t0)
    val () = prerr "]."
    val () = prerr_newline ()
  in
    s2exp_err (s2t0)
  end (* end of [if] *)
end // end of [s1exp_trdn]

(* ****** ****** *)

implement
s1exp_trdn_bool (s1e) = s1exp_trdn (s1e, s2rt_bool)

implement
s1explst_trdn_bool
  (s1es) = l2l (list_map_fun (s1es, s1exp_trdn_bool))
// end of [s1explst_trdn_bool]

(* ****** ****** *)

implement
s1explst_trdn_err
  (s1es, s2ts, err) =
  case+ s1es of
  | list_cons (s1e, s1es) => (
    case+ s2ts of
    | list_cons (s2t, s2ts) => let
        val s2e = s1exp_trdn (s1e, s2t)
        val s2es = s1explst_trdn_err (s1es, s2ts, err)
      in
        list_cons (s2e, s2es)
      end // end of [list_cons]
    | list_nil () => let
        val () = err := err + 1 in list_nil ()
      end // end of [list_nil]
    )
  | list_nil () => list_nil () where {
      val () = case+ s2ts of
        | list_cons _ => (err := err - 1) | list_nil () => ()
      // end of [val]
    } // end of [list_nil]
// end of [s1explst_trdn_err]

(* ****** ****** *)

implement
s1rtext_tr (s1te0) = let
(*
*)
in
//
case+ s1te0.s1rtext_node of
| S1TEsrt (s1t) => (case+ s1t.s1rt_node of
  | S1RTqid (q, id) => let
      val ans = the_s2rtenv_find_qua (q, id)
    in
      case+ ans of
      | ~Some_vt s2te => s2te
      | ~None_vt () => S2TEerr () where {
          val () = the_tran2errlst_add (T2E_s1rtext_qid (q, id))
          val () = prerr_loc_error2 (s1t.s1rt_loc)
          val () = if isdebug () then prerr (": s1rtext_tr")
          val () = prerr ": the identifier [";
          val () = ($SYN.prerr_s0rtq (q); $SYM.prerr_symbol (id))
          val () = prerr "] refers to an unrecognized sort.";
          val () = prerr_newline ()
        } // end of [None_vt]
    end (* end of [S1RTqid] *)
  | _ => S2TEsrt (s1rt_tr s1t)
  ) // end of [S1TEsrt]
| S1TEsub (id, s1te, s1ps) => let
    val s2te = s1rtext_tr s1te
    val s2t = (case+ s2te of
      | S2TEsrt s2t => s2t
      | S2TEsub (_, s2t, _) => s2t
      | S2TEerr () => s2rt_err ()
    ) : s2rt // end of [val]
    val s2v_new = s2var_make_id_srt (id, s2t)
    val (pfenv | ()) = the_s2expenv_push_nil ()
    val () = the_s2expenv_add_svar (s2v_new)
    val s2ps = s1explst_trdn_bool (s1ps)
    val () = the_s2expenv_pop_free (pfenv | (*none*))
    val s2ps = (
      case+ s2te of
      | S2TEsrt _ => s2ps
      | S2TEsub (s2v1, _, s2ps1) => begin
          list_append (s2ps, s2explst_alpha (s2v1, s2v_new, s2ps1))
        end // end of [S2TEsub]
      | S2TEerr () => s2ps
    ) : s2explst // end of [val]
  in
    S2TEsub (s2v_new, s2t, s2ps)
   end // end of [S1TEsub]
// end of [case]
end // end of [s1rtext_tr]

(* ****** ****** *)

(* end of [pats_trans2_staexp.dats] *)
