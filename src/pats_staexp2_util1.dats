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

implement
s2rt_linearize
  (s2t) = let
  var err: int = 0
  var s2t: s2rt = s2t
  val () = case+ s2t of
    | S2RTbas s2tb => (case+ s2tb of
      | S2RTBASimp (name, knd) => let
          val knd = impkind_linearize (knd)
        in
          s2t := S2RTbas (S2RTBASimp (name, knd))
        end // end of [S2RTBASimp]
      | _ => err := 1
      ) // end of [S2RTbas]
    | _ => err := 1
(*
  val () = assertloc (err > 0) // [s2t] maybe [S2RTerr]
*)
in
  s2t
end // end of [s2rt_linearize]

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
s2rt_npf_lin_prf_boxed
  (npf, lin, prf, boxed) =
  if npf >= 0 then (
    if lin = 0 then
      if boxed > 0 then s2rt_type else s2rt_t0ype
    else
      if boxed > 0 then s2rt_viewtype else s2rt_viewt0ype
    // end of [if]
  ) else (
    if prf = 0 then (
      if lin = 0 then
        if boxed > 0 then s2rt_type else s2rt_t0ype
      else
        if boxed > 0 then s2rt_viewtype else s2rt_viewt0ype
      // end of [if]
    ) else
      if lin = 0 then
        if boxed > 0 then s2rt_type else s2rt_prop
      else
        if boxed > 0 then s2rt_viewtype else s2rt_view
      // end of [if]
  ) (* end of [if] *)
// end of [s2rt_lin_prg_boxed]

implement
s2rt_npf_lin_prf_prgm_boxed_labs2explst
  (npf, lin, prf, prgm, boxed, ls2es) = let
//
(*
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: npf = "
  val () = fprint_int (stdout_ref, npf)
  val () = print_newline ()
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: lin = "
  val () = fprint_int (stdout_ref, lin)
  val () = print_newline ()
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: prf = "
  val () = fprint_int (stdout_ref, prf)
  val () = print_newline ()
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: prgm = "
  val () = fprint_int (stdout_ref, prgm)
  val () = print_newline ()
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: boxed = "
  val () = fprint_int (stdout_ref, boxed)
  val () = print_newline ()
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: labs2explst = "
  val () = fprint_labs2explst (stdout_ref, ls2es)
  val () = print_newline ()
*)
//
fun aux (
  npf: int, lin: int, xs: labs2explst
) : s2rt =
  if npf > 0 then let
    val- list_cons (_, xs) = xs
  in
    aux (npf-1, lin, xs)
  end else let
    val- list_cons (x, xs) = xs
    val s2e = x.1
    val s2t = s2e.s2exp_srt
(*
    val () = (print "aux: s2t = "; print_s2rt (s2t); print_newline ())
*)
  in
    if s2rt_is_prf (s2t) then
      aux (0(*npf*), lin, xs) // HX: [xs] cannot be nil
    else (
      if lin = 0 then s2t else s2rt_linearize (s2t)
    ) // end of [if]
  end (* end of [if] *)
// end of [aux]
in
  if prgm = 0 then
    s2rt_npf_lin_prf_boxed (npf, lin, prf, boxed)
  else
    aux (npf, lin, ls2es)
  // end of [if]
end // end of [s2rt_npf_lin_prf_prgm_boxed_labs2explst]

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

local

#define :: list_cons
assume stasub_type = List @(s2var, s2exp)

in // in of [local]

implement
stasub_make_nil () = list_nil ()

implement
stasub_add (sub, s2v, s2e) = (s2v, s2e) :: sub

implement
stasub_get_domain (sub) = let
  typedef a = (s2var, s2exp) and b = s2var
in
  list_map_fun<a><b> (sub, lam (x) =<0> x.0)
end // end of [stasub_get_domain]

(* ****** ****** *)

extern
fun s2exp_subst_flag
  (sub: stasub, s2e: s2exp, flag: &int): s2exp
// end of [s2exp_subst_flag]
extern
fun s2explst_subst_flag
  (sub: stasub, s2es: s2explst, flag: &int): s2explst
// end of [s2explst_subst_flag]

implement
s2exp_subst_flag (sub, s2e, flag) = s2e

implement
s2explst_subst_flag
  (sub, s2es0, flag) =
  case+ s2es0 of
  | list_cons (s2e, s2es) => let
      val flag0 = flag
      val s2e = s2exp_subst_flag (sub, s2e, flag)
      val s2es = s2explst_subst_flag (sub, s2es, flag)
    in
      if flag > flag0 then s2e :: s2es else s2es0
    end (* end of [::] *)
  | list_nil () => list_nil ()
// end of [s2explst_subst_flag]

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
  val s2es = list_map_vclo (pfu | s2es, !p_clo)
  prval unit_v () = pfu
in
  l2l (s2es)
end // end of [s2explst_alpha]

(* ****** ****** *)

implement
s2exp_subst (sub, s2e) = let
  var flag: int = 0 in s2exp_subst_flag (sub, s2e, flag)
end // end of [s2exp_subst]

implement
s2explst_subst (sub, s2es) = let
  var flag: int = 0 in s2explst_subst_flag (sub, s2es, flag)
end // end of [s2explst_subst]

(* ****** ****** *)

(* end of [pats_staexp2_util1.dats] *)
