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
// Start Time: April, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement
prerr_FILENAME<> () = prerr "pats_trans3_assgn"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"
stadef loc_t = $LOC.location
overload + with $LOC.location_combine

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

local

fun
auxerr_proof
(
  loc0: loc_t, s2e: s2exp, d3ls: d3lablst, s2e_sel: s2exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": a non-proof component is replaced of the type"
  val () = prerrln! ("[", s2e_sel, "].")
in
  the_trans3errlst_add (T3E_s2addr_assgn_deref_proof (loc0, s2e, d3ls))
end // end of [auxerr_proof]

fun
auxerr_linsel
(
  loc0: loc_t, s2e: s2exp, d3ls: d3lablst, s2e_sel: s2exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": a linear component is abandoned of the type"
  val () = prerrln! (": [", s2e_sel, "].")
in
  the_trans3errlst_add (T3E_s2addr_assgn_deref_linsel (loc0, s2e, d3ls))
end // end of [auxerr_linsel]

fun
auxerr_context
(
  loc0: loc_t, s2e: s2exp, d3ls: d3lablst, s2e_sel: s2exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the type of the selected component cannot be changed"
  val () = prerrln! (": [", s2e_sel, "].")
in
  the_trans3errlst_add (T3E_s2addr_assgn_deref_context (loc0, s2e, d3ls))
end // end of [auxerr_context]

in (* in of [local] *)

extern
fun d2var_assgn_lin0
(
  loc0: loc_t, d2v: d2var, s2e_new: s2exp
) : void // end of [d2var_assgn_lin0]
extern
fun d2var_assgn_lin1
(
  loc0: loc_t, d2v: d2var, d3ls: d3lablst, s2e_new: s2exp
) : void // end of [d2var_assgn_lin1]
extern
fun d2var_assgn_lin01
(
  loc0: loc_t, d2v: d2var, d3ls: d3lablst, s2e_new: s2exp
) : void // end of [d2var_assgn_lin01]

implement
d2var_assgn_lin0
  (loc0, d2v, s2e_new) = let
  val opt = d2var_get_type (d2v)
in
//
case+ opt of
//
| None () =>
    d2var_set_type(d2v, Some(s2e_new))
  // end of [None]
//
| Some (s2e) => let
    val islin = s2exp_is_lin(s2e)
    val d3ls = list_nil and s2e_sel = s2e
    val () =
      if islin
        then auxerr_linsel(loc0, s2e, d3ls, s2e_sel)
      // end of [if]
  in
    d2var_set_type(d2v, Some(s2e_new))
  end // end of [Some]
//
end // end of [d2var_assgn_lin0]

implement
d2var_assgn_lin1
  (loc0, d2v, d3ls, s2e_new) = let
//
val s2e =
  d2var_get_type_some (loc0, d2v)
var ctxtopt: s2ctxtopt = None ()
val s2e_sel =
  s2exp_get_dlablst_context (loc0, s2e, d3ls, ctxtopt)
// end of [val]
val isprf = s2exp_is_prf (s2e_sel)
val () = if ~(isprf)
  then auxerr_proof (loc0, s2e, d3ls, s2e_sel)
val islin = s2exp_is_lin (s2e_sel)
val () = if  (islin)
  then auxerr_linsel (loc0, s2e, d3ls, s2e_sel)
val isctx = (
  case+ ctxtopt of Some _ => true | None _ => false
) : bool // end of [val]
val () = if ~(isctx)
  then auxerr_context (loc0, s2e, d3ls, s2e_sel)
val s2e = (
  case+ ctxtopt of
  | Some (ctxt) => s2ctxt_hrepl (ctxt, s2e_new) | None () => s2e
) : s2exp // end of [val]
val () = d2var_set_type (d2v, Some (s2e))
//
in
  // nothing
end // end of [d2var_assgn_lin1]

implement
d2var_assgn_lin01
(
  loc0, d2v, d3ls, s2e_new
) = let
  val () = d2var_inc_linval(d2v)
in
  case+ d3ls of
  | list_nil() =>
      d2var_assgn_lin0(loc0, d2v, s2e_new)
    // end of [list_nil]
  | list_cons _ =>
      d2var_assgn_lin1(loc0, d2v, d3ls, s2e_new)
    // end of [list_cons]
end // end of [d2var_assgn_lin01]

end // end of [local]

(* ****** ****** *)

local

fun
auxerr_pfobj
(
  loc0: loc_t, s2l: s2exp
) : void = let
//
  val () = prerr_error3_loc (loc0)
//
  val () =
  prerr (": assignment cannot be performed")
  val () =
  prerrln! (
    ": proof search for the view at [", s2l, "] failed."
  ) (* prerrln! *)
in
  the_trans3errlst_add(T3E_pfobj_search_none(loc0, s2l))
end // end of [auxerr_pfobj]

fun
auxerr_sharing
(
  loc0: loc_t, s2e_elt: s2exp, d3ls: d3lablst
) : void = let
//
  val () = prerr_error3_loc (loc0)
//
  val () =
  prerrln! (
    ": a boxed non-linear record is selected for field-update."
  ) (* prerrln! *)
in
//
the_trans3errlst_add
  (T3E_s2addr_assgn_deref_sharing(loc0, s2e_elt, d3ls))
//
end // end of [auxerr_sharing]

fun
auxerr_linsel
(
  loc0: loc_t
, s2e_elt: s2exp, d3ls: d3lablst, s2e_sel: s2exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () =
  prerr (
    ": a linear component of the following type is abandoned: "
  ) (* prerr *)
  val () = prerrln! ("[", s2e_sel, "].")
in
  the_trans3errlst_add
    (T3E_s2addr_assgn_deref_linsel(loc0, s2e_elt, d3ls))
  // the_trans3errlst_add
end // end of [auxerr_linsel]

fun
auxck_tszeq
(
  loc0: loc_t
, s2e1: s2exp, s2e2: s2exp
) : void = let
//
val
tszeq = s2exp_tszeq (s2e1, s2e2)
//
in
//
if ~tszeq then let
//
  val () =
  prerr_error3_loc (loc0)
//
  val () = prerr ": assignment cannot be performed"
  val () = prerr ": mismatch of bef/aft type-sizes:\n"
  val () = (prerr "bef: ["; prerr_s2exp (s2e1); prerr "]")
  val () = prerr_newline ((*void*))
  val () = (prerr "aft: ["; prerr_s2exp (s2e2); prerr "]")
  val () = prerr_newline ((*void*))
//
in
  the_trans3errlst_add(T3E_s2exp_assgn_tszeq(loc0, s2e1, s2e2))
end // end of [if] // end of [val]
//
end // end of [auxck_tszeq]

fun
auxmain .<>.
(
  loc0: loc_t
, pfobj: pfobj
, d3ls: d3lablst
, d3e_r: d3exp
, s2rt: &s2exp? >> s2exp
) : d3exp = let
val+~PFOBJ
(
  d2vw, s2e_ctx, s2e_elt, s2l
) = pfobj
//
(*
val () = println! ("auxmain: s2e_ctx = ", s2e_ctx)
val () = println! ("auxmain: s2e_elt = ", s2e_elt)
*)
//
val () = s2rt := s2e_elt
//
var linrest: int = 0 and sharing: int = 0
//
val (s2e_sel, s2ps) =
  s2exp_get_dlablst_linrest_sharing
    (loc0, s2e_elt, d3ls, linrest, sharing)
  // s2exp_get_dlablst_linrest_sharing
val ((*void*)) =
  if sharing > 0
    then auxerr_sharing (loc0, s2e_elt, d3ls)
  // end of [if]
//
val s2e_sel = s2exp_hnfize (s2e_sel)
val ((*void*)) = trans3_env_add_proplst_vt (loc0, s2ps)
//
val islin = s2exp_is_lin (s2e_sel)
val ((*void*)) =
  if islin
    then auxerr_linsel (loc0, s2e_elt, d3ls, s2e_sel)
  // end of [if]
//
var ctxtopt: s2ctxtopt = None ()
val _(*s2e_sel*) =
  s2exp_get_dlablst_context (loc0, s2e_elt, d3ls, ctxtopt)
// end of [val]
in
//
case+ ctxtopt of
//
| Some(ctxt) =>
    d3e_r where {
//
    val () = d3exp_open_and_add(d3e_r)
    val s2e_sel2 = d3exp_get_type(d3e_r)
//
    val () = auxck_tszeq(loc0, s2e_sel, s2e_sel2)
//
    val () = d2var_inc_linval (d2vw)
//
    val
    s2e_elt = s2ctxt_hrepl(ctxt, s2e_sel2)
//
    val s2e0 = s2exp_hrepl(s2e_ctx, s2e_elt)
//
    val ((*void*)) = d2var_set_type (d2vw, Some(s2e0))
//
  } (* end of [Some] *)
//
| None((*void*)) => d3exp_trdn (d3e_r, s2e_sel) // HX: assignment changes no type
//
end // end of [auxmain]

in (* in of [local] *)

implement
s2addr_assgn_deref
(
  loc0, s2l, d3ls, d3e_r, s2rt
) = let
//
val opt = pfobj_search_atview (s2l)
//
in
  case+ opt of
  | ~Some_vt (pfobj) =>
      auxmain(loc0, pfobj, d3ls, d3e_r, s2rt)
    // end of [Some_vt]
  | ~None_vt ((*void*)) => let
      val () =
        s2rt := s2exp_t0ype_err()
      // end of [val]
      val () = auxerr_pfobj(loc0, s2l) in d3e_r
    end // end of [None_vt]
end // end of [s2addr_assgn_deref]

end // end of [local]

(* ****** ****** *)

local

fun auxerr_nonderef
  (d3e: d3exp): void = let
//
  val loc = d3e.d3exp_loc
//
  val () = prerr_error3_loc (loc)
//
  val () =
  prerrln! (
    ": the dynamic expression cannot be dereferenced."
  ) (* prerrln! *)
//
in
  the_trans3errlst_add(T3E_d3exp_nonderef(d3e))
end // end of [auxerr_nonderef]

fun
auxerr_refsharing
(
  loc0: loc_t, d3e_l: d3exp, d3ls: d3lablst
) : void = let
//
  val () = prerr_error3_loc (loc0)
//
  val () =
  prerrln! (
    ": a boxed non-linear record is selected for field-update."
  ) (* prerrln! *)
  // end of [val]
//
in
  the_trans3errlst_add(T3E_d3exp_assgn_deref_refsharing(d3e_l, d3ls))
end // end of [auxerr_refsharing]

fun
auxerr_reflinsel
(
  loc0: loc_t
, d3e_l: d3exp, d3ls: d3lablst, s2e_sel: s2exp
) : void = let
//
  val () = prerr_error3_loc (loc0)
//
  val () =
  prerr (
    ": a linear component of the following type is abandoned: "
  ) (* prerr *)
//
  val () = prerrln! ("[", s2e_sel, "]")
//
in
  the_trans3errlst_add (T3E_d3exp_assgn_deref_reflinsel (d3e_l, d3ls))
end // end of [auxerr_reflinsel]

fun aux1
(
  loc0: loc_t
, s2f0: s2hnf
, d3e_l: d3exp
, d3ls: d3lablst
, d3e_r: d3exp
) : d3exp = let
//
val opt =
  un_s2exp_ptr_addr_type(s2f0)
//
in
//
case+ opt of
//
| ~None_vt() =>
    aux2(loc0, s2f0, d3e_l, d3ls, d3e_r)
  // end of [None_vt]
//
| ~Some_vt(s2l) => let
    var
    s2rt: s2exp
    val
    d3e_r =
    s2addr_assgn_deref
      (loc0, s2l, d3ls, d3e_r, s2rt)
    // end of [val]
  in
    d3exp_assgn_ptr(loc0, d3e_l, s2rt, d3ls, d3e_r)
  end // end of [Some_vt]
//
end // end of [aux1]

and aux2
(
  loc0: loc_t
, s2f0: s2hnf
, d3e_l: d3exp
, d3ls: d3lablst
, d3e_r: d3exp
) : d3exp = let
  val opt = un_s2exp_ref_vt0ype_type (s2f0)
in
//
case+ opt of
| ~Some_vt (s2e) => let
    val s2rt = s2e // HX: selection root
//
    var linrest: int = 0
    and sharing: int = 0
//
    val (s2e_sel, s2ps) =
    s2exp_get_dlablst_linrest_sharing
    (
      loc0, s2rt, d3ls, linrest, sharing
    ) (* s2exp_get_dlablst_linrest_sharing *)
//
    val () =
    if sharing > 0
      then auxerr_refsharing (loc0, d3e_l, d3ls)
    // end of [if]
//
    val s2e_sel = s2exp_hnfize (s2e_sel)
    val () = trans3_env_add_proplst_vt (loc0, s2ps)
    val islin = s2exp_is_lin (s2e_sel)
    val () =
    if islin
      then auxerr_reflinsel (loc0, d3e_l, d3ls, s2e_sel)
    // end of [if]
    val d3e_r = d3exp_trdn (d3e_r, s2e_sel)
    val _(*err*) = the_effenv_check_ref (loc0)
  in
    d3exp_assgn_ref (loc0, d3e_l, s2rt, d3ls, d3e_r)
  end // end of [Some_vt]
| ~None_vt () => aux3 (loc0, s2f0, d3e_l, d3ls, d3e_r)
//
end // end of [aux2]

and aux3
(
  loc0: loc_t
, s2f0: s2hnf
, d3e_l: d3exp
, d3ls: d3lablst
, d3e_r: d3exp
) : d3exp = let
  val () = auxerr_nonderef (d3e_l) in d3exp_errexp_void (loc0)
end // end of [aux3]

in (* in of [local] *)

implement
d2exp_trup_assgn_deref
  (loc0, d2e_l, d2ls, d2e_r) = let
(*
//
val () = (
  println! ("d2exp_trup_assgn_deref: d2e_l = ", d2e_l);
  println! ("d2exp_trup_assgn_deref: d2e_r = ", d2e_r);
) (* end of [val] *)
//
*)
val d3e_l = d2exp_trup (d2e_l)
val ((*void*)) = d3exp_open_and_add (d3e_l)
//
val d3ls = d2lablst_trup (d2ls)
val s2e0 = d3exp_get_type (d3e_l)
val s2f0 = s2exp2hnf_cast (s2e0)
//
val d3e_r = d2exp_trup (d2e_r)
val ((*void*)) = d3exp_open_and_add (d3e_r)
//
in
  aux1 (loc0, s2f0, d3e_l, d3ls, d3e_r)
end // end of [d2exp_trup_assgn_deref]

end // end of [local]

(* ****** ****** *)

local

fun
auxerr_wrt_if
  (loc0: loc_t): void = let
  val err = the_effenv_check_wrt (loc0)
in
//
if (
err > 0
) then (
  the_trans3errlst_add(T3E_d2exp_trup_wrt(loc0))
) (* end of [then] *)
//
end // end of [auxerr_wrt]

in (* in of [local] *)

implement
d2exp_trup_assgn
  (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Eassgn(d2e_l, d2e_r) = d2e0.d2exp_node
val d2lv = d2exp_lvalize(d2e_l)
(*
val () = (
  println! ("d2exp_trup_assgn: d2lv = ", d2lv)
) (* end of [val] *)
*)
//
in
//
case+ d2lv of
//
| D2LVALvar_mut
    (d2v, d2ls) => let
//
    val-
    Some(s2l) =
      d2var_get_addr(d2v)
    // end of [val]
//
    val d3ls  = d2lablst_trup(d2ls)
//
    var s2rt  : s2exp
    val d3e_r = d2exp_trup(d2e_r)
    val ()    = d3exp_open_and_add(d3e_r)
    val d3e_r =
      s2addr_assgn_deref(loc0, s2l, d3ls, d3e_r, s2rt)
    // end of [val]
    val ((*void*)) =
      if d3exp_isnot_prf(d3e_r) then auxerr_wrt_if(loc0)
    // end of [val]
  in
    d3exp_assgn_var(loc0, d2v, s2rt, d3ls, d3e_r)
  end // end of [D2LVALvar_mut]
//
| D2LVALvar_lin
    (d2v, d2ls) => let
    val loc_l = d2e_l.d2exp_loc
    val d3ls  = d2lablst_trup (d2ls)
    val d3e_r = d2exp_trup (d2e_r)
    val ()    = d3exp_open_and_add (d3e_r)
    val s2e_r = d3exp_get_type (d3e_r)
    val opt   = d2var_get_type (d2v)
    val s2rt  =
    (
      case+ opt of
      | Some (s2e) => s2e
      | None ((*void*)) => s2exp_void_t0ype()
    ) : s2exp // end of [val]
    val () =
      d2var_assgn_lin01(loc_l, d2v, d3ls, s2e_r)
    // end of [val]
  in
    d3exp_assgn_var(loc0, d2v, s2rt, d3ls, d3e_r)
  end // end of [D2LVALvar_lin]
//
| D2LVALderef
    (d2e_l, d2ls) => let
    val () = auxerr_wrt_if(loc0)
  in
    d2exp_trup_assgn_deref(loc0, d2e_l, d2ls, d2e_r)
  end // end of [D2LVALd2ref]
//
| D2LVALviewat _ => d2exp_trup_viewat_assgn (d2e0)
//
| D2LVALarrsub
  (
    d2s, arr, loc_ind, ind // d2s: lrbrackets
  ) => let
//
    val d2es =
      list_vt_cons(arr, list_extend(ind, d2e_r))
    // end of [val]
//
    val d2a0 =
      D2EXPARGdyn(~1(*npf*), loc0, (l2l)d2es)
    val d3e_sub =
      d2exp_trup_applst_sym(d2e0, d2s, list_sing(d2a0))
    // end of [val]
//
  in
    d3exp_trdn (d3e_sub, s2exp_void_t0ype((*void*)))
  end // [D2LVALarrsub]
//
| _ (*rest-of-d2lv*) => let
    val opt = d2exp_get_seloverld (d2e_l)
  in
    case+ opt of
    | Some (d2s) => let
        val _top = d2exp_top(loc0)
        val d2e0 = d2exp_get_seloverld_root (d2e_l)
        val d2a0 =
          D2EXPARGdyn (~1(*npf*), loc0, list_pair(d2e0, d2e_r))
        val d3e_sel =
          d2exp_trup_applst_sym ((*d2e*)_top, d2s, list_sing(d2a0))
        // end of [val]
      in
        d3exp_trdn (d3e_sel, s2exp_void_t0ype ())
      end // end of [Some]
    | None ((*void*)) => let
        val loc_l = d2e_l.d2exp_loc
        val () = prerr_error3_loc (loc_l)
        val () = prerr ": a left-value is required but a non-left-value is given."
        val () = prerr_newline ((*void*))
        val () = the_trans3errlst_add (T3E_d2exp_nonlval (d2e_l))
      in
        d3exp_errexp_void (loc0)
      end // end of [None]
  end // end of [rest-of-d2lv]
//
end // end of [d2exp_trup_assgn]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_assgn.dats] *)
