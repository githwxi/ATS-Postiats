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

staload UN = "prelude/SATS/unsafe.sats"
macdef castvwtp1 = $UN.castvwtp1
staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload ERR = "pats_error.sats"
staload INT = "pats_intinf.sats"

(* ****** ****** *)

staload "pats_basics.sats"
macdef prerr_ifdebug (x) = if (debug_flag_get () > 0) then prerr ,(x)

(* ****** ****** *)

staload LOC = "pats_location.sats"
overload + with $LOC.location_combine

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
overload = with $SYM.eq_symbol_symbol

staload SYN = "pats_syntax.sats"
typedef s0taq = $SYN.s0taq
typedef i0delst = $SYN.i0delst

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

fn prerr_error2_loc
  (loc: location): void = (
  $LOC.prerr_location loc; prerr ": error(2)"
) // end of [prerr_error2_loc]
fn prerr_interror () = prerr "INTERROR(pats_trans2_staexp)"
fn prerr_interror_loc (loc: location) = (
  $LOC.prerr_location loc; prerr ": INTERROR(pats_trans2_staexp)"
) // end of [prerr_interror_loc]

(* ****** ****** *)

(*
** HX: static special identifier
*)
datatype staspecid = SPSIDarrow | SPSIDnone

fn staspecid_of_qid
  (q: s0taq, id: symbol): staspecid = begin
//
case+ q.s0taq_node of
| $SYN.S0TAQnone () =>
    if id = $SYM.symbol_MINUSGT then SPSIDarrow () else SPSIDnone ()
  // end of [S0TAQnone]
| _ => SPSIDnone ()
//
end // end of [staspecid_of_qid]

(* ****** ****** *)

fn effvar_tr
  (efv: effvar): s2exp = let
  val sym = efv.i0de_sym
  val ans = the_s2expenv_find (efv.i0de_sym)
in
//
case+ ans of
| ~Some_vt s2i => begin case+ s2i of
  | S2ITMvar s2v => let
      val () = s2var_check_tmplev (efv.i0de_loc, s2v)
    in
      s2exp_var (s2v)
    end // end of [S2ITEMvar]
  | _ => s2exp_err (s2t_err) where {
      val s2t_err = s2rt_err ()
      val () = prerr_error2_loc (efv.i0de_loc)
      val () = prerr_ifdebug ": effvar_tr" // for debugging
      val () = prerr ": the static identifer ["
      val () = $SYM.prerr_symbol (sym)
      val () = prerr "] should refer to a variable but it does not."
      val () = prerr_newline ()
    } // end of [_]
  end // end of [Some_vt]
| ~None_vt () => s2exp_err (s2t_err) where {
    val s2t_err = s2rt_err ()
    val () = prerr_error2_loc (efv.i0de_loc)
    val () = prerr_ifdebug ": effvar_tr" // for debugging
    val () = prerr ": unrecognized static identifer ["
    val () = $SYM.prerr_symbol (sym)
    val () = prerr "]."
    val () = prerr_newline ()
  } // end of [None_vt]
end // end of [effvar_tr]

fn effvarlst_tr
  (efvs: effvarlst): s2explst = l2l (list_map_fun (efvs, effvar_tr))
// end of [effvarlst_tr]

implement
effcst_tr (efc) = begin
  case+ efc of
  | EFFCSTall () => S2EFFall ()
  | EFFCSTnil () => S2EFFnil ()
  | EFFCSTset (efs, efvs) => S2EFFset (efs, effvarlst_tr efvs)
end // end of [effcst_tr]

(* ****** ****** *)

implement
s2var_check_tmplev
  (loc, s2v) = let
  val tmplev = s2var_get_tmplev (s2v)
in
  case+ 0 of
  | _ when tmplev > 0 => let
      val tmplev0 = the_tmplev_get ()
    in
      if tmplev < tmplev0 then let
        val () = prerr_error2_loc (loc)
        val () = prerr ": the static variable ["
        val () = prerr_s2var (s2v)
        val () = prerr "] is out of scope."
        val () = prerr_newline ()
      in
        $ERR.abort ()
      end // end of [if]
    end // end of [_ when s2v_tmplev > 0]
  | _ => () // not a template variable
end // end of [s2var_tmplev_check]

(* ****** ****** *)

fn s1exp_trup_qid (
  s1e0: s1exp, q: $SYN.s0taq, id: symbol
) : s2exp = let
//
  val loc0 = s1e0.s1exp_loc
  val ans = the_s2expenv_find_qua (q, id)
//
in
//
case+ ans of
| ~Some_vt s2i => begin case+ s2i of
//
  | S2ITMcst s2cs => let
      val- list_cons (s2c, _) = s2cs // HX: [s2cs] cannot be empty
      val s2e0 = s2exp_cst (s2c)
    in
      case+ s2cst_get_srt (s2c) of
      | S2RTfun (
          list_nil (), s2t_res
        ) when s2rt_is_dat (s2t_res) =>
          s2exp_app_srt (s2t_res, s2e0, list_nil ()) // HX: automatically applied
        // S2RTfun
      | _ => s2e0 // HX: [s2c] is not a nullary constructor
    end // end of [S2ITMcst]
//
  | S2ITMe1xp e1xp => let
      val e1xp = e1xp_normalize (e1xp)
      val s1e = s1exp_make_e1xp (loc0, e1xp)
    in
      s1exp_trup (s1e)
    end // end of [S1ITMe1xp]
//
  | S2ITMvar s2v => let
      val () = s2var_check_tmplev (loc0, s2v) in s2exp_var (s2v)
    end // end of [S2ITMvar]
//
  | _ => s2exp_err (s2t_err) where {
      val s2t_err = s2rt_err ()
      val () = prerr_interror_loc (loc0)
      val () = prerr ": s1exp_trup_qid: s2i = "
      val () = prerr_s2itm (s2i)
      val () = prerr_newline ()
    } // end of [_]
  end // end of [Some_vt]
| ~None_vt () => s2exp_err (s2t_err) where {
    val s2t_err = s2rt_err ()
    val () = the_tran2errlst_add (T2E_s1exp_qid (s1e0))
    val () = prerr_error2_loc (loc0)
    val () = prerr_ifdebug ": s1exp_trup_qid"
    val () = prerr ": the static identifier ["
    val () = ($SYN.prerr_s0taq q; $SYM.prerr_symbol id)
    val () = prerr "] is unrecognized."
    val () = prerr_newline ()
  } // end of [None_vt]
//
end // end of [s1exp_trup_qid]

(* ****** ****** *)

typedef
locs1explst = @(location, s1explst)

fun s2exp_app_wind (
  s2e_fun: s2exp, s2ess_arg: List_vt (s2explst)
) : s2exp = let
//
fun loop (
  s2t: s2rt, s2e: s2exp, s2ess: List_vt (s2explst)
) : s2exp =
  case+ s2ess of
  | ~list_vt_cons (s2es, s2ess) => let
      val- S2RTfun (_, s2t) = s2t
      val s2e = s2exp_app_srt (s2t, s2e, s2es)
    in
      loop (s2t, s2e, s2ess)
    end // end of [list_cons]
  | ~list_vt_nil () => s2e
// end if [loop]
in
  loop (s2e_fun.s2exp_srt, s2e_fun, s2ess_arg)
end // end of [s2exp_app_wind]

fun s1exp_app_unwind (
  s1e: s1exp, xs: &List_vt (locs1explst)
) : s1exp = begin
  case+ s1e.s1exp_node of
  | S1Eapp (s1e, larg, s1es) => let
      val x = (larg, s1es)
      val () = xs := list_vt_cons (x, xs)
    in
      s1exp_app_unwind (s1e, xs)
    end // end of [S1Eapp]
  | S1Esqid (q, id) => begin case+ q.s0taq_node of
    | $SYN.S0TAQnone () => let
        val ans = the_s2expenv_find (id)
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
      end // end of [S0TAQnone]
    | _ => s1e
    end (* end of [S1Eqid] *)
  | _ => s1e // end of [_]
end // end of [s1exp_app_unwind]

(* ****** ****** *)

fn s1exp_trup_invar
  (refval: int, s1e: s1exp): s2exp = let
  val s2t = (
    if refval = 0 then s2rt_view (*val*) else s2rt_viewt0ype (*ref*)
  ) : s2rt // end of [val]
  val s2e: s2exp = s1exp_trdn (s1e, s2t)
in
  s2exp_refarg (refval, s2e)
end // end of [s1exp_trup_invar]

(* ****** ****** *)

implement
s1exp_trup_arg
  (s1e0, wths1es) = let
in
case+ s1e0.s1exp_node of
| S1Einvar (refval, s1e) => let
    val () = wths1es := WTHS1EXPLSTcons_some (refval, s1e, wths1es)
  in
    s1exp_trup_invar (refval, s1e)
  end // end of [S1Einvar]
| S1Etrans (s1e1, s1e2) => (
  case+ s1e1.s1exp_node of
  | S1Einvar (refval, s1e_arg) => let
      val () = wths1es := WTHS1EXPLSTcons_some (refval, s1e2, wths1es)
    in
      s1exp_trup_invar (refval, s1e_arg)
    end // end of [S1Einvar]
  | _ => s2exp_err (s2t_err) where {
      val s2t_err = s2rt_err ()
      val () = prerr_error2_loc (s1e1.s1exp_loc)
      val () = prerr_ifdebug ": s1exp_trup_arg" // for debugging
      val () = prerr ": a refval-type must begin with !(call-by-value) or &(call-by-reference)"
      val () = prerr_newline ()
    } // end of [_]
  ) // end of [S1Etrans]
| _ => let
    val () = wths1es := WTHS1EXPLSTcons_none (wths1es)
  in
    s1exp_trup (s1e0)
  end // end of [_]
end // end of [s1exp_trup_arg]

(* ****** ****** *)

implement
s1exp_trdn_res_impredicative
  (s1e0, wths1es) = let
//
  fun auxwth (
    wths1es: wths1explst
  ) : wths2explst = begin
    case+ wths1es of
    | WTHS1EXPLSTcons_some
        (refval, s1e, wths1es) => let
        val s2t = (
          if refval = 0 then s2rt_view  else s2rt_viewt0ype
        ) : s2rt // end of [val]
        val s2e = s1exp_trdn (s1e, s2t)
      in
        WTHS2EXPLSTcons_some (refval, s2e, auxwth wths1es)
      end // end of [WTHS1EXPLSTcons_some]
    | WTHS1EXPLSTcons_none (wths1es) =>
        WTHS2EXPLSTcons_none (auxwth wths1es)
    | WTHS1EXPLSTnil () => WTHS2EXPLSTnil ()
  end // endof [auxwth]
//
  fun auxres (
    s1e: s1exp, wths1es: wths1explst
  ) : s2exp =
    case+ s1e.s1exp_node of
    | S1Eexi (1(*funres*), s1qs, s1e_scope) => let
        val (pf_s2expenv | ()) = the_s2expenv_push_nil ()
        val @(s2vs, s2ps) = s1qualst_tr (s1qs)
        val s2e_scope = auxres (s1e_scope, wths1es)
        val () = the_s2expenv_pop_free (pf_s2expenv | (*none*))
      in
        s2exp_exi (s2vs, s2ps, s2e_scope)
      end // end of [S1Eexi]
    | _ => let
        val s2e = s1exp_trdn_impredicative (s1e)
        val wths2es = auxwth (wths1es)
      in
        s2exp_wth (s2e, wths2es)
      end // end of [_]
  (* end of [auxres] *)
//
in
  if wths1explst_is_none (wths1es) then
    s1exp_trdn_impredicative (s1e0) else auxres (s1e0, wths1es)
  // end of [if]
end // end of [s1exp_trdn_res_impredicative]

(* ****** ****** *)

fun
s1exp_trup_arrow ( // arrow is a special type constructor
  loc0: location
, fcopt: funcloopt
, islin: bool
, isprf: bool
, efcopt: effcstopt
, xs: List_vt (locs1explst)
) : s2exp = let
//
#define nil list_nil
#define cons list_cons
#define :: list_cons
//
fun auxerr (
  xs: List_vt (locs1explst)
) :<cloref1> void =
  case+ xs of
  | list_vt_cons _ => let
      prval () = fold@ (xs)
      val () = list_vt_free (xs)
      val () = prerr_error2_loc (loc0)
      val () = prerr_ifdebug ": s1exp_trup_arrow"
      val () = prerr ": illegal static application."
    in
      // nothing
    end // end of [~list_vt_cons]
  | ~list_vt_nil () => ()
// end of [auxerr]
//
  val- ~list_vt_cons (x, xs) = xs
  val () = auxerr (xs) // HX: reporting an error if [xs] is not nil
  val s1es = x.1 : s1explst
  val- s1e_arg :: s1e_res :: nil () = s1es
//
  var npf: int = 0
  var s1es_arg: s1explst = list_nil ()
//
  val () = case+ s1e_arg.s1exp_node of
    | S1Elist (n, s1es) => (npf := n; s1es_arg := s1es)
    | _ => s1es_arg := list_cons (s1e_arg, nil ())
  (* end of [val] *)
//
  var wths1es: wths1explst = WTHS1EXPLSTnil () // restoration
//
  val s2es_arg = let
    fun aux (
      s1es: s1explst, wths1es: &wths1explst
    ) : s2explst =
      case+ s1es of
      | list_cons (s1e, s1es) => let
          val s2e = s1exp_trup_arg (s1e, wths1es)
          val s2t = s2e.s2exp_srt
          var imp: int = 0 and types: int = 0
          val () = (case+ s2t of
            | S2RTbas s2tb => (
              case+ s2tb of
              | S2RTBASimp (id, _) => {
                  val () = imp := 1 // impredicative
                  val () = if id = $SYM.symbol_TYPES then types := 1
                } // end of [S2RTBASimp]
              | _ => () // end of [_]
              ) // end of [S2RTbas]
            | _ => () // end of [_]
          ) : void // end of [val]
          val s2e = (
            if imp > 0 then
              if types > 0 then s2exp_vararg (s2e) else s2e
            else let
              val s2t_err = s2rt_err ()
              val () = prerr_error2_loc (s1e.s1exp_loc)
              val () = prerr_ifdebug  ": s1exp_trup_arrow"
              val () = prerr ": the static expression needs to be impredicative"
              val () = prerr " but it is assigned the sort ["
              val () = prerr_s2rt (s2t)
              val () = prerr "]."
              val () = prerr_newline ()
            in
              s2exp_err (s2t_err)
            end (* end of [if] *)
          ) : s2exp // end of [val]
        in
          list_cons (s2e, aux (s1es, wths1es))
        end // end of [cons]
      | nil () => nil ()
    // end of [aux]
  in
    aux (s1es_arg, wths1es)
  end // end of [val]
  val () = wths1es := wths1explst_reverse wths1es
  val s2e_res = s1exp_trdn_res_impredicative (s1e_res, wths1es)
  val s2t_res = s2e_res.s2exp_srt
  val isprf = (if isprf then isprf else s2rt_is_prf s2t_res): bool
  val fc = (
    case+ fcopt of // default is [function]
    | Some fc => fc | None () => FUNCLOfun ()
  ) : funclo
  val s2t_fun = s2rt_prf_lin_fc (loc0, isprf, islin, fc)
  val lin = (if islin then 1 else 0): int // end of [val]
  val sf2e = (case+ efcopt of
    | Some efc => effcst_tr (efc)
    | None () =>
        if isprf then S2EFFnil () else S2EFFall ()
      // end of [None]
  ) : s2eff // end of [val]
in
  s2exp_fun_srt (s2t_fun, fc, lin, sf2e, npf, s2es_arg, s2e_res)
end // end of [s1exp_trup_arrow]

(* ****** ****** *)

fn s1exp_trup_app (
  loc_fun: location
, _fun: s2exp, _arg: List_vt (locs1explst)
) : s2exp = let
//
fun loop (
  s2e_fun: s2exp, xs: List_vt (locs1explst)
) :<cloref1> s2exp = begin
  case+ xs of
  | ~list_vt_cons (x, xs) => let
      val s2t_fun = s2e_fun.s2exp_srt
    in
      if s2rt_is_fun (s2t_fun) then let
        val- S2RTfun (s2ts_arg, s2t_res) = s2t_fun
        var err: int = 0
        val s2es_arg = s1explst_trdn_err (x.1, s2ts_arg, err)
      in
        case+ 0 of
        | _ when err = 0 => let
            val s2e_fun = s2exp_app_srt (s2t_res, s2e_fun, s2es_arg)
          in
            loop (s2e_fun, xs)
          end // end of [_ when err = 0]
        | _ => s2exp_err (s2t_res) where {
            val () = list_vt_free (xs)
//
            val loc_app = loc_fun + x.0
            val () = prerr_error2_loc (loc_app)
            val () = prerr_ifdebug ": s1exp_trup_app"
            val () = prerr ": the static application needs "
            val () = prerr_string (if err > 0 then "less" else "more")
            val () = prerr " arguments."
            val () = prerr_newline ()
//
          } // end of [_ when err != 0]
        // end of [case]
      end else let
        val () = list_vt_free (xs)
//
        val () = prerr_error2_loc (loc_fun)
        val () = prerr_ifdebug ": s1exp_trup_app"
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
  loop (_fun, _arg)
end // end of [s1exp_trup_app]

(* ****** ****** *)

fun
s1exp_trup_app_qid (
  s1e0: s1exp
, s1opr: s1exp
, q: $SYN.s0taq, id: symbol
, xs: List_vt (locs1explst)
) : s2exp = let
//
  val spsid = staspecid_of_qid (q, id) 
//
in
//
case+ spsid of
| SPSIDarrow () => s1exp_trup_arrow (
    s1e0.s1exp_loc, None(*fc*), false(*lin*), false(*prf*), None(*efc*), xs
  ) // end of [SPSIDarrow]
| SPSIDnone () => let
    val ans = the_s2expenv_find_qua (q, id)
  in
    case+ ans of
    | ~Some_vt s2i =>
        s1exp_trup_app_qid_itm (s1e0, s1opr, q, id, s2i, xs)
      // end of [Some_vt]
    | ~None_vt () => s2exp_err (s2t_err) where {
        val s2t_err = s2rt_err ()
        val () = list_vt_free (xs)
        val () = prerr_error2_loc (s1e0.s1exp_loc)
        val () = prerr_ifdebug ": s1exp_trup_app_qid"
        val () = prerr ": unrecognized static identifier ["
        val () = ($SYN.prerr_s0taq q; $SYM.prerr_symbol id)
        val () = prerr "]."
        val () = prerr_newline ()
      } // end of [None_vt]
  end // end of [SPSIDnone]
//
end // end of [s1exp_trup_app_qid]

and
s1exp_trup_app_qid_itm (
  s1e0: s1exp
, s1opr: s1exp
, q: $SYN.s0taq, id: symbol, s2i: s2itm
, xs: List_vt (locs1explst)
) : s2exp = let
  
in
//
case+ s2i of
| S2ITMcst s2cs => let
    typedef T1 = (location, s1explst) and T2 = s2explst
    val s2ess = list_map_fun<T1><T2>
      (castvwtp1 {List(T1)} xs, lam x =<1> s1explst_trup (x.1))
    val () = list_vt_free (xs)
    val s2cs = s2cst_select_s2explstlst (s2cs, castvwtp1 {List(T2)} s2ess)
  in
    case+ s2cs of
    | list_cons (s2c, _) =>
        s2exp_app_wind (s2exp_cst s2c, s2ess)
      // end of [list_cons]
    | list_nil () => s2exp_err (s2t_err) where {
        val s2t_err = s2rt_err ()
        val () = list_vt_free<T2> (s2ess)
        val () = prerr_error2_loc (s1e0.s1exp_loc)
        val () = prerr_ifdebug ": s1exp_trup_app_qid"
        val () = prerr ": none of the static constants referred to by ["
        val () = ($SYN.prerr_s0taq q; $SYM.prerr_symbol id)
        val () = prerr "] is applicable."
        val () = prerr_newline ()
      } // end of [_]
  end // end of [S2ITEMcst]
| S2ITMvar s2v => let
    val () = s2var_check_tmplev (s1opr.s1exp_loc, s2v)
  in
    s1exp_trup_app (s1e0.s1exp_loc, s2exp_var (s2v), xs)
  end // end of [S2ITEMvar]
(*
| S2ITMdatconptr d2c => s1exp_trup_app_datconptr (loc_app, d2c, s1ess)
| S2ITMdatcontyp d2c => s1exp_trup_app_datcontyp (loc_app, d2c, s1ess)
*)
| _ => s2exp_err (s2t_err) where {
    val s2t_err = s2rt_err ()
    val () = list_vt_free (xs)
    val () = prerr_interror_loc (s1opr.s1exp_loc)
    val () = prerr ": s1exp_trup_app_qid: not implemented yet: s2i = "
    val () = prerr_s2itm (s2i)
    val () = prerr_newline ()
  } // end of [_]
end // end of [s1exp_trup_app_qid_itm]

(* ****** ****** *)

implement
s1exp_trup (s1e0) = let
(*
  val () = begin
    print "s1exp_trup: s1e0 = "; print s1e0; print_newline ()
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
//
| S1Eapp _ => let
    typedef T = locs1explst
    viewtypedef VT = List_vt (T)
    var xs: VT = list_vt_nil ()
    val s1opr = s1exp_app_unwind (s1e0, xs)
  in
    case+ :(xs: VT?) => s1opr.s1exp_node of
    | S1Esqid (q, id) =>
        s1exp_trup_app_qid (s1e0, s1opr, q, id, xs)
      // end of [S1Esqid]
    | S1Eimp (fc, lin, prf, oefc) =>
        s1exp_trup_arrow (loc0, Some fc, lin>0, prf>0, oefc, xs)
      // end of [S1Eimp]
    | _ => let
        val lopr = s1opr.s1exp_loc
        val s2opr = s1exp_trup (s1opr)
      in
        s1exp_trup_app (lopr, s2opr, xs)
      end // end of [_]
  end (* end of [S1Eapp] *)
//
| _ => let
    val () = prerr_interror_loc (loc0)
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
s1explst_trup (s1es) = l2l (list_map_fun (s1es, s1exp_trup))

(* ****** ****** *)

implement
s1exp_trdn
  (s1e0, s2t0) = let
  val s2e0 = s1exp_trup (s1e0)
  val s2t0_new = s2e0.s2exp_srt
  val test = s2rt_ltmat1 (s2t0_new, s2t0)
in
  if test then s2e0 else let
    val () = prerr_error2_loc (s1e0.s1exp_loc)
    val () = prerr_ifdebug ": s1exp_tr_dn" // for debugging
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

(* ****** ****** *)

implement
s1exp_trdn_impredicative (s1e) = let
  val s2e = s1exp_trup (s1e); val s2t = s2e.s2exp_srt
in
  if s2rt_is_impredicative s2t then s2e else let
    val () = prerr_error2_loc (s1e.s1exp_loc)
    val () = prerr_ifdebug ": s1exp_trdn_impredicative"
    val () = prerr ": the static expression needs to be impredicative"
    val () = prerr " but it is assigned the sort ["
    val () = prerr_s2rt (s2t)
    val () = prerr "]."
    val () = prerr_newline ()
  in
    s2exp_err (s2t)
  end (* end of [if] *)
end // end of [s1exp_trdn_impredicative]

(* ****** ****** *)

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
s1qualst_tr (s1qs) = let
//
viewtypedef s2varlst_vt = List_vt (s2var)
viewtypedef s2explst_vt = List_vt (s2exp)
//
fun loop (
  s1qs: s1qualst
, s2vs: &s2varlst_vt
, s2ps: &s2explst_vt
) : void = let
//
fun auxsrt (
  s2t1: s2rt, ids: i0delst, s2vs: &s2varlst_vt
) : void =
  case+ ids of
  | list_cons (id, ids) => let
      val s2v = s2var_make_id_srt (id.i0de_sym, s2t1)
      val () = the_s2expenv_add_svar (s2v)
      val () = s2vs := list_vt_cons (s2v, s2vs);
    in
      auxsrt (s2t1, ids, s2vs)
    end
  | list_nil () => ()
(* end of [auxsrt] *)
//
fun auxsub1 (
  s2v1: s2var
, s2ps1: s2explst
, s2v: s2var
, s2ps: &s2explst_vt
) : void = case+ s2ps1 of
  | list_cons (s2p1, s2ps1) => let
      val s2p = s2exp_alpha (s2v1, s2v, s2p1)
      val () = s2ps := list_vt_cons (s2p, s2ps)
    in
      auxsub1 (s2v1, s2ps1, s2v, s2ps)
    end // end of [list_cons]
  | list_nil () => ()
(* end of [auxsub1] *)
//
fun auxsub2 (
  s2v1: s2var
, s2t1: s2rt
, s2ps1: s2explst
, ids: i0delst
, s2vs: &s2varlst_vt
, s2ps: &s2explst_vt
) : void = case+ ids of
  | list_cons (id, ids) => let
      val s2v =
        s2var_make_id_srt (id.i0de_sym, s2t1)
      // end of [val]
      val () = the_s2expenv_add_svar (s2v)
      val () = s2vs := list_vt_cons (s2v, s2vs)
      val () = auxsub1 (s2v1, s2ps1, s2v, s2ps)
    in
      auxsub2 (s2v1, s2t1, s2ps1, ids, s2vs, s2ps)
    end // end of [list_cons]
  | list_nil () => ()
(* end of [auxsub2] *)
//
in
//
case+ s1qs of
| list_cons (s1q, s1qs) => begin
  case+ s1q.s1qua_node of
  | S1Qprop s1p => let
      val s2p = s1exp_trdn_bool (s1p)
      val () = s2ps := list_vt_cons (s2p, s2ps)
    in
      loop (s1qs, s2vs, s2ps)
    end
  | S1Qvars (ids, s1te) => let
      val s2te = s1rtext_tr (s1te)
    in
      case+ s2te of
      | S2TEsrt s2t1 => let
          val () = auxsrt (s2t1, ids, s2vs)
        in
          loop (s1qs, s2vs, s2ps)
        end // end of [S2TEsrt]
      | S2TEsub (s2v1, s2t1, s2ps1) => let
          val () = auxsub2 (s2v1, s2t1, s2ps1, ids, s2vs, s2ps)
        in
          loop (s1qs, s2vs, s2ps)
        end (* end of [S2TEsub] *)
      | S2TEerr () => let
          val s2t1 = s2rt_err ()
          val () = auxsrt (s2t1, ids, s2vs)
        in
          loop (s1qs, s2vs, s2ps)
        end (* end of [S2TEerr] *)
      end // end of [S1Qvars]
    end // end of [list_cons]
  | list_nil () => ()
end // end of [loop]
//
var s2vs: s2varlst_vt = list_vt_nil ()
var s2ps: s2explst_vt = list_vt_nil ()
//
val () = loop (s1qs, s2vs, s2ps)
//
val s2vs = list_vt_reverse (s2vs)
val s2ps = list_vt_reverse (s2ps)
//
in // in of [let]
//
((l2l)s2vs, (l2l)s2ps)
//
end // end of [s1qualst_tr]


(* ****** ****** *)

implement
s1rtext_tr (s1te0) = let
(*
  val () = print "s1rtext_tr: s1te0 = "
  val () = fprint_s1rtext (stdout_ref, s1te0)
  val () = print_newline ()
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
//
          val () = the_tran2errlst_add (T2E_s1rtext_qid (q, id))
//
          val () = prerr_error2_loc (s1t.s1rt_loc)
          val () = prerr_ifdebug (": s1rtext_tr") // for debugging
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
