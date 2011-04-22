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
// Start Time: April, 2011
//
(* ****** ****** *)

staload ERR = "pats_error.sats"
staload LOC = "pats_location.sats"
overload + with $LOC.location_combine

staload SYM = "pats_symbol.sats"
macdef BACKSLASH = $SYM.symbol_BACKSLASH
overload = with $SYM.eq_symbol_symbol

(* ****** ****** *)

staload "pats_basics.sats"
staload "pats_fixity.sats"
staload "pats_syntax.sats"
staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"

(* ****** ****** *)

staload "pats_trans1.sats"
staload "pats_trans1_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt
macdef list_sing (x) = list_cons (,(x), list_nil ())

(* ****** ****** *)

fn prerr_loc_error1
  (loc: location): void = (
  $LOC.prerr_location loc; prerr ": error(1)"
) // end of [prerr_loc_error1]

fn prerr_interror
  (): void = prerr "INTERROR(pats_trans1_dynexp)"
// end of [prerr_interror]

fn prerr_loc_interror
  (loc: location): void = (
  $LOC.prerr_location loc; prerr "INTERROR(pats_trans1_dynexp)"
) // end of [prerr_loc_interror]

(* ****** ****** *)
//
// HX: translation of dynamic expressions
//
typedef d1expitm = fxitm (d1exp)
typedef d1expitmlst = List (d1expitm)

(* ****** ****** *)

local

fn appf (
  d1e1: d1exp
, d1e2: d1exp
) :<cloref1> d1expitm = let
  val loc = d1e1.d1exp_loc + d1e2.d1exp_loc
  val d1e_app = d1exp_app_syndef (loc, d1e1, d1e2)
(*
  val () = begin
    print "d1expitm_app: f: d1e_app = "; print d1e_app; print_newline ()
  end // end of [val]
*)
in
  FXITMatm (d1e_app)
end // end of [appf]

in // in of [local]

fn d1expitm_app
  (loc: location): d1expitm = fxitm_app (loc, appf)
// end of [d1expitm_app]

end // end of [local]

fn d1exp_get_loc (x: d1exp): location = x.d1exp_loc

fn d1exp_make_opr (
  opr: d1exp, f: fxty
) : d1expitm = begin
  fxopr_make {d1exp} (
    d1exp_get_loc
  , lam (loc, x, loc_arg, xs) => d1exp_app_dyn (loc, x, loc_arg, ~1(*npf*), xs)
  , opr, f
  ) // end of [oper_make]
end // end of [d1exp_make_opr]

fn d1expitm_backslash
  (loc_opr: location) = begin
  fxopr_make_backslash {d1exp} (
    lam x => x.d1exp_loc
  , lam (loc, x, loc_arg, xs) => d1exp_app_dyn (loc, x, loc_arg, ~1(*npf*), xs)
  , loc_opr
  ) // end of [oper_make_backslash]
end // end of [d1expitm_backslash]

(* ****** ****** *)

fn s0expdarg_tr (
  d0e: d0exp
) : s1exparg = let
  val d1e = d0exp_tr d0e
in
  case+ d1e.d1exp_node of
  | D1Esexparg s1a => s1a
  | _ => let
      val () = prerr_loc_interror (d0e.d0exp_loc)
      val () = prerr ": d0exp_tr: D0Efoldat: d1e = "
      val () = fprint_d1exp (stderr_ref, d1e)
      val () = prerr_newline ()
    in
      $ERR.abort {s1exparg} ()
    end // end of [_]
end // end of [s0expdarg_tr]

fn s0expdarglst_tr
  (xs: d0explst): s1exparglst = l2l (list_map_fun (xs, s0expdarg_tr))
// end of [s0expdarglst_tr]

(* ****** ****** *)

implement
d0exp_lams_dyn_tr (
  lamknd, locopt, fcopt, lin, args, res, efcopt, d0e_body
) = let
//
fun aux (
  lamknd: int
, args: f0arglst
, d1e_body: d1exp
, flag: int
) :<cloref1> d1exp = begin
//
case+ args of
| list_cons (arg, args) => let
    val loc_arg = arg.f0arg_loc
    val d1e_body = aux (lamknd, args, d1e_body, flag1) where {
      val flag1 = (
        case+ arg.f0arg_node of F0ARGdyn _ => flag + 1 | _ => flag
      ) : int
    } // end of [where]
    val loc_body = d1e_body.d1exp_loc
    val loc = (case+ locopt of
      | Some loc => loc | None () => loc_arg + loc_body
    ) : location // end of [val]
  in
    case+ arg.f0arg_node of
    | F0ARGsta1 s0qs =>
        d1exp_lam_sta_syn (loc, loc_arg, s0qualst_tr s0qs, d1e_body)
      // end of [F0ARGsta1]
    | F0ARGsta2 s0as =>
        d1exp_lam_sta_ana (loc, loc_arg, s0arglst_tr s0as, d1e_body)
      // end of [F0ARGsta2]
    | F0ARGdyn p0t when flag = 0 => let
        val p1t = p0at_tr p0t
        val isbox = lamkind_isbox (lamknd)
      in
        if isbox > 0 then
          d1exp_lam_dyn (loc, lin, p1t, d1e_body)
        else
          d1exp_laminit_dyn (loc, lin, p1t, d1e_body)
        // end of [if]
      end // end of [F0ARGdyn when ...]
    | F0ARGdyn p0t (* flag > 0 *) => let
        val p1t = p0at_tr (p0t)
        val d1e_body = // linear closure
(*
** HX: funcloknd is set to FUNCLOcloptr if no annotation is available
*)
          d1exp_ann_funclo_opt (loc_body, d1e_body, FUNCLOcloptr)
        // end of [val]
      in
        d1exp_lam_dyn (loc, lin, p1t, d1e_body)
      end // end of [F0ARGdyn]
    | F0ARGmet s0es =>
        d1exp_lam_met (loc, loc_arg, s0explst_tr s0es, d1e_body)
      // end of [F0ARGmet]
  end // end of [list_cons]
| list_nil () => d1e_body
//
end (* end of [aux] *)
//
val d1e_body = d0exp_tr (d0e_body)
//
val d1e_body = (case+ res of
  | Some s0e => let
      val loc = s0e.s0exp_loc + d1e_body.d1exp_loc
      val s1e = s0exp_tr (s0e)
    in
      d1exp_ann_type (loc, d1e_body, s1e)
    end // end of [Some]
  | None () => d1e_body // end of [None]
) : d1exp
//
val d1e_body = (case+ efcopt of
  | Some efc => begin
      d1exp_ann_effc (d1e_body.d1exp_loc, d1e_body, efc)
    end // end of [Some]
  | None () => d1e_body
) : d1exp // end of [val]
//
val d1e_body = (case+ fcopt of
  | Some fc => begin
      d1exp_ann_funclo (d1e_body.d1exp_loc, d1e_body, fc)
    end // end of [Some]
  | None () => d1e_body
) : d1exp // end of [val]
//
in
  aux (lamknd, args, d1e_body, 0(*flag*))
end // end of [d0exp_lams_dyn_tr]

(* ****** ****** *)

implement
termination_metric_check
  (loc, ismet, efcopt) = case+ efcopt of
  | Some efc => let
      val is_okay = begin
        if ismet then true else effcst_contain_ntm efc
      end : bool // end of [val]
    in
      if (is_okay) then () else let
        val () = prerr_loc_error1 (loc)
        val () = prerr ": a termination metric is missing"
        val () = prerr_newline ()
      in
        $ERR.abort ()
      end // end of [if]
    end // end of [Some]
  | None () => () // end of [None]
// end of [termination_metric_check]

(* ****** ****** *)

fn i0nvarg_tr
  (arg: i0nvarg): i1nvarg = let
  val opt = s0expopt_tr (arg.i0nvarg_typ)
in
  i1nvarg_make (arg.i0nvarg_loc, arg.i0nvarg_sym, opt)
end // end of [i0nvarg_tr]

fun i0nvarglst_tr
  (xs: i0nvarglst): i1nvarglst = l2l (list_map_fun (xs, i0nvarg_tr))

fn i0nvresstate_tr
  (res: i0nvresstate): i1nvresstate = let
  val s1qs = (
    case+ res.i0nvresstate_qua of
    | Some s0qs => s0qualst_tr (s0qs) | None () => list_nil ()
  ) : s1qualst // end of [val]
  val arg = i0nvarglst_tr res.i0nvresstate_arg
in
  i1nvresstate_make (s1qs, arg)
end // end of [i0nvresstate_tr]

(* ****** ****** *)

local

fn d0exp_tr_errmsg_opr
  (loc: location): d1exp = let
  val () = prerr_loc_error1 (loc)
  val () = prerr ": the operator needs to be applied."
  val () = prerr_newline ()
in
  $ERR.abort {d1exp} ()
end // end of [d0exp_tr_errmsg_opr]

in // in of [local]

implement
d0exp_tr (d0e0) = let
//
#define :: list_cons
//
fun
aux_item (
  d0e0: d0exp
) : d1expitm = let
  val loc0 = d0e0.d0exp_loc in
  case+ d0e0.d0exp_node of
//
  | D0Eide id when id = BACKSLASH => d1expitm_backslash (loc0)
  | D0Eide id => let
      val d1e = d1exp_ide (loc0, id)
    in
      case+ the_fxtyenv_find id of
      | ~Some_vt f => d1exp_make_opr (d1e, f)
      | ~None_vt () => FXITMatm (d1e)
    end // end of [D0Eide]
  | D0Edqid (dq, id) => FXITMatm (d1exp_dqid (loc0, dq, id))
  | D0Eopid (id) => FXITMatm (d1exp_ide (loc0, id))
//
  | D0Echar x => FXITMatm (d1exp_char (loc0, x))
  | D0Efloat x => FXITMatm (d1exp_float (loc0, x))
  | D0Estring x => FXITMatm (d1exp_string (loc0, x))
  | D0Eempty () => FXITMatm (d1exp_empty (loc0))
//
  | D0Ecstsp x => FXITMatm (d1exp_cstsp (loc0, x))
//
  | D0Eextval (_type, _code) =>
      FXITMatm (d1exp_extval (loc0, s0exp_tr (_type), _code))
    // end of [D0Eextval]
//
(*
  | D0Elabel lab => d1exp_label (loc0, lab)
*)
  | D0Eloopexn (knd) => FXITMatm (d1exp_loopexn (loc0, knd))
//
  | D0Efoldat (d0es) => let
      val s1as = s0expdarglst_tr d0es
      fn f (
        d1e: d1exp
      ) :<cloref1> d1expitm = let
        val loc = loc0 + d1e.d1exp_loc
      in
        FXITMatm (d1exp_foldat (loc, s1as, d1e))
      end // end of [f]
    in
      FXITMopr (loc0, FXOPRpre (foldat_prec_dyn, f))
    end // end of [D0Efoldat]
  | D0Efreeat (d0es) => let
      val s1as = s0expdarglst_tr d0es
      fn f (
        d1e: d1exp
      ) :<cloref1> d1expitm = let
        val loc = loc0 + d1e.d1exp_loc
      in
        FXITMatm (d1exp_freeat (loc, s1as, d1e))
      end // end of [f]
    in
      FXITMopr (loc0, FXOPRpre (freeat_prec_dyn, f))
    end // end of [D0Efreeat]
  | D0Eapp _ => let 
      val d1e = fixity_resolve (
        loc0, d1exp_get_loc, d1expitm_app (loc0), aux_itemlst d0e0
      ) // end of [val]
(*
      val () = (
        print "d0exp_tr: aux_item: d1e = "; print_d1exp d1e; print_newline ()
      ) // end of [val]
*)
      val d1e = d1exp_idextapp_resolve (loc0, d1e)
    in
      FXITMatm (d1e)
    end // end of [D0Eapp]
//
  | D0Elist (npf, d0es) => let
      val d1es = d0explst_tr d0es in FXITMatm (d1exp_list (loc0, npf, d1es))
    end // end of [D0Elist]
//
  | D0Eifhead (hd, _cond, _then, _else) => let
      val inv = i0nvresstate_tr hd.ifhead_inv
      val _cond = d0exp_tr (_cond)
      val _then = d0exp_tr (_then)
      val _else = d0expopt_tr (_else)
      val d1e_if = d1exp_ifhead (loc0, inv, _cond, _then, _else)
    in
      FXITMatm (d1e_if)        
    end // end of [D0Eifhead]
//
  | D0Elam (
      knd, args, res, effopt, body
    ) => let
      val lin0 = lamkind_islin (knd)
      val (fcopt, lin, efcopt) = (case+ effopt of
        | Some eff => let
            val (fcopt, lin, prf, efc) = e0fftaglst_tr (eff)
            val lin = (if lin0 > 0 then 1 else lin): int
          in
            (fcopt, lin, Some efc)
          end // end of [Some]
        | None () => (None (), lin0, None ())
      ) : (funcloopt, int, effcstopt)
      val d1e_lam = d0exp_lams_dyn_tr
        (knd, Some loc0, fcopt, lin, args, res, efcopt, body)
      // end of [val]
    in
      FXITMatm (d1e_lam)
    end // end of [D0Elam]
  | D0Efix (
      knd, id, args, res, effopt, d0e_def
    ) => let
      val (fcopt, lin, efcopt) = (case+ effopt of
        | Some eff => let
            val (fcopt, lin, prf, efc) = e0fftaglst_tr (eff)
          in
            (fcopt, lin, Some efc)
          end // end of [Some]
        | None () => (
            None () (*fcopt*), 0 (*lin*), None () (*efcopt*)
          ) // end of [None]
      ) : (funcloopt, int, effcstopt)
      val d1e_def = d0exp_lams_dyn_tr (
        knd, Some loc0, fcopt, lin, args, res, efcopt, d0e_def
      ) // end of [val]
//
      val ismet = d1exp_is_metric (d1e_def)
      val () = termination_metric_check (loc0, ismet, efcopt)
//
      val isbox = lamkind_isbox (knd) // HX: fixind = lamkind
      val knd = (if isbox > 0 then 1 else 0): int
//
    in
      FXITMatm (d1exp_fix (loc0, knd, id, d1e_def))
    end // end of [D0Efix]
//
  | D0Esel_lab (knd, lab) => let
      val d1l = d1lab_lab (loc0, lab)
      fn f (d1e: d1exp):<cloref1> d1expitm =
        let val loc = d1e.d1exp_loc + loc0 in
          FXITMatm (d1exp_sel (loc, knd, d1e, d1l))
        end // end of [let]
      // end of [f]
    in
      FXITMopr (loc0, FXOPRpos (select_prec, f))
    end // end of [D0Esel_lab]
(*
  | D0Esel_ind of (int(*knd*), d0explstlst(*ind*))
*)
// (*
  | _ => let
      val () = (
        print "d0e0 = "; fprint_d0exp (stdout_ref, d0e0); print_newline ()
      ) // end of [val]
      val () = assertloc (false) in $ERR.abort ()
    end
// *)
end (* end of [aux_item] *)
//
and aux_itemlst
  (d0e0: d0exp): d1expitmlst = let
  fun loop (d0e0: d0exp, res: d1expitmlst): d1expitmlst =
    case+ d0e0.d0exp_node of
    | D0Eapp (d0e1, d0e2) => let
        val res = aux_item d0e2 :: res in loop (d0e1, res)
      end // end of [D0Eapp]
    | _ => aux_item d0e0 :: res
  // end of [loop]
in
  loop (d0e0, list_nil ())
end // end of [aux_itemlist]
//
(*
val () = (
  print "d0exp_tr: d0e0 = "; fprint_d0exp (stdout_ref, d0e0); print_newline ()
) // end of [val]
*)
//
in
//
case+ aux_item (d0e0) of
| FXITMatm (p1t) => p1t
| FXITMopr _ => d0exp_tr_errmsg_opr (d0e0.d0exp_loc)
//
end // end of [d0exp_tr]

end // end of [local]

implement
d0explst_tr (xs) = l2l (list_map_fun (xs, d0exp_tr))

implement
d0expopt_tr (opt) = case+ opt of
  | Some (d0e) => Some (d0exp_tr d0e) | None () => None ()
// end of [d0expopt_tr]

(* ****** ****** *)

(* end of [pats_trans1_dynexp.sats] *)
