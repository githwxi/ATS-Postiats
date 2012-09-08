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
// Start Time: September, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_typerase.sats"

(* ****** ****** *)

extern
fun labhipatlst_get_labhisexplst (lxs: labhipatlst): labhisexplst
implement
labhipatlst_get_labhisexplst
  (lxs) = let
//
  fun f (lx: labhipat): labhisexp = let
    val LABHIPAT (l, x) = lx
  in
    HSLABELED (l, None(*name*), x.hipat_type)
  end // end of [f]
//
  val lhses = list_map_fun (lxs, f)
//
in
  list_of_list_vt (lhses)
end // end of [labhipatlst_get_labhisexplst]

(* ****** ****** *)

extern
fun p3atlst_npf_tyer (npf: int, p3ts: p3atlst): hipatlst
extern
fun labp3atlst_npf_tyer (npf: int, lp3ts: labp3atlst): labhipatlst

(* ****** ****** *)

implement
p3at_tyer (p3t0) = let
//
val loc0 = p3t0.p3at_loc
val s2e0 = p3at_get_type (p3t0)
val hse0 = s2exp_tyer_shallow (loc0, s2e0)
//
(*
val () = println! ("p3at_tyer: p3t0 = ", p3t0)
val () = println! ("p3at_tyer: s2e0 = ", s2e0)
val () = println! ("p3at_tyer: hse0 = ", hse0)
*)
//
in
//
case+ p3t0.p3at_node of
//
| P3Tbool
    (b) => hipat_bool (loc0, hse0, b)
| P3Tchar
    (c) => hipat_char (loc0, hse0, c)
| P3Tstring
    (str) => hipat_string (loc0, hse0, str)
//
| P3Tempty () => hipat_empty (loc0, hse0)
//
| P3Trec (
    knd, npf, lp3ts
  ) => let
    val lhips =
      labp3atlst_npf_tyer (npf, lp3ts)
    val lhses = labhipatlst_get_labhisexplst (lhips)
    val recknd = (
      if knd > 0 then TYRECKINDbox() else TYRECKINDflt0()
    ) : tyreckind
    val hse_rec = hisexp_tyrec (recknd, lhses)
  in
    hipat_rec (loc0, hse0, knd, lhips, hse_rec)
  end // end of [P3Trec]
| P3Tlst (
    lin, s2e_elt, p3ts
  ) => let
    val hse_elt =
      s2exp_tyer_shallow (loc0, s2e_elt)
    val hips = p3atlst_tyer (p3ts)
  in
    hipat_lst (loc0, hse0, hse_elt, hips)
  end // end of [P3Tlst]
//
| P3Tann
    (p3t, s2e_ann) => let
    val hip = p3at_tyer (p3t)
    val hse_ann = s2exp_tyer_shallow (loc0, s2e_ann)
  in
    hipat_ann (loc0, hse0, hip, hse_ann)
  end // end of [P3Tann]
//
| _ => exitloc (1)
//
end // endof [p3at_tyer]

(* ****** ****** *)

implement
p3atlst_tyer
  (p3ts) = let
  val hips =
    list_map_fun (p3ts, p3at_tyer)
  // end of [val]
in
  list_of_list_vt (hips)
end // end of [p3atlst_tyer]

(* ****** ****** *)

implement
p3atlst_npf_tyer
  (npf, p3ts) = let
in
  if npf > 0 then let
    val- list_cons (_, p3ts) = p3ts
  in
    p3atlst_npf_tyer (npf-1, p3ts)
  end else
    p3atlst_tyer (p3ts)
  // end of [if]
end // end of [p3atlst_npf_tyer]

(* ****** ****** *)

local

fun labp3atlst_tyer
  (lxs: labp3atlst): labhipatlst = let
//
  fun f (
    lx: labp3at
  ) : labhipat = let
    val LABP3AT (l, x) = lx
  in
    LABHIPAT (l, p3at_tyer (x))
  end // end of [f]
//
  val lhips = list_map_fun (lxs, f)
in
  list_of_list_vt (lhips)
end // end of [labp3atlst_tyer]

in // in of [local]

implement
labp3atlst_npf_tyer
  (npf, lp3ts) = let
in
  if npf > 0 then let
    val- list_cons (_, lp3ts) = lp3ts
  in
    labp3atlst_npf_tyer (npf-1, lp3ts)
  end else
    labp3atlst_tyer (lp3ts)
  // end of [if]
end // end of [labp3atlst_npf_tyer]

end // end of [local]

(* ****** ****** *)

implement
d3exp_tyer
  (d3e0) = let
  val loc0 = d3e0.d3exp_loc
  val s2e0 = d3exp_get_type (d3e0)
  val hse0 = s2exp_tyer_shallow (loc0, s2e0)
in
//
case+
  d3e0.d3exp_node of
//
| D3Ebool (b) =>
    hidexp_bool (loc0, hse0, b)
| D3Echar (c) =>
    hidexp_char (loc0, hse0, c)
| D3Estring (str) =>
    hidexp_string (loc0, hse0, str)
//
| _ => exitloc (1)
//
end // endof [d3exp_tyer]

(* ****** ****** *)

implement
d3explst_tyer
  (d3es) = let
  val hdes =
    list_map_fun (d3es, d3exp_tyer)
  // end of [val]
in
  list_of_list_vt (hdes)
end // end of [d3explst_tyer]

(* ****** ****** *)

(* end of [pats_typerase_dynexp.dats] *)
