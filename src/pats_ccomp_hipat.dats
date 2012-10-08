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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload LAB = "pats_label.sats"
staload LOC = "pats_location.sats"

(* ****** ****** *)

staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

implement
hipatck_ccomp (
  res, fail, hip0, pmv0
) = let
//
(*
val () = begin
  print "hipatck_ccomp: hip0 = "; print_hipat hip0; print_newline ();
  print "hipatck_ccomp: pmv0 = "; print_primval pmv0; print_newline ();
end // end of [val]
*)
val loc0 = hip0.hipat_loc
//
in
//
case+ hip0.hipat_node of
//
| HIPany _ => ()
| HIPvar _ => ()
//
| HIPint (i) => let
    val ins = instr_patck (loc0, pmv0, PATCKint (i), fail)
  in
    instrseq_add (res, ins)
  end // end of [HIPint]
| HIPbool (b) => let
    val ins = instr_patck (loc0, pmv0, PATCKbool (b), fail)
  in
    instrseq_add (res, ins)
  end // end of [HIPbool]
| HIPchar (c) => let
    val ins = instr_patck (loc0, pmv0, PATCKchar (c), fail)
  in
    instrseq_add (res, ins)
  end // end of [HIPchar]
//
| HIPi0nt (tok) => let
    val ins = instr_patck (loc0, pmv0, PATCKi0nt (tok), fail)
  in
    instrseq_add (res, ins)
  end // end of [HIPi0nt]
| HIPf0loat (tok) => let
    val ins = instr_patck (loc0, pmv0, PATCKf0loat (tok), fail)
  in
    instrseq_add (res, ins)
  end // end of [HIPf0loat]
//
| HIPann (hip, ann) => hipatck_ccomp (res, fail, hip, pmv0)
//
| _ => let
    val () = println! ("hipatck_ccomp: hip0 = ", hip0)
  in
    exitloc (1)
  end // end o [val]
//
end // end of [ccomp_patck]

(* ****** ****** *)

local

fun auxvar (
  env: !ccompenv
, res: !instrseq
, lev0: int, d2v: d2var, pmv0: primval
) : void = let
(*
val () = (
  println! ("himatch_ccomp: auxvar: d2v = ", d2v)
) // end of [val]
*)
//
val () = d2var_set_level (d2v, lev0)
//
val n = d2var_get_utimes (d2v)
//
in
//
if n > 0 then let
  val ismov = (
    case+ pmv0.primval_node of
    | _ when d2var_is_mutabl (d2v) => false
    | _ => primval_is_mutabl (pmv0)
  ) : bool // end of [val]
in
  if ismov then let
    val loc_d2v = d2var_get_loc (d2v)
    val hse_pmv = pmv0.primval_type
    val tmp = tmpvar_make (loc_d2v, hse_pmv)
    val () = instrseq_add (res, instr_move_val (loc_d2v, tmp, pmv0))
    val pmv1 = primval_tmp (loc_d2v, hse_pmv, tmp)
  in
    ccompenv_add_varbind (env, d2v, pmv1)
  end else (
    ccompenv_add_varbind (env, d2v, pmv0)
  ) // end of [if]
end else (
  // HX: [d2v] is unused!
) // end of [if]
//
end // end of [auxvar]

in // in of [local]

implement
himatch_ccomp (
  env, res, lev0, hip0, pmv0
) = let
//
(*
val () = begin
  println! ("ccomp_match: lev0 = ", lev0);
  println! ("ccomp_match: hip0 = ", hip0);
  println! ("ccomp_match: pmv0 = ", pmv0);
end // end [val]
*)
//
val loc0 = hip0.hipat_loc
//
in
//
case+ hip0.hipat_node of
| HIPany _ => ()
| HIPvar (d2v) => auxvar (env, res, lev0, d2v, pmv0)
| HIPint _ => ()
| HIPbool _ => ()
| HIPchar _ => ()
| HIPstring _ => ()
//
| HIPi0nt _ => ()
| HIPf0loat _ => ()
//
| HIPann (hip, ann) => himatch_ccomp (env, res, lev0, hip, pmv0)
//
| _ => let
    val () = println! ("himatch_ccomp: hip0 = ", hip0)
  in
    exitloc (1)
  end // end of [_]
//
end (* end of [himatch_ccomp] *)

end // end of [local]

(* ****** ****** *)

extern
fun primval_make_funarg
  (loc: location, hse: hisexp, narg: int): primval
// end of [primval_make_funarg]

implement
primval_make_funarg (
  loc, hse0, narg
) : primval = let
in
//
case+ hse0.hisexp_node of
| HSErefarg
    (refval, hse) => (
    if refval = 0 then
      primval_arg (loc, hse, narg)
    else
      primval_argref (loc, hse, narg)
    // end of [if]
  ) // end of [HITrefarg]
| HSEvararg _ =>
    primval_argtmpref (loc, hse0, narg)
| _ => primval_arg (loc, hse0, narg)
//
end // end of [primval_make_funarg]

(* ****** ****** *)

implement
hifunarg_ccomp (
  env, res, fl, lev0, loc_fun, hips
) = let
//
fun
auxpatck
  {n:nat} .<n>. (
  res: !instrseq
, narg: int
, hips: list (hipat, n)
, fail: patckont
) : list_vt (primval, n) = let
in
//
case+ hips of
| list_cons
    (hip, hips) => let
    val loc = hip.hipat_loc
    val hse = hip.hipat_type
(*
    val () = begin
      println! ("hifunarg_ccomp: auxpatck: hip = ", hip);
      println! ("hifunarg_ccomp: auxpatck: hse = ", hse);
    end // end of [val]
*)
    val pmv = primval_make_funarg (loc, hse, narg)
    val ((*void*)) = hipatck_ccomp (res, fail, hip, pmv)
    val pmvs = auxpatck (res, narg+1, hips, fail)
  in
    list_vt_cons (pmv, pmvs)
  end // end of [list_cons]
| list_nil () => list_vt_nil ()
//
end // end of [auxpatck]
//
fun auxmatch
  {n:nat} .<n>. (
  env: !ccompenv
, res: !instrseq
, lev0: int
, hips: list (hipat, n)
, pmvs: list_vt (primval, n)
) : void = let
in
//
case+ pmvs of
| ~list_vt_cons (pmv, pmvs) => let
    val+ list_cons (hip, hips) = hips
    val () = himatch_ccomp (env, res, lev0, hip, pmv)
  in
    auxmatch (env, res, lev0, hips, pmvs)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [aux_match]
//
val fail = PTCKNTfunarg_fail (loc_fun, fl)
val pmvs = auxpatck (res, 0, hips, fail)
//
in
  auxmatch (env, res, lev0, hips, pmvs)
end // end of [hifunarg_ccomp]

(* ****** ****** *)

(* end of [pats_ccomp_hipat.dats] *)
