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
// Start Time: November, 2012
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_ccomp_subst"

(* ****** ****** *)

staload ERR = "./pats_error.sats"
staload GLOB = "./pats_global.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

local

fun auxlst (
  loc0: location
, sub: !stasub, xs: t2mpmarglst
) : t2mpmarglst = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val s2es = x.t2mpmarg_arg
    val s2es2 =
      s2explst_subst (sub, s2es)
    val x2 = t2mpmarg_make (loc0, s2es2)
    val xs2 = auxlst (loc0, sub, xs)
  in
    list_cons (x2, xs2)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxlst]

in // in of [local]

implement
t2mpmarglst_subst
  (loc0, sub, t2mas) = auxlst (loc0, sub, t2mas)
// end of [t2mpmarglst_subst]

end // end of [local]

(* ****** ****** *)

implement
t2mpmarglst_tsubst
  (loc0, tsub, t2mas) = let
//
val sub = tmpsub2stasub (tsub)
val t2mas2 = t2mpmarglst_subst (loc0, sub, t2mas)
val () = stasub_free (sub)
in
  t2mas2
end // end of [t2mpmarglst_tsubst]

(* ****** ****** *)
//
extern
fun tmpvar_subst
  (sub: !stasub, tmp: tmpvar, sfx: int): tmpvar
extern
fun tmpvarlst_subst
  (sub: !stasub, tmplst: tmpvarlst, sfx: int): tmpvarlst
//
(* ****** ****** *)

local

extern
fun tmpvar_set_origin (
  tmp: tmpvar, opt: tmpvaropt
) : void  = "patsopt_tmpvar_set_origin"
extern
fun tmpvar_set_suffix
  (tmp: tmpvar, sfx: int): void = "patsopt_tmpvar_set_suffix"
// end of [tmpvar_set_suffix]

in // in of [local]

implement
tmpvar_subst
  (sub, tmp, sfx) = let
  val loc = tmpvar_get_loc (tmp)
  val hse = tmpvar_get_type (tmp)
  val hse = hisexp_subst (sub, hse)
  val tmp2 = tmpvar_make (loc, hse)
  val () =
    tmpvar_set_origin (tmp2, Some (tmp))
  // end of [val]
  val () = tmpvar_set_suffix (tmp2, sfx)
in
  tmp2
end // end of [tmpvar_subst]

end // end of [local]

(* ****** ****** *)

implement
tmpvarlst_subst
  (sub, tmplst, sfx) = let
//
fun loop (
  sub: !stasub
, xs: tmpvarlst, sfx: int, ys: tmpvarlst_vt
) : tmpvarlst_vt = let
//
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val y = tmpvar_subst (sub, x, sfx)
  in
    loop (sub, xs, sfx, list_vt_cons (y, ys))
  end // end of [list_cons]
| list_nil () => ys
//
end // end of [loop]
//
val tmplst2 =
  loop (sub, tmplst, sfx, list_vt_nil)
val tmplst2 = list_vt_reverse (tmplst2)
//
in
  list_of_list_vt (tmplst2)
end // end of [tmpvarlst_subst]

(* ****** ****** *)

vtypedef tmpmap = tmpvarmap_vt (tmpvar)

(* ****** ****** *)
//
extern
fun primval_subst (
  env: !ccompenv, map: !tmpmap, sub: !stasub, pmv: primval, sfx: int
) : primval // end of [primval_subst]
extern
fun primvalist_subst (
  env: !ccompenv, map: !tmpmap, sub: !stasub, pmvs: primvalist, sfx: int
) : primvalist // end of [primvalist_subst]
//
extern
fun labprimval_subst (
  env: !ccompenv, map: !tmpmap, sub: !stasub, lpmv: labprimval, sfx: int
) : labprimval // end of [labprimval_subst]
extern
fun labprimvalist_subst (
  env: !ccompenv, map: !tmpmap, sub: !stasub, lpmvs: labprimvalist, sfx: int
) : labprimvalist // end of [labprimvalist_subst]
//
extern
fun primdec_subst (
  env: !ccompenv, map: !tmpmap, sub: !stasub, pmd: primdec, sfx: int
) : primdec // end of [primdec_subst]
extern
fun primdeclst_subst (
  env: !ccompenv, map: !tmpmap, sub: !stasub, pmds: primdeclst, sfx: int
) : primdeclst // end of [primdeclst_subst]
//
extern
fun instr_subst
  (env: !ccompenv, map: !tmpmap, sub: !stasub, ins: instr, sfx: int): instr
extern
fun instrlst_subst
  (env: !ccompenv, map: !tmpmap, sub: !stasub, inss: instrlst, sfx: int): instrlst
//
(* ****** ****** *)

extern
fun ccompenv_add_fundecsloc_subst (
  env: !ccompenv
, map: !tmpmap, sub: !stasub
, knd: funkind, decarg: s2qualst, hfds: hifundeclst
) : void // end of [ccompenv_add_fundecsloc_subst]

(* ****** ****** *)

implement
funlab_subst
  (sub, flab) = flab2 where {
//
val name = funlab_get_name (flab)
val level = funlab_get_level (flab)
val hse = funlab_get_type (flab)
val hse2 = hisexp_subst (sub, hse)
val () = println! ("funlab_subst: hse2 = ", hse2)
val qopt = funlab_get_d2copt (flab)
val t2mas = funlab_get_tmparg (flab)
val stamp = $STMP.funlab_stamp_make ()
//
val flab2 =
  funlab_make (name, level, hse2, qopt, t2mas, stamp)
val () = funlab_set_origin (flab2, Some (flab))
//
} // end of [funlab_subst]

(* ****** ****** *)

extern
fun tmpmap_make
  (xs: tmpvarlst): tmpmap
implement
tmpmap_make (xs) = let
//
fun loop (
  xs: tmpvarlst, res: &tmpmap
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val-Some (xp) = tmpvar_get_origin (x)
    val _(*inserted*) = tmpvarmap_vt_insert (res, xp, x)
  in
    loop (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
var res
  : tmpmap = tmpvarmap_vt_nil ()
val () = loop (xs, res)
//
in
  res
end // end of [tmpmap_make]

(* ****** ****** *)

extern
fun tmpvar2var
  (map: !tmpmap, tmp: tmpvar): tmpvar
implement
tmpvar2var (map, tmp) = let
  val opt = tmpvarmap_vt_search (map, tmp)
in
//
case+ opt of
| ~Some_vt (tmp2) => tmp2
| ~None_vt () => let
    val () = prerr_interror ()
    val () = prerr ": tmpvar2var: copy is not found: tmp = "
    val () = prerr_tmpvar (tmp)
  in
    $ERR.abort ()
  end // end of [None_vt]
//
end // end of [tmpvar2var]

(* ****** ****** *)

(*
extern
fun tmpvarlst_reset_alias (
  map: !tmpmap, tmplst: tmpvarlst
) : void // end of [tmpvarlst_reset_alias]
//
implement
tmpvarlst_reset_alias
  (map, tmplst) = let
in
//
case+ tmplst of
| list_cons
    (tmp, tmplst) => let
    val-Some (tmp0) =
      tmpvar_get_origin (tmp)
    val opt = tmpvar_get_alias (tmp0)
    val () = (
      case+ opt of
      | Some (atmp) => let
          val atmp2 = tmpvar2var (map, atmp)
        in
          tmpvar_set_alias (tmp, Some (atmp2))
        end // end of [Some]
      | None () => ()
    ) : void // end of [val]
  in
    tmpvarlst_reset_alias (map, tmplst)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [tmpvarlst_reset_alias]
*)

(* ****** ****** *)

implement
funent_subst
  (env, sub, flab2, fent, sfx) = let
//
val () =
  println! ("funent_subst: flab2 = ", flab2)
// end of [val]
//
val loc = funent_get_loc (fent)
val flab = funent_get_lab (fent)
val level = funent_get_level (fent)
//
val imparg = funent_get_imparg (fent)
val tmparg = funent_get_tmparg (fent)
//
val tmparg2 = s2explstlst_subst (sub, tmparg)
//
val tmpret = funent_get_tmpret (fent)
val inss = funent_get_instrlst (fent)
val tmplst = funent_get_tmpvarlst (fent)
//
val tmplst2 =
  tmpvarlst_subst (sub, tmplst, sfx)
val tmpmap2 = tmpmap_make (tmplst2)
//
val tmpret2 = tmpvar2var (tmpmap2, tmpret)
//
val () = let
  val opt = funlab_get_d2copt (flab)
in
//
case+ opt of
| Some (d2c) =>
    ccompenv_add_tmpcstmat (
    env, TMPCSTMATsome2 (d2c, tmparg2, flab2)
  ) // end of [Some]
| None () => ()
//
end // end of [val]
//
val inss2 = instrlst_subst (env, tmpmap2, sub, inss, sfx)
//
val ((*void*)) = tmpvarmap_vt_free (tmpmap2)
//
val fent2 =
  funent_make (
  loc, level, flab2, imparg, tmparg, None(), tmpret2, inss2, tmplst2
) // end of [val]
//
in
  fent2
end // end of [funent_subst]

(* ****** ****** *)

implement
primval_subst (
  env, map, sub, pmv0, sfx
) = let
//
val (
) = println!
  ("primval_subst: pmv0 = ", pmv0)
//
val loc0 = pmv0.primval_loc
val hse0 = pmv0.primval_type
val hse0 = hisexp_subst (sub, hse0)
//
macdef ftmp (x) = tmpvar2var (map, ,(x))
macdef fpmv (x) = primval_subst (env, map, sub, ,(x), sfx)
macdef fpmvlst (xs) = primvalist_subst (env, map, sub, ,(xs), sfx)
//
in
//
case+
  pmv0.primval_node of
//
| PMVtmp (tmp) => let
    val tmp = ftmp (tmp) in primval_tmp (loc0, hse0, tmp)
  end // end of [PMVtmp]
| PMVtmpref (tmp) => let
    val tmp = ftmp (tmp) in primval_tmpref (loc0, hse0, tmp)
  end // end of [PMVtmpref]
//
| PMVarg (n) => primval_arg (loc0, hse0, n)
| PMVargref (n) => primval_argref (loc0, hse0, n)
//
| PMVtop () => primval_top (loc0, hse0)
| PMVempty () => primval_empty (loc0, hse0)
//
| PMVextval (name) => primval_extval (loc0, hse0, name)
//
| PMVcastfn
    (d2c, pmv) => let
    val pmv = fpmv (pmv)
  in
    primval_castfn (loc0, hse0, d2c, pmv)
  end // end of [PMVcastfn]
//
| PMVsizeof (hselt) => let
    val hselt =
      hisexp_subst (sub, hselt)
    // end of [val]
  in
    primval_sizeof (loc0, hse0, hselt)
  end // end of [PMVsizeof]
//
| PMVselcon
    (pmv, hse_sum, lab) => let
    val pmv = fpmv (pmv)
    val hse_sum = hisexp_subst (sub, hse_sum)
  in
    primval_selcon (loc0, hse0, pmv, hse_sum, lab)
  end // end of [PMVselcon]
//
| PMVselect
    (pmv, hse_rt, pml) => let
    val pmv = fpmv (pmv)
    val hse_rt = hisexp_subst (sub, hse_rt)
  in
    primval_select (loc0, hse0, pmv, hse_rt, pml)
  end // end of [PMVselect]
| PMVselect2
    (pmv, hse_rt, pmls) => let
    val pmv = fpmv (pmv)
    val hse_rt = hisexp_subst (sub, hse_rt)
  in
    primval_select2 (loc0, hse0, pmv, hse_rt, pmls)
  end // end of [PMVselect2]
//
| PMVsel_var
    (pmv, hse_rt, pmls) => let
    val pmv = fpmv (pmv)
    val hse_rt = hisexp_subst (sub, hse_rt)
  in
    primval_sel_var (loc0, hse0, pmv, hse_rt, pmls)
  end // end of [PMVsel_var]
| PMVsel_ptr
    (pmv, hse_rt, pmls) => let
    val pmv = fpmv (pmv)
    val hse_rt = hisexp_subst (sub, hse_rt)
  in
    primval_sel_ptr (loc0, hse0, pmv, hse_rt, pmls)
  end // end of [PMVsel_ptr]
//
| PMVptrof (pmv) => let
    val pmv = fpmv (pmv) in primval_ptrof (loc0, hse0, pmv)
  end // end of [PMVptrof]
| PMVptrofsel
    (pmv, hse_rt, pmls) => let
    val pmv = fpmv (pmv)
    val hse_rt = hisexp_subst (sub, hse_rt)
  in
    primval_ptrofsel (loc0, hse0, pmv, hse_rt, pmls)
  end // end of [PMVptrof]
//
| PMVrefarg
    (knd, pmv) => let
    val pmv = fpmv (pmv) in primval_refarg (loc0, hse0, knd, pmv)
  end // of [PMVrefarg]
//
| PMVfunlab
    (flab) => primval_funlab (loc0, hse0, flab)
| PMVfunlab2
    (d2v, flab) => let
    val opt = ccompenv_find_varbind (env, d2v)
  in
    case+ opt of
    | ~Some_vt (
        pmv_flab
      ) => pmv_flab
    | ~None_vt (
      ) => primval_funlab2 (loc0, hse0, d2v, flab)
  end // end of [PMVfunlab2]
//
| PMVtmpltcst
    (d2c, t2mas) => let
    val trd = ccompenv_get_tmprecdepth (env)
    val mtrd = $GLOB.the_CCOMPENV_maxtmprecdepth_get ()
  in
    if trd < mtrd then let
      val t2mas = t2mpmarglst_subst (loc0, sub, t2mas)
      val tmpmat = ccompenv_tmpcst_match (env, d2c, t2mas)
    in
      ccomp_tmpcstmat (env, loc0, hse0, d2c, t2mas, tmpmat)
    end else
      pmv0 // HX-2013-01: maximal tmprecdepth is reached!
    // end of [if]
  end // end of [PMVtmpltcst]
//
| _ => pmv0
//
end // end of [primval_subst]

(* ****** ****** *)

implement
primvalist_subst (
  env, map, sub, pmvs, sfx
) = let
in
//
case+ pmvs of
| list_cons
    (pmv, pmvs) => let
    val pmv = primval_subst (env, map, sub, pmv, sfx)
    val pmvs = primvalist_subst (env, map, sub, pmvs, sfx)
  in
    list_cons (pmv, pmvs)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [primvalist_subst]

(* ****** ****** *)

implement
labprimval_subst (
  env, map, sub, lpmv, sfx
) = let
//
val LABPRIMVAL (lab, pmv) = lpmv
val pmv = primval_subst (env, map, sub, pmv, sfx)
//
in
  LABPRIMVAL (lab, pmv)
end // end of [labprimval_subst]

(* ****** ****** *)

implement
labprimvalist_subst (
  env, map, sub, lpmvs, sfx
) = let
in
//
case+ lpmvs of
| list_cons
    (lpmv, lpmvs) => let
    val lpmv = labprimval_subst (env, map, sub, lpmv, sfx)
    val lpmvs = labprimvalist_subst (env, map, sub, lpmvs, sfx)
  in
    list_cons (lpmv, lpmvs)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [primvalist_subst]

(* ****** ****** *)

typedef instrlst0 = ccomp_instrlst_type

extern
fun instrlst0_subst (
  env: !ccompenv, map: !tmpmap, sub: !stasub, inss: instrlst0, sfx: int
) : instrlst0 // [ccomp_instrlst_subst]

implement
instrlst0_subst
  (env, map, sub, inss, sfx) = let
  val inss = $UN.cast{instrlst} (inss)
  val inss = instrlst_subst (env, map, sub, inss, sfx)
in
  $UN.cast{instrlst0} (inss)
end // end of [instrlst0_subst]

(* ****** ****** *)

implement
primdec_subst (
  env, map, sub, pmd0, sfx
) = let
  val loc0 = pmd0.primdec_loc
in
//
case+
  pmd0.primdec_node of
//
| PMDnone () => pmd0
//
| PMDsaspdec _ => pmd0
//
| PMDdatdecs _ => pmd0
| PMDexndecs _ => pmd0
//
| PMDimpdec (imp) => let
    val () = ccompenv_add_impdecloc (env, imp) in pmd0
  end // end of [PMDimpdec]
//
| PMDfundecs
    (knd, decarg, hfds) => let
    val () =
      ccompenv_add_fundecsloc (env, knd, decarg, hfds)
    // end of [val]
    val () =
      ccompenv_add_fundecsloc_subst (env, map, sub, knd, decarg, hfds)
    // end of [val]
  in
    pmd0
  end // end of [PMDfundecs]
//
| PMDvaldecs
    (knd, hvds, inss) => let
    val inss = instrlst0_subst (env, map, sub, inss, sfx)
  in
    primdec_valdecs (loc0, knd, hvds, inss)
  end // end of [PMDvaldecs]
| PMDvaldecs_rec
    (knd, hvds, inss) => let
    val inss = instrlst0_subst (env, map, sub, inss, sfx)
  in
    primdec_valdecs_rec (loc0, knd, hvds, inss)
  end // end of [PMDvaldecs_rec]
//
| PMDvardecs (hvds, inss) => let
    val inss = instrlst0_subst (env, map, sub, inss, sfx)
  in
    primdec_vardecs (loc0, hvds, inss)
  end // end of [PMDvardecs]
//
| PMDstaload (fenv) => let
    val () = ccompenv_add_staload (env, fenv) in pmd0
  end // end of [PMDstaload]
//
| PMDlocal (
    pmds_head, pmds_body
  ) => let
    val (pf | ()) = ccompenv_push (env)
    val pmds_head =
      primdeclst_subst (env, map, sub, pmds_head, sfx)
    val (pf2 | ()) = ccompenv_push (env)
    val pmds_body =
      primdeclst_subst (env, map, sub, pmds_body, sfx)
    val () = ccompenv_localjoin (pf, pf2 | env)
  in
    primdec_local (loc0, pmds_head, pmds_body)
  end // end of [PMDlocal]
//
end // end of [primdec_subst]

(* ****** ****** *)

implement
primdeclst_subst (
  env, map, sub, pmds, sfx
) = let
in
//
case+ pmds of
| list_cons
    (pmd, pmds) => let
    val pmd = primdec_subst (env, map, sub, pmd, sfx)
    val pmds = primdeclst_subst (env, map, sub, pmds, sfx)
  in
    list_cons (pmd, pmds)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [primdeclst_subst]

(* ****** ****** *)

implement
instr_subst (
  env, map, sub, ins0, sfx
) = let
//
val loc0 = ins0.instr_loc
//
macdef ftmp (x) = tmpvar2var (map, ,(x))
macdef fpmv (x) = primval_subst (env, map, sub, ,(x), sfx)
macdef flabpmv (lx) = labprimval_subst (env, map, sub, ,(lx), sfx)
macdef fpmvlst (xs) = primvalist_subst (env, map, sub, ,(xs), sfx)
macdef flabpmvlst (lxs) = labprimvalist_subst (env, map, sub, ,(lxs), sfx)
macdef fpmd (x) = primdec_subst (env, map, sub, ,(x), sfx)
macdef fpmdlst (xs) = primdeclst_subst (env, map, sub, ,(xs), sfx)
//
in
//
case+
  ins0.instr_node of
//
| INSfunlab _ => ins0
//
| INSmove_val
    (tmp, pmv) => let
    val tmp = ftmp (tmp)
    val pmv = fpmv (pmv)
  in
    instr_move_val (loc0, tmp, pmv)
  end // end of [INSmove_val]
//
| INSpmove_val
    (tmp, pmv) => let
    val tmp = ftmp (tmp)
    val pmv = fpmv (pmv)
  in
    instr_pmove_val (loc0, tmp, pmv)
  end // end of [INSpmove_val]
//
| INSmove_arg_val
    (narg, pmv) => let
    val pmv = fpmv (pmv)
  in
    instr_move_arg_val (loc0, narg, pmv)
  end // end of [INSmove_arg_val]
//
| INSfuncall
    (tmp, _fun, hse, _arg) => let
    val tmp = ftmp (tmp)
    val _fun = fpmv (_fun)
    val hse = hisexp_subst (sub, hse)
    val _arg = fpmvlst (_arg)
  in
    instr_funcall (loc0, tmp, _fun, hse, _arg)
  end // end of [INSfuncall]
//
| INScond (
    pmv, _then, _else
  ) => let
    val pmv = fpmv (pmv)
    val _then = instrlst_subst (env, map, sub, _then, sfx)
    val _else = instrlst_subst (env, map, sub, _else, sfx)
  in
    instr_cond (loc0, pmv, _then, _else)
  end // end of [INScond]
//
(*
| INSswitch (x) => ...
*)
//
| INSletpop () => let
    prval pfpush = __assert () where {
      extern praxi __assert : () -<prf> ccompenv_push_v
    } // end of [prval]
    val () = ccompenv_pop (pfpush | env)
  in
    ins0
  end // end of [INSletpop]
//
| INSletpush (pmds) => let
    val (pfpush | ()) = ccompenv_push (env)
    prval () = __assert (pfpush) where {
      extern praxi __assert : (ccompenv_push_v) -<prf> void
    } // end of [prval]
    val pmds = fpmdlst (pmds)
  in
    instr_letpush (loc0, pmds)
  end // end of [INSletpush]
//
| INSmove_con (
    tmp, d2c, hse_sum, lpmvs
  ) => let
    val tmp = ftmp (tmp)
    val hse_sum = hisexp_subst (sub, hse_sum)
    val lpmvs = flabpmvlst (lpmvs)
  in
    instr_move_con (loc0, tmp, d2c, hse_sum, lpmvs)
  end // end of [INSmove_con]
//
| INSmove_ref
    (tmp, pmv) => let
    val tmp = ftmp (tmp)
    val pmv = fpmv (pmv)
  in
    instr_move_ref (loc0, tmp, pmv)
  end // end of [INSmove_ref]
//
| INSmove_boxrec (
    tmp, lpmvs, hse_rec
  ) => let
    val tmp = ftmp (tmp)
    val hse_rec = hisexp_subst (sub, hse_rec)
    val lpmvs = flabpmvlst (lpmvs)
  in
    instr_move_boxrec (loc0, tmp, lpmvs, hse_rec)
  end // end of [INSmove_boxrec]
| INSmove_fltrec (
    tmp, lpmvs, hse_rec
  ) => let
    val tmp = ftmp (tmp)
    val hse_rec = hisexp_subst (sub, hse_rec)
    val lpmvs = flabpmvlst (lpmvs)
  in
    instr_move_fltrec (loc0, tmp, lpmvs, hse_rec)
  end // end of [INSmove_fltrec]
//
(*
| INSpatck of (primval, patck, patckont) // pattern check
*)
//
(*
| INSmove_ptrofsel of
    (tmpvar, primval, hisexp(*tyroot*), primlablst)
  // end of [INSmove_ptrofsel]
*)
//
(*
| INSload_varofs
    (tmp, pmv, hse_rt, pmls) => let
    val tmp = ftmp (tmp)
    val pmv = fpmv (pmv)
    val hse_rt = hisexp_subst (sub, hse_rt)
  in
    instr_load_varofs (loc0, tmp, pmv, hse_rt, pmls)
  end // end of [INSload_varofs]
| INSload_ptrofs
    (tmp, pmv, hse_rt, pmls) => let
    val tmp = ftmp (tmp)
    val pmv = fpmv (pmv)
    val hse_rt = hisexp_subst (sub, hse_rt)
  in
    instr_load_ptrofs (loc0, tmp, pmv, hse_rt, pmls)
  end // end of [INSload_ptrofs]
*)
//
| INSstore_varofs (
    pmv_l, hse_rt, pmls, pmv_r
  ) => let
    val pmv_l = fpmv (pmv_l)
    val hse_rt = hisexp_subst (sub, hse_rt)
    val pmv_r = fpmv (pmv_r)
  in
    instr_store_varofs (loc0, pmv_l, hse_rt, pmls, pmv_r)
  end // end of [INSstore_varofs]
| INSstore_ptrofs (
    pmv_l, hse_rt, pmls, pmv_r
  ) => let
    val pmv_l = fpmv (pmv_l)
    val hse_rt = hisexp_subst (sub, hse_rt)
    val pmv_r = fpmv (pmv_r)
  in
    instr_store_ptrofs (loc0, pmv_l, hse_rt, pmls, pmv_r)
  end // end of [INSstore_ptrofs]
//
(*
//
| INSmove_list_nil of (tmpvar) // tmp <- list_nil
| INSpmove_list_nil of (tmpvar) // *tmp <- list_nil
| INSpmove_list_cons of (tmpvar) // *tmp <- list_cons
| INSupdate_list_head of // hd <- &(tl->val)
    (tmpvar(*hd*), tmpvar(*tl*), hisexp(*elt*))
| INSupdate_list_tail of // tl_new <- &(tl_old->next)
    (tmpvar(*new*), tmpvar(*old*), hisexp(*elt*))
//
| INSmove_arrpsz of
    (tmpvar, hisexp(*elt*), int(*asz*))
| INSupdate_ptrinc of (tmpvar, hisexp(*elt*))
//
*)
| _ => ins0
//
end // end of [instr_subst]

(* ****** ****** *)

implement
instrlst_subst
  (env, map, sub, inss, sfx) = let
//
fun loop (
  env: !ccompenv
, map: !tmpmap
, sub: !stasub
, inss: instrlst
, sfx: int
, res: &instrlst? >> instrlst
) : void = let
in
//
case+ inss of
| list_cons
    (ins, inss) => let
    val ins =
      instr_subst (env, map, sub, ins, sfx)
    // end of [val]
    val () = res := list_cons {instr}{0} (ins, ?)
    val list_cons (_, !p_res1) = res
    val () = loop (env, map, sub, inss, sfx, !p_res1)
    prval () = fold@ (res)
  in
    // nothing
  end // end of [list_cons]
| list_nil () => (res := list_nil ())
//
end // end of [loop]
//
var res: instrlst?
val () = loop (env, map, sub, inss, sfx, res)
//
in
  res
end // end of [instrlst_subst]

(* ****** ****** *)

local

extern
fun auxinit
  {n:nat} (
  env: !ccompenv
, map: !tmpmap, sub: !stasub, hfds: list (hifundec, n)
) : list_vt (funlab, n)
implement
auxinit (
  env, map, sub, hfds
) = let
in
//
case+ hfds of
| list_cons
    (hfd, hfds) => let
    val-Some (flab) =
      hifundec_get_funlabopt (hfd)
    // end of [val]
//
    val sfx = funlab_incget_ncopy (flab)
    val flab2 = funlab_subst (sub, flab)
    val () = funlab_set_suffix (flab2, sfx)
    val () = the_funlablst_add (flab2)
//
    val loc = hfd.hifundec_loc
    val d2v = hfd.hifundec_var
    val pmv = primval_make_funlab (loc, flab2)
    val () = ccompenv_add_varbind (env, d2v, pmv)
//
    val flabs2 = auxinit (env, map, sub, hfds)
  in
    list_vt_cons (flab2, flabs2)
  end
| list_nil () => list_vt_nil ()
//
end // end of [auxinit]

extern
fun auxmain
  {n:nat} (
  env: !ccompenv
, map: !tmpmap, sub: !stasub
, hfds: list (hifundec, n), flabs: list_vt (funlab, n)
) : void // end of [val]
implement
auxmain (
  env, map, sub, hfds, flabs2
) = let
in
//
case+ hfds of
| list_cons
    (hfd, hfds) => let
    val+~list_vt_cons (flab2, flabs2) = flabs2
    val-Some (flab) = funlab_get_origin (flab2)
    val-Some (fent) = funlab_get_funent (flab)
    val sfx = funlab_get_suffix (flab2)
    val fent2 = funent_subst (env, sub, flab2, fent, sfx)
    val () = funlab_set_funent (flab2, Some (fent2))
  in
    auxmain (env, map, sub, hfds, flabs2)
  end // end of [list_cons]
| list_nil () => let
    val+~list_vt_nil () = flabs2 in (*nothing*)
  end // end of [list_nil]
//
end // end of [auxmain]

in (* in of [local] *)

implement
ccompenv_add_fundecsloc_subst (
  env, map, sub, knd, decarg, hfds
) = let
in
//
case+ decarg of
| list_nil (
  ) => let
    val flabs = auxinit (env, map, sub, hfds)
    val () = auxmain (env, map, sub, hfds, flabs)
  in
    // nothing
  end // end of [list_nil]
| list_cons _ => ()
//
end // end of [ccompenv_add_fundecsloc_subst]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_subst.dats] *)
