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

staload ERR = "./pats_error.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans2_p1at"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
macdef label_make_int = $LAB.label_make_int

staload SYM = "./pats_symbol.sats"
overload = with $SYM.eq_symbol_symbol

staload SYN = "./pats_syntax.sats"
typedef d0ynq = $SYN.d0ynq

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_e1xpval.sats"
staload "./pats_dynexp1.sats"
staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans2.sats"
staload "./pats_trans2_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fun
p1at_tr_ide
(
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
        | _ when sym =
            $SYM.symbol_TRUE_BOOL => p2at_bool (loc0, true)
        | _ when sym =
            $SYM.symbol_FALSE_BOOL => p2at_bool (loc0, false)
        | _ => p2at_var (loc0, d2var_make (loc0, id))
      // end of [val]
    end // end of [D2ITEMcst]
//
   | _ => p2at_var (loc0, d2var_make (loc0, id))
   end // end of [Some_vt]
| ~None_vt () => p2at_var (loc0, d2var_make (loc0, id))
end // end of [p1at_tr_ide]

(* ****** ****** *)

extern
fun
p1at_tr_app_dyn
(
  p1t0: p1at, p1t_fun: p1at, npf: int, darg: p1atlst
) : p2at // end of [p1at_tr_app_dyn]
extern
fun
p1at_tr_app_sta_dyn
(
  p1t0: p1at, p1t1: p1at
, p1t_fun: p1at, sarg: s1vararglst, npf: int, darg: p1atlst
) : p2at // end of [p1at_tr_app_sta_dyn]

(* ****** ****** *)

fun
p1atconarg_is_omit
  (arg: p1atlst): bool = let
in
//
case+ arg of
| list_cons (
    p1t, list_nil ()
  ) => (
    case+ p1t.p1at_node of P1Tany _ => true | _ => false
  ) // end of [list_cons]
| _ => false // end of [_]
//
end // end of [p1atconarg_is_omit]

fun
p1at_tr_con_sapp1
(
  loc0: location // p1t1.p1at_loc
, d2c: d2con, sub: &stasub
, s2qs: s2qualst, out: &List_vt(s2qua)
) : s2exp = let
in
//
case+ s2qs of
| list_cons (s2q, s2qs) => let
    val s2vs =
      stasub_extend_svarlst (sub, s2q.s2qua_svs)
    // end of [val]
    val s2vs = (l2l)s2vs
    val s2ps = s2explst_subst (sub, s2q.s2qua_sps)
    val s2q = s2qua_make (s2vs, s2ps)
    val () = out := list_vt_cons (s2q, out)
  in
    p1at_tr_con_sapp1 (loc0, d2c, sub, s2qs, out)
  end // end of [cons]
| list_nil () => let
    val npf = d2con_get_npf (d2c)
    val s2es_arg =
      s2explst_subst (sub, d2con_get_arg d2c)
    val s2c = d2con_get_scst (d2c)
    val indopt = d2con_get_ind (d2c)
    val s2f_res = (
      case+ indopt of
      | Some s2es_ind => let
          val s2es_ind = s2explst_subst (sub, s2es_ind)
        in
          s2exp_cstapp (s2c, s2es_ind)
        end // end of [Some]
      | None () => s2exp_cst (s2c) // end of [None]
    ) : s2exp // end of [val]
    val () = out := list_vt_reverse (out)
  in
    s2exp_confun (npf, s2es_arg, s2f_res)
  end // end of [list_nil]
//
end // end of [p1at_tr_con_sapp1]

fun
p1at_tr_con_sapp2
(
  p1t1: p1at
, d2c: d2con, sub: &stasub, s2qs: s2qualst, s1as: s1vararglst
, out: &s2qualst_vt
) : s2exp = let
(*
val () = (
  print "p1at_tr_con_sapp2: d2c.type = "; print_s2exp (d2con_get_type d2c); print_newline ()
) // end of [val]
*)
fn auxerr1 (
  p1t1: p1at, d2c: d2con
) : void = let
  val () = prerr_error2_loc (p1t1.p1at_loc)
  val () = prerr ": the constructor ["
  val () = prerr_d2con (d2c)
  val () = prerr "] is overly applied statically."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_p1at_tr (p1t1))
end // end of [auxerr1]
fn auxerr2 (
  p1t1: p1at, d2c: d2con, locarg: location, serr: int
) : void = let
  val () = prerr_error2_loc (locarg)
  val () = prerr ": the static argument group is expected to contain "
  val () = if serr < 0 then prerr_string ("more components.")
  val () = if serr > 0 then prerr_string ("fewer components.")
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_p1at_tr (p1t1))
end // end of [auxerr2]
//
in
//
case+ s1as of
| list_cons
    (s1a, s1as) => (
  case+ s1a of
  | S1VARARGone (loc) => begin
    case+ s2qs of
    | list_cons (s2q, s2qs) => let
        val s2vs =
          stasub_extend_svarlst (sub, s2q.s2qua_svs)
        // end of [val]
        val s2vs = (l2l)s2vs
        val s2ps = s2explst_subst (sub, s2q.s2qua_sps)
        val s2q = s2qua_make (s2vs, s2ps)
        val () = out := list_vt_cons (s2q, out)
      in
        p1at_tr_con_sapp2 (p1t1, d2c, sub, s2qs, s1as, out)
      end // end of [list_cons]
    | list_nil () => let
        val () = auxerr1 (p1t1, d2c) in s2exp_s2rt_err ()
      end (* end of [list_nil] *)
    end // end of [S1VARARGone]
  | S1VARARGall (loc) =>
      p1at_tr_con_sapp1 (p1t1.p1at_loc, d2c, sub, s2qs, out)
  | S1VARARGseq (loc, sarg) => begin
    case+ s2qs of
    | list_cons (s2q, s2qs) => let
//
        var serr: int = 0
        val s2vs = s2q.s2qua_svs
        val s2vs = stasub_extend_sarglst_svarlst (sub, sarg, s2vs, serr)
        val () = if serr != 0 then let
          val () = auxerr2 (p1t1, d2c, loc, serr) in (*nothing*)
        end // end of [val]
//
        val s2vs = (l2l)s2vs
        val s2ps = s2explst_subst (sub, s2q.s2qua_sps)
        val s2q = s2qua_make (s2vs, s2ps)
        val () = out := list_vt_cons (s2q, out)
      in
        p1at_tr_con_sapp2 (p1t1, d2c, sub, s2qs, s1as, out)
      end // end of [list_cons]
    | list_nil () => let
        val () = auxerr1 (p1t1, d2c) in s2exp_s2rt_err ()
      end (* end of [list_nil] *)
    end // end of [S1VARARGseq]
  ) // end of [list_cons]
| list_nil () => p1at_tr_con_sapp1 (p1t1.p1at_loc, d2c, sub, s2qs, out)
//
end // end of [p1at_tr_con_sapp2]

(* ****** ****** *)

fun
p1at_tr_con
(
  p1t0: p1at, p1t1: p1at
, d2cs: d2conlst, sarg: s1vararglst, npf: int, darg: p1atlst
) : p2at = let
//
val isargomit = p1atconarg_is_omit (darg)
val d2cs =
(
  if isargomit then d2cs else let
    val n = list_length (darg) in d2con_select_arity (d2cs, n)
  end // end of [if]
) : d2conlst // end of [val]
//
val-list_cons (d2c, _) = d2cs // HX: [d2cs] cannot be nil
//
var sub = stasub_make_nil ()
val s2qs = d2con_get_qua (d2c)
var out: List_vt (s2qua) = list_vt_nil ()
val s2e = p1at_tr_con_sapp2 (p1t1, d2c, sub, s2qs, sarg, out)
val () = stasub_free (sub)
val out = (l2l)out
//
val darg = let
  fun nanys (loc: location, i: int): p2atlst =
    if i > 0 then let
      val p2t = p2at_any (loc) in list_cons (p2t, nanys (loc, i-1))
    end else list_nil // end of [if]
  // end of [nanys]
in
  if isargomit then let
    val-list_cons (p1t, _) = darg
  in
    nanys (p1t.p1at_loc, d2con_get_arity_full (d2c))
  end else
    p1atlst_tr (darg)
  // end of [if]
end : p2atlst // end of [val]
//
in
  p2at_con (p1t0.p1at_loc, PCKcon, d2c, out, s2e, npf, darg)
end // end of [p1at_tr_con]

(* ****** ****** *)

extern
fun
p1at_tr_app_dyn_e1xp
(
  p1t0: p1at, p1t1: p1at
, e0: e1xp, npf: int, p1ts_arg: p1atlst
) : p2at // end of [p1at_tr_app_dyn_e1xp]

extern
fun
p1at_tr_app_dyn_dqid
(
  p1t0: p1at, p1t1: p1at
, dq: d0ynq, id: symbol, npf: int, darg: p1atlst
) : p2at // end of [p1at_tr_app_dyn_dqid]

(* ****** ****** *)

implement
p1at_tr_app_dyn_e1xp
(
  p1t0, p1t1, e0, npf, darg
) = let
(*
  val () = begin
    print "p1at_tr_app_dyn_e1xp: p1t0 = "; print_p1at p1t0; print_newline ()
  end // end of [val]
*)
in
//
case+ e0.e1xp_node of
| E1XPfun _ => let
    val loc0 = p1t0.p1at_loc
//
    prval pfu = unit_v ()
    val es = list_map_vclo<p1at> {unit_v} (pfu | darg, !p_clo) where {
      var !p_clo = @lam (pf: !unit_v | p1t: p1at): e1xp => e1xp_make_p1at (loc0, p1t)
    } // end of [val]
    prval unit_v () = pfu
//
    val e1 = e1xp_app (loc0, e0, loc0, (l2l)es)
(*
    val () = (
      print "p1at_tr_app_dyn_e1xp: e1 = "; print_e1xp e1; print_newline ()
    ) // end of [val]
*)
    val e2 = e1xp_normalize (e1)
(*
    val () = (
      print "p1at_tr_app_dyn_e1xp: e2 = "; print_e1xp e2; print_newline ()
    ) // end of [val]
*)
    val p1t0_new = p1at_make_e1xp (loc0, e2)
  in
    p1at_tr (p1t0_new)
  end // end of [E1XPfun]
| _ => let
    val p1t_fun =
      p1at_make_e1xp (p1t1.p1at_loc, e0)
    // end of [val]
  in
    p1at_tr_app_dyn (p1t0, p1t_fun, npf, darg)
  end (* end of [_] *)
//
end // end of [p1at_tr_app_dyn_e1xp]

local

fun
dqid_is_vbox
(
  dq: d0ynq, id: symbol
) : bool =
  if $SYN.d0ynq_is_none (dq) then id = $SYM.symbol_VBOX else false
// end of [dqid_is_vbox]

fun
auxerr1 (
  p1t0: p1at, p1t1: p1at, dq: d0ynq, id: symbol
) : void = let
  val () = prerr_error2_loc (p1t1.p1at_loc)
  val () = filprerr_ifdebug ("p1at_tr_app_dyn_dqid")
  val () = prerr ": the identifier ["
  val () = ($SYN.prerr_d0ynq (dq); $SYM.prerr_symbol (id))
  val () = prerr "] does not refer to any constructor."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_p1at_tr (p1t0))
end // end of [auxerr1]

fun
auxerr2 (
  p1t0: p1at, p1t1: p1at, dq: d0ynq, id: symbol
) : void = let
  val () = prerr_error2_loc (p1t1.p1at_loc)
  val () = filprerr_ifdebug ("p1at_tr_app_dyn_dqid")
  val () = prerr ": the identifier ["
  val () = ($SYN.prerr_d0ynq (dq); $SYM.prerr_symbol (id))
  val () = prerr "] is unrecognized."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_p1at_tr (p1t0))
end // end of [auxerr2]

(* ****** ****** *)

fun
p2at_vbox_err
(
  p1t0: p1at, p2ts: p2atlst
) : p2at = let
  val loc0 = p1t0.p1at_loc
in
  case+ p2ts of
  | list_cons (
      p2t, list_nil ()
    ) => (
    case+ p2t.p2at_node of
    | P2Tany () => let
        val d2v =
          d2var_make_any (p2t.p2at_loc)
        // end of [val]
      in
        p2at_vbox (loc0, d2v)
      end // end of [P2Tany]
    | P2Tvar (d2v) => p2at_vbox (loc0, d2v)
    | _ => let
        val () = prerr_error2_loc (loc0)
        val () = prerr ": [vbox] should be applied to a variable."
        val () = prerr_newline ()
        val () = the_trans2errlst_add (T2E_p1at_tr (p1t0))
      in
        p2at_errpat (loc0)
      end // end of [_] 
    ) // end of [list_cons]
  | _ => let
      val () = prerr_error2_loc (loc0)
      val () = prerr ": [vbox] should be applied to exactly one argument."
      val () = prerr_newline ()
      val () = the_trans2errlst_add (T2E_p1at_tr (p1t0))
    in
      p2at_errpat (loc0)
    end // end of [list_nil]
end // end of [p2at_vbox_err]

in (* in-of-local *)

implement
p1at_tr_app_dyn_dqid
(
  p1t0, p1t1, dq, id, npf, darg
) = let
  val ans = the_d2expenv_find_qua (dq, id)
in
//
case+ ans of
| ~Some_vt (d2i) => (
  case+ d2i of
  | D2ITMe1xp (e0) =>
      p1at_tr_app_dyn_e1xp (p1t0, p1t1, e0, npf, darg)
  | D2ITMcon (d2cs) =>
      p1at_tr_con (p1t0, p1t1, d2cs, list_nil(*sarg*), npf, darg)
  | _ => let
      val () =
      auxerr1 (p1t0, p1t1, dq, id) in p2at_errpat (p1t0.p1at_loc)
    end // end of [_]
  ) // end of [Some_vt]
| ~None_vt ((*void*)) => (
  case+ 0 of
  | _ when dqid_is_vbox (dq, id) => let
      val p2ts = p1atlst_tr (darg) in p2at_vbox_err (p1t0, p2ts)
    end // end of [vbox]
  | _ => let
      val () =
        auxerr2 (p1t0, p1t1, dq, id) in p2at_errpat (p1t0.p1at_loc)
      // end of [val]
    end // end of [_]
  ) // end of [None_vt]
//
end // end of [p1at_tr_app_dyn_dqid]  

end // end of [local]

(* ****** ****** *)

implement
p1at_tr_app_dyn
(
  p1t0, p1t_fun, npf, darg
) = let
(*
  val () = begin
    print "p1at_tr_app_dyn: p1t0 = "; print_p1at p1t0; print_newline ()
  end // end of [val]
*)
in
//
case+
p1t_fun.p1at_node of
| P1Tide (id) => let
    val dq = $SYN.the_d0ynq_none in
    p1at_tr_app_dyn_dqid (p1t0, p1t_fun, dq, id, npf, darg)
  end
| P1Tdqid (dq, id) =>
    p1at_tr_app_dyn_dqid (p1t0, p1t_fun, dq, id, npf, darg)
| _ => let
    val () = prerr_error2_loc (p1t_fun.p1at_loc)
    val () = prerr ": a (qualified) identifier is expected."
    val () = prerr_newline ()
    val () = the_trans2errlst_add (T2E_p1at_tr (p1t0))
  in
    p2at_errpat (p1t0.p1at_loc)
  end // end of [_]
//
end // end of [p1at_tr_app_dyn]

(* ****** ****** *)

fun
p1at_tr_app_sta_dyn_itm
(
  p1t0: p1at, p1t1: p1at, p1t2: p1at
, d2i: d2itm, sarg: s1vararglst, npf: int, darg: p1atlst
) : p2at = let
(*
  val () = begin
    print "p1at_tr_app_sta_dyn_itm: p1t0 = "; print_p1at p1t0; print_newline ()
  end // end of [val]
*)
in
//
case+ d2i of
| D2ITMcon (d2cs) =>
    p1at_tr_con (p1t0, p1t1, d2cs, sarg, npf, darg)
  // end of [D2ITMcon]
| D2ITMe1xp (e0) => let
    val p1t2 = p1at_make_e1xp (p1t2.p1at_loc, e0)
  in
    p1at_tr_app_sta_dyn (p1t0, p1t1, p1t2, sarg, npf, darg)
  end
| _ => let
    val () = prerr_error2_loc (p1t2.p1at_loc)
    val () = prerr ": the (qualified) identifier does not refer to any constructor."
    val () = prerr_newline ()
    val () = the_trans2errlst_add (T2E_p1at_tr (p1t0))
  in
    p2at_errpat (p1t0.p1at_loc)
  end
end // end of [p1at_tr_app_sta_dyn_itm]

implement
p1at_tr_app_sta_dyn
(
  p1t0, p1t1, p1t_fun, sarg, npf, darg
) = let
//
fun
auxerr .<>. (
  p1t0: p1at, p1t1: p1at, p1t_fun: p1at, dq: d0ynq, id: symbol
) : void = let
  val loc = p1t_fun.p1at_loc
  val () = prerr_error2_loc (loc)
  val () = prerr ": the (qualified) identifier ["
  val () = ($SYN.prerr_d0ynq dq; $SYM.prerr_symbol id)
  val () = prerr "] is unrecognized."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_p1at_tr (p1t0))
end // end of [auxerr]
//
in
//
case+
p1t_fun.p1at_node of
| P1Tide (id) => let
    val ans = the_d2expenv_find (id)
  in
    case+ ans of
    | ~Some_vt (d2i) =>
        p1at_tr_app_sta_dyn_itm (p1t0, p1t1, p1t_fun, d2i, sarg, npf, darg)
    | ~None_vt () => let
        val dq = $SYN.the_d0ynq_none
        val () = auxerr (p1t0, p1t1, p1t_fun, dq, id)
      in
        p2at_errpat (p1t_fun.p1at_loc)
      end (* end of [None] *)
  end // end of [P1Tide]
| P1Tdqid (dq, id) => let
    val ans = the_d2expenv_find_qua (dq, id)
  in
    case+ ans of
    | ~Some_vt (d2i) =>
        p1at_tr_app_sta_dyn_itm (p1t0, p1t1, p1t_fun, d2i, sarg, npf, darg)
    | ~None_vt () => let
        val () = auxerr (p1t0, p1t1, p1t_fun, dq, id)
      in
        p2at_errpat (p1t_fun.p1at_loc)
      end // end of [None_vt]
  end // end of [P1Tdqid]
| _ => let
    val () = prerr_error2_loc (p1t_fun.p1at_loc)
    val () = prerr ": a (qualified) identifier is expected."
    val () = prerr_newline ()
    val () = the_trans2errlst_add (T2E_p1at_tr (p1t0))
  in
    p2at_errpat (p1t0.p1at_loc)
  end // end of [_]
//
end // end of [p1at_tr_app_sta_dyn]

(* ****** ****** *)

fun
p1at_tr_free_unfold
(
  pck: pckind, p1t0: p1at, p1t: p1at
) : p2at = let
//
val p2t = p1at_tr (p1t)
//
in
//
case+
p2t.p2at_node of
//
| P2Tcon (
    PCKcon (), d2c, s2qs, s2e, npf, darg
  ) => let
    val loc0 = p1t0.p1at_loc
  in
    p2at_con (loc0, pck, d2c, s2qs, s2e, npf, darg)
  end // end of [P2Tcon]
//
| _ => let
    val loc0 = p1t0.p1at_loc
    val () = prerr_error2_loc (loc0)
    val () = filprerr_ifdebug ("p1at_tr_free_unfold")
    val () = prerr ": the pattern is expected to be formed with a constructor (of datavtype)."
    val () = prerr_newline ()
    val () = the_trans2errlst_add (T2E_p1at_tr (p1t0))
  in
    p2at_errpat (loc0)
  end // end of [_]
//
end // end of [p1at_tr_free_unfold]

(* ****** ****** *)

fun
p1at_tr_tup (
  p1t0: p1at
, knd: int, npf: int, p1ts: p1atlst
) : p2at = let
//
val loc0 = p1t0.p1at_loc
val p2ts =
  list_map_fun (p1ts, p1at_tr)
val lp2ts =
  p2atlst_tupize ($UN.list_vt2t(p2ts))
val ((*freed*)) = list_vt_free (p2ts)
//
in
  p2at_rec (loc0, knd, npf, lp2ts)
end // end of [p1at_tr_tup]
  
(* ****** ****** *)

implement
p1at_tr (p1t0) = let
//
val loc0 = p1t0.p1at_loc
//
(*
val () = println! ("p1at_tr: p1t0 = ", p1t0)
*)
//
in
//
case+
p1t0.p1at_node of
| P1Tany _ => p2at_any (loc0)
| P1Tany2 _ => p2at_any (loc0)
| P1Tide (id) => p1at_tr_ide (p1t0, id)
| P1Tdqid (dq, id) => let
    val npf = ~1; val darg = list_nil ()
  in
    p1at_tr_app_dyn_dqid (p1t0, p1t0, dq, id, npf, darg)
  end // end of [P2Tdqid]
//
| P1Tint (int) => p2at_int (loc0, int)
| P1Tintrep (rep) => p2at_intrep (loc0, rep)
| P1Tchar (c) => p2at_char (loc0, c)
| P1Tstring (str) => p2at_string (loc0, str)
| P1Tfloat (rep) => p2at_float (loc0, rep)
//
| P1Ti0nt (x) => p2at_i0nt (loc0, x)
| P1Tf0loat (x) => p2at_f0loat (loc0, x)
//
| P1Tempty () => p2at_empty (loc0)
//
| P1Tapp_dyn (
    p1t1, _(*loc*), npf, darg
  ) => (
    case+ p1t1.p1at_node of
    | P1Tapp_sta (p1t_fun, sarg) =>
        p1at_tr_app_sta_dyn (p1t0, p1t1, p1t_fun, sarg, npf, darg)
      // end of [P1Tapp_sta]
    | _ (*non-P1Tapp_sta*) => p1at_tr_app_dyn (p1t0, p1t1, npf, darg)
  ) (* end of [P1Tapp_dyn] *)
| P1Tapp_sta (p1t_fun, sarg) =>
    p1at_tr_app_sta_dyn (p1t0, p1t_fun, p1t_fun, sarg, ~1(*npf*), list_nil)
//
| P1Tlist (npf, p1ts) => (
  case+ p1ts of
  | list_cons _ =>
      p1at_tr_tup (p1t0, 0(*tupknd*), npf, p1ts)
  | list_nil () => p2at_empty (loc0)
  ) (* end of [P1Tlist] *)
//
| P1Ttup (knd, npf, p1ts) => p1at_tr_tup (p1t0, knd, npf, p1ts)
| P1Trec (
    knd, npf, lp1ts
  ) => let
    val lp2ts = 
      list_map_fun (lp1ts, labp1at_tr)
    // end of [val]
  in
    p2at_rec (loc0, knd, npf, (l2l)lp2ts)
  end // end of [P1Trec]
| P1Tlst (lin, p1ts) => p2at_lst (loc0, lin, p1atlst_tr (p1ts))
//
| P1Tfree (p1t) => p1at_tr_free_unfold (PCKfree, p1t0, p1t)
| P1Tunfold (p1t) => p1at_tr_free_unfold (PCKunfold, p1t0, p1t)
//
| P1Trefas (
    id, loc_id, p1t
  ) => let
    val d2v = d2var_make (loc_id, id)
  in
    p2at_refas (loc0, d2v, p1at_tr (p1t))
  end // end of [P1Trefas]
//
| P1Texist (s1as, p1t) => let
    val (
      pfenv | ()
    ) = the_s2expenv_push_nil ()
    val s2vs = s1arglst_trup (s1as)
    val () = the_s2expenv_add_svarlst (s2vs)
    val p2t = p1at_tr (p1t)
    val () = the_s2expenv_pop_free (pfenv | (*none*))
  in
    p2at_exist (loc0, s2vs, p2t)
  end
| P1Tsvararg _ => let
    val () = prerr_interror_loc (loc0)
    val () = prerr ": p1at_tr: P1Tsvararg: this pattern should have been eliminated."
    val () = prerr_newline ()
  in
    p2at_errpat (loc0)
  end // end of [P1Tavararg]
//
| P1Tann (p1t, ann) => let
    val p2t = p1at_tr (p1t)
    val ann = s1exp_trdn_impred (ann)
    val ann = s2exp_hnfize (ann)
  in
    p2at_ann (loc0, p2t, ann)
  end // end of [P1Tann]
//
| P1Terrpat () => p2at_errpat (loc0)
//
(*
| _ => let
    val () =
    prerr_interror_loc (loc0)
    val () =
    prerrln! (": p1at_tr: not yet implemented: p1t0 = ", p1t0, "]")
  in
    $ERR.abort_interr{p2at}((*unreachable*))
  end // end of [_]
*)
//
end // end of [p1at_tr]

implement
p1atlst_tr (p1ts) = l2l (list_map_fun (p1ts, p1at_tr))

implement
labp1at_tr (lp1t) = let
in
//
case+
lp1t.labp1at_node of
| LABP1ATnorm (l0, p1t) => let
    val p2t = p1at_tr (p1t) in LABP2ATnorm (l0, p2t)
  end // end of [LABP1ATnorm]
| LABP1ATomit ((*void*)) => LABP2ATomit (lp1t.labp1at_loc)
//
end // end of [labp1at_tr]

(* ****** ****** *)

implement
p1at_tr_arg
  (p1t0, ws1es) = let
//
val loc0 = p1t0.p1at_loc
//
in
//
case+
p1t0.p1at_node of
//
| P1Tann
    (p1t, ann) => let
    val p2t = p1at_tr (p1t)
    val ann =
      s1exp_trdn_arg_impred (ann, ws1es)
    // end of [ann]
    val ann = s2exp_hnfize (ann)
  in
    p2at_ann (loc0, p2t, ann)
  end // end of [P1Tann]
//
| P1Tlist
    (npf, p1ts) => let
    val p2ts = p1atlst_tr_arg (p1ts, ws1es)
  in
    p2at_list (loc0, npf, p2ts)
  end // end of [P1Tlist]
//
| _ (*P1T-rest*) => let
    val () = ws1es := WTHS1EXPLSTcons_none (ws1es)
  in
    p1at_tr (p1t0)
  end // end of [P1T-rest]
//
end // end of [p1at_tr_arg]


local

fun
p1at_tr_arg_2
(
  p1t: p1at, w1ts: &wths1explst
) : p2at = let
//
val p2t = p1at_tr_arg (p1t, w1ts)
//
in
//
case+
p2t.p2at_node of
| P2Tlist
    (npf, p2ts) => let
    val loc0 = p2t.p2at_loc
    val lp2ts = p2atlst_tupize (p2ts)
  in
    p2at_rec (loc0, 0(*tupknd*), npf, lp2ts)
  end // end of [P2Tlist]
| _ (*non-P2Tlist*) => p2t
//
end // end of [p1at_tr_arg_2]

in (* in-of-local *)

implement
p1atlst_tr_arg
  (p1ts, ws1es) = let
in
//
case+ p1ts of
| list_cons
    (p1t, p1ts) => let
    val p2t = p1at_tr_arg_2 (p1t, ws1es)
    val p2ts = p1atlst_tr_arg (p1ts, ws1es)
  in
    list_cons (p2t, p2ts)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [p1atlst_tr_arg]

end // end of [local]

(* ****** ****** *)

implement
d2con_instantiate
  (loc0, d2c) = let
//
var sub = stasub_make_nil ()
val s2qs = d2con_get_qua (d2c)
var out: List_vt (s2qua) = list_vt_nil ()
val s2e = p1at_tr_con_sapp1 (loc0, d2c, sub, s2qs, out)
val () = stasub_free (sub)
val out = (l2l)out
//
in
  @(out, s2e)
end // end of [p1at_con_instantiate]

(* ****** ****** *)

(* end of [pats_trans2_p1at.dats] *)
