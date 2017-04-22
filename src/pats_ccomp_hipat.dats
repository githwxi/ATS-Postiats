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
// Start Time: October, 2012
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload UT = "./pats_utils.sats"
//
(* ****** ****** *)
//
staload LAB = "./pats_label.sats"
staload LOC = "./pats_location.sats"
//
overload print with $LOC.print_location
//
(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

fun
hipat_getset_asvar
  (hip: hipat): d2var = let
in
//
case+
  hip.hipat_asvar of
| Some (d2v) => (d2v)
| None () => let
    val loc = hip.hipat_loc
    val d2v = d2var_make_any (loc)
    val () = hipat_set_asvar (hip, Some (d2v))
  in
     d2v
  end // end of [None]
//
end // end of [hipat_getset_asvar]

(* ****** ****** *)

extern
fun
hipatck_ccomp_rec
(
  env: !ccompenv, res: !instrseq
, fail: patckont, hip0: hipat, pmv0: primval
) : void // end of [hipatck_ccomp_rec]

local

fun aux
(
  env: !ccompenv
, res: !instrseq
, fail: patckont
, lab: label, hip: hipat
, pmv0: primval, hse_rec: hisexp
) : void = let
//
in
//
case+
hip.hipat_node
of (* case+ *)
| HIPany _ => ()
| HIPvar _ => ()
| HIPann (hip, ann) =>
    aux (env, res, fail, lab, hip, pmv0, hse_rec)
  // end of [HIPann]
//
| hipnode => let
    val loc = hip.hipat_loc
    val hse = hipat_get_type (hip)
    val pml = primlab_lab (loc, lab)
    val tmp = tmpvar_make (loc, hse)
    val ins =
      instr_move_select (loc, tmp, hse, pmv0, hse_rec, pml)
    val pmv = primval_make_tmp (loc, tmp)
//
    val d2v_as = hipat_getset_asvar (hip)
    val () = ccompenv_add_vbindmapenvall (env, d2v_as, pmv)
//
    val () = instrseq_add (res, ins)
//
  in
    hipatck_ccomp (env, res, fail, hip, pmv)
  end // end of [_]
//
end // end of [aux]

fun auxlst
(
  env: !ccompenv
, res: !instrseq
, fail: patckont
, lhips: labhipatlst
, pmv0: primval, hse_rec: hisexp
) : void = let
in
//
case+ lhips of
| list_cons
    (lhip, lhips) => let
    val+LABHIPAT (lab, hip) = lhip
    val () =
      aux (env, res, fail, lab, hip, pmv0, hse_rec)
    // end of [val]
  in
    auxlst (env, res, fail, lhips, pmv0, hse_rec)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlst]

in (* in of [local] *)

implement
hipatck_ccomp_rec
(
  env, res, fail, hip0, pmv0
) = let
//
val-HIPrec
  (knd, pck, lhips, hse_rec) = hip0.hipat_node
//
in
  auxlst(env, res, fail, lhips, pmv0, hse_rec)
end // end of [hipatck_ccomp_rec]

end // end of [local]

(* ****** ****** *)

extern
fun
hipatck_ccomp_con
(
  env: !ccompenv, res: !instrseq
, fail: patckont, loc0: location, d2c: d2con, pmv0: primval
) : void // end of [hipatck_ccomp_con]

implement
hipatck_ccomp_con
(
  env, res, fail, loc0, d2c, pmv0
) = let
//
val ins = instr_patck (loc0, pmv0, PATCKcon (d2c), fail)
//
in
  instrseq_add (res, ins)
end // end of [hipatck_ccomp_con]

(* ****** ****** *)

extern
fun
hipatck_ccomp_sum
(
  env: !ccompenv, res: !instrseq
, fail: patckont, hip0: hipat, pmv0: primval
) : void // end of [hipatck_ccomp_sum]

local

fun aux
(
  env: !ccompenv
, res: !instrseq
, fail: patckont
, narg: int
, lab: label, hip: hipat
, pmv0: primval, hse_sum: hisexp
) : void = let
//
val loc = hip.hipat_node
//
in
//
case+
hip.hipat_node
of (* case+ *)
| HIPany _ => ()
| HIPvar _ => ()
| HIPann (hip, ann) =>
    aux (env, res, fail, narg, lab, hip, pmv0, hse_sum)
  // end of [HIPann]
| hipnode => let
    val loc = hip.hipat_loc
    val hse = hipat_get_type (hip)
    val tmp = tmpvar_make (loc, hse)
    val ins =
      instr_move_selcon (loc, tmp, hse, pmv0, hse_sum, lab)
    val pmv = primval_make_tmp (loc, tmp)
    var use: int = 0
//
    val hip = (
      case+ hipnode of
      | HIPrefas
          (d2v, hip) => hip where
        {
          val isnot =
            not(d2var_is_mutabl(d2v))
          val ((*void*)) =
          (
            if isnot then let
              val () = use := use + 1
            in
              ccompenv_add_vbindmapenvall(env, d2v, pmv)
            end else let
              val pmv =
                primval_selcon(loc, hse, pmv0, hse_sum, lab)
              val pmv_ref = primval_ptrof(loc, hisexp_typtr, pmv)
            in
              ccompenv_add_vbindmapenvall(env, d2v, pmv_ref)
            end // end of [if]
          ) : void // end of [val]
        } (* end of [HIPrefas] *)
      | _ => hip
    ) : hipat // end of [val]
//
    val () = (
      case+ hip.hipat_node of
      | HIPany _ => () | HIPvar _ => () | HIPrefas _ => ()
      | _ => {
          val () = use := use + 1
          val d2v_as = hipat_getset_asvar (hip)
          val () = ccompenv_add_vbindmapenvall (env, d2v_as, pmv)
        } (* end of [_] *)
    ) : void // end of [val]
//
    val () = if use >= 1 then instrseq_add (res, ins)
//
  in
    hipatck_ccomp (env, res, fail, hip, pmv)
  end // end of [_]
//
end // end of [aux]

fun auxlst
(
  env: !ccompenv
, res: !instrseq
, fail: patckont
, narg: int, lhips: labhipatlst
, pmv0: primval, hse_sum: hisexp
) : void = let
in
  case+ lhips of
  | list_cons
      (lhip, lhips) => let
      val+LABHIPAT(lab, hip) = lhip
      val () =
        aux(env, res, fail, narg, lab, hip, pmv0, hse_sum)
      // end of [val]
    in
      auxlst(env, res, fail, narg+1, lhips, pmv0, hse_sum)
    end // end of [list_cons]
  | list_nil((*void*)) => ()
end // end of [auxlst]

in (* in of [local] *)

implement
hipatck_ccomp_sum
(
  env, res, fail, hip0, pmv0
) = let
//
val loc0 = hip0.hipat_loc
//
(*
val () =
(
println! ("hipatck_ccomp_sum: loc0 = ", loc0);
println! ("hipatck_ccomp_sum: hip0 = ", hip0);
) // end of [val]
*)
//
val-HIPcon
  (pck, d2c, hse_sum, lhips) = hip0.hipat_node
val () =
  hipatck_ccomp_con(env, res, fail, loc0, d2c, pmv0)
//
in
  auxlst(env, res, fail, 0(*narg*), lhips, pmv0, hse_sum)
end // end of [hipatck_ccomp_sum]

end // end of [local]

(* ****** ****** *)

implement
hipatck_ccomp
(
  env, res, fail, hip0, pmv0
) = let
//
val loc0 = hip0.hipat_loc
//
(*
val () =
(
println! ("hipatck_ccomp: loc0 = ", loc0);
println! ("hipatck_ccomp: hip0 = ", hip0);
println! ("hipatck_ccomp: pmv0 = ", pmv0);
) // end of [val]
*)
//
in
//
case+
hip0.hipat_node
of (* case+ *)
//
| HIPany _ => ()
| HIPvar _ => ()
//
| HIPcon _ =>
  hipatck_ccomp_sum(env, res, fail, hip0, pmv0)
//
| HIPcon_any(pck, d2c) =>
  hipatck_ccomp_con(env, res, fail, loc0, d2c, pmv0)
//
| HIPint(i) =>
  instrseq_add(res, ins) where
  {
    val ins =
    instr_patck
      (loc0, pmv0, PATCKint (i), fail)
    // end of [val]
  } (* end of [HIPint] *)
| HIPintrep(rep) =>
  instrseq_add(res, ins) where
  {
    val i =
      $UN.cast{int}($UT.llint_make_string(rep))
    val ins =
      instr_patck(loc0, pmv0, PATCKint (i), fail)
  } (* end of [HIPintrep] *)
//
| HIPbool(b) =>
  instrseq_add(res, ins) where
  {
    val ins =
      instr_patck(loc0, pmv0, PATCKbool(b), fail)
    // end of [val]
  } (* end of [HIPbool] *)
| HIPchar(c) =>
  instrseq_add(res, ins) where
  {
    val ins =
      instr_patck(loc0, pmv0, PATCKchar(c), fail)
  } (* end of [HIPchar] *)
| HIPstring(str) =>
  instrseq_add(res, ins) where
  {
    val ins =
    instr_patck
      (loc0, pmv0, PATCKstring(str), fail)
    // end of [val]
  } (* end of [HIPstring] *)
//
| HIPi0nt(tok) =>
  instrseq_add (res, ins) where
  {
    val ins =
    instr_patck
      (loc0, pmv0, PATCKi0nt (tok), fail)
    // end of [val]
  } (* end of [HIPi0nt] *)
| HIPf0loat(tok) =>
  instrseq_add(res, ins) where
  {
    val ins =
    instr_patck
      (loc0, pmv0, PATCKf0loat (tok), fail)
    // end of [val]
  } (* end of [HIPf0loat] *)
//
| HIPempty() => ()
//
| HIPrec(_, _, _, _) =>
  {
    val () =
    hipatck_ccomp_rec
      (env, res, fail, hip0, pmv0)
    // hipatck_ccomp_rec
  } (* end of [HIPrec] *)
//
| HIPrefas(d2v, hip) =>
    hipatck_ccomp(env, res, fail, hip, pmv0)
  // end of [HIPrefas]
//
| HIPann(hip, ann) =>
    hipatck_ccomp (env, res, fail, hip, pmv0)
  // end of [HIPann]
//
| _ (*rest-of-HIP*) =>
    exitloc( 1 ) where
  {
    val () = println! ("hipatck_ccomp: loc0 = ", loc0)
    val () = println! ("hipatck_ccomp: hip0 = ", hip0)
  } (* end o [rest-of-HIP] *)
//
end // end of [hipatck_ccomp]

(* ****** ****** *)

extern
fun
himatch_ccomp_rec
(
  env: !ccompenv, res: !instrseq
, lvl0: int, hip0: hipat, pmv0: primval // HX: [pmv] matches [hip]
) : void // end of [himatch_ccomp]

local

fun auxvar
(
  env: !ccompenv
, res: !instrseq
, lvl0: int
, lab: label, hip: hipat
, pmv0: primval, hse_rec: hisexp
) : void = let
  val loc = hip.hipat_loc
  val-HIPvar (d2v) = hip.hipat_node
  val () = d2var_set_level (d2v, lvl0)
  val utimes = d2var_get_utimes (d2v)
in
//
case+ 0 of
| _ when
    utimes = 0 => () // HX: [d2v] is unused
(*
| _ when
    d2var_is_mutabl (d2v) => let
    val hse = hipat_get_type (hip)
    val pml = primlab_lab (loc, lab)
    val pmv = primval_select (loc, hse, pmv0, hse_rec, pml)
    val pmv_ref = primval_ptrof (loc, hisexp_typtr, pmv)
    val () = ccompenv_add_vbindmapenvall (env, d2v, pmv_ref)
  in
    // nothing
  end // end of [_]
*)
| _ => let
    val hse = hipat_get_type (hip)
    val tmp = tmpvar_make(loc, hse)
    val pml = primlab_lab(loc, lab)
    val ins = instr_move_select(loc, tmp, hse, pmv0, hse_rec, pml)
    val pmv = primval_make_tmp(loc, tmp)
    val ((*void*)) = ccompenv_add_vbindmapenvall(env, d2v, pmv)
  in
    instrseq_add (res, ins)    
  end // end of [_]
//
end // end of [auxvar]

fun
auxpat
(
  env: !ccompenv
, res: !instrseq
, lvl0: int
, lab: label, hip: hipat
, pmv0: primval, hse_rec: hisexp
) : void = let
in
//
case+
hip.hipat_node
of (* case+ *)
//
| HIPany _ => ()
//
| HIPvar(d2v) =>
    auxvar(env, res, lvl0, lab, hip, pmv0, hse_rec)
//
| HIPrefas(d2v, hip) =>
    auxpat(env, res, lvl0, lab, hip, pmv0, hse_rec)
  // end of [HIPrefas]
| HIPann(hip, ann) =>
    auxpat(env, res, lvl0, lab, hip, pmv0, hse_rec)
  // end of [HIPann]
| _ (* rest-of-hipat *) => let
    val loc = hip.hipat_loc
    val-Some(d2v) = hip.hipat_asvar
    val-~Some_vt(pmv) =
      ccompenv_find_vbindmapenv (env, d2v)
  in
    himatch_ccomp(env, res, lvl0, hip, pmv)
  end // end of [_]
end // end of [auxpat]

fun
auxpatlst
(
  env: !ccompenv
, res: !instrseq
, lvl0: int
, lhips: labhipatlst
, pmv0: primval, hse_rec: hisexp
) : void = let
in
//
case+ lhips of
| list_nil
    ((*void*)) => ()
  // list_nil
| list_cons
    (lhip, lhips) => let
//
    val+LABHIPAT(lab, hip) = lhip
//
    val () =
    auxpat(env, res, lvl0, lab, hip, pmv0, hse_rec)
//
  in
    auxpatlst(env, res, lvl0, lhips, pmv0, hse_rec)
  end // end of [list_cons]
//
end // end of [auxpatlst]

in (* in of [local] *)

implement
himatch_ccomp_rec
(
  env, res, lvl0, hip0, pmv0
) = let
//
val-HIPrec
  (knd, pck, lhips, hse_rec) = hip0.hipat_node
//
in
  auxpatlst(env, res, lvl0, lhips, pmv0, hse_rec)
end // end of [himatch_ccomp_rec]

end // end of [local]

(* ****** ****** *)

extern
fun
himatch_ccomp_sum
(
  env: !ccompenv, res: !instrseq
, lvl0: int, hip0: hipat, pmv0: primval // HX: [pmv] matches [hip]
) : void // end of [himatch_ccomp_sum]

local

fun auxvar
(
  env: !ccompenv
, res: !instrseq
, lvl0: int
, narg: int
, lab: label, hip: hipat
, pmv0: primval, hse_sum: hisexp
) : void = let
  val loc = hip.hipat_loc
  val-HIPvar (d2v) = hip.hipat_node
  val () = d2var_set_level (d2v, lvl0)
  val utimes = d2var_get_utimes (d2v)
in
//
case+ 0 of
| _ when
    utimes = 0 => () // HX: [d2v] is unused
| _ when
    d2var_is_mutabl (d2v) => let
    val hse = hipat_get_type (hip)
//
    val pmv =
      primval_selcon (loc, hse, pmv0, hse_sum, lab)
    val pmv_ref = primval_ptrof (loc, hisexp_typtr, pmv)
//
    val () = ccompenv_add_vbindmapenvall (env, d2v, pmv_ref)
//
  in
    // nothing
  end // end of [_]
| _ => let
    val hse = hipat_get_type (hip)
    val tmp = tmpvar_make (loc, hse)
    val ins = instr_move_selcon (loc, tmp, hse, pmv0, hse_sum, lab)
    val pmv = primval_make_tmp (loc, tmp)
    val () = ccompenv_add_vbindmapenvall (env, d2v, pmv)
  in
    instrseq_add (res, ins)    
  end // end of [_]
//
end // end of [auxvar]

fun auxpat
(
  env: !ccompenv
, res: !instrseq
, lvl0: int
, narg: int
, lab: label, hip: hipat
, pmv0: primval, hse_sum: hisexp
) : void = let
in
//
case+
  hip.hipat_node of
| HIPany _ => ()
| HIPvar (d2v) =>
    auxvar (env, res, lvl0, narg, lab, hip, pmv0, hse_sum)
  // end of [HIPvar]
| HIPrefas (_, hip) =>
    auxpat (env, res, lvl0, narg, lab, hip, pmv0, hse_sum)
  // end of [HIPrefas]
| HIPann (hip, ann) =>
    auxpat (env, res, lvl0, narg, lab, hip, pmv0, hse_sum)
  // end of [HIPann]
| _ => let
    val-Some (d2v) = hip.hipat_asvar
    val-~Some_vt (pmv) = ccompenv_find_vbindmapenv (env, d2v)
  in
    himatch_ccomp (env, res, lvl0, hip, pmv)
  end // end of [_]
//
end // end of [auxpat]

fun auxpatlst
(
  env: !ccompenv
, res: !instrseq
, lvl0: int
, narg: int
, lhips: labhipatlst
, pmv0: primval, hse_sum: hisexp
) : void = let
in
//
case+ lhips of
| list_cons
    (lhip, lhips) => let
    val LABHIPAT (lab, hip) = lhip
    val () =
      auxpat (env, res, lvl0, narg, lab, hip, pmv0, hse_sum)
    // end of [val]
  in
    auxpatlst (env, res, lvl0, narg+1, lhips, pmv0, hse_sum)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxpat]

in (* in of [local] *)

implement
himatch_ccomp_sum
(
  env, res, lvl0, hip0, pmv0
) = let
(*
val () =
println! ("himatch_ccomp_sum: hip0 = ", hip0)
*)
val-HIPcon
  (pck, d2c, hse_sum, lhips) = hip0.hipat_node
//
in
  auxpatlst(env, res, lvl0, 0(*narg*), lhips, pmv0, hse_sum)
end // end of [himatch_ccomp_sum]

end // end of [local]

(* ****** ****** *)

local

fun auxvar
(
  env: !ccompenv
, res: !instrseq
, lvl0: int, d2v: d2var, pmv0: primval
) : void = let
//
val n = d2var_get_utimes (d2v)
val () = d2var_set_level (d2v, lvl0)
(*
val () =
(
  println! ("himatch_ccomp: auxvar: n = ", n);
  println! ("himatch_ccomp: auxvar: d2v = ", d2v);
) // end of [val]
*)
//
in
//
if n > 0 then let
  val ismov = (
    case+ pmv0.primval_node of
    | _ when
        d2var_is_mutabl (d2v) => false
    | _ => primval_is_nshared (pmv0)
  ) : bool // end of [val]
in
  if ismov then let
    val loc_d2v = d2var_get_loc (d2v)
    val hse_pmv = pmv0.primval_type
    val tmp = tmpvar_make (loc_d2v, hse_pmv)
    val ( ) = instrseq_add (res, instr_move_val (loc_d2v, tmp, pmv0))
    val pmv1 = primval_make_tmp (loc_d2v, tmp)
  in
    ccompenv_add_vbindmapenvall (env, d2v, pmv1)
  end else (
    ccompenv_add_vbindmapenvall (env, d2v, pmv0)
  ) // end of [if]
end else (
  // HX: [d2v] is unused!
) // end of [if]
//
end // end of [auxvar]

in (* in of [local] *)

implement
himatch_ccomp
(
  env, res, lvl0, hip0, pmv0
) = let
//
val loc0 = hip0.hipat_loc
//
(*
val () =
(
println! ("ccomp_match: lvl0 = ", lvl0);
println! ("ccomp_match: hip0 = ", hip0);
println! ("ccomp_match: pmv0 = ", pmv0);
) // end [val]
*)
//
in
//
case+
hip0.hipat_node
of (* case+ *)
| HIPany _ => ()
//
| HIPvar(d2v) =>
  auxvar(env, res, lvl0, d2v, pmv0)
//
| HIPint _ => ()
| HIPintrep _ => ()
//
| HIPbool _ => ()
| HIPchar _ => ()
| HIPstring _ => ()
//
| HIPi0nt _ => ()
| HIPf0loat _ => ()
//
| HIPempty() => ()
//
| HIPcon
  (
    pck, d2c, _, _
  ) => let
    val () =
    ccompenv_add_freeconenv_if
      (env, pmv0, pck, d2c)
    // end of [val]
  in
    himatch_ccomp_sum(env, res, lvl0, hip0, pmv0)
  end // end of [HIPcon]
//
| HIPcon_any
    (pck, d2c) => () where
  {
    val () =
    ccompenv_add_freeconenv_if(env, pmv0, pck, d2c)
    // end of [val]
  } // end of [HIPcon_any]
//
| HIPrec
    (_, pck, _, _) =>
    himatch_ccomp_rec
      (env, res, lvl0, hip0, pmv0) where
  {
    val () =
      ccompenv_add_freetupenv_if(env, pmv0, pck)
    // end of [val]
  } // end of [HIPrec]
//
| HIPrefas(d2v, hip) =>
  {
    val () =
    himatch_ccomp(env, res, lvl0, hip, pmv0)
  } // end of [HIPrefas]
//
| HIPann(hip, _(*ann*)) =>
  {
    val () =
    himatch_ccomp(env, res, lvl0, hip, pmv0)
  } // end of [HIPann]
//
| _ (*rest-of-hipat*) =>
    exitloc(1) where
  {
    val () =
    println! ("himatch_ccomp: hip0 = ", hip0)
  } (* end of [_] *)
//
end (* end of [himatch_ccomp] *)

end // end of [local]

(* ****** ****** *)
 
implement
himatch2_ccomp
(
  env, res, lvl0, hip0, pmv0
) = let
//
val () = ccompenv_inc_freeconenv (env)
val () = himatch_ccomp (env, res, lvl0, hip0, pmv0)
val pmvs = ccompenv_getdec_freeconenv (env)
//
in
  instrseq_add_freeconlst (res, hip0.hipat_loc, pmvs)
end // end of [himatch2_ccomp]

(* ****** ****** *)

extern
fun
primval_make_funarg
  (loc: location, hse: hisexp, narg: int): primval
// end of [primval_make_funarg]

implement
primval_make_funarg
  (loc, hse0, narg) = let
in
//
case+
  hse0.hisexp_node of
//
| HSErefarg
    (refval, hse) =>
  (
  if refval = 0 then
    primval_arg(loc, hse0, narg)
  else
    primval_argref(loc, hse0, narg)
  // end of [if]
  ) // end of [HSErefarg]
//
| HSEvararg _ =>
    primval_argtmpref(loc, hse0, narg)
//
| _ (*rest-of-hidexp*) =>
    primval_arg(loc, hse0, narg)
//
end // end of [primval_make_funarg]

(* ****** ****** *)

implement
hifunarg_ccomp
(
  env, res, fl, lvl0, loc_fun, hips
) = let
//
fun
auxpatck
  {n:nat} .<n>.
(
  env: !ccompenv
, res: !instrseq
, narg: int
, hips: list(hipat, n)
, fail: patckont
) : list_vt(primval, n) = let
(*
val () =
println! ("hifunarg_ccomp")
*)
in
//
case+ hips of
//
| list_nil
    () => list_vt_nil()
  // end of [list_nil]
//
| list_cons
    (hip, hips) => let
//
    val loc = hip.hipat_loc
    val hse = hip.hipat_type
//
(*
    val () =
    (
      println!("hifunarg_ccomp: auxpatck: hip = ", hip);
      println!("hifunarg_ccomp: auxpatck: hse = ", hse);
    ) (* end of [val] *)
*)
//
    val pmv =
      primval_make_funarg(loc, hse, narg)
    val ((*void*)) =
      hipatck_ccomp(env, res, fail, hip, pmv)
//
    val pmvs = auxpatck(env, res, narg+1, hips, fail)
//
  in
    list_vt_cons(pmv, pmvs)
  end // end of [list_cons]
//
end // end of [auxpatck]
//
fun auxmatch
  {n:nat} .<n>.
(
  env: !ccompenv
, res: !instrseq
, lvl0: int
, hips: list (hipat, n)
, pmvs: list_vt (primval, n)
) : void = let
in
//
case+ pmvs of
| ~list_vt_cons
    (pmv, pmvs) => let
    val+list_cons(hip, hips) = hips
    val () = himatch_ccomp(env, res, lvl0, hip, pmv)
  in
    auxmatch(env, res, lvl0, hips, pmvs)
  end // end of [list_vt_cons]
| ~list_vt_nil((*nond*)) => ()
//
end // end of [auxmatch]
//
val fail = PTCKNTfunarg_fail (loc_fun, fl)
val pmvs = auxpatck (env, res, 0, hips, fail)
//
in
  auxmatch (env, res, lvl0, hips, pmvs)
end // end of [hifunarg_ccomp]

(* ****** ****** *)

(* end of [pats_ccomp_hipat.dats] *)
