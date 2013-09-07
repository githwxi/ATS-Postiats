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
// Start Time: September, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_typerase_decl"

(* ****** ****** *)

staload LOC = "./pats_location.sats"
overload print with $LOC.print_location

(* ****** ****** *)

staload FIL = "./pats_filename.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload TRENV2 = "./pats_trans2_env.sats"
staload TRENV3 = "./pats_trans3_env.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_typerase.sats"

(* ****** ****** *)

extern
fun d3ecl_tyer_impdec (d3c0: d3ecl): hidecl
extern
fun d3ecl_tyer_fundecs (d3c0: d3ecl): hidecl
extern
fun d3ecl_tyer_valdecs (d3c0: d3ecl): hidecl
extern
fun d3ecl_tyer_valdecs_rec (d3c0: d3ecl): hidecl
extern
fun d3ecl_tyer_vardecs (d3c0: d3ecl): hidecl

(* ****** ****** *)

extern
fun tmpcstimpmap_make_hideclist (xs: hideclist): tmpcstimpmap
extern
fun tmpvardecmap_make_hideclist (xs: hideclist): tmpvardecmap

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
//
| D3Clist (d3cs) => let
    val hids = d3eclist_tyer (d3cs) in hidecl_list (loc0, hids)
  end // end of [D3Clist]
//
| D3Csaspdec (d2c) => hidecl_saspdec (loc0, d2c)
//
| D3Cextcode
    (knd, pos, code) => hidecl_extcode (loc0, knd, pos, code)
  // end of [D3Cextcode]
//
| D3Cdatdecs (
    knd, s2cs
  ) => hidecl_datdecs (loc0, knd, s2cs)
| D3Cexndecs
    (d2cs) => hidecl_exndecs (loc0, d2cs)
//
| D3Cdcstdecs
    (knd, d2cs) => hidecl_dcstdecs (loc0, knd, d2cs)
//
| D3Cimpdec _ => d3ecl_tyer_impdec (d3c0)
//
| D3Cfundecs _ => d3ecl_tyer_fundecs (d3c0)
//
| D3Cvaldecs _ => d3ecl_tyer_valdecs (d3c0)
| D3Cvaldecs_rec _ => d3ecl_tyer_valdecs_rec (d3c0)
//
| D3Cvardecs _ => d3ecl_tyer_vardecs (d3c0)
//
| D3Cprvardecs _ => hidecl_none (loc0) // proof vars
//
| D3Cinclude (d3cs) => let
    val hids = d3eclist_tyer (d3cs) in hidecl_include (loc0, hids)
  end // end of [D3Cinclude]
//
| D3Cstaload
  (
    fname, flag, fenv, loaded
  ) => let
    val-Some (d3cs) =
      $TRENV3.filenv_get_d3eclistopt (fenv)
    // end of [val]
(*
    val () = (
      println! ("d3ecl_tyer: D3Cstaload: fname = ", fname);
      println! ("d3ecl_tyer: D3Cstaload: loaded = ", loaded);
    ) // end of [val]
*)
    val () = (
      if (loaded = 0) then let
        val hids = d3eclist_tyer (d3cs)
//
        val tcimap = tmpcstimpmap_make_hideclist (hids)
        val p = $TRENV2.filenv_getref_tmpcstimpmap (fenv)
        val () = $UN.ptrset<tmpcstimpmapopt> (p, Some (tcimap))
//
        val tvdmap = tmpvardecmap_make_hideclist (hids)
        val p = $TRENV2.filenv_getref_tmpvardecmap (fenv)
        val () = $UN.ptrset<tmpvardecmapopt> (p, Some (tvdmap))
//
      in
        // nothing
      end // end of [Some]
    ) : void // end of [val]
  in
    hidecl_staload (loc0, fname, flag, fenv, loaded)
  end // end of [D3Cstaload]
//
| D3Cdynload (fil) => hidecl_dynload (loc0, fil)
//
| D3Clocal
    (head, body) => let
    val head = d3eclist_tyer (head)
    val body = d3eclist_tyer (body)
  in
    hidecl_local (loc0, head, body)
  end // end of [D3Clocal]
//
(*
| _ => let
    val () = println! ("d3exp_tyer: loc0 = ", loc0)
    val () = println! ("d3ecl_tyer: d3c0 = ", d3c0)
  in
    exitloc (1)
  end // end of [_]
*)
//
end // end of [d3ecl_tyer]

(* ****** ****** *)

implement
d3eclist_tyer
  (d3cs) = let
//
vtypedef res = List_vt (hidecl)
//
fun loop
  (d3cs: d3eclist, res: res): res = let
in
//
case+ d3cs of
| list_cons
    (d3c, d3cs) => let
    val hid = d3ecl_tyer (d3c)
    val isemp = hidecl_is_empty (hid)
  in
    if isemp
      then loop (d3cs, res)
      else loop (d3cs, list_vt_cons (hid, res))
    // end of [if]
  end // end of [list_cons]
| list_nil ((*void*)) => res
//
end // end of [loop]
//
val hids = loop (d3cs, list_vt_nil)
val hids = list_vt_reverse<hidecl> (hids)
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
val-D3Cimpdec (knd, impdec) = d3c0.d3ecl_node
//
in
//
if knd = 0 then let
  val loc = impdec.i3mpdec_loc
  val d2c = impdec.i3mpdec_cst
  val imparg = impdec.i3mpdec_imparg
  val tmparg = impdec.i3mpdec_tmparg
  val tmparg = s2explstlst_mhnfize (tmparg)
  val hse_def = d3exp_tyer (impdec.i3mpdec_def)
  val himp = hiimpdec_make (loc, d2c, imparg, tmparg, hse_def)
in
  hidecl_impdec (loc0, knd(*0*), himp)
end else
  hidecl_none (loc0)
// end of [if]
//
end // end of [d3ecl_tyer_impdec]

(* ****** ****** *)

implement
decarg2imparg (s2qs) = let
in
//
case+ s2qs of
| list_cons
    (s2q, s2qs) =>
    list_append<s2var> (s2q.s2qua_svs, decarg2imparg (s2qs))
  // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [decarg2imparg]

(* ****** ****** *)

local

fun f3undec_tyer
(
  imparg: s2varlst, f3d: f3undec
) : hifundec = let
//
  val loc = f3d.f3undec_loc
//
  val d2v_fun = f3d.f3undec_var
  val d3e_def = f3d.f3undec_def
//
  val isprf = d3exp_is_prf (d3e_def)
//
  val () = if isprf then let
    val () = prerr_error4_loc (loc)
    val () = prerr ": [fun] should be replaced with [prfun] as this is a proof binding."
    val () = prerr_newline ()
  in
    the_trans4errlst_add (T4E_d3exp_tyer_isprf (d3e_def))
  end // end of [val]
//
  val d2v_fun = d2var_tyer (d2v_fun)
  val hde_def = d3exp_tyer (d3e_def)
//
in
  hifundec_make (loc, d2v_fun, imparg, hde_def)
end // end of [f3undec_tyer]

fun f3undeclst_tyer
(
  knd: funkind
, decarg: s2qualst, f3ds: f3undeclst
) : hifundeclst = let
  val isprf = funkind_is_proof (knd)
in
//
if isprf then
  list_nil () // proofs are erased
else let
  val imparg = decarg2imparg (decarg)
  val hfds = list_map_cloptr<f3undec><hifundec> (f3ds, lam (f3d) =<1> f3undec_tyer (imparg, f3d))
in
  list_of_list_vt (hfds)
end // end of [if]
//
end // end of [f3undeclst_tyer]

in (* in of [local] *)

implement
d3ecl_tyer_fundecs
  (d3c0) = hdc0 where
{
//
val loc0 = d3c0.d3ecl_loc
//
val-D3Cfundecs
  (knd, decarg, f3ds) = d3c0.d3ecl_node
//
val hfds = f3undeclst_tyer (knd, decarg, f3ds)
val hdc0 = hidecl_fundecs (loc0, knd, decarg, hfds)
//
val () = hifundeclst_set_hideclopt (hfds, Some(hdc0))
//
} // end of [d3ecl_tyer_fundecs]

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
    the_trans4errlst_add (T4E_d3exp_tyer_isprf (d3e_def))
  end // end of [val]
  val hde_def = d3exp_tyer (d3e_def)
in
  hivaldec_make (loc, hip, hde_def)
end // end of [v3aldec_tyer]

fun v3aldeclst_tyer
(
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

in (* in of [local] *)

implement
d3ecl_tyer_valdecs (d3c0) = let
//
val loc0 = d3c0.d3ecl_loc
val-D3Cvaldecs (knd, v3ds) = d3c0.d3ecl_node
val hvds = v3aldeclst_tyer (knd, v3ds)
//
in
  hidecl_valdecs (loc0, knd, hvds)
end // end of [d3ecl_tyer_valdecs]

implement
d3ecl_tyer_valdecs_rec (d3c0) = let
//
val loc0 = d3c0.d3ecl_loc
val-D3Cvaldecs_rec (knd, v3ds) = d3c0.d3ecl_node
val hvds = v3aldeclst_tyer (knd, v3ds)
//
in
  hidecl_valdecs_rec (loc0, knd, hvds)
end // end of [d3ecl_tyer_valdecs_rec]

end // end of [local]

(* ****** ****** *)

local

fun v3ardec_tyer
  (v3d: v3ardec): hivardec = let
  val loc = v3d.v3ardec_loc
  val knd = v3d.v3ardec_knd
  val d2v = v3d.v3ardec_dvar_ptr
  val d2v = d2var_tyer (d2v)
  val d2vw = v3d.v3ardec_dvar_view
  val type = s2exp_tyer_shallow (loc, v3d.v3ardec_type)
  val ini = d3expopt_tyer (v3d.v3ardec_ini)
in
  hivardec_make (loc, knd, d2v, d2vw, type, ini)
end // end of [v3ardec_tyer]

in (* in of [local] *)

implement
d3ecl_tyer_vardecs (d3c0) = let
//
val loc0 = d3c0.d3ecl_loc
val-D3Cvardecs (v3ds) = d3c0.d3ecl_node
val hvds = list_map_fun (v3ds, v3ardec_tyer)
val hvds = list_of_list_vt (hvds)
//
in
  hidecl_vardecs (loc0, hvds)
end // end of [d3ecl_tyer_vardecs]

end // end of [local]

(* ****** ****** *)

implement
tmpcstimpmap_make_hideclist (xs) = let
//
fun aux
(
  map: &tmpcstimpmap, x: hidecl
) : void = let
in
//
case+ x.hidecl_node of
| HIDimpdec
    (knd, imp) => let
    val tmparg = imp.hiimpdec_tmparg
  in
    case+ tmparg of
    | list_cons _ => tmpcstimpmap_insert (map, imp)
    | list_nil () => ()
  end // end of [HIDimpdec]
//
| HIDinclude
    (xs_incl) => auxlst (map, xs_incl)
  (* end of [HIDinclude] *)
//
| HIDlocal
    (xs_head, xs_body) =>
  (
    auxlst (map, xs_head); auxlst (map, xs_body)
  ) // end of [HIDlocal]
//
| _ => ()
//
end (* end of [aux] *)
//
and auxlst
(
  map: &tmpcstimpmap, xs: hideclist
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = aux (map, x) in auxlst (map, xs)
  end (* end of [list_cons] *)
| list_nil () => ()
//
end (* end of [auxlst] *)
//
var map
  : tmpcstimpmap = d2cstmap_nil ()
val () = auxlst (map, xs)
//
in
  map
end // end of [tmpcstimpmap_make_hideclist]

(* ****** ****** *)

implement
tmpvardecmap_make_hideclist (xs) = let
//
fun aux
(
  map: &tmpvardecmap, x: hidecl
) : void = let
in
//
case+ x.hidecl_node of
| HIDfundecs
    (knd, s2qs, hfds) => let
  in
    case+ s2qs of
    | list_cons _ => tmpvardecmap_inserts (map, hfds)
    | list_nil () => ()
  end // end of [HIDfundecs]
//
| HIDinclude
    (xs_incl) => auxlst (map, xs_incl)
  (* end of [HIDinclude] *)
//
| HIDlocal
    (xs_head, xs_body) =>
  (
    auxlst (map, xs_head); auxlst (map, xs_body)
  ) // end of [HIDlocal]
//
| _ => ()
//
end (* end of [aux] *)
//
and auxlst
(
  map: &tmpvardecmap, xs: hideclist
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = aux (map, x) in auxlst (map, xs)
  end (* end of [list_cons] *)
| list_nil () => ()
//
end (* end of [auxlst] *)
//
var map
  : tmpvardecmap = d2varmap_nil ()
val () = auxlst (map, xs)
//
in
  map
end // end of [tmpvardecmap_make_hideclist]

(* ****** ****** *)

(* end of [pats_typerase_decl.dats] *)
