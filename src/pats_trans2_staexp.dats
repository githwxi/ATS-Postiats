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
// Start Time: May, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"
staload INT = "./pats_intinf.sats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)
//
staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
//
implement
prerr_FILENAME<>
(
// argumentless
) = prerr("pats_trans2_staexp")
//
(* ****** ****** *)
//
staload
LOC = "./pats_location.sats"
staload
LEX = "./pats_lexing.sats"
//
staload
SYM = "./pats_symbol.sats"
//
typedef token = $LEX.token
typedef symbol = $SYM.symbol
//
overload + with $LOC.location_combine
overload = with $SYM.eq_symbol_symbol
overload print with $SYM.print_symbol
overload prerr with $SYM.prerr_symbol
//
(* ****** ****** *)
//
staload
SYN = "./pats_syntax.sats"
//
typedef s0taq = $SYN.s0taq
typedef d0ynq = $SYN.d0ynq
typedef i0delst = $SYN.i0delst
//
macdef
prerr_sqid (sq, id) =
  ($SYN.prerr_s0taq ,(sq); $SYM.prerr_symbol ,(id))
// end of [prerr_sqid]
//
(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_e1xpval.sats"
staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_trans2.sats"
staload "./pats_trans2_env.sats"

(* ****** ****** *)

#include "./pats_basics.hats"

(* ****** ****** *)
//
macdef
list_sing (x) =
list_cons (,(x), list_nil)
//
#define :: list_cons
#define l2l list_of_list_vt
//
(* ****** ****** *)
//
overload fprint with fprint_s1arg
overload fprint with fprint_s1var
//
(* ****** ****** *)
//
(*
** HX: static special identifier
*)
datatype
staspecid = SPSIDarrow | SPSIDnone
//
fun
staspecid_of_sqid
(
sq: s0taq, id: symbol
) : staspecid =
(
//
case+
sq.s0taq_node
of (* case *)
| $SYN.S0TAQnone () =>
  (
    if id = $SYM.symbol_MINUSGT
      then SPSIDarrow(*void*) else SPSIDnone(*void*)
    // end of [if]
  ) // end of [S0TAQnone]
| _ (*non-S0TAQnone*) => SPSIDnone(*void*)
//
) (* end of [staspecid_of_sqid] *)
//
(* ****** ****** *)

fun
effvar_tr
  (efv: effvar): s2exp = let
//
val loc = efv.i0de_loc
val sym = efv.i0de_sym
val ans = the_s2expenv_find (sym)
//
in
//
case+ ans of
| ~Some_vt s2i => (
  case+ s2i of
  | S2ITMvar (s2v) => let
(*
      val () = s2var_check_tmplev (loc, s2v)
*)
    in
      s2exp_var (s2v)
    end // end of [S2ITEMvar]
  | S2ITMcst (s2cs) => let
      val-list_cons (s2c, _) = s2cs in s2exp_cst (s2c)
    end // end of [S2ITMcst]
  | _ => let
      val s2t_err = s2rt_err ()
      val () = prerr_error2_loc (loc)
      val () = filprerr_ifdebug "effvar_tr"
      val () = prerr! (": the static identifier [", sym)
      val () = prerrln! "] should refer to a variable or constant."
      val () = the_trans2errlst_add (T2E_effvar_tr (efv))
    in
      s2exp_s2rt_err ()
    end // end of [_]
  ) // end of [Some_vt]
| ~None_vt () => let
    val s2t_err = s2rt_err ()
    val () = prerr_error2_loc (loc)
    val () = filprerr_ifdebug ("effvar_tr")
    val () = prerrln! (": unrecognized static identifier [", sym, "].")
    val () = the_trans2errlst_add (T2E_effvar_tr (efv))
  in
    s2exp_s2rt_err ()
  end // end of [None_vt]
end // end of [effvar_tr]

fun effvarlst_tr
  (efvs: effvarlst): s2eff = (
  case+ efvs of
  | list_cons
      (efv, efvs) => let
      val s2e = effvar_tr (efv)
      val s2fe1 = s2eff_exp (s2e)
      val s2fe2 = effvarlst_tr (efvs)
    in
      s2eff_add (s2fe1, s2fe2)
    end // end of [list_cons]
  | list_nil () => s2eff_nil
) // end of [effvarlst_tr]

implement
effcst_tr (efc) = begin
  case+ efc of
  | EFFCSTall () => s2eff_all
  | EFFCSTnil () => s2eff_nil
  | EFFCSTset (efs, efvs) =>
      s2eff_add (s2eff_effset (efs), effvarlst_tr (efvs))
    // end of [EFFSTset]
end // end of [effcst_tr]

(* ****** ****** *)

implement
s1arg_trup(s1a) = let
//
val s2t =
(
case+
s1a.s1arg_srt
of // case+
| Some (s1t) => s1rt_tr(s1t)
| None ((*void*)) =>
    S2RTVar(s2rtVar_make(s1a.s1arg_loc))
  // end of [None]
) : s2rt // end of [val]
//
in
  s2var_make_id_srt(s1a.s1arg_sym, s2t)
end // end of [s1arg_trup]

implement
s1arglst_trup
  (s1as) = l2l(list_map_fun(s1as, s1arg_trup))
// end of [s1arglst_trup]

(* ****** ****** *)

implement
s1arg_trdn
  (s1a, s2t0) = let
//
(*
val () =
fprintln!
  (stdout_ref, "s1a = ", s1a)
val () =
fprintln!
  (stdout_ref, "s2t0 = ", s2t0)
*)
//
fun
auxerr
(
s1a: s1arg, s2t: s2rt, s2t0: s2rt
) : void = let
//
val () =
prerr_error2_loc(s1a.s1arg_loc)
//
val () =
filprerr_ifdebug ("s1arg_trdn")
//
val () =
prerr!(": the argument is assigned the sort [", s2t)
val () =
prerrln!
("] but it is expected to accept a static term of the sort [", s2t0, "].")
//
in
  the_trans2errlst_add (T2E_s1arg_trdn (s1a, s2t0))
end (* end of [auxerr] *)
//
in
case+
s1a.s1arg_srt
of (* case *)
| None() =>
    s2var_make_id_srt(s1a.s1arg_sym, s2t0)
  // end of [None]
| Some(s1t) => let
    val s2t = s1rt_tr(s1t)
    val okay = s2rt_ltmat1(s2t0, s2t)
    val () = if ~okay then auxerr (s1a, s2t, s2t0)
  in
    s2var_make_id_srt(s1a.s1arg_sym, s2t0) // HX: yes, [s2t0] should be used!
  end // end of [Some]
//
end (* end of [s1arg_trdn] *)

implement
s1arglst_trdn_err
  (s1as, s2ts, serr) = let
(*
//
val () = (
  println! ("s1arglst_trdn_err: serr", serr)
) (* end of [val] *)
//
*)
in
//
case+ (s1as, s2ts) of
| (s1a :: s1as, s2t :: s2ts) => let
    val s2v = s1arg_trdn (s1a, s2t)
    val s2vs = s1arglst_trdn_err (s1as, s2ts, serr)
  in
    list_cons (s2v, s2vs)
  end // end of [::, ::]
| (list_nil _, list_nil _) => list_nil
| (list_cons _, list_nil _) => (serr := serr + 1; list_nil)
| (list_nil _, list_cons _) => (serr := serr - 1; list_nil)
//
end // end of [s1arglst_trdn_err]

implement
s1marg_trdn
  (s1ma, s2ts) = let
//
fun auxerr
(
  s1ma: s1marg, s2ts: s2rtlst, serr: int
) : void = let
  val
  loc0 = s1ma.s1marg_loc
  val () = prerr_error2_loc (loc0)
  val () = filprerr_ifdebug "s1marg_trdn"
  val () =
    prerr ": the static argument group is expected to contain "
  val () =
    prerr_string (if serr > 0 then "more" else "fewer")
  val () = prerrln! " components."
in
  the_trans2errlst_add (T2E_s1marg_trdn (s1ma, s2ts))
end // end of [auxerr]
//
var serr: int = 0
val s2vs =
  s1arglst_trdn_err (s1ma.s1marg_arg, s2ts, serr)
// end of [val]
val () = if serr != 0 then auxerr (s1ma, s2ts, serr)
//
in
  s2vs
end // end of [s1marg_trdn]

(* ****** ****** *)

local

fun sp1at_get_dups
  (s2vs: s2varlst): s2varlst = let
//
typedef s2varset = $UT.lstord (s2var)
//
fun f (
  svs: s2varset, s2v: s2var
) : s2varset =
  $UT.lstord_insert (svs, s2v, compare_s2vsym_s2vsym)
// end of [f]
//
val svs = 
  list_fold_left_fun<s2varset><s2var> (f, $UT.lstord_nil (), s2vs)
// end of [val]
//
in
  $UT.lstord_get_dups (svs, compare_s2vsym_s2vsym)
end // end of [sp1at_get_dups]

fun sp1at_trdn_arg
(
  sp1t: sp1at
, s2t_pat: s2rt
, sq: s0taq, id: symbol
, s1as: s1arglst, s2ts: s2rtlst
) : s2varlst = let
//
fun auxerr
(
  sp1t: sp1at, serr: int
) :<cloref1> void = let
  val
  loc0 = sp1t.sp1at_loc
  val () =
    prerr_error2_loc (loc0)
  val () =
    prerr ": the static constructor ["
  val () = prerr_sqid (sq, id)
  val () = prerr "] requires "
  val () =
    prerr_string (if serr > 0 then "more" else "fewer")
  val () = prerrln! " arguments."
in
  the_trans2errlst_add (T2E_sp1at_trdn (sp1t, s2t_pat))
end // end of [auxerr]
//
var serr: int = 0
val s2vs =
  s1arglst_trdn_err (s1as, s2ts, serr)
// end of [val]
val () = if serr != 0 then auxerr (sp1t, serr)
//
in
  s2vs
end // end of [sp2at_trdn_arg]

in (* in of [local] *)

implement
sp1at_trdn
  (sp1t, s2t_pat) = let
//
val loc0 = sp1t.sp1at_loc
//
fun auxerr1
(
  sq: s0taq, id: symbol
) :<cloref1> void = let
//
val () =
  prerr_error2_loc (loc0)
val () =
  filprerr_ifdebug ("sp1at_trdn")
val () =
  prerr ": the static identifier ["
val () = prerr_sqid (sq, id)
val () =
  prerrln! ("] does not refer to a static constructor associated with the sort [", s2t_pat, "].")
//
in
  the_trans2errlst_add (T2E_sp1at_trdn (sp1t, s2t_pat))
end // end of [auxerr1]
//
fun auxerr2
(
  sq: s0taq, id: symbol
) :<cloref1> void = let
//
val () =
  prerr_error2_loc (loc0)
val () =
  filprerr_ifdebug ("sp1at_trdn")
val () =
  prerr ": the static identifier ["
val () = prerr_sqid (sq, id)
val () =
  prerrln! "] does not refer to a static constructor."
//
in
  the_trans2errlst_add(T2E_sp1at_trdn(sp1t, s2t_pat))
end // end of [auxerr2]
//
fun auxerr3
(
  sq: s0taq, id: symbol
) :<cloref1> void = let
//
val () =
  prerr_error2_loc (loc0)
val () =
  filprerr_ifdebug ("sp1at_trdn")
val () =
  prerr ": the static identifier ["
val () = prerr_sqid (sq, id)
val () = prerrln! "] is unrecognized."
//
in
  the_trans2errlst_add(T2E_sp1at_trdn(sp1t, s2t_pat))
end // end of [auxerr3]
//
fun auxcheck
(
  sp1t: sp1at, s2vs: s2varlst
) :<cloref1> void = let
//
  fun procrepeat
  (
    sp1t: sp1at, sym: symbol
  ) : void =
  (
    case+ sp1t.sp1at_node of
    | SP1Tcstr (_(*sq*), _(*id*), s1as) => procrepeat2 (s1as, sym)
  )
  and procrepeat2
  (
    s1as: s1arglst, sym: symbol
  ) : void =
  (
    case+ s1as of
    | list_cons
        (s1a, s1as) => let
        val () = if
          s1a.s1arg_sym = sym then (
          $LOC.prerr_location (s1a.s1arg_loc); prerr_newline ()
        ) // end of [val]
      in
        procrepeat2 (s1as, sym)
      end // end of [list_cons]
    | list_nil () => ()
  ) // end of [procrepeat2]
//
  val s2vs_dups = sp1at_get_dups (s2vs)
//
in
//
case+
s2vs_dups
of // case+
//
| list_nil() => ()
//
| list_cons
    (s2v, _) => {
    val
    sym = s2var_get_sym (s2v)
    val () = prerr_error2_loc (loc0)
    val () = prerr! (": the static variable [", sym)
    val () = prerrln! "] is not allowed to occur repeatedly in a pattern:"
    val () = procrepeat (sp1t, sym)
    val () = the_trans2errlst_add (T2E_sp1at_trdn (sp1t, s2t_pat))
  } (* end of [list_cons] *)
//
end (* end of [auxcheck] *)
//
fun auxselect
(
  s2cs: s2cstlst
, s2t_pat: s2rt, s2ts_arg: &s2rtlst
) : s2cstlst = let
in
//
case+ s2cs of
| list_cons
    (s2c, s2cs1) => let
    val s2t_s2c = s2cst_get_srt (s2c)
  in
    case+ s2t_s2c of
    | S2RTfun
        (s2ts, s2t) => let
        val test = s2rt_ltmat1 (s2t_pat, s2t)
      in
        if test then let
          val () = s2ts_arg := s2ts in s2cs
        end else
          auxselect (s2cs1, s2t_pat, s2ts_arg)
        // end of [if]
      end // end of [S2RTfun]
    | _ => auxselect (s2cs1, s2t_pat, s2ts_arg)
   end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxselect]
//
in
//
case+ sp1t.sp1at_node of
| SP1Tcstr
    (sq, id, s1as) => let
    val ans = the_s2expenv_find_qua (sq, id)
  in
    case+ ans of
    | ~Some_vt s2i => begin
      case+ s2i of
      | S2ITMcst (s2cs) => let
          var s2ts_arg: s2rtlst = list_nil ()
          val s2cs = auxselect (s2cs, s2t_pat, s2ts_arg)
        in
          case+ s2cs of
          | list_cons (s2c, _) => let
              val s2vs = sp1at_trdn_arg
                (sp1t, s2t_pat, sq, id, s1as, s2ts_arg)
              // HX: checking for repeated occurrences
              val () = auxcheck (sp1t, s2vs)
            in
              sp2at_con (loc0, s2c, s2vs)
            end // end of [list_cons]
          | list_nil () => let
              // HX: [sqid] is not applicable
              val () = auxerr1 (sq, id) in sp2at_err (loc0)
            end // end of [list_nil]
        end // end of [S2ITMcst]
      | _ => let
          // HX: [sqid] does not refer to a static constructor
          val () = auxerr2 (sq, id) in sp2at_err (loc0)
        end (* end of [_] *)
      end // end of [Some_vt]
    | ~None_vt () => let
        // HX: [sqid] is unrecognized
        val () = auxerr3 (sq, id) in sp2at_err (loc0)
      end // end of [None_vt]
  end // end of [SP1Tcstr]
//
end // end of [sp1at_trdn]

end // end of [local]

(* ****** ****** *)

fun s1exp_trup_sqid
(
  s1e0: s1exp, sq: s0taq, id: symbol
) : s2exp = let
//
  val loc0 = s1e0.s1exp_loc
  val ans = the_s2expenv_find_qua (sq, id)
//
in
//
case+ ans of
//
| ~Some_vt s2i0 => begin
  case+ s2i0 of
//
  | S2ITMcst s2cs => let
      val-list_cons (s2c, _) = s2cs // HX: [s2cs] cannot be empty
//
      fun loop (
        s2cs: s2cstlst, s2c0: s2cst
      ) : s2cst = // find the first non-functional one if it exists
        case+ s2cs of
        | list_cons (s2c, s2cs) => let
            val s2t = s2cst_get_srt (s2c) in
            if s2rt_is_fun (s2t) then loop (s2cs, s2c0) else s2c
          end // end of [list_cons]
        | list_nil () => s2c0 // end of [list_nil]
      val s2c = loop (s2cs, s2c)
//
      val s2e0 = s2exp_cst (s2c)
//
    in
      case+ s2cst_get_srt (s2c) of
      | S2RTfun (
          list_nil (), s2t_res
        ) when s2rt_is_dat (s2t_res) =>
          s2exp_app_srt (s2t_res, s2e0, list_nil ()) // HX: automatically applied
        // S2RTfun
      | _ (*non-S2RTfun*) => s2e0 // HX: [s2c] is not a nullary constructor
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
(*
      val () = s2var_check_tmplev (loc0, s2v)
*)
    in
      s2exp_var (s2v)
    end // end of [S2ITMvar]
//
  | _ => let
      val () =
        prerr_interror_loc (loc0)
      val () =
        prerrln! (": s1exp_trup_sqid: s1e0 = ", s1e0)
      val () =
        prerrln! (": s1exp_trup_sqid: s2i0 = ", s2i0)
    in
      $ERR.abort_interr{s2exp}((*void*))
    end (* end of [_] *)
  end // end of [Some_vt]
//
| ~None_vt () => let
    val () =
      prerr_error2_loc (loc0)
    val () =
      filprerr_ifdebug "s1exp_trup_sqid"
    val () = prerr ": the static identifier ["
    val () = prerr_sqid (sq, id)
    val () = prerrln! "] is unrecognized."
    val () = the_trans2errlst_add (T2E_s1exp_trup (s1e0))
  in
    s2exp_s2rt_err ()
  end // end of [None_vt]
//
end // end of [s1exp_trup_sqid]

(* ****** ****** *)

fun
s2exp_app_wind
(
  s1e0: s1exp
, s2e_fun: s2exp, s2ess_arg: List_vt (locs2explst)
) : s2exp = let
(*
//
val () = (
  println! ("s2exp_app_wind: aux: s1e0 = ", s1e0)
) (* end of [val] *)
//
*)
fun aux (
  s1e0: s1exp, x: locs2exp, s2t: s2rt
) : s2exp = let
  val s2e = x.1
(*
//
val () = (
  println! ("s2exp_app_wind: aux: s2e = ", s2e)
) (* end of [val] *)
//
*)
val test = s2rt_ltmat1 (s2e.s2exp_srt, s2t)
//
in
//
if test
  then s2e
  else let
    val () = prerr_error2_loc (x.0)
    val () = filprerr_ifdebug "s1exp_app_wind"
    val () = prerr ": the static expression is of the sort ["
    val () = prerr_s2rt (s2e.s2exp_srt)
    val () = prerrln! ("] but it is expected to be of the sort [", s2t, "].")
    val () = the_trans2errlst_add (T2E_s1exp_trup (s1e0))
  in
    s2exp_errexp(s2t)
  end // end of [else]
//
end // end of [s2exp_app_wind]
//
fun auxlst (
  s1e0: s1exp, xs: locs2explst, s2ts: s2rtlst
) : s2explst = let
in
//
case+ xs of
| list_cons (x, xs) => (
  case+ s2ts of
  | list_cons (s2t, s2ts) => let
      val s2e = aux (s1e0, x, s2t)
    in
      list_cons (s2e, auxlst (s1e0, xs, s2ts))
    end
  | list_nil () => let
      val () = prerr_error2_loc (x.0)
      val () = filprerr_ifdebug "s1exp_app_wind"
      val (
      ) = prerrln! (
        ": arity mismatch: the static argument is discarded."
      ) (* end of [val] *)
      val () = the_trans2errlst_add (T2E_s1exp_trup (s1e0))
    in
      auxlst (s1e0, xs, s2ts)
    end // end of [list_nil]
  ) (* end of [list_cons] *)
| list_nil ((*void*)) => (
  case+ s2ts of
  | list_cons
      (s2t, s2ts) => let
      val () = prerr_error2_loc (s1e0.s1exp_loc)
      val () = filprerr_ifdebug "s1exp_app_wind"
      val (
      ) = prerrln! (
        ": arity mismatch: more static arguments are needed."
      ) (* end of [val] *)
      val () = the_trans2errlst_add(T2E_s1exp_trup(s1e0))
      val s2e = s2exp_errexp(s2t) // HX: a placeholder for continuing
    in
      list_cons (s2e, auxlst (s1e0, xs, s2ts))
    end // end of [list_cons]
  | list_nil () => list_nil ()
  ) (* end of [list_nil] *)
//
end // end of [auxlst]
//
fun loop (
  s1e0: s1exp
, s2t: s2rt
, xss: List_vt (locs2explst)
, s2e: s2exp
) : s2exp = let
in
//
case+ xss of
| ~list_vt_cons
    (xs, xss) => (
    if s2rt_is_fun(s2t)
      then let
        val-S2RTfun (s2ts, s2t) = s2t
        var err: int = 0
        val s2es = auxlst (s1e0, xs, s2ts)
        val s2e = s2exp_app_srt (s2t, s2e, s2es)
      in
        loop (s1e0, s2t, xss, s2e)
      end // end of [then]
      else let
        val () = list_vt_free (xss)
        val () = prerr_error2_loc (s1e0.s1exp_loc)
        val () = filprerr_ifdebug "s1exp_app_wind"
        val () = prerrln! ": the static term is overly applied."
        val () = the_trans2errlst_add (T2E_s1exp_trup (s1e0))
      in
        s2exp_errexp(s2t)
      end // end of [else]
    // end of [if]
  ) // end of [list_cons]
| ~list_vt_nil () => s2e
//
end (* end if [loop] *)
//
in
  loop (s1e0, s2e_fun.s2exp_srt, s2ess_arg, s2e_fun)
end // end of [s2exp_app_wind]

(* ****** ****** *)

typedef
locs1explst = @(location, s1explst)

(* ****** ****** *)

fun s1exp_app_unwind
(
  s1e0: s1exp, xs: &List_vt (locs1explst)
) : s1exp = let
in
//
case+ s1e0.s1exp_node of
| S1Eapp (
    s1e, larg, s1es
  ) => let
    val x = (larg, s1es)
    val () = xs := list_vt_cons (x, xs)
  in
    s1exp_app_unwind (s1e, xs)
  end // end of [S1Eapp]
| S1Eide (id) => let
    val ans = the_s2expenv_find (id)
  in
    case+ ans of
    | ~Some_vt s2i => (
      case+ s2i of
      | S2ITMe1xp e0 => s1exp_app_unwind_e1xp (s1e0, e0, xs) | _ => s1e0
      ) // end of [Some_vt]
    | ~None_vt () => s1e0
  end (* end of [S1Eide] *)
| _ => s1e0 // end of [_]
//
end // end of [s1exp_app_unwind]

and s1exp_app_unwind_e1xp
(
  s1e0: s1exp, e0: e1xp, xs: &List_vt (locs1explst)
) : s1exp = let
  val loc0 = s1e0.s1exp_loc
  val nxs = list_vt_length<locs1explst> (xs)
in
//
case+ e0.e1xp_node of
| E1XPfun _
  when nxs > 0 => let
    val+~list_vt_cons (x, xs1) = xs
    val () = xs := xs1
//
  prval pfu = unit_v()
//
    val es =
      list_map_vclo<s1exp>{unit_v}(pfu | x.1, !p_clo) where
    {
      var !p_clo =
        @lam (pf: !unit_v | s1e: s1exp): e1xp => e1xp_make_s1exp (loc0, s1e)
      // end of [var]
    } // end of [where] // end of [val]
//
  prval unit_v () = pfu
//
    val es = l2l(es)
    val e0 = e1xp_app(loc0, e0, loc0, es)
    val e1 = e1xp_normalize(e0)
    val s1e1 = s1exp_make_e1xp( loc0, e1 )
  in
    s1exp_app_unwind( s1e1, xs )
  end // end of [E1XPfun]
| _ (* non-E1XPfun *) => let
    val e1 = e1xp_normalize(e0)
    val s1e1 = s1exp_make_e1xp(loc0, e1)
  in
    s1exp_app_unwind( s1e1, xs )
  end // end of [_]
//
end // end of [s1exp_app_unwind_e1xp]

(* ****** ****** *)

fun
s1exp_trup_invar
(
  refval: int, s1e: s1exp
) : s2exp = let
  val s2t = (
    if refval = 0 then s2rt_view (*val*) else s2rt_vt0ype (*ref*)
  ) : s2rt // end of [val]
  val s2e: s2exp = s1exp_trdn (s1e, s2t)
in
  s2exp_refarg (refval, s2e)
end // end of [s1exp_trup_invar]

(* ****** ****** *)

(*
** HX-2012-05-24:
** for synthesizing the second arg of S1Etrans:
** T  >> _   stands for T >> T
** T  >> _?  stands for T >> T?
** T  >> _?! stands for T >> T?!
** T? >> _   stands for T? >> T
*)
fun
s1exp_is_underscore
  (s1e: s1exp): bool = let
in
  case+ s1e.s1exp_node of
  | S1Eide (sym) =>
      if sym = $SYM.symbol_UNDERSCORE then true else false
  | _ => false // end of [_]
end // end of [s1exp_is_underscore]

fun
s1exp_test_top_underscore
  (s1e: s1exp): int = let
in
  case+ s1e.s1exp_node of
  | S1Etop (knd, s1e) =>
      if s1exp_is_underscore (s1e) then knd else ~1
  | _ => ~1
end // end of [s1exp_is_top_underscore]

fun s1exp_untop_if
  (s1e: s1exp): s1exp =
(
  case+ s1e.s1exp_node of S1Etop (knd, s1e) => s1e | _ => s1e
) // end of [s1exp_untop_if]

fun s1exp_trans_syn_arg2
(
  s1e1: s1exp, s1e2: s1exp
) : s1exp = let
  val isUS = s1exp_is_underscore (s1e2)
in
  if isUS then let
    val s1e = s1exp_untop_if (s1e1) in s1e
  end else let
    val knd = s1exp_test_top_underscore (s1e2)
  in
    if knd >= 0 then let
      val s1e = s1exp_untop_if (s1e1)
    in
      s1exp_top (s1e.s1exp_loc, knd, s1e)
    end else s1e2 // end of [if]
  end // end of [if]
end // end of [s1exp_trans_syn_arg2]

(* ****** ****** *)

implement
s1exp_trup_arg
  (s1e0, ws1es) = let
(*
//
val () = (
  println! ("s1exp_trup_arg: s1e0 = ", s1e0)
) (* end of [val] *)
//
*)
in
//
case+
  s1e0.s1exp_node of
| S1Einvar (refval, s1e) => let
    val () = ws1es :=
      WTHS1EXPLSTcons_some (0(*invar*), refval, s1e, ws1es)
    // end of [val]
  in
    s1exp_trup_invar (refval, s1e)
  end // end of [S1Einvar]
| S1Etrans (s1e1, s1e2) => (
  case+ s1e1.s1exp_node of
  | S1Einvar (refval, s1e_arg) => let
      val s1e2 = s1exp_trans_syn_arg2 (s1e_arg, s1e2)
      val () = ws1es :=
        WTHS1EXPLSTcons_some (1(*trans*), refval, s1e2, ws1es)
      // end of [val]
    in
      s1exp_trup_invar (refval, s1e_arg)
    end // end of [S1Einvar]
  | _ => let
      val () = prerr_error2_loc (s1e1.s1exp_loc)
      val () = filprerr_ifdebug "s1exp_trup_arg" // for debugging
      val () = prerrln! ": a refval-type must begin with !(call-by-value) or &(call-by-reference)"
      val () = the_trans2errlst_add (T2E_s1exp_trup (s1e0))
    in
      s2exp_s2rt_err ()
    end // end of [_]
  ) // end of [S1Etrans]
| _ => let
    val () = ws1es := WTHS1EXPLSTcons_none (ws1es)
  in
    s1exp_trup (s1e0)
  end // end of [_]
//
end // end of [s1exp_trup_arg]

(* ****** ****** *)

implement
s1exp_trdn_res_impred
  (s1e0, ws1es) = let
//
fun auxwth
(
  ws1es: wths1explst
) : wths2explst = let
in
//
case+ ws1es of
| WTHS1EXPLSTcons_some
    (knd, refval, s1e, ws1es) => let
    val s2t =
    (
      if refval = 0 then s2rt_view else s2rt_vt0ype
    ) : s2rt // end of [val]
    val s2e = s1exp_trdn (s1e, s2t)
    val ws2es = auxwth (ws1es)
//
// HX-2012-05:
// hnfizing needed for removing READ, WRITE, etc.
//
    val s2e = s2exp_hnfize (s2e)
    val isinv =
    (
      if knd = 0 then s2exp_is_nonvar (s2e) else false
    ) : bool // end of [val]
//
  in
    if isinv then
      WTHS2EXPLSTcons_invar (refval, s2e, ws2es)
    else
      WTHS2EXPLSTcons_trans (refval, s2e, ws2es)
    // end of [if]
  end // end of [WTHS1EXPLSTcons_invar]
| WTHS1EXPLSTcons_none (ws1es) => let
    val ws2es = auxwth (ws1es) in WTHS2EXPLSTcons_none (ws2es)
  end // end of [WTHS1EXPLSTcons_none]
| WTHS1EXPLSTnil () => WTHS2EXPLSTnil ()
//
end // endof [auxwth]
//
fun auxres
(
  s1e: s1exp, ws1es: wths1explst
) : s2exp = let
in
//
case+
  s1e.s1exp_node of
| S1Eexi
  (
    1(*funres*), s1qs, s1e_scope
  ) => let
    val (pf_s2expenv | ()) = the_s2expenv_push_nil ()
    val s2q = s1qualst_tr (s1qs)
    val s2e_scope = auxres (s1e_scope, ws1es)
    val () = the_s2expenv_pop_free (pf_s2expenv | (*none*))
  in
    s2exp_exi (s2q.s2qua_svs, s2q.s2qua_sps, s2e_scope)
  end // end of [S1Eexi]
| _ => let
    val s2e = s1exp_trdn_impred (s1e)
    val ws2es = auxwth (ws1es) in s2exp_wthtype (s2e, ws2es)
  end // end of [_]
//
end // end of [auxres]
//
in
//
if wths1explst_is_none (ws1es)
  then s1exp_trdn_impred (s1e0) else auxres (s1e0, ws1es)
// end of [if]
//
end // end of [s1exp_trdn_res_impred]

(* ****** ****** *)

fun
s1exp_trup_arrow // arrow is a special type constructor
(
  s1e0: s1exp
, fcopt: fcopt
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
fun auxerr1
(
  s1e0: s1exp, xs: !List_vt (locs1explst)
) : void = case+ xs of
  | list_vt_cons _ => fold@ (xs)
  | list_vt_nil () => {
      prval () = fold@ (xs)
      val () = prerr_error2_loc (s1e0.s1exp_loc)
      val () = filprerr_ifdebug "s1exp_trup_arrow"
      val () = prerrln! ": illegal static application."
      val () = the_trans2errlst_add (T2E_s1exp_trup (s1e0))
    } // end of [list_vt_nil]
// end of [auxerr1]
fun auxerr2
(
  s1e0: s1exp
, xs: List_vt (locs1explst)
) : void = let
in
//
case+ xs of
  | list_vt_cons _ => let
//
    prval () = fold@(xs)
//
      val () = list_vt_free(xs)
      val () = prerr_error2_loc(s1e0.s1exp_loc)
      val () = filprerr_ifdebug "s1exp_trup_arrow"
      val () = prerrln! ": illegal static application."
      val () = the_trans2errlst_add(T2E_s1exp_trup(s1e0))
    in
      // nothing
    end // end of [list_vt_cons]
  | ~list_vt_nil((*void*)) => ()
//
end // end of [auxerr2]
//
fun auxerr3
(
  s1e0: s1exp, s1e: s1exp, s2t: s2rt
) : s2exp = let
  val () =
    prerr_error2_loc(s1e.s1exp_loc)
  val () =
    filprerr_ifdebug "s1exp_trup_arrow"
  val () =
    prerr ": the static expression needs to be impredicative"
  val () =
    prerrln!(" but is assigned the sort [", s2t, "].")
  val () = the_trans2errlst_add(T2E_s1exp_trup (s1e0))
in
  s2exp_s2rt_err((*void*))
end (* end of [auxerr3] *)
//
val () = auxerr1(s1e0, xs) // HX: is this really needed?
val-~list_vt_cons(x, xs) = xs
val () = auxerr2(s1e0, xs) // HX: reporting an error if [xs] is not nil
val s1es = (x.1 : s1explst)
val-s1e_arg :: s1e_res :: nil () = s1es
//
var npf: int = ~1 // HX: default
var s1es_arg: s1explst = list_nil ()
//
val () = (
  case+
  s1e_arg.s1exp_node
  of (* case+ *)
  | S1Elist(n, s1es) =>(npf := n; s1es_arg := s1es)
  | _(*non-S1Elist*) => s1es_arg := list_sing(s1e_arg) // HX: npf = -1
) : void // end of [val]
//
var ws1es: wths1explst = WTHS1EXPLSTnil()
//
val s2es_arg = let
  fun aux
  (
    s1es: s1explst, ws1es: &wths1explst
  ) :<cloref1> s2explst =
    case+ s1es of
    | list_nil() => list_nil()
    | list_cons
        (s1e, s1es) => let
        val s2e = s1exp_trup_arg(s1e, ws1es)
        val s2t = s2e.s2exp_srt
        var imp: int = 0 and types: int = 0
        val () = (
          case+ s2t of
          | S2RTbas s2tb =>
            (
            case+ s2tb of
            | S2RTBASimp(_, name) =>
              {
                val () = imp := 1 // impredicative
                val () =
                if name =
                   $SYM.symbol_TYPES then types := 1
                // end of [if]
              } // end of [S2RTBASimp]
            | _ => () // end of [_]
            ) // end of [S2RTbas]
          | _ (*non-S2RTbas*) => ()
        ) : void // end of [val]
        val s2e = (
          if imp > 0 then
            (if types > 0 then s2exp_vararg(s2e) else s2e)
          else auxerr3 (s1e0, s1e, s2t)
        ) : s2exp // end of [val]
      in
        list_cons(s2e, aux(s1es, ws1es))
      end // end of [list_cons]
  // end of [aux]
in
  aux(s1es_arg, ws1es)
end // end of [val]
//
val () =
(
  ws1es :=
  wths1explst_reverse(ws1es)
)
val s2e_res =
  s1exp_trdn_res_impred(s1e_res, ws1es)
val s2t_res = s2e_res.s2exp_srt
//
val loc0 = s1e0.s1exp_loc
//
val isprf =
(if isprf
   then isprf else s2rt_is_prf(s2t_res)): bool
//
val fc = (
  case+ fcopt of
  | Some fc => fc
  | None () => FUNCLOfun() // default is [function]
) : funclo // end of [val]
val s2t_fun =
  s2rt_prf_lin_fc(loc0, isprf, islin, fc)
val lin = (if islin then 1 else 0): int // end of [val]
val sf2e =
(
  case+ efcopt of
  | Some(efc) => effcst_tr(efc)
  | None((*void*)) => if isprf then s2eff_nil else s2eff_all
) : s2eff // end of [val]
//
in
  s2exp_fun_srt(s2t_fun, fc, lin, sf2e, npf, s2es_arg, s2e_res)
end // end of [s1exp_trup_arrow]

(* ****** ****** *)

fun
s1exp_trup_app
(
  s1e0: s1exp, s1opr: s1exp
, _fun: s2exp, _arg: List_vt(locs1explst)
) : s2exp = let
//
fun auxerr1
(
  s1e0: s1exp, loc: location, serr: int
) : void = {
  val () =
    prerr_error2_loc (loc)
  val () =
    filprerr_ifdebug "s1exp_trup_app"
  val () =
    prerr ": the static application needs "
  val () =
    prerr_string (if serr > 0 then "more" else "fewer")
  val () = prerrln! " arguments."
  val () = the_trans2errlst_add (T2E_s1exp_trup (s1e0))
} (* end of [auxerr1] *)
//
fun auxerr2
(
  s1e0: s1exp, loc: location, s2e: s2exp
) : void = {
  val () =
    prerr_error2_loc (loc)
  val () =
    filprerr_ifdebug "s1exp_trup_app"
  val () =
    prerr! (": the static expression [", s2e)
  val () =
    prerrln! ("] is expected to be of a functional sort but it is assigned the sort [", s2e.s2exp_srt, "].")
  val () = the_trans2errlst_add (T2E_s1exp_trup_app (s1e0))
} (* end of [auxerr2] *)
//
fun
loop (
  s1e0: s1exp, loc: location
, s2e_fun: s2exp, xs: List_vt (locs1explst)
) : s2exp = begin
  case+ xs of
  | ~list_vt_cons (x, xs) => let
      val s2t_fun = s2e_fun.s2exp_srt
    in
      if s2rt_is_fun(s2t_fun) then let
        val-S2RTfun(s2ts_arg, s2t_res) = s2t_fun
        var serr:int = 0
        val s2es_arg = s1explst_trdn_err(x.1, s2ts_arg, serr)
      in
        case+ 0 of
        | _ when serr = 0 => let
            val s2e_fun = s2exp_app_srt(s2t_res, s2e_fun, s2es_arg)
          in
            loop (s1e0, loc, s2e_fun, xs)
          end // end of [_ when serr = 0]
        | _ => let
            val () = list_vt_free (xs)
            val () =
              auxerr1(s1e0, loc + x.0, serr) in s2exp_errexp(s2t_res)
          end // end of [_ when err != 0]
        // end of [case]
      end else let
        val () = list_vt_free (xs)
        val () = auxerr2 (s1e0, loc, s2e_fun) in s2exp_errexp(s2t_fun)
      end // end of [if]
    end (* end of [list_cons] *)
  | ~list_vt_nil _ => s2e_fun
end // end of [loop]
//
in
  loop (s1e0, s1opr.s1exp_loc, _fun, _arg)
end // end of [s1exp_trup_app]

(* ****** ****** *)

fun s1exp_trup_app_datcontyp
(
  s1e0: s1exp
, s1opr: s1exp
, d2c: d2con, xs: List_vt (locs1explst)
) : s2exp = let
//
fun auxck1 (
  s1e0: s1exp
, d2c: d2con, xs: List_vt (locs1explst)
) : int(*nerr*) = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val () = prerr_error2_loc (x.0)
    val () = prerrln! ": overly supplied static argument group."
  in
    auxck1 (s1e0, d2c, xs) + 1
  end // end of [list_vt_cons]
| ~list_vt_nil () => (0)
//
end // end of [auxck1]
//
fun auxck2 (
  s1e0: s1exp
, d2c: d2con, s1es: s1explst
) : void = let
  val n = list_length (s1es)
  val arity = d2con_get_arity_full (d2c)
  val sgn = n - arity
in
//
if sgn != 0 then let
  val loc0 = s1e0.s1exp_loc
  val () = prerr_error2_loc (loc0)
  val () = prerr ": the type constructor ["
  val () = prerr_d2con (d2c)
  val () = if sgn < 0 then prerr "] expects more arguments.";
  val () = if sgn > 0 then prerr "] expects fewer arguments.";
  val () = prerr_newline ((*void*))
in
  the_trans2errlst_add (T2E_s1exp_trup (s1e0))
end // end of [if]
//
end // end of [auxck2]
//
val s1es =
(
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val nerr = auxck1 (s1e0, d2c, xs)
    val () = (
      if nerr > 0 then
        the_trans2errlst_add (T2E_s1exp_trup (s1e0))
      // end of [if]
    ) // end of [val]
  in
    x.1
  end // end of [list_vt_cons]
| ~list_vt_nil () => list_nil ()
) : s1explst // end of [val]
//
val () = auxck2 (s1e0, d2c, s1es)
val s2es = s1explst_trdn_impred (s1es)
//
in
  s2exp_datcontyp (d2c, s2es)
end // end of [s1exp_trup_app_datcontyp]

(* ****** ****** *)

fun s1exp_trup_app_datconptr
(
  s1e0: s1exp
, s1opr: s1exp
, d2c: d2con, xs: List_vt (locs1explst)
) : s2exp = let
//
fun auxck1 (
  s1e0: s1exp
, d2c: d2con, xs: List_vt (locs1explst)
) : int(*nerr*) = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val () = prerr_error2_loc (x.0)
    val () = prerrln! ": overly supplied static argument group."
  in
    auxck1 (s1e0, d2c, xs) + 1
  end // end of [list_vt_cons]
| ~list_vt_nil () => (0)
//
end // end of [auxck1]
//
fun auxck2 (
  s1e0: s1exp
, d2c: d2con, s1es: s1explst
) : void = let
  val n = list_length (s1es)
  val arity = d2con_get_arity_full (d2c)
  val sgn = n - (1(*rt*) + arity)
in
//
if sgn != 0 then let
  val loc0 = s1e0.s1exp_loc
  val () = prerr_error2_loc (loc0)
  val () = prerr ": the type constructor ["
  val () = prerr_d2con (d2c)
  val () = if sgn < 0 then prerr "] expects more arguments.";
  val () = if sgn > 0 then prerr "] expects fewer arguments.";
  val () = prerr_newline ((*void*))
in
  the_trans2errlst_add (T2E_s1exp_trup (s1e0))
end // end of [if]
//
end // end of [auxck2]
//
val s1es =
(
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val nerr = auxck1 (s1e0, d2c, xs)
    val () = (
      if nerr > 0 then
        the_trans2errlst_add (T2E_s1exp_trup (s1e0))
      // end of [if]
    ) // end of [val]
  in
    x.1
  end // end of [list_vt_cons]
| ~list_vt_nil () => list_nil ()
) : s1explst // end of [val]
//
val () = auxck2 (s1e0, d2c, s1es)
val s2es = s1explst_trdn_addr (s1es)
val-list_cons (_rt, _arg) = s2es
//
in
  s2exp_datconptr (d2c, _rt, _arg)
end // end [s1exp_trup_app_datconptr]

(* ****** ****** *)

fun
s1exp_trup_app_sqid
(
  s1e0: s1exp
, s1opr: s1exp
, sq: s0taq, id: symbol
, xs: List_vt (locs1explst)
) : s2exp = let
//
val spsid = staspecid_of_sqid (sq, id) 
//
in
//
case+ spsid of
| SPSIDarrow () =>
    s1exp_trup_arrow (
    s1e0, None(*fc*), false(*lin*), false(*prf*), None(*efc*), xs
  ) // end of [SPSIDarrow]
| _(*SPSIDnone*) => let
    val ans = the_s2expenv_find_qua (sq, id)
  in
    case+ ans of
    | ~Some_vt s2i =>
        s1exp_trup_app_sqid_itm (s1e0, s1opr, sq, id, s2i, xs)
      // end of [Some_vt]
    | ~None_vt () => let
        val () =
          list_vt_free (xs)
        val () =
          prerr_error2_loc (s1opr.s1exp_loc)
        val () =
          filprerr_ifdebug "s1exp_trup_app_sqid"
        val () =
          prerr ": unrecognized static identifier ["
        val () = prerr_sqid (sq, id)
        val () = prerrln! "]."
      in
        s2exp_s2rt_err ()
      end // end of [None_vt]
  end // end of [SPSIDnone]
//
end // end of [s1exp_trup_app_sqid]

and
s1exp_trup_app_sqid_itm
(
  s1e0: s1exp
, s1opr: s1exp
, sq: s0taq, id: symbol, s2i0: s2itm
, xs: List_vt (locs1explst)
) : s2exp = let
//
(*
val () =
(
  println! ("s1exp_trup_app_sqid_itm: s1e0 = ", s1e0);
  println! ("s1exp_trup_app_sqid_itm: s1e0 = ", s2i0);
) (* end of [val] *)
*)
//
in
//
case+ s2i0 of
| S2ITMcst s2cs => let
    typedef T1 = locs1explst // = (loc)s1explst
    typedef T2 = locs2explst // = (locs2exp)lst
    val ys = let
      fun f (x: T1): T2 = l2l (
        list_map_fun<s1exp> (x.1, lam s1e =<1> (s1e.s1exp_loc, s1exp_trup s1e))
      ) // end of [f] // end of [fun]
    in
      list_map_fun<T1><T2> ($UN.castvwtp1 {List(T1)} (xs), f)
    end // end of [val]
    val () = list_vt_free (xs)
    val s2cs = s2cst_select_locs2explstlst (s2cs, $UN.castvwtp1 {List(T2)} (ys))
  in
    case+ s2cs of
    | list_cons (s2c, _) =>
        s2exp_app_wind (s1e0, s2exp_cst (s2c), ys)
      // end of [list_cons]
    | list_nil () => let
        val () = list_vt_free<T2> (ys)
        val () = prerr_error2_loc (s1e0.s1exp_loc)
        val () = filprerr_ifdebug "s1exp_trup_app_sqid_itm"
        val () = prerr ": none of the static constants referred to by ["
        val () = prerr_sqid (sq, id)
        val () = prerrln! "] is applicable."
        val () = the_trans2errlst_add (T2E_s1exp_trup (s1e0))
      in
        s2exp_s2rt_err ()
      end // end of [_]
  end // end of [S2ITEMcst]
| S2ITMvar s2v => let
(*
    val () =
      s2var_check_tmplev (s1opr.s1exp_loc, s2v)
    // end of [val]
*)
  in
    s1exp_trup_app (s1e0, s1opr, s2exp_var (s2v), xs)
  end // end of [S2ITEMvar]
//
| S2ITMdatcontyp d2c => s1exp_trup_app_datcontyp (s1e0, s1opr, d2c, xs)
| S2ITMdatconptr d2c => s1exp_trup_app_datconptr (s1e0, s1opr, d2c, xs)
//
| _ => let
    val () = list_vt_free (xs)
    val () = prerr_interror_loc (s1opr.s1exp_loc)
    val () = prerr_newline ((*void*))
    val () = prerrln! (": NIY: s1exp_trup_app_sqid_itm: s1e0 = ", s1e0)
    val () = prerrln! (": NIY: s1exp_trup_app_sqid_itm: s2i0 = ", s2i0)
  in
    $ERR.abort_interr{s2exp}((*reachable*))
  end // end of [_]
end // end of [s1exp_trup_app_sqid_itm]

(* ****** ****** *)

fun s1exp_trup_top
(
  knd: int, s1e: s1exp
) : s2exp = let
  val s2e = s1exp_trdn_impred (s1e)
in
  s2exp_top (knd, s2e)
end // end of [s1exp_trup_top]

(* ****** ****** *)

local

fun aux01 // flt/box: 0/1
(
  i: int
, npf: int, s1es: s1explst
, lin: &int, prf: &int, prgm: &int
) : labs2explst = let
in
//
case+ s1es of
| list_nil
    ((*void*)) => list_nil()
  // end of [list_nil]
| list_cons
    (s1e, s1es) => let
//
    val lab =
      $LAB.label_make_int(i)
    // end of [val]
//
    val s2e =
      s1exp_trdn_impred s1e
    // end of [val]
    val s2t = s2e.s2exp_srt
    val ls2e = SLABELED(lab, None(), s2e)
//
    val () =
    if s2rt_is_lin(s2t) then (lin := lin+1)
    val () =
    if s2rt_is_prf(s2t)
      then (prf := prf+1)
      else (if i >= npf then (prgm := prgm+1))
    // end of [if] // end of [val]
  in
    list_cons(ls2e, aux01(i+1, npf, s1es, lin, prf, prgm))
  end (* end of [list_cons] *)
//
end // end of [aux01]

fun aux23 // box_t/box_vt : 2/3
(
  i: int
, npf: int, s1es: s1explst
, s2t_prf: s2rt, s2t_prgm: s2rt
) : labs2explst = let
in
//
case+ s1es of
| list_nil
    ((*void*)) => list_nil()
| list_cons
    (s1e, s1es) => let
    val lab = $LAB.label_make_int(i)
    val s2e = (
      if i >= npf
        then (
          s1exp_trdn(s1e, s2t_prgm)
        ) else s1exp_trdn(s1e, s2t_prf)
      // end of [if]
    ) : s2exp // end of [val]
    val ls2e = SLABELED(lab, None(), s2e)
  in
    list_cons(ls2e, aux23(i+1, npf, s1es, s2t_prf, s2t_prgm))
  end (* end of [list_cons] *)
//
end // end of [aux23]

in (* in of [local] *)

fun
s1exp_trup_tytup
(
  s1e0: s1exp
, knd: int, npf: int, s1es: s1explst
) : s2exp = let
(*
val () = (
  println! ("s1exp_trup_tytup: s1e0 = ", s1e0)
) (* end of [val] *)
*)
in
//
case+ knd of
| TYTUPKIND_flt =>
    s1exp_trup_tytup_flt (s1e0, npf, s1es)
  // end of [TYTUPKIND_flt]
| TYTUPKIND_box => let
//
    var lin: int = 0
    var prf: int = 0 and prgm: int = 0
//
    val ls2es =
      aux01 (0, npf, s1es, lin, prf, prgm)
    // end of [val]
//
    val s2t_rec =
    (
      s2rt_npf_lin_prf_prgm_boxed_labs2explst
        (npf, lin, prf, prgm, 1(*boxed*), ls2es)
      // s2rt_npf_lin_prf_prgm_boxed_labs2explst
    ) (* end of [val] *)
//
    val knd =
    (
      if s2rt_is_nonlin(s2t_rec)
        then TYRECKINDbox() else TYRECKINDbox_lin()
    ) : tyreckind // end of [val]
  in
    s2exp_tyrec_srt(s2t_rec, knd, npf, ls2es)
  end
| TYTUPKIND_box_t => let
    val ls2es =
      aux23(0, npf, s1es, s2rt_prop, s2rt_t0ype)
    // end of [val]
  in
    s2exp_tyrec_srt(s2rt_type, TYRECKINDbox(), npf, ls2es)
  end
| TYTUPKIND_box_vt => let
    val ls2es =
      aux23(0, npf, s1es, s2rt_view, s2rt_vt0ype)
    // end of [val]
  in
    s2exp_tyrec_srt
      (s2rt_vtype, TYRECKINDbox_lin (), npf, ls2es)
    // s2exp_tyrec_srt
  end
| _ => let
    val () = assertloc (false) in s2exp_t0ype_err ()
  end (* end of [_] *)
end // end of [s1exp_trup_tytup]

and
s1exp_trup_tytup_flt
(
  s1e0: s1exp, npf: int, s1es: s1explst
) : s2exp = let
  var lin: int = 0
  var prf: int = 0 and prgm: int = 0
  val ls2es = aux01(0, npf, s1es, lin, prf, prgm)
  val boxed = 0 (* HX: this is the default *)
  val s2t_rec =
  (
    s2rt_npf_lin_prf_prgm_boxed_labs2explst(npf, lin, prf, prgm, boxed, ls2es)
  ) (* end of [val] *)
in
  s2exp_tyrec_srt(s2t_rec, TYRECKINDflt0(), npf, ls2es)
end // end of [s1exp_trup_tytup_flt]

end // end of [local]

(* ****** ****** *)

local

fun string_of_s0tring
  (tok: token): string = let
  val-$LEX.T_STRING (str) = tok.token_node in str
end // end of [string_of_s0tring]

fun aux01 ( // flt/box: 0/1
  i: int
, npf: int, ls1es: labs1explst
, lin: &int
, prf: &int
, prgm: &int
) : labs2explst = begin case+ ls1es of
  | list_cons (ls1e, ls1es) => let
      val $SYN.SL0ABELED (l0ab, name, s1e) = ls1e
      val lab = l0ab.l0ab_lab
      val name = (case+ name of
        | Some tok => let
            val str = string_of_s0tring (tok) in Some (str)
          end // end of [Some]
        | None () => None
      ) : Option (string)
      val s2e = s1exp_trdn_impred (s1e)
      val ls2e = SLABELED (lab, name, s2e)
      val s2t = s2e.s2exp_srt
      val () = if s2rt_is_lin (s2t) then (lin := lin+1)
      val () = if s2rt_is_prf (s2t)
        then (prf := prf+1) else (if i >= npf then prgm := prgm+1)
      // end of [val]
    in
      list_cons (ls2e, aux01 (i+1, npf, ls1es, lin, prf, prgm))
    end (* end of [list_cons] *)
  | list_nil () => list_nil ()
end // end of [aux01]

fun aux23 ( // box_t/box_vt : 2/3
  i: int
, npf: int, ls1es: labs1explst
, s2t_prf: s2rt
, s2t_prgm: s2rt
) : labs2explst = begin case+ ls1es of
  | list_cons (ls1e, ls1es) => let
      val
      $SYN.SL0ABELED
        (l0ab, name, s1e) = ls1e
      // end of [val]
      val lab = l0ab.l0ab_lab
      val name = (
        case+ name of
        | None() => None()
        | Some(tok) => let
            val str = string_of_s0tring(tok) in Some(str)
          end // end of [Some]
      ) : Option (string)
      val s2e = (
        if i >= npf
          then s1exp_trdn(s1e, s2t_prgm) else s1exp_trdn(s1e, s2t_prf)
        // end of [if]
      ) : s2exp // end of [val]
    in
      list_cons
      (
        SLABELED(lab, name, s2e), aux23(i+1, npf, ls1es, s2t_prf, s2t_prgm)
      ) (* end of [list_cons] *)
    end (* end of [list_cons] *)
  | list_nil () => list_nil ()
end // end of [aux23]

in (* in of [local] *)

fun
s1exp_trup_tyrec
(
  s1e0: s1exp
, knd: int, npf: int, ls1es: labs1explst
) : s2exp = let
(*
//
val () =
println!
  ("s1exp_trup_tyrec: s1e0 = ", s1e0);
//
val () =
  println! ("s1exp_trup_tyrec: knd = ", knd)
val () =
  println! ("s1exp_trup_tyrec: npf = ", npf)
//
*)
in
//
case+ knd of
| TYRECKIND_flt => let
    var lin: int = 0
    var prf: int = 0 and prgm: int = 0
    val ls2es =
      aux01(0, npf, ls1es, lin, prf, prgm)
    // end of [val]
    val s2t_rec =
    (
      s2rt_npf_lin_prf_prgm_boxed_labs2explst
        (npf, lin, prf, prgm, 0(*boxed*), ls2es)
      // s2rt_npf_lin_prf_prgm_boxed_labs2explst
    ) (* end of [val] *)
  in
    s2exp_tyrec_srt(s2t_rec, TYRECKINDflt0(), npf, ls2es)
  end // end of [TYRECKIND_flt]
| TYRECKIND_box => let
    var lin: int = 0
    var prf: int = 0 and prgm: int = 0
    val ls2es =
      aux01(0, npf, ls1es, lin, prf, prgm)
    // end of [val]
    val s2t_rec =
    (
      s2rt_npf_lin_prf_prgm_boxed_labs2explst
        (npf, lin, prf, prgm, 1(*boxed*), ls2es)
      // s2rt_npf_lin_prf_prgm_boxed_labs2explst
    ) (* end of [val] *)
  in
    s2exp_tyrec_srt (s2t_rec, TYRECKINDbox(), npf, ls2es)
  end // end of [TYRECKIND_box]
| TYRECKIND_box_t => let
    val ls2es =
      aux23(0, npf, ls1es, s2rt_prop, s2rt_t0ype)
    // end of [val]
  in
    s2exp_tyrec_srt(s2rt_type, TYRECKINDbox(), npf, ls2es)
  end // end of [TYRECKIND_box_t]
| TYRECKIND_box_vt => let
    val ls2es =
      aux23(0, npf, ls1es, s2rt_view, s2rt_vt0ype)
    // end of [val]
  in
    s2exp_tyrec_srt(s2rt_vtype, TYRECKINDbox(), npf, ls2es)
  end // end of [TYRECKIND_box_vt]
| _ => let
    val ((*exited*)) = assertloc(false) in s2exp_t0ype_err()
  end (* end of [_] *)
end // end of [s1exp_trup_tyrec]

fun
s1exp_trup_tyrec_ext
(
  s1e0: s1exp
, name: string, npf: int, ls1es: labs1explst
) : s2exp = let
  var lin: int = 0
  var prf: int = 0 and prgm: int = 0      
  val ls2es =
    aux01(0, npf, ls1es, lin, prf, prgm)
  // end of [val]
  val s2t_rec = (
    s2rt_npf_lin_prf_prgm_boxed_labs2explst
      (npf, lin, prf, prgm, 0(*boxed*), ls2es)
    // s2rt_npf_lin_prf_prgm_boxed_labs2explst
  ) (* end of [val] *)
in
  s2exp_tyrec_srt(s2t_rec, TYRECKINDflt_ext name, npf, ls2es)
end // end of [s1exp_tyrec_ext_tr_up]

end // end of [local]

(* ****** ****** *)

implement
s1exp_trup(s1e0) = let
//
val loc0 = s1e0.s1exp_loc
//
(*
//
val () = (
  println! ("s1exp_trup: s1e0 = ", s1e0)
) (* end of [val] *)
//
*)
in
//
case+
s1e0.s1exp_node
of (* case+ *)
//
| S1Eide (id) => let
    val sq = $SYN.the_s0taq_none
  in
    s1exp_trup_sqid (s1e0, sq, id)
  end // end of [S1Eide]
| S1Esqid (sq, id) => s1exp_trup_sqid (s1e0, sq, id)
//
| S1Eint (i) => s2exp_int (i)
| S1Eintrep (rep) => let
    val i =
      $INTINF.intinf_make_string (rep) in s2exp_intinf (i)
    // end of [val]
  end // end of [S1Eintrep]
//
| S1Echar (c) => s2exp_int_char (c) // HX: it is signed!
//
| S1Efloat (rep) => s2exp_float (rep) // HX: for exporting
| S1Estring (str) => s2exp_string (str) // HX: for exporting
//
| S1Eextype
    (name, s1ess) => let
    val s2ess =
      list_map_fun (s1ess, s1explst_trdn_vt0ype)
    // end of [val]
  in
    s2exp_extype_srt (s2rt_vt0ype, name, (l2l)s2ess)
  end // end of [S1Eextype]
| S1Eextkind
    (name, s1ess) => let
    val s2ess =
      list_map_fun (s1ess, s1explst_trdn_vt0ype)
    // end of [val]
  in
    s2exp_extkind_srt (s2rt_tkind, name, (l2l)s2ess)
  end // end of [S1Eextkind]
//
| S1Eapp _ => let
    typedef T = locs1explst
    viewtypedef TS = List_vt (T)
    var xs: TS = list_vt_nil ()
    val s1opr = s1exp_app_unwind (s1e0, xs)
  in
    case+
    :(xs: TS?) =>
    s1opr.s1exp_node
    of (* case+ *)
    | S1Eide (id) => let
        val sq = $SYN.the_s0taq_none in 
        s1exp_trup_app_sqid (s1e0, s1opr, sq, id, xs)
      end // end of [S1Eide]
    | S1Esqid (sq, id) =>
        s1exp_trup_app_sqid (s1e0, s1opr, sq, id, xs)
      // end of [S1Esqid]
    | S1Eimp (fc, lin, prf, oefc) =>
        s1exp_trup_arrow (s1e0, Some fc, lin>0, prf>0, oefc, xs)
      // end of [S1Eimp]
    | _ (*rest-of-s1exp*) => let
        val s2opr = s1exp_trup (s1opr) in s1exp_trup_app (s1e0, s1opr, s2opr, xs)
      end // end of [_(*rest*)]
  end (* end of [S1Eapp] *)
| S1Elam
  (
    s1ma, s1topt, s1e_body
  ) => let
    val s2vs =
      s1arglst_trup (s1ma.s1marg_arg)
    // end of [val]
    val (pfenv|()) = the_s2expenv_push_nil()
    val ((*added*)) = the_s2expenv_add_svarlst (s2vs)
    val s2e_body = (
      case+ s1topt of
      | Some s1t => let
          val s2t =
            s1rt_tr(s1t) in s1exp_trdn (s1e_body, s2t)
          // end of [val]
        end // end of [Some]
      | None ((*void*)) => s1exp_trup (s1e_body)
    ) : s2exp // end of [val]
    val ((*popped*)) = the_s2expenv_pop_free (pfenv | (*none*))  
  in
    s2exp_lam (s2vs, s2e_body)
  end // end of [S1Elam]
//
| S1Eimp _ => let
    val () =
    prerr_interror_loc(loc0)
    val () =
    prerrln! (
      ": s1exp_trup: S1Eimp: s1e0 = ", s1e0
    ) (* end of [val] *)
  in
    $ERR.abort_interr{s2exp}((*reachable*))
  end // end of [S1Eimp]
//
| S1Etop
    (knd, s1e) => s1exp_trup_top (knd, s1e)
  // end of [S1Etop]
//
| S1Elist (npf, s1es) =>
    s1exp_trup_tytup_flt (s1e0, npf, s1es)
//
| S1Etyarr
    (s1e_elt, s1es_ind) => let
    val s2e_elt = s1exp_trdn_vt0ype (s1e_elt)
    val s2es_ind = s1explst_trdn_int (s1es_ind)
  in
    s2exp_tyarr (s2e_elt, s2es_ind)
  end // end of [S1Etyarr]
| S1Etytup (knd, npf, s1es) =>
    s1exp_trup_tytup (s1e0, knd, npf, s1es)
| S1Etyrec (knd, npf, ls1es) =>
    s1exp_trup_tyrec (s1e0, knd, npf, ls1es)
| S1Etyrec_ext (name, npf, ls1es) =>
    s1exp_trup_tyrec_ext (s1e0, name, npf, ls1es)
//
| S1Einvar _ => let
    val () =
    prerr_error2_loc(loc0)
    val () =
    prerrln! (
      ": invariant type can only be assigned to a function argument."
    ) (* end of [val] *)
    val () = the_trans2errlst_add(T2E_s1exp_trup(s1e0))
  in
    s2exp_s2rt_err ()
  end // end of [S1Einvar]
| S1Etrans _ => let
    val () =
    prerr_error2_loc(loc0)
    val () =
    prerrln! (
      ": transitional type can only be assigned to a function argument."
    ) (* end of [val] *)
    val () = the_trans2errlst_add(T2E_s1exp_trup(s1e0))
  in
    s2exp_s2rt_err ()
  end // end of [S1Etrans]
//
| S1Euni
    (s1qs, s1e_scope) => let
(*
    val () =
    println!
      ("s1exp_trup: S1Euni: s1e0 = ", s1e0)
    // end of [val]
*)
    val (pfenv|()) = the_s2expenv_push_nil()
    val s2q = s1qualst_tr (s1qs)
    val s2e_scope = s1exp_trdn_impred s1e_scope
    val ((*popped*)) =
      the_s2expenv_pop_free (pfenv | (*none*))
    // end of [val]
//
  in
    s2exp_uni (s2q.s2qua_svs, s2q.s2qua_sps, s2e_scope)
  end // end of [S1Euni]
| S1Eexi
    (knd, s1qs, s1e_scope) => let
(*
    val () =
    println!
      ("s1exp_trup: S1Eexi: s1e0 = ", s1e0)
    // end of [val]
*)
//
    val () =
    if knd > 0 then
    {
      val () = prerr_error2_loc(loc0)
      val () =
      prerrln! (
        ": incorrect use of the existential quantifier #[...]"
      ) (* end of [val] *)
      val () =
        the_trans2errlst_add(T2E_s1exp_trup(s1e0))
      // end of [val]
    } (* end of [if] *) // end of [val]
//
    val (pfenv|()) = the_s2expenv_push_nil()
    val s2q = s1qualst_tr (s1qs)
    val s2e_scope = s1exp_trdn_impred (s1e_scope)
    val ((*popped*)) = the_s2expenv_pop_free (pfenv | (*none*))
  in
    s2exp_exi (s2q.s2qua_svs, s2q.s2qua_sps, s2e_scope)
  end // end of [S1Eexi]
//
| S1Eann (s1e, s1t) => let
    val s2t = s1rt_tr (s1t) in s1exp_trdn (s1e, s2t)
  end // end of [S1Eann]
//
| S1Ed2ctype(d2ctp) => S1Ed2ctype_tr (d2ctp)
//
| S1Eerr((*error*)) => s2exp_s2rt_err((*void*))
//
(*
| _ (*rest-of-s1exp*) => let
    val () = prerr_interror_loc(loc0)
    val () = prerrln! (": NYI: s1exp_tr: s1e0 = ", s1e0)
  in
    $ERR.abort_interr((*unreachable*))
  end // end of [_(*rest-of-s1exp*)]
*)
//
end // end of [s1exp_trup]

implement
s1exp_trup_hnfize (s1e) = s2exp_hnfize (s1exp_trup s1e)

(* ****** ****** *)

implement
s1explst_trup
  (s1es) = l2l (list_map_fun (s1es, s1exp_trup))
// end of [s1explst_trup]

implement
s1explst_trup_hnfize
  (s1es) = l2l (list_map_fun (s1es, s1exp_trup_hnfize))
// end of [s1explst_trup]

(* ****** ****** *)

implement
s1expopt_trup
  (s1eopt) = case+ s1eopt of
  | Some s1e => Some (s1exp_trup s1e) | None () => None ()
// end of [s1expopt_trup]

(* ****** ****** *)

fun s1exp_trdn_lam
(
  s1e_lam: s1exp, s2t_fun: s2rt
) : s2exp = let
//
fun auxerr
(
  s1e: s1exp, s2t1: s2rt, s2t2: s2rt
) :<cloref1> void = {
  val () =
    prerr_error2_loc (s1e.s1exp_loc)
  val () = filprerr_ifdebug "s1exp_trdn_lam"
  val () = prerr ": the body of the static function is given the sort ["
  val () = prerr_s2rt (s2t1)
  val () = prerrln! ("] but it is expected to be of the sort [", s2t2, "].")
  val () = the_trans2errlst_add (T2E_s1exp_trdn (s1e_lam, s2t_fun))
} // end of [auxerr]
//
  val-S1Elam (
    s1ma, s1topt_res, s1e_body
  ) = s1e_lam.s1exp_node
  val-S2RTfun (s2ts_arg, s2t_res) = s2t_fun
//
  var err: int = 0
  val s2vs = s1marg_trdn (s1ma, s2ts_arg)
//
  val s2t_res = (case+ s1topt_res of
    | Some s1t => s2t where {
        val s2t = s1rt_tr (s1t)
        val okay = s2rt_ltmat1 (s2t, s2t_res)
        val () = if ~okay then auxerr (s1e_lam, s2t, s2t_res)
      } // end of [Some]
    | None () => s2t_res
  ) : s2rt // end of [val]
//
  val (pfenv | ()) = the_s2expenv_push_nil ()
  val () = the_s2expenv_add_svarlst (s2vs)
  val s2e_body = s1exp_trdn (s1e_body, s2t_res)
  val () = the_s2expenv_pop_free (pfenv | (*none*))  
//
in
  s2exp_lam_srt (s2t_fun, s2vs, s2e_body)
end // end of [s2exp_trdn_lam]

implement
s2exp_trdn
  (loc0, s2e, s2t) = let
  val s2t_new = s2e.s2exp_srt
  val test = s2rt_ltmat1 (s2t_new, s2t)
in
//
if test
  then s2e
  else let
    val () =
      prerr_error2_loc (loc0)
    val () =
      filprerr_ifdebug "s2exp_trdn" // for debugging
    // end of [val]
    val () = prerr ": the static expression is of the sort ["
    val () = prerr_s2rt (s2t_new)
    val () = prerrln! ("] but it is expected to be of the sort [", s2t, "].")
    val () = the_trans2errlst_add (T2E_s2exp_trdn (loc0, s2e, s2t))
  in
    s2exp_errexp(s2t)
  end (* end of [else] *)
//
end // end of [s2exp_trdn]

implement
s1exp_trdn (s1e, s2t) = let
//
fun auxerr // for S2Eextype
(
  s1e: s1exp, s2t: s2rt
) : void = {
  val () =
    prerr_error2_loc (s1e.s1exp_loc)
  val () = filprerr_ifdebug ("s1exp_trdn")
  val () = prerrln! (": the static term (extype) cannot be given the sort [", s2t, "].")
  val () = the_trans2errlst_add (T2E_s1exp_trdn (s1e, s2t))
} (* end of [auxerr] *)
//
in
//
case+ (s1e.s1exp_node, s2t) of
//
| (S1Elam _, S2RTfun _) => s1exp_trdn_lam (s1e, s2t)
//
| (S1Eextype (name, s1ess), _) =>
    if s2rt_ltmat1 (s2t, s2rt_vt0ype) then let
      val s2ess = list_map_fun (s1ess, s1explst_trdn_vt0ype)
    in
      s2exp_extype_srt (s2t, name, (l2l)s2ess)
    end else let
      val () = auxerr (s1e, s2t) in s2exp_errexp(s2t)
    end // end of [if]
//
| (_, _) => let
    val s2e = s1exp_trup (s1e) in s2exp_trdn (s1e.s1exp_loc, s2e, s2t)
  end (* end of [_] *)
//
end // end of [s1exp_trdn]

(* ****** ****** *)

implement
s1exp_trdn_int (s1e) = s1exp_trdn (s1e, s2rt_int)
implement
s1exp_trdn_addr (s1e) = s1exp_trdn (s1e, s2rt_addr)
implement
s1exp_trdn_bool (s1e) = s1exp_trdn (s1e, s2rt_bool)
implement
s1exp_trdn_t0ype (s1e) = s1exp_trdn (s1e, s2rt_t0ype)
implement
s1exp_trdn_vt0ype (s1e) = s1exp_trdn (s1e, s2rt_vt0ype)

(* ****** ****** *)

implement
s1exp_trdn_impred (s1e) = let
//
  val s2e = s1exp_trup (s1e)
  val s2t = s2rt_delink (s2e.s2exp_srt)
  val isimp = s2rt_is_impred (s2t)
//
in
//
if isimp
  then s2e
  else let
    val () = prerr_error2_loc (s1e.s1exp_loc)
    val () = filprerr_ifdebug "s1exp_trdn_impred"
    val () =
      prerr ": the static expression needs to be impredicative"
    val () = (
      prerr " but is assigned the sort ["; prerr_s2rt (s2t); prerr "]."
    ) (* end of [val] *)
    val () = prerr_newline ()
    val () = the_trans2errlst_add (T2E_s1exp_trdn_impred (s1e))
  in
    s2exp_errexp(s2t)
  end (* end of [else] *)
//
end // end of [s1exp_trdn_impred]

(* ****** ****** *)

implement
s1explst_trdn_int
  (s1es) = l2l (list_map_fun (s1es, s1exp_trdn_int))
// end of [s1explst_trdn_int]

implement
s1explst_trdn_addr
  (s1es) = l2l (list_map_fun (s1es, s1exp_trdn_addr))
// end of [s1explst_trdn_addr]

implement
s1explst_trdn_bool
  (s1es) = l2l (list_map_fun (s1es, s1exp_trdn_bool))
// end of [s1explst_trdn_bool]

implement
s1explst_trdn_vt0ype
  (s1es) = l2l (list_map_fun (s1es, s1exp_trdn_vt0ype))
// end of [s1explst_trdn_vt0ype]

implement
s1explst_trdn_impred
  (s1es) = l2l (list_map_fun (s1es, s1exp_trdn_impred))
// end of [s1explst_trdn_impred]

(* ****** ****** *)

implement
s1explst_trdn_err
  (s1es, s2ts, serr) = begin
//
case+ s1es of
| list_cons (s1e, s1es) => (
  case+ s2ts of
  | list_cons (s2t, s2ts) => let
      val s2e = s1exp_trdn (s1e, s2t)
      val s2es = s1explst_trdn_err (s1es, s2ts, serr)
    in
      list_cons (s2e, s2es)
    end // end of [list_cons]
  | list_nil () => let
      val () = serr := serr + 1 in list_nil ()
    end // end of [list_nil]
  )
| list_nil () => list_nil () where {
    val () = (case+ s2ts of
      | list_cons _ => (serr := serr - 1) | list_nil () => ()
    ) : void // end of [val]
  } // end of [list_nil]
//
end // end of [s1explst_trdn_err]

(* ****** ****** *)

implement
s1exp_trdn_arg_impred
  (s1e, w1ts) = s2e where
{
//
val s2e = s1exp_trup_arg (s1e, w1ts)
val s2t = s2e.s2exp_srt
val s2t = s2rt_delink (s2t)
val isimp = s2rt_is_impred (s2t)
//
val () =
if not(isimp) then let
  val () =
    prerr_error2_loc (s1e.s1exp_loc)
  val () =
    filprerr_ifdebug ("s1exp_trdn_arg_impred")
  val () = prerr ": the static expression needs to be impredicative"
  val () = prerrln! (" but it is assigned the sort [", s2t, "].")
in
  the_trans2errlst_add (T2E_s1exp_trdn_impred (s1e))
end // end of [val]
//
} // end of [s1exp_trdn_arg_impred]

(* ****** ****** *)

implement
witht1ype_tr (w1t) =
(
case+ w1t of
| WITHT1YPEsome
    (knd, s1e) => let
    val s2t = s2rt_impred (knd) in Some (s1exp_trdn (s1e, s2t))
  end // end of [WiTHT1YPEsome]
| WITHT1YPEnone () => None ()
) // end of [witht1ype_tr]

(* ****** ****** *)

implement
s1qualst_tr (s1qs) = let
//
fun loop (
  s1qs: s1qualst
, s2vs: &s2varlst_vt
, s2ps: &s2explst_vt
) : void = let
//
fun auxsrt (
  s2t1: s2rt
, ids: i0delst
, s2vs: &s2varlst_vt
) : void =
  case+ ids of
  | list_cons (id, ids) => let
      val s2v = s2var_make_id_srt (id.i0de_sym, s2t1)
      val () = the_s2expenv_add_svar (s2v)
      val () = s2vs := list_vt_cons (s2v, s2vs);
    in
      auxsrt (s2t1, ids, s2vs)
    end // end of [list_cons]
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
//
end // end of [loop]
//
var s2vs
  : s2varlst_vt = list_vt_nil ()
var s2ps
  : s2explst_vt = list_vt_nil ()
//
val () = loop (s1qs, s2vs, s2ps)
//
val s2vs = list_vt_reverse (s2vs)
val s2ps = list_vt_reverse (s2ps)
//
in (* in of [let] *)
//
s2qua_make ((l2l)s2vs, (l2l)s2ps)
//
end // end of [s1qualst_tr]

(* ****** ****** *)

implement
q1marg_tr (q1ma) = s1qualst_tr (q1ma.q1marg_arg)

implement
q1marg_tr_dec (q1ma) = let
//
val s2q = s1qualst_tr (q1ma.q1marg_arg)
//
in
//
if
list_is_nil (s2q.s2qua_sps)
then s2q
else let
//
val loc = q1ma.q1marg_loc
//
val () =
  prerr_error3_loc (loc)
//
val () =
  filprerr_ifdebug "q1marg_tr_dec"
//
val () = prerrln! ": template arguments cannot be constrained."
val () = the_trans2errlst_add (T2E_q1marg_tr_dec (q1ma))
//
in
  s2qua_make (s2q.s2qua_svs, list_nil) // HX: sps is discarded
end // end of [if]
//
end // end of [q1marg_tr_dec]

(* ****** ****** *)

implement
s1rtext_tr (s1te0) = let
(*
val () = print "s1rtext_tr: s1te0 = "
val () = fprint_s1rtext (stdout_ref, s1te0)
val () = fprint_newline (stdout_ref)
*)
fun auxerr
(
  s1t: s1rt, q: s0rtq, id: symbol
) :<cloref1> void = let
//
val () =
  prerr_error2_loc (s1t.s1rt_loc)
val () =
  filprerr_ifdebug "s1rtext_tr" // for debugging
//
val () = prerr ": the identifier [";
val () = ($SYN.prerr_s0rtq(q); $SYM.prerr_symbol(id))
val () = prerrln! "] refers to an unrecognized sort.";
//
in
  the_trans2errlst_add (T2E_s1rtext_tr (s1te0))
end // end of [auxerr]
//
in
//
case+
s1te0.s1rtext_node
of // of [case+]
| S1TEsrt (s1t) => (
  case+ s1t.s1rt_node of
  | S1RTqid (q, id) => let
      val ans = the_s2rtenv_find_qua (q, id)
    in
      case+ ans of
      | ~Some_vt s2te => s2te
      | ~None_vt () => let
          val () = auxerr (s1t, q, id) in S2TEerr ()
        end // end of [None_vt]
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

implement
s1vararg_tr (x) =
  case+ x of
  | S1VARARGone (loc) => S2VARARGone ()
  | S1VARARGall (loc) => S2VARARGall ()
  | S1VARARGseq (loc, s1as) => let
      val s2vs = s1arglst_trup (s1as) in S2VARARGseq (s2vs)
    end // end of [S1VARARGseq]
// end of [s1vararg_tr]

implement
s1exparg_tr (x) = let
  val loc = x.s1exparg_loc
in
//
case+ x.s1exparg_node of
| S1EXPARGone () => s2exparg_one (loc)
| S1EXPARGall () => s2exparg_all (loc)
| S1EXPARGseq (s1es) =>
    s2exparg_seq (loc, s1explst_trup (s1es))
  (* end of [S1EXPARGseq] *)
//
end // end of [s1exparg_tr]

implement
s1exparglst_tr (xs) = let
  val xs = list_map_fun (xs, s1exparg_tr) in (l2l)xs
end // end of [s1exparglst_tr]

(* ****** ****** *)

implement
t1mpmarg_tr (x) = let
  val loc = x.t1mpmarg_loc
  val s1es = x.t1mpmarg_arg
  val s2es = s1explst_trup (s1es)
in
  t2mpmarg_make (loc, s2es)
end // end of [t1mpmarg_tr]

implement
t1mpmarglst_tr (xs) = let
  val xs = list_map_fun (xs, t1mpmarg_tr) in (l2l)xs
end // end of [t1mpmarglst_tr]

(* ****** ****** *)

implement
d1atcon_tr
(
  s2c, islin, isprf, s2vss0, fil, d1c
) = let
//
fun auxerr1
(
  d1c: d1atcon, id: symbol, serr: int
) : void = {
//
val loc = d1c.d1atcon_loc
//
val () =
  prerr_error2_loc (loc)
val () =
  prerr ": the constructor ["
//
val () = $SYM.prerr_symbol (id)
//
val () =
if serr < 0
  then prerrln! "] is expected to be given more indexes."
//
val () =
if serr > 0
  then prerrln! "] is expected to be given fewer indexes."
//
val () = the_trans2errlst_add(T2E_d1atcon_tr(d1c))
//
} (* end of [auxerr1] *)
//
fun auxerr2
(
  d1c: d1atcon, id: symbol
) : void = {
//
val loc = d1c.d1atcon_loc
//
val () =
  prerr_error2_loc (loc)
//
val () = prerr! (": the constructor [", id)
val () = prerrln! "] needs some indexes (but is given none)."
//
val () = the_trans2errlst_add (T2E_d1atcon_tr(d1c))
//
} (* end of [auxerr2] *)
//
fun auxerr3
(
  d1c: d1atcon, id: symbol
) : void = {
  val () =
    prerr_error2_loc (d1c.d1atcon_loc)
  val () = prerr! (": the constructor [", id)
  val () = prerrln! "] needs no indexes (but is given some)."
  val () = the_trans2errlst_add (T2E_d1atcon_tr(d1c))
} // end of [auxerr3]
//
val (pfenv|()) = the_s2expenv_push_nil()
//
val () = list_app_fun
  (s2vss0, the_s2expenv_add_svarlst)
//
var s2qs: List_vt (s2qua) =
  list_map_fun<q1marg> (d1c.d1atcon_qua, q1marg_tr)
//
val () = let
  fun aux (
    s2qs: &List_vt (s2qua), xs: s2varlstlst
  ) : void =
    case+ xs of
    | list_nil() => ()
    | list_cons(x, xs) => let
        val () = aux (s2qs, xs)
        val s2q = s2qua_make (x, list_nil)
      in
        s2qs := list_vt_cons (s2q, s2qs)
      end // end of [list_cons]
  // end of [aux]
in
  aux (s2qs, s2vss0)
end // end of [val]
val s2qs = l2l(s2qs)
//
val
indopt_s2ts = let
  val s2t_fun = s2cst_get_srt(s2c)
in
  case+ s2t_fun of S2RTfun (s2ts, _) => Some s2ts | _ => None ()
end : s2rtlstopt // end of [val]
//
val npf = d1c.d1atcon_npf and s1es_arg = d1c.d1atcon_arg
//
val
s2es_arg = let
  val
  s2t_pfarg =
  (
    if islin then s2rt_view else s2rt_prop
  ) : s2rt // end of [val]
  val s2t_arg =
  (
    if isprf then s2t_pfarg else
      (if islin then s2rt_vt0ype else s2rt_t0ype)
  ) : s2rt // end of [val]
  fun aux (
    i: int, s1es: s1explst
  ) :<cloref1> s2explst =
    case+ s1es of
    | list_cons (s1e, s1es) => let
        val s2t = (
          if i < npf then s2t_pfarg else s2t_arg
        ) : s2rt
        val s2e = s1exp_trdn (s1e, s2t)
      in
        list_cons (s2e, aux (i+1, s1es))
      end // end of [cons]
    | list_nil () => list_nil () // end of [list_nil]
  // end of [aux]
in
  aux (0, s1es_arg)
end // end of [val]
//
val id = d1c.d1atcon_sym
val
indopt_s1es = d1c.d1atcon_ind
val
indopt_s2es =
(
//
case+ (
  indopt_s1es, indopt_s2ts
) of // of [case+]
| (None (), None ()) => None ()
| (Some s1es, Some s2ts) => let
    var serr: int = 0
    val s2es = s1explst_trdn_err (s1es, s2ts, serr)
    val () = if (serr != 0) then auxerr1 (d1c, id, serr)
  in
    Some (s2es)
  end // end of [Some, Some]
| (None (), Some s2ts) => let
    val s2vs =
    (
      case+ s2vss0 of
      | list_nil () => list_nil ()
      | list_cons (s2vs, _) => s2vs
    ) : s2varlst // end of [val]
    val sgn =
      list_length_compare(s2vs, s2ts)
    // end of [val]
    val s2es = (
      if sgn = 0 then let
        val s2es = list_map_fun(s2vs, s2exp_var)
      in
        (l2l)s2es
      end else let // sgn < 0
        val () = auxerr2 (d1c, id)
        val s2es = list_map_fun(s2ts, s2exp_errexp)
      in
        (l2l)s2es // HX: placeholder for continuing
      end // end of [if]
    ) : s2explst // end of [val]
  in
    Some (s2es)
  end // end of [None, Some]
| (Some _, None ()) => let
    val () = auxerr3 (d1c, id) in None ()
  end // end of [Some, None]
//
) : s2explstopt // end of [val]
//
val ((*popped*)) = the_s2expenv_pop_free(pfenv | (*none*))
//
val
loc0 = d1c.d1atcon_loc
val
vwtp =
(
  if isprf then 0 else if islin then 1 else 0
) : int // end of [val]
val d2c =
d2con_make
  (loc0, fil, id, s2c, vwtp, s2qs, npf, s2es_arg, indopt_s2es)
// end of [val]
val () = the_d2expenv_add_dcon (d2c)
//
val () =
if not(isprf) then {
  val () = the_s2expenv_add_datcontyp(d2c) // struct
  val () = if islin then the_s2expenv_add_datconptr(d2c) // unfold
} // end of [if] // end of [val]
//
in
  d2c (*d2con*)
end // end of [d1atcon_tr]

(* ****** ****** *)

implement
stasub_extend_sarglst_svarlst
  (sub, s1as, s2vs, serr) = let
//
fun loop (
  s1as: s1arglst
, s2vs: s2varlst
, sub: &stasub
, s2vs1: s2varlst_vt
, serr: &int
) : s2varlst_vt =
  case+ (s1as, s2vs) of
  | (s1a :: s1as, s2v :: s2vs) => let
      val s2t0 = s2var_get_srt (s2v)
      val s2v1 = s1arg_trdn (s1a, s2t0)
      val s2e1 = s2exp_var (s2v1)
      val () = stasub_add (sub, s2v, s2e1)
      val s2vs1 = list_vt_cons (s2v1, s2vs1)
    in
      loop (s1as, s2vs, sub, s2vs1, serr)
    end
  | (list_nil (), list_nil ()) => s2vs1
  | (_ :: _, list_nil ()) => let
      val () = serr := serr + 1 in s2vs1
    end // end of [nil, ::]
  | (list_nil _, _ :: _) => let
      val () = serr := serr - 1 in s2vs1
    end // end of [::, nil]
//
  val s2vs1 = loop (s1as, s2vs, sub, list_vt_nil, serr)
in
  list_vt_reverse (s2vs1)
end // end of [stasub_extend_sarglst_svarlst]

(* ****** ****** *)

implement
s1vararg_bind_svarlst
  (s1va, s2vs, serr) = let
(*
val () = (
  print "s1vararg_bind_svarlst: s1va = "; print_s1vararg (s1va); print_newline ();
  print "s1vararg_bind_svarlst: s2vs = "; print_s2varlst (s2vs); print_newline ();
) // end of [val]
*)
in
//
case+ s1va of
| S1VARARGone (loc) => let
    var sub = stasub_make_nil ()
    val s2vs1 = stasub_extend_svarlst (sub, s2vs)
  in
    (sub, s2vs1)
  end (* end of [S1VARARGone] *)
| S1VARARGall (loc) => let
    var sub = stasub_make_nil ()
    val s2vs1 = stasub_extend_svarlst (sub, s2vs)
  in
    (sub, s2vs1)
  end (* end of [S1VARARGone] *)
| S1VARARGseq
    (locarg, s1as) => let
    var sub = stasub_make_nil ()
    val s2vs1 = stasub_extend_sarglst_svarlst (sub, s1as, s2vs, serr)
  in
    (sub, s2vs1)
  end // end of [S1VARARGseq]
//
end // end of [s1vararg_bind_svarlst]

(* ****** ****** *)

(* end of [pats_trans2_staexp.dats] *)
