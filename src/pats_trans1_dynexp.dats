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

extern
fun d1exp_app_syndef
  (loc: location, d1e1: d1exp, d1e2: d1exp): d1exp
// end of [d1exp_app_syndef]

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
//
  | D0Echar x => FXITMatm (d1exp_char (loc0, x))
  | D0Efloat x => FXITMatm (d1exp_float (loc0, x))
  | D0Estring x => FXITMatm (d1exp_string (loc0, x))
  | D0Ecstsp x => FXITMatm (d1exp_cstsp (loc0, x))
  | D0Eempty () => FXITMatm (d1exp_empty (loc0))
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
      end // end of [P0Tapp]
    | _ => aux_item d0e0 :: res
  // end of [loop]
in
  loop (d0e0, list_nil ())
end // end of [aux_itemlist]
//
in
//
case+ aux_item (d0e0) of
| FXITMatm (p1t) => p1t
| FXITMopr _ => d0exp_tr_errmsg_opr (d0e0.d0exp_loc)
//
end // end of [d0exp_tr]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans1_dynexp.sats] *)
