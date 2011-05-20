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
staload "pats_e1xpval.sats"
staload "pats_dynexp1.sats"
staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp2_util.sats"

(* ****** ****** *)

staload "pats_trans2.sats"
staload "pats_trans2_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fun p1at_tr_ide (
  p1t0: p1at, id: symbol
) : p2at = let
  val loc0 = p1t0.p1at_loc
  val ans = the_d2expenv_find (id)
in
//
case+ ans of
| ~Some_vt d2i => begin case+ d2i of
  | D2ITMe1xp e1xp => let
      val p1t = p1at_make_e1xp (loc0, e1xp) in p1at_tr (p1t)
    end // end of [D2ITEMe1xp]
//
// HX: for handling [true] and [false] patterns
//
  | D2ITMcst d2c => let
      val sym = d2cst_get_sym (d2c) in case+ 0 of
        | _ when sym = $SYM.symbol_TRUE => p2at_bool (loc0, true)
        | _ when sym = $SYM.symbol_FALSE => p2at_bool (loc0, false)
        | _ => p2at_var (loc0, 0(*refknd*), d2var_make (loc0, id))
    end // end of [D2ITEMcst]
//
   | _ => p2at_var (loc0, 0(*refknd*), d2var_make (loc0, id))
   end // end of [Some_vt]
| ~None_vt () => p2at_var (loc0, 0(*refknd*), d2var_make (loc0, id))
//
end // end of [p1at_tr_ide]

(* ****** ****** *)

extern
fun p1at_app_tr_main (
  p1t0: p1at, p1t1: p1at
, p1t_fun: p1at, sarg: s1vararglst, npf: int, darg: p1atlst
) : p2at // end of [p1at_app_tr_main]

implement
p1at_app_tr_main (
  p1t0, p1t1, p1t_fun, sarg, npf, p1ts_arg
) = let
  val loc0 = p1t0.p1at_loc
in
  p2at_err (loc0)
end // end of [p1at_app_tr_main]

(* ****** ****** *)

fun p1at_app_tr_e1xp (
  p1t0: p1at, p1t1: p1at
, e0: e1xp, npf: int, p1ts_arg: p1atlst
) : p2at = let
(*
  val () = begin
    print "p1at_app_tr_e1xp: p1t0 = "; print_p1at p1t0; print_newline ()
  end // end of [val]
*)
in
//
case+ e0.e1xp_node of
| E1XPfun _ => let
    val loc0 = p1t0.p1at_loc
    prval pfu = unit_v ()
    val es = list_map_clo<p1at> {unit_v} (pfu | p1ts_arg, !p_clo) where {
      var !p_clo = @lam (pf: !unit_v | p1t: p1at): e1xp => e1xp_make_p1at (loc0, p1t)
    } // end of [val]
    prval unit_v () = pfu
    val e1 = e1xp_app (loc0, e0, loc0, (l2l)es)
(*
    val () = (
      print "p1at_app_tr_e1xp: e1 = "; print_e1xp e1; print_newline ()
    ) // end of [val]
*)
    val e2 = e1xp_normalize (e1)
(*
    val () = (
      print "p1at_app_tr_e1xp: e2 = "; print_e1xp e2; print_newline ()
    ) // end of [val]
*)
    val p1t0_new = p1at_make_e1xp (loc0, e2)
  in
    p1at_tr (p1t0_new)
  end // end of [E1XPfun]
| _ => let
    val p1t_fun = p1at_make_e1xp (p1t1.p1at_loc, e0) in
    p1at_app_tr_main (p1t0, p1t1, p1t_fun, list_nil(*sarg*), npf, p1ts_arg)
  end (* end of [_] *)
//
end // end of [p1at_app_tr_e1xp]

(* ****** ****** *)

fun p1at_app_tr_dqid (
  p1t0: p1at, p1t1: p1at
, dq: d0ynq, id: symbol, npf: int, p1ts_arg: p1atlst
) : p2at = let
  val loc0 = p1t0.p1at_loc
  val ans = the_d2expenv_find_qua (dq, id)
in
//
case+ ans of
| ~Some_vt (d2i) => (case+ d2i of
  | D2ITMe1xp (e0) =>
      p1at_app_tr_e1xp (p1t0, p1t1, e0, npf, p1ts_arg)
  | D2ITMcon (d2cs) => let
      val n = list_length (p1ts_arg)
      val d2cs = d2con_select_arity (d2cs, n)
      val- list_cons (d2c, _) = d2cs
      val p2ts_arg = p1atlst_tr (p1ts_arg)
    in
      p2at_con (loc0, d2c, list_nil(*sarg*), npf, p2ts_arg)
    end
  | _ => let
      val () = prerr_error2_loc (p1t1.p1at_loc)
      val () = prerr ": the identifier ["
      val () = ($SYN.prerr_d0ynq (dq); $SYM.prerr_symbol (id))
      val () = prerr "] does not refer to any constructor."
      val () = prerr_newline ()
    in
      p2at_err (loc0)
    end
  ) // end of [Some_vt]
| ~None_vt () => let
    val () = prerr_error2_loc (p1t1.p1at_loc)
    val () = prerr ": the identifier ["
    val () = ($SYN.prerr_d0ynq (dq); $SYM.prerr_symbol (id))
    val () = prerr "] is unrecognized."
    val () = prerr_newline ()
  in
    p2at_err (loc0)
  end // end of [None_vt]
//
end // end of [p1at_app_tr_dqid]

fun p1at_app_tr_sta (
  p1t0: p1at, p1t1: p1at
, p1t_fun: p1at, sarg: s1vararglst, npf: int, p1ts_arg: p1atlst
) : p2at = let
  val p1t_fun = (case+
    p1t_fun.p1at_node of
    | P1Tide (id) => let
        val ans = the_d2expenv_find (id)
      in
        case+ ans of
        | ~Some_vt (d2i) => (case+ d2i of
          | D2ITMe1xp (e0) => p1at_make_e1xp (p1t_fun.p1at_loc, e0) | _ => p1t_fun
          ) // end of [Some_vt]
        | ~None_vt () => p1t_fun
      end
    | _ => p1t_fun
  ) : p1at // end of [val]
in
  p1at_app_tr_main (p1t0, p1t1, p1t_fun, sarg, npf, p1ts_arg)
end // end of [p1at_app_tr_sta]

(* ****** ****** *)

implement
p1at_tr (p1t0) = let
  val loc0 = p1t0.p1at_loc
in
//
case+ p1t0.p1at_node of
| P1Tany _ => p2at_any (loc0)
| P1Tanys _ => p2at_anys (loc0)
| P1Tide (id) => p1at_tr_ide (p1t0, id)
| P1Tchar (x) => p2at_char (loc0, x)
| P1Tempty () => p2at_empty (loc0)
| P1Tapp_dyn (
    p1t_fun, _(*loc*), npf, p1ts_arg
  ) => let
    val loc_fun = p1t_fun.p1at_loc
  in
    case+ p1t_fun.p1at_node of
    | P1Tide (id) => let
        val dq = $SYN.the_d0ynq_none
      in
        p1at_app_tr_dqid (p1t0, p1t_fun, dq, id, npf, p1ts_arg)
      end // end of [P1Tide]
    | P1Tdqid (dq, id) =>
        p1at_app_tr_dqid (p1t0, p1t_fun, dq, id, npf, p1ts_arg)
    | P1Tapp_sta (p1t_f2un, sarg) =>
        p1at_app_tr_sta (p1t0, p1t_fun, p1t_f2un, sarg, npf, p1ts_arg)
      // end of [P1Tapp_sta]
    | _ => let
        val () = prerr_error2_loc (loc0)
        val () = filprerr_ifdebug ": p1at_tr"
        val () = prerr ": the application in the pattern is not allowed."
        val () = prerr_newline ()
      in
        p2at_err (loc0)
      end // end of [_]
    // end of [case]
  end // end of [P1Tapp_dyn]
| P1Tlist (npf, p1ts) => (
  case+ p1ts of
  | list_cons _ => let
      val p2ts = p1atlst_tr p1ts in p2at_list (loc0, npf, p2ts)
    end // end of [list_cons]
  | list_nil _ => p2at_empty (loc0)
  ) // end of [P1Tlist]
| P1Ttup (
    knd, npf, p1ts
  ) => let
    val p2ts = p1atlst_tr p1ts in p2at_tup (loc0, knd, npf, p2ts)
  end // end of [P1Ttup]
| P1Tann (p1t, ann) => let
    val p2t = p1at_tr (p1t)
    val ann = s1exp_trdn_impredicative (ann)
  in
    p2at_ann (loc0, p2t, ann)
  end
| _ => let
    val () = prerr_interror_loc (loc0)
    val () = prerr ": p1at_tr: not yet implemented: p1t0 = "
    val () = prerr_p1at (p1t0)
    val () = prerr "]"
    val () = prerr_newline ()
  in
    $ERR.abort {p2at} ()
  end // end of [_]
//
end // end of [p1at_tr]

implement
p1atlst_tr (p1ts) = l2l (list_map_fun (p1ts, p1at_tr))

(* ****** ****** *)

(* end of [pats_trans2_p1at.dats] *)
