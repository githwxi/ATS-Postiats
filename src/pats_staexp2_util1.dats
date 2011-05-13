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

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fn prerr_error2_loc
  (loc: location): void = (
  $LOC.prerr_location loc; prerr ": error(2)"
) // end of [prerr_error2_loc]

(* ****** ****** *)

local

#define CLO 0
#define CLOPTR 1
#define CLOREF ~1

in // in of [local]

implement
s2rt_prf_lin_fc (
  loc0, isprf, islin, fc
) = begin
  if isprf then begin
    (if islin then s2rt_view else s2rt_prop)
  end else begin case+ islin of
    | _ when islin => begin case+ fc of
      | FUNCLOclo (knd) => begin case+ knd of
        | CLO(*0*) => s2rt_viewt0ype
        | CLOPTR(*1*) => s2rt_viewtype
        | _ (*CLOREF*) => s2rt_err () where {
            val () = prerr_error2_loc (loc0)
            val () = prerr ": a closure reference cannot be linear."
            val () = prerr_newline ()
          } // end of [_]
        end (* end of [FUNCLOclo] *)
      | FUNCLOfun () => s2rt_viewtype
      end // end of [_ when islin]
    | _ => begin case+ fc of
      | FUNCLOclo (knd) => begin case+ knd of
        | CLO => s2rt_t0ype
        | CLOPTR => s2rt_viewtype (*ptr*)
        | _ (*CLOREF*) => s2rt_type (*ref*)
        end // end of [FUNCLOclo]
      | FUNCLOfun () => s2rt_type
      end // end of [_]
  end (* end of [if] *)
end // end of [s2rt_prf_lin_fc]

end // end of [local]

(* ****** ****** *)

implement
s2exp_alpha (s2v, s2v_new, s2e) = s2e

(* ****** ****** *)

implement
s2explst_alpha
  (s2v, s2v_new, s2es) = let
  var !p_clo = @lam
    (pf: !unit_v | s2e: s2exp): s2exp => s2exp_alpha (s2v, s2v_new, s2e)
  // end of [var]
  prval pfu = unit_v ()
  val s2es = list_map_clo (pfu | s2es, !p_clo)
  prval unit_v () = pfu
in
  l2l (s2es)
end // end of [s2explst_alpha]

(* ****** ****** *)

implement
s2cst_select_locs2explstlst (s2cs, xss) = let
//
  fun test1 (
    xs: locs2explst, s2ts: s2rtlst
  ) : bool =
    case+ xs of
    | list_cons (x, xs) => (case+ s2ts of
      | list_cons (s2t, s2ts) => let
          val s2e = x.1 in
          if s2rt_ltmat0 (s2e.s2exp_srt, s2t) then test1 (xs, s2ts) else false
        end // end of [list_cons]
      | list_nil () => false
      ) // end of [list_cons]
    | list_nil () => (case+ s2ts of
      | list_cons _ => false | list_nil () => true
      ) // end of [list_nil]
  (* end of [test1] *)
//
  fun test2 (
    s2t: s2rt, xss: List (locs2explst)
  ) : bool =
    case+ xss of
    | list_cons (xs, xss) => (
        if s2rt_is_fun (s2t) then let
          val- S2RTfun (s2ts_arg, s2t_res) = s2t
        in
          if test1 (xs, s2ts_arg) then test2 (s2t_res, xss) else false
        end else false
      ) // end of [list_cons]
    | list_nil () => true
  (* end of [test2] *)
//
  fun filter (
    s2cs: s2cstlst, xss: List (locs2explst)
  ) : s2cstlst =
    case+ s2cs of
    | list_cons (s2c, s2cs) => let
(*
        val () = print "s2cst_select_locs2explstlst: filter: s2c = "
        val () = print_s2cst (s2c)
        val () = print_newline ()
*)
        val s2t = s2cst_get_srt (s2c)
(*
        val () = print "s2cst_select_locs2explstlst: filter: s2t = ";
        val () = print_s2rt (s2t)
        val () = print_newline ()
*)
      in
        if test2 (s2t, xss) then
          list_cons (s2c, filter (s2cs, xss)) else filter (s2cs, xss)
        // end of [if]
      end // end of [S2CSTLSTcons]
    | list_nil () => list_nil ()
  (* end of [filter] *)
//
in
  if list_is_sing (s2cs)
    then s2cs else filter (s2cs, xss)
  // end of [if]
end // end of [s2cst_select_locs2explstlst]

(* ****** ****** *)

(* end of [pats_staexp2_util1.dats] *)
