(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: April, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload
LAB = "pats_label.sats"
overload = with $LAB.eq_label_label
macdef prerr_label = $LAB.prerr_label

staload
LOC = "pats_location.sats"
stadef location = $LOC.location

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_selab"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

local

fun
labfind_context (
  l0: label
, ls2es: labs2explst
, context: &labs2explst
, err: &int
) : s2exp = let
in
//
case+ ls2es of
| list_cons (ls2e, ls2es) => let
    val SLABELED (l, name, s2e) = ls2e
  in
    if l0 = l then let
      val s2t = s2e.s2exp_srt
      val s2h = s2hole_make_srt (s2t)
      val s2e_ctx = s2exp_hole (s2h)
      val ls2e_ctx = SLABELED (l, name, s2e_ctx)
      val () = context := list_cons (ls2e_ctx, ls2es)
    in
      s2e
    end else let
      val s2e = labfind_context (l0, ls2es, context, err)
      val () = if (err = 0) then context := list_cons (ls2e, context)
    in
      s2e
    end // end of [if]
  end // end of [list_cons]
| list_nil () => let
    val () = err := err + 1 in s2exp_err (s2rt_t0ype)
  end // end of [list_nil]
//
end // end of [labfind_context]

fun auxlab (
  d3l: d3lab
, s2f: s2hnf
, l0: label
, context_vt: &s2expopt_vt? >> s2expopt_vt
) : s2exp = let
  val s2e = s2hnf2exp (s2f)
in
//
case+ s2e.s2exp_node of
| S2Etyrec (
    knd, npf, ls2es
  ) => let
    var context2 : labs2explst = list_nil
    var err: int = 0
    val s2e1 =
      labfind_context (l0, ls2es, context2, err)
    // end of [val]
    val () = if :(
      context_vt: s2expopt_vt
    ) =>
      (err > 0) then let
      val () = context_vt := None_vt
    in
      // nothing
    end else let
      val s2t = s2e.s2exp_srt
      val s2e_ctx =
        s2exp_tyrec_srt (s2t, knd, npf, context2)
      val () = context_vt := Some_vt (s2e_ctx)
    in
      // nothing
    end // end of [if]
    val () = if
      (err > 0) then let
      val loc = d3l.d3lab_loc
      val () = prerr_error3_loc (loc)
      val () = prerr ": the record-type ["
      val () = prerr_s2exp (s2e)
      val () = prerr "] is expected to contain the label ["
      val () = prerr_label (l0)
      val () = prerr "]."
      val () = prerr_newline ()
    in
      the_trans3errlst_add (T3E_d3exp_trup_selab_labnot (d3l))
    end // end of [val]
  in
    s2e1
  end // end of [S2Etyrec]
| _ => let
    val () = context_vt := None_vt () in s2exp_err (s2rt_t0ype)
  end // end of [_]
//
end // end of [auxlab]

fun auxsel (
  s2e: s2exp
, d3l: d3lab
, context_vt: &s2expopt_vt? >> s2expopt_vt
) : s2exp = let
  val s2f = s2exp2hnf (s2e)
in
//
case+ d3l.d3lab_node of
| D3LABlab (lab) =>
    auxlab (d3l, s2f, lab, context_vt)
  // end of [S3LABlab]
| D3LABind (ind) => let
    val () = context_vt := None_vt ()
  in
    s2exp_err (s2rt_t0ype)
  end // end of [D3LABind]
//
end // end of [auxsel]

and auxselist (
  s2e: s2exp
, d3ls: d3lablst
, context_vt: &s2expopt_vt? >> s2expopt_vt
) : s2exp = let
in
//
case+ d3ls of
| list_cons (
    d3l, list_nil ()
  ) => auxsel (s2e, d3l, context_vt)
| list_cons (d3l, d3ls) => let
    var context1: s2expopt_vt?
    var context2: s2expopt_vt?
    val s2e = auxsel (s2e, d3l, context1)
    val s2e = auxselist (s2e, d3ls, context2)
    val opt = (
      case+ context1 of
      | ~Some_vt s2e1_ctx => (
        case+ context2 of
        | ~Some_vt s2e2_ctx => s2exp_hrepl0 (s2e1_ctx, s2e2_ctx)
        | ~None_vt () => None_vt ()
        ) // end of [Some_vt]
      | ~None_vt () => (
        case+ context2 of
        | ~Some_vt _ => None_vt () | ~None_vt () => None_vt ()
        ) // end of [None_vt]
    ) : s2expopt_vt // end of [val]
    val () = context_vt := opt
  in
    s2e
  end // end of [list_cons]
| list_nil () => let
    val s2h =
      s2hole_make_srt (s2e.s2exp_srt)
    val s2e_ctx = s2exp_hole (s2h)
    val () = context_vt := Some_vt (s2e_ctx)
  in
    s2e
  end // end of [list_nil]
//
end // end of [auxselist]

in // in of [local]

implement
s2exp_get_dlablst_context
  (loc0, s2e, d3ls, context) = let
  var context_vt: s2expopt_vt // uninitialized
  val s2es2ps = auxselist (s2e, d3ls, context_vt)
  val () = (
    case+ context_vt of
    | ~Some_vt (s2e_ctx) => context := Some (s2e_ctx)
    | ~None_vt () => ()
  ) : void // end of [val]
in
  s2es2ps
end // end of [s2exp_get_dlablst_context]

end // end of [local]

(* ****** ****** *)

local

fun aux .<>. (
  loc0: location
, pfobj: pfobj
, d3ls: d3lablst
) : s2exp = let
  val+ ~PFOBJ (
    d2v, s2e_ctx, s2e_elt, s2l
  ) = pfobj // end of [val]
  var linrest: int = 0
  val (s2e_sel, s2ps) =
    s2exp_get_dlablst_linrest (loc0, s2e_elt, d3ls, linrest)
  // end of [val]
  val s2e_sel =
    s2exp_hnfize (s2e_sel)
  // end of [val]
  val islin = s2exp_is_lin (s2e_sel)
in
//
if islin then let
  val () = list_vt_free (s2ps)
  val s2t_elt = s2e_elt.s2exp_srt
  var context: s2expopt = None ()
  val s2e_sel =
    s2exp_get_dlablst_context (loc0, s2e_elt, d3ls, context)
  // end of [val]
  val () = (
    case+ context of
    | None () => {
        val () = prerr_error3_loc (loc0)
        val () = prerr ": the type of the selected component cannot be changed: "
        val () = prerr_newline ()
        val () = the_trans3errlst_add (T3E_s2addr_deref_context (loc0, s2e_elt, d3ls))
      } // end of [val]
    | Some _ => () // end of [_]
  ) : void // end of [val]
  val () = let
    val s2e_sel = s2exp_topize (1, s2e_sel)
    val s2e_elt = let
      val opt = s2expopt_hrepl0 (context, s2e_sel)
    in
      case+ opt of
      | ~Some_vt (s2e_elt) => s2e_elt | ~None_vt () => s2e_elt
    end : s2exp // end of [val]
    val s2e = let
      val- ~Some_vt (s2e) = s2exp_hrepl0 (s2e_ctx, s2e_elt) in s2e
    end : s2exp // end of [val]
    val () = d2var_set_type (d2v, Some (s2e))
  in
    // nothing
  end // end of [val]
in
  s2e_sel
end else let
  val () =
    trans3_env_add_proplst_vt (loc0, s2ps)
  // end of [val]
in
  s2e_sel
end // end of [if]
//
end // end of [aux]

in // in of [local]

implement
s2addr_deref
  (loc0, s2l, d3ls) = let
  val () =
    fprint_the_pfmanenv (stdout_ref)
  // end of [val]
  val opt = pfobj_search_atview (s2l)
in
  case+ opt of
  | ~Some_vt
      (pfobj) => aux (loc0, pfobj, d3ls)
  | ~None_vt () => s2exp_err (s2rt_t0ype)
end // end of [s2addr_deref]

end // end of [local]

(* ****** ****** *)

local

fun aux1 (
  loc0: location
, s2f0: s2hnf
, d3e: d3exp, d3ls: d3lablst
) : d3exp = let
  val opt = un_s2exp_ptr_addr_type (s2f0)
in
//
case+ opt of
| ~Some_vt (s2l) => let
    val s2e_sel =
      s2addr_deref (loc0, s2l, d3ls)
    // end of [val]
  in
    d3exp_sel_ptr (loc0, s2e_sel, d3e, d3ls)
  end // end of [Some_vt]
| ~None_vt () => aux2 (loc0, s2f0, d3e, d3ls)
//
end // end of [aux1]

and aux2 (
  loc0: location
, s2f0: s2hnf
, d3e: d3exp, d3ls: d3lablst
) : d3exp = let
  val opt = un_s2exp_ref_viewt0ype_type (s2f0)
in
//
case+ opt of
| ~Some_vt (s2e) => let
    var linrest: int = 0
    val (s2e_sel, s2ps) =
      s2exp_get_dlablst_linrest (loc0, s2e, d3ls, linrest)
    // end of [val]
    val () = trans3_env_add_proplst_vt (loc0, s2ps)
    val s2e_sel =
      s2exp_hnfize (s2e_sel)
    // end of [val]
    val islin = s2exp_is_lin (s2e_sel)
    val () = if islin then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": a linear component is taken out of a given reference."
      val () = prerr_newline ()
      val () = the_trans3errlst_add (T3E_d3exp_trup_deref_linsel (d3e, d3ls))
    } // end of [val]
  in
    d3exp_sel_ref (loc0, s2e_sel, d3e, d3ls)
  end // end of [Some_vt]
| ~None_vt () => aux3 (loc0, s2f0, d3e, d3ls)
//
end // end of [aux2]

and aux3 (
  loc0: location
, s2f0: s2hnf
, d3e: d3exp, d3ls: d3lablst
) : d3exp = let
in
  d3exp_err (loc0)
end // end of [aux3]

in // in of [local]

implement
d2exp_trup_deref
  (loc0, d2e, d2ls) = let
// (*
val () = (
  print "d2exp_trup_deref: d2e = "; print_d2exp (d2e); print_newline ()
) // end of [val]
// *)
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
