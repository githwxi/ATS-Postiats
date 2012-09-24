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

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_dynexp_up"

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
fun d3ecl_tyer_impdec (d3c0: d3ecl): hidecl
extern
fun d3ecl_tyer_fundecs (d3c0: d3ecl): hidecl
extern
fun d3ecl_tyer_valdecs (d3c0: d3ecl): hidecl
extern
fun d3ecl_tyer_valdecs_rec (d3c0: d3ecl): hidecl

(* ****** ****** *)

implement
d3ecl_tyer
  (d3c0) = let
//
val loc0 = d3c0.d3ecl_loc
//
in
//
case+
  d3c0.d3ecl_node of
//
| D3Cnone () => hidecl_none (loc0)
| D3Clist (d3cs) => let
    val hids = d3eclist_tyer (d3cs) in hidecl_list (loc0, hids)
  end // end of [D3Clist]
//
| D3Cimpdec _ => d3ecl_tyer_impdec (d3c0)
//
| D3Cfundecs _ => d3ecl_tyer_fundecs (d3c0)
//
| D3Cvaldecs _ => d3ecl_tyer_valdecs (d3c0)
| D3Cvaldecs_rec _ => d3ecl_tyer_valdecs_rec (d3c0)
//
| D3Cstaload (
    filename, flag, loaded, filenv
  ) =>
    hidecl_staload (loc0, filename, flag, loaded, filenv)
  // end of [D3Cstaload]
//
| D3Clocal
    (head, body) => let
    val head = d3eclist_tyer (head)
    val body = d3eclist_tyer (body)
  in
    hidecl_local (loc0, head, body)
  end // end of [D3Clocal]
//
| _ => let
(*
    val () = println! ("d3ecl_tyer: d3c0 = ", d3c0)
*)
  in
    exitloc (1)
  end // end of [_]
//
end // end of [d3ecl_tyer]

(* ****** ****** *)

implement
d3eclist_tyer
  (d3cs) = let
//
val hids = list_map_fun (d3cs, d3ecl_tyer)
//
in
  list_of_list_vt (hids)
end // end of [d3eclist_tyer]

(* ****** ****** *)

implement
d3ecl_tyer_impdec
  (d3c0) = let
//
val loc0 = d3c0.d3ecl_loc
val- D3Cimpdec (knd, impdec) = d3c0.d3ecl_node
//
in
//
if knd = 0 then let
  val loc = impdec.i3mpdec_loc
  val d2c = impdec.i3mpdec_cst
  val imparg = impdec.i3mpdec_imparg
  val tmparg = impdec.i3mpdec_tmparg
  val hse_def = d3exp_tyer (impdec.i3mpdec_def)
  val himpdec = hiimpdec_make (loc, d2c, imparg, tmparg, hse_def)
in
  hidecl_impdec (loc0, knd(*0*), himpdec)
end else
  hidecl_none (loc0)
// end of [if]
//
end // end of [d3ecl_tyer_impdec]

(* ****** ****** *)

local

fun f3undec_tyer
  (f3d: f3undec): hifundec = let
  val loc = f3d.f3undec_loc
  val d2v_fun = f3d.f3undec_var
  val d3e_def = f3d.f3undec_def
  val isprf = d3exp_is_prf (d3e_def)
  val () = if isprf then let
    val () = prerr_error4_loc (loc)
    val () = prerr ": [fun] should be replaced with [prfun] as this is a proof binding."
    val () = prerr_newline ()
  in
    the_trans4errlst_add (T3E_d3exp_tyer_isprf (d3e_def))
  end // end of [val]
  val hde_def = d3exp_tyer (d3e_def)
in
  hifundec_make (loc, d2v_fun, hde_def)
end // end of [f3undec_tyer]

fun f3undeclst_tyer (
  knd: funkind, f3ds: f3undeclst
) : hifundeclst = let
  val isprf = funkind_is_proof (knd)
in
//
if isprf then
  list_nil () // proofs are erased
else let
  val hfds = list_map_fun (f3ds, f3undec_tyer)
in
  list_of_list_vt (hfds)
end // end of [if]
//
end // end of [f3undeclst_tyer]

in // in of [local]

implement
d3ecl_tyer_fundecs (d3c0) = let
//
val loc0 = d3c0.d3ecl_loc
val- D3Cfundecs (knd, decarg, f3ds) = d3c0.d3ecl_node
val hfds = f3undeclst_tyer (knd, f3ds)
//
in
  hidecl_fundecs (loc0, knd, decarg, hfds)
end // end of [d3ecl_tyer_fundecs]

end // end of [local]

(* ****** ****** *)

local

fun v3aldec_tyer
  (v3d: v3aldec): hivaldec = let
  val loc = v3d.v3aldec_loc
  val hip = p3at_tyer (v3d.v3aldec_pat)
  val d3e_def = v3d.v3aldec_def
  val isprf = d3exp_is_prf (d3e_def)
  val () = if isprf then let
    val () = prerr_error4_loc (loc)
    val () = prerr ": [val] should be replaced with [prval] as this is a proof binding."
    val () = prerr_newline ()
  in
    the_trans4errlst_add (T3E_d3exp_tyer_isprf (d3e_def))
  end // end of [val]
  val hde_def = d3exp_tyer (d3e_def)
in
  hivaldec_make (loc, hip, hde_def)
end // end of [v3aldec_tyer]

fun v3aldeclst_tyer (
  knd: valkind, v3ds: v3aldeclst
) : hivaldeclst = let
  val isprf = valkind_is_proof (knd)
in
//
if isprf then
  list_nil () // proofs are erased
else let
  val hvds = list_map_fun (v3ds, v3aldec_tyer)
in
  list_of_list_vt (hvds)
end // end of [if]
//
end // end of [v3aldeclst_tyer]

in // in of [local]

implement
d3ecl_tyer_valdecs (d3c0) = let
//
val loc0 = d3c0.d3ecl_loc
val- D3Cvaldecs (knd, v3ds) = d3c0.d3ecl_node
val hvds = v3aldeclst_tyer (knd, v3ds)
//
in
  hidecl_valdecs (loc0, knd, hvds)
end // end of [d3ecl_tyer_valdecs]

implement
d3ecl_tyer_valdecs_rec (d3c0) = let
//
val loc0 = d3c0.d3ecl_loc
val- D3Cvaldecs_rec (knd, v3ds) = d3c0.d3ecl_node
val hvds = v3aldeclst_tyer (knd, v3ds)
//
in
  hidecl_valdecs_rec (loc0, knd, hvds)
end // end of [d3ecl_tyer_valdecs_rec]

end // end of [local]

(* ****** ****** *)

(* end of [pats_typerase_decl.dats] *)
