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

staload
LAB = "./pats_label.sats"
overload = with $LAB.eq_label_label
macdef prerr_label = $LAB.prerr_label

(* ****** ****** *)

staload
LOC = "./pats_location.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_deref"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_stacst2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

local

fun
auxerr_pfobj
(
  loc0: loc_t, s2l: s2exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": dereference cannot be performed"
  val () = prerr ": the proof search for view located at ["
  val () = prerr_s2exp (s2l)
  val () = prerr "] failed to turn up a result."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_pfobj_search_none (loc0, s2l))
end // end of [auxerr_pfobj]

fun
auxmain .<>.
(
  loc0: loc_t
, pfobj: pfobj
, d3ls: d3lablst
, s2rt: &s2exp? >> s2exp
) : s2exp = let
  val+~PFOBJ (
    d2vw, s2e_ctx, s2e_elt, s2l
  ) = pfobj
  val () = s2rt := s2e_elt
  var linrest: int = 0 and sharing: int = 0
  val (s2e_sel, s2ps) =
    s2exp_get_dlablst_linrest_sharing (loc0, s2e_elt, d3ls, linrest, sharing)
  val s2e_sel = s2exp_hnfize (s2e_sel)
  val () = trans3_env_add_proplst_vt (loc0, s2ps)
  val islin = s2exp_is_lin (s2e_sel)
in
//
if islin then let
  val s2t_elt = s2e_elt.s2exp_srt
  var ctxtopt: s2ctxtopt = None ()
  val s2e_sel =
    s2exp_get_dlablst_context (loc0, s2e_elt, d3ls, ctxtopt)
  // end of [val]
  val isctx = (
    case+ ctxtopt of Some _ => true | None _ => false
  ) : bool // end of [val]
  val () = if ~isctx then {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the linear component cannot taken out."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_s2addr_deref_context (loc0, s2e_elt, d3ls))
  } // end of [val]
//
  val () = d2var_inc_linval (d2vw)
  val () = let
    val s2e_sel = s2exp_topize (1, s2e_sel)
    val s2e_elt = (
      case+ ctxtopt of
      | Some (ctxt) => s2ctxt_hrepl (ctxt, s2e_sel) | None () => s2e_elt
    ) : s2exp // end of [val]
    val s2e = s2exp_hrepl (s2e_ctx, s2e_elt)
    val () = d2var_set_type (d2vw, Some (s2e))
  in
    // nothing
  end // end of [val]
//
in
  s2e_sel
end else s2e_sel // end of [if]
//
end // end of [auxmain]

in // in of [local]

implement
s2addr_deref
  (loc0, s2l, d3ls, s2rt) = let
  val opt = pfobj_search_atview (s2l)
in
  case+ opt of
  | ~Some_vt (pfobj) =>
      auxmain (loc0, pfobj, d3ls, s2rt)
  | ~None_vt () => let
      val s2e_sel =
        s2exp_t0ype_err ()
      // end of [val]
      val () = s2rt := s2e_sel
      val () = auxerr_pfobj (loc0, s2l)
    in
      s2e_sel
    end // end of [None]
end // end of [s2addr_deref]

end // end of [local]

(* ****** ****** *)

local

fun
auxerr_nonderef
(
  loc0: loc_t, d3e: d3exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the dynamic expression cannot be dereferenced."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3exp_nonderef (d3e))
end // end of [auxerr_nonderef]

fun
auxerr_reflinsel
(
  loc0: loc_t
, d3e: d3exp, d3ls: d3lablst, s2e_sel: s2exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerrln! (": the linear component cannot taken out.")
in
  the_trans3errlst_add (T3E_d3exp_deref_reflinsel (d3e, d3ls))
end // end of [auxerr_reflinsel]

fun aux1
(
  loc0: loc_t
, s2f0: s2hnf, d3e: d3exp, d3ls: d3lablst
) : d3exp = let
//
  val opt = un_s2exp_ptr_addr_type (s2f0)
//
in
//
case+ opt of
| ~Some_vt (s2l) => let
    var s2rt: s2exp
    val s2e_sel =
      s2addr_deref (loc0, s2l, d3ls, s2rt)
    // end of [val]
  in
    d3exp_sel_ptr (loc0, s2e_sel, d3e, s2rt, d3ls)
  end // end of [Some_vt]
| ~None_vt () => aux2 (loc0, s2f0, d3e, d3ls)
//
end // end of [aux1]

and aux2
(
  loc0: loc_t
, s2f0: s2hnf, d3e: d3exp, d3ls: d3lablst
) : d3exp = let
//
  val opt = un_s2exp_ref_vt0ype_type (s2f0)
//
in
//
case+ opt of
| ~Some_vt (s2e) => let
    var s2rt = s2e
    var linrest: int = 0 and sharing: int = 0
    val (s2e_sel, s2ps) =
      s2exp_get_dlablst_linrest_sharing (loc0, s2e, d3ls, linrest, sharing)
    val s2e_sel = s2exp_hnfize (s2e_sel)
    val () = trans3_env_add_proplst_vt (loc0, s2ps)
    val islin = s2exp_is_lin (s2e_sel)
    val () = if islin then auxerr_reflinsel (loc0, d3e, d3ls, s2e_sel)
    val _(*err*) = the_effenv_check_ref (loc0)
  in
    d3exp_sel_ref (loc0, s2e_sel, d3e, s2rt, d3ls)
  end // end of [Some_vt]
| ~None_vt () => aux3 (loc0, s2f0, d3e, d3ls)
//
end // end of [aux2]

and aux3
(
  loc0: loc_t
, s2f0: s2hnf
, d3e: d3exp, d3ls: d3lablst
) : d3exp = let
//
// HX: [d3ls] is ignored!!!
//
  val opt = un_s2exp_lazy_t0ype_type (s2f0)
in
//
case+ opt of
| ~Some_vt (s2e) =>
    d3exp_lazyeval (loc0, s2e, 0(*lin*), d3e)
| ~None_vt () => let
    val opt = un_s2exp_lazy_vt0ype_vtype (s2f0)
  in
  //
  case+ opt of
  | ~Some_vt (s2e) =>
      d3exp_lazyeval (loc0, s2e, 1(*lin*), d3e)
  | ~None_vt () => let
      val () = auxerr_nonderef (loc0, d3e) in d3exp_err (loc0)
    end // end of [None_vt]
  //
  end // end of [None_vt]
//
end // end of [aux3]

in // in of [local]

implement
d2exp_trup_deref
  (loc0, d2e, d2ls) = let
(*
val () = (
  print "d2exp_trup_deref: d2e = "; print_d2exp (d2e); print_newline ()
) // end of [val]
*)
val d3e = d2exp_trup (d2e)
val d3ls = d2lablst_trup (d2ls)
val () = d3exp_open_and_add (d3e)
val s2e0 = d3exp_get_type (d3e)
val s2f0 = s2exp2hnf_cast (s2e0)
//
in
  aux1 (loc0, s2f0, d3e, d3ls)
end // end of [d2exp_trup_deref]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_deref.dats] *)
