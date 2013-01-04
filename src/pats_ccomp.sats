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

staload "./pats_basics.sats"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp

(* ****** ****** *)

staload LAB = "./pats_label.sats"
typedef label = $LAB.label

(* ****** ****** *)
//
staload FIL = "./pats_filename.sats"
//
staload LOC = "./pats_location.sats"
typedef location = $LOC.location
//
(* ****** ****** *)

staload
SYN = "./pats_syntax.sats"
typedef i0nt = $SYN.i0nt
typedef f0loat = $SYN.f0loat

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

abstype tmplab_type
typedef tmplab = tmplab_type

fun tmplab_make (): tmplab

fun tmplab_get_stamp (x: tmplab): stamp

fun fprint_tmplab : fprint_type (tmplab)
fun print_tmplab (x: tmplab): void
overload print with print_tmplab
fun prerr_tmplab (x: tmplab): void
overload prerr with prerr_tmplab

(* ****** ****** *)

abstype tmpvar_type
typedef tmpvar = tmpvar_type
//
typedef tmpvarlst = List (tmpvar)
typedef tmpvaropt = Option (tmpvar)
//
viewtypedef tmpvarlst_vt = List_vt (tmpvar)
viewtypedef tmpvaropt_vt = Option_vt (tmpvar)

(* ****** ****** *)

absviewtype tmpvarset_viewtype
viewtypedef tmpvarset_vt = tmpvarset_viewtype

(* ****** ****** *)

fun tmpvar_make
  (loc: location, hse: hisexp): tmpvar
fun tmpvar_make_ret
  (loc: location, hse: hisexp): tmpvar

fun tmpvar_get_type (tmp: tmpvar): hisexp

fun tmpvar_get_tpknd (tmp: tmpvar): int // 0/1: local/(static)top

fun tmpvar_get_stamp (tmp: tmpvar): stamp

(* ****** ****** *)

fun print_tmpvar (x: tmpvar): void
overload print with print_tmpvar
fun prerr_tmpvar (x: tmpvar): void
overload prerr with prerr_tmpvar
fun fprint_tmpvar : fprint_type (tmpvar) // implemented in [pats_ccomp_tmpvar.dats]
fun fpprint_tmpvar : fprint_type (tmpvar) // implemented in [pats_ccomp_print.dats]

fun eq_tmpvar_tmpvar (x1: tmpvar, x2: tmpvar):<> bool
overload = with eq_tmpvar_tmpvar

fun compare_tmpvar_tmpvar (x1: tmpvar, x2: tmpvar):<> int
overload = with compare_tmpvar_tmpvar

(* ****** ****** *)

fun tmpvarset_vt_nil ():<> tmpvarset_vt
fun tmpvarset_vt_free (xs: tmpvarset_vt):<> void
fun tmpvarset_vt_add (xs: tmpvarset_vt, x: tmpvar):<> tmpvarset_vt
fun tmpvarset_vt_listize (xs: !tmpvarset_vt):<> tmpvarlst_vt
fun tmpvarset_vt_listize_free (xs: tmpvarset_vt):<> tmpvarlst_vt

(* ****** ****** *)
//
// HX: function label
//
abstype ccomp_funlab_type
typedef funlab = ccomp_funlab_type
typedef funlablst = List (funlab)
//
fun print_funlab (x: funlab): void
overload print with print_funlab
fun prerr_funlab (x: funlab): void
overload prerr with prerr_funlab
fun fprint_funlab : fprint_type (funlab)
//
fun funlab_make_type (hse: hisexp): funlab
fun funlab_make_dcst_type (d2c: d2cst, hse: hisexp): funlab
fun funlab_make_dvar_type (d2v: d2var, hse: hisexp): funlab
fun funlab_make_tmpcst_type
   (d2c: d2cst, t2ms: t2mpmarglst, hse: hisexp): funlab
// end of [funlab_make_tmpcst_typ]
//
fun funlab_get_qopt
  (fl: funlab): d2cstopt // qualifier
//
fun funlab_get_name (fl: funlab): string
//
fun funlab_get_level (fl: funlab): int
//
fun funlab_get_type (fl: funlab): hisexp
fun funlab_get_funclo (fl: funlab): funclo
fun funlab_get_type_arg (fl: funlab): hisexplst
fun funlab_get_type_res (fl: funlab): hisexp
//
fun funlab_get_tmparg (fl: funlab): t2mpmarglst
//
fun funlab_get_stamp (fl: funlab): stamp
//
(* ****** ****** *)
//
// HX: function entry
//
abstype funent_type
typedef funent = funent_type
typedef funentlst = List (funent)
typedef funentopt = Option (funent)
viewtypedef funentopt_vt = Option_vt (funent)
//
fun print_funent (x: funent): void
overload print with print_funent
fun prerr_funent (x: funent): void
overload prerr with prerr_funent
fun fprint_funent : fprint_type (funent)
//
(* ****** ****** *)

fun funent_is_tmplt (feng: funent): bool

(* ****** ****** *)

fun funent_get_loc (fent: funent): location
fun funent_get_lab (fent: funent): funlab
//
fun funent_get_imparg (fent: funent): s2varlst
fun funent_get_tmparg (fent: funent): s2explstlst
//
fun funent_get_tmpret (fent: funent): tmpvar // return value
fun funent_get_tmpvarlst (fent: funent): tmpvarlst // tmporaries
//
(* ****** ****** *)

fun funlab_get_funentopt (fl: funlab): funentopt
fun funlab_set_funentopt (fl: funlab, opt: funentopt): void

(* ****** ****** *)

fun the_funlablst_get (): funlablst
fun the_funlablst_add (fl: funlab): void
fun the_funlablst_addlst (fls: funlablst): void

(* ****** ****** *)

fun hiimpdec_get_funlabopt
  (imp: hiimpdec): Option (funlab)
fun hiimpdec_set_funlabopt
  (imp: hiimpdec, opt: Option (funlab)): void

(* ****** ****** *)

datatype tmpsub =
  | TMPSUBcons of (s2var, s2exp, tmpsub) | TMPSUBnil of ()
viewtypedef tmpsubopt_vt = Option_vt (tmpsub)
 
fun fprint_tmpsub : fprint_type (tmpsub)

(* ****** ****** *)

datatype tmpcstmat =
  | TMPCSTMATsome of (hiimpdec, tmpsub) | TMPCSTMATnone of ()
// end of [tmpcstmat]

fun fprint_tmpcstmat : fprint_type (tmpcstmat)
fun fprint_tmpcstmat_kind : fprint_type (tmpcstmat) // 1/0:found/not

(* ****** ****** *)

abstype ccomp_instrlst_type
typedef instrlst = ccomp_instrlst_type

datatype
primdec_node =
  | PMDnone of () 
//
  | PMDimpdec of (hiimpdec)
//
  | PMDfundecs of (hifundeclst)
//
  | PMDvaldecs of
      (valkind, hivaldeclst, instrlst)
    // end of [PMDvaldecs]
  | PMDvaldecs_rec of
      (valkind, hivaldeclst, instrlst)
    // end of [PMDvaldecs_rec]
//
  | PMDvardecs of (hivardeclst, instrlst)
//
  | PMDstaload of ($FIL.filename)
//
  | PMDlocal of (primdeclst, primdeclst)
// end of [primdec_node]

and primval_node =
//
  | PMVtmp of (tmpvar) // temporary variables
  | PMVtmpref of (tmpvar) // for addresses of temporary variables
//
  | PMVarg of (int)
  | PMVargref of (int) // call-by-reference
  | PMVargtmpref of (int) // call-by-reference but treated as tmpvar
//
  | PMVcst of (d2cst) // for constants
  | PMVvar of (d2var) // for temporaries
//
  | PMVtmpltcst of (d2cst, t2mpmarglst) // for template constants
  | PMVtmpltcstmat of (d2cst, t2mpmarglst, tmpcstmat) // for matched template constants
  | PMVtmpltvar of (d2var, t2mpmarglst) // for template variables
//
  | PMVint of (int)
  | PMVbool of (bool)
  | PMVchar of (char)
  | PMVstring of (string)
//
  | PMVi0nt of (i0nt)
  | PMVf0loat of (f0loat)
//
  | PMVempty of ()
//
  | PMVextval of (string(*name*))
//
  | PMVfunlab of (funlab)
//
  | PMVptrof of (primval)
//
  | PMVcastfn of (d2cst, primval)
//
  | PMVerr of ()
// end of [primval_node]

and primlab_node =
  | PMLlab of (label) | PMLind of (primvalist(*ind*))
// end of [primlab]

and labprimval = LABPRIMVAL of (label, primval)

(* ****** ****** *)

where
primdec = '{
  primdec_loc= location
, primdec_node= primdec_node
} // end of [primdec]

and primdeclst = List (primdec)
and primdeclst_vt = List_vt (primdec)

and primval = '{
  primval_loc= location
, primval_type= hisexp
, primval_node= primval_node
} // end of [primval]

and primvalist = List (primval)
and primvalist_vt = List_vt (primval)
and primvalopt = Option (primval)

and primlab = '{
  primlab_loc= location
, primlab_node= primlab_node
} // end of [primlab]

and primlablst = List (primlab)

and labprimvalist = List (labprimval)

(* ****** ****** *)

fun fprint_primdec : fprint_type (primdec)
fun print_primdec (pmd: primdec): void
overload print with print_primdec
fun prerr_primdec (pmd: primdec): void
overload prerr with prerr_primdec

fun fprint_primdeclst : fprint_type (primdeclst)

(* ****** ****** *)

fun primdec_none (loc: location): primdec

(* ****** ****** *)

fun primdec_impdec
  (loc: location, imp: hiimpdec): primdec
// end of [primdec_impdec]

fun primdec_fundecs
  (loc: location, hfds: hifundeclst): primdec
// end of [primdec_fundecs]

fun primdec_valdecs (
  loc: location, knd: valkind, hvds: hivaldeclst, inss: instrlst
) : primdec // end of [primdec_valdecs]
fun primdec_valdecs_rec (
  loc: location, knd: valkind, hvds: hivaldeclst, inss: instrlst
) : primdec // end of [primdec_valdecs_rec]
//
fun primdec_vardecs
  (loc: location, hvds: hivardeclst, inss: instrlst): primdec
// end of [primdec_vardecs]
//
fun primdec_staload (loc: location, fil: $FIL.filename): primdec
//
(* ****** ****** *)

fun print_primval (x: primval): void
overload print with print_primval
fun prerr_primval (x: primval): void
overload prerr with prerr_primval
fun fprint_primval : fprint_type (primval)

fun fprint_primvalist : fprint_type (primvalist)

(* ****** ****** *)

fun fprint_primlab : fprint_type (primlab)
fun fprint_primlablst : fprint_type (primlablst)

(* ****** ****** *)

fun fprint_labprimvalist : fprint_type (labprimvalist)

(* ****** ****** *)

fun tmpvar_is_void (tmp: tmpvar): bool

(* ****** ****** *)

fun tmpvar_get_alias (tmp: tmpvar): primvalopt
fun tmpvar_set_alias
  (tmp: tmpvar, opt: primvalopt): void = "patsopt_tmpvar_set_alias"
// end of [tmpvar_set_alias]

(* ****** ****** *)

fun primval_is_void (pmv: primval): bool

fun primval_is_mutabl (pmv: primval): bool

(* ****** ****** *)

fun primval_tmp
  (loc: location, hse: hisexp, tmp: tmpvar): primval
fun primval_tmpref
  (loc: location, hse: hisexp, tmp: tmpvar): primval

(* ****** ****** *)

fun primval_arg
  (loc: location, hse: hisexp, narg: int): primval
fun primval_argref
  (loc: location, hse: hisexp, narg: int): primval
fun primval_argtmpref
  (loc: location, hse: hisexp, narg: int): primval

(* ****** ****** *)

fun primval_cst
  (loc: location, hse: hisexp, d2c: d2cst): primval
// end of [primval_cst]

fun primval_var
  (loc: location, hse: hisexp, d2v: d2var): primval
// end of [primval_var]

(* ****** ****** *)

fun primval_int
  (loc: location, hse: hisexp, i: int): primval
fun primval_bool
  (loc: location, hse: hisexp, b: bool): primval
fun primval_char
  (loc: location, hse: hisexp, c: char): primval
fun primval_string
  (loc: location, hse: hisexp, str: string): primval

(* ****** ****** *)

fun primval_i0nt
  (loc: location, hse: hisexp, tok: i0nt): primval
fun primval_f0loat
  (loc: location, hse: hisexp, tok: f0loat): primval

(* ****** ****** *)

fun primval_empty (loc: location, hse: hisexp): primval

(* ****** ****** *)

fun primval_extval
  (loc: location, hse: hisexp, name: string): primval
// end of [primval_extval]

(* ****** ****** *)

fun primval_funlab
  (loc: location, hse: hisexp, fl: funlab): primval
// end of [primval_funlab]

(* ****** ****** *)

fun primval_tmpltcst (
  loc: location, hse: hisexp, d2c: d2cst, t2mas: t2mpmarglst
) : primval // end of [primval_tmpltcst]

fun primval_tmpltvar (
  loc: location, hse: hisexp, d2v: d2var, t2mas: t2mpmarglst
) : primval // end of [primval_tmpltvar]

fun primval_tmpltcstmat (
  loc: location, hse: hisexp, d2c: d2cst, t2mas: t2mpmarglst, mat: tmpcstmat
) : primval // end of [primval_tmpltcstmat]

(* ****** ****** *)

fun primval_make_funlab (loc: location, fl: funlab): primval

(* ****** ****** *)

fun primval_make_tmp (loc: location, tmp: tmpvar): primval
fun primval_make_ptrof (loc: location, pmv: primval): primval

(* ****** ****** *)

fun primlab_lab (loc: location, lab: label): primlab
fun primlab_ind (loc: location, ind: primvalist): primlab

(* ****** ****** *)

datatype patck =
//
  | PATCKint of int
  | PATCKbool of bool
  | PATCKchar of char
  | PATCKstring of string
//
  | PATCKi0nt of (i0nt)
  | PATCKf0loat of (f0loat)
//
  | PATCKcon of d2con
  | PATCKexn of d2con
// end of [patck]

and patckont =
  | PTCKNTnone of ()
  | PTCKNTtmplab of tmplab
  | PTCKNTtmplabint of (tmplab, int)
  | PTCKNTcaseof_fail of (location) // run-time failure
  | PTCKNTfunarg_fail of (location, funlab) // run-time failure
  | PTCKNTraise of primval
// end of [patckont]

(* ****** ****** *)

fun fprint_patck : fprint_type (patck)
fun fprint_patckont : fprint_type (patckont)

(* ****** ****** *)

datatype
instr_node =
//
  | INSfunlab of (funlab)
//
  | INSmove_val of (tmpvar, primval)
  | INSmove_arg_val of (int(*arg*), primval)
  | INSmove_ptr_val of (tmpvar(*ptr*), primval)
//
  | INSmove_con of
      (tmpvar, d2con, hisexp, primvalist(*arg*))
  | INSmove_ptr_con of
      (tmpvar(*ptr*), d2con, hisexp, primvalist(*arg*))
//
  | INSTRmove_rec_box of
      (tmpvar, labprimvalist(*arg*), hisexp)
  | INSTRmove_rec_flt of
      (tmpvar, labprimvalist(*arg*), hisexp)
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
  | INSmove_ref of (tmpvar, primval) // tmp := ref (pmv)
//
  | INSfuncall of
      (tmpvar, primval(*fun*), hisexp, primvalist(*arg*))
    // end of [INSfuncall]
//    
  | INScond of ( // conditinal instruction
      primval(*test*), instrlst(*then*), instrlst(*else*)
    ) // end of [INScond]
//
  | INSpatck of (primval, patck, patckont) // pattern check
//
  | INSselect of (tmpvar, primval, hisexp(*rec*), hilablst)
  | INSselcon of (tmpvar, primval, hisexp(*sum*), int(*narg*))
//
  | INSassgn_varofs of
      (d2var(*left*), primlablst(*ofs*), primval(*right*))
  | INSassgn_ptrofs of
      (primval(*left*), primlablst(*ofs*), primval(*right*))
//
  | INSletpop of ()
  | INSletpush of (primdeclst)
// end of [instr_node]

where
instr = '{
  instr_loc= location, instr_node= instr_node
} // end of [instr]

and instrlst = List (instr)
and instrlst_vt = List_vt (instr)

and ibranch = '{
  ibranch_lab= tmplab, ibranch_inslst= instrlst
} // end of [ibranch]

(* ****** ****** *)

fun fprint_instr : fprint_type (instr)
fun print_instr (x: instr): void
overload print with print_instr
fun prerr_instr (x: instr): void
overload print with prerr_instr

fun fprint_instrlst : fprint_type (instrlst)

(* ****** ****** *)

fun instr_funlab (loc: location, fl: funlab): instr

(* ****** ****** *)

fun instr_move_val (
  loc: location, tmp: tmpvar, pmv: primval
) : instr // end of [instr_move_val]

fun instr_move_arg_val
  (loc: location, arg: int, pmv: primval): instr
// end of [instr_move_arg_val]

(* ****** ****** *)

fun instr_move_con (
  loc: location
, tmp: tmpvar, d2c: d2con, hse_sum: hisexp, pmvs: primvalist
) : instr // end of [instr_move_con]

fun instr_move_ptr_con (
  loc: location
, tmp: tmpvar, d2c: d2con, hse_sum: hisexp, pmvs: primvalist
) : instr // end of [instr_move_ptr_con]

(* ****** ****** *)

fun instr_move_list_nil (loc: location, tmp: tmpvar): instr
fun instr_pmove_list_nil (loc: location, tmp: tmpvar): instr
fun instr_pmove_list_cons (loc: location, tmp: tmpvar): instr

fun instr_update_list_head
  (loc: location, tmphd: tmpvar, tmptl: tmpvar, hse_elt: hisexp): instr
fun instr_update_list_tail
  (loc: location, tl_new: tmpvar, tl_old: tmpvar, hse_elt: hisexp): instr

(* ****** ****** *)

fun instr_move_arrpsz (
  loc: location, tmp: tmpvar, hse_elt: hisexp, asz: int
) : instr // end of [instr_move_arrpsz]

fun instr_update_ptrinc
  (loc: location, tmpelt: tmpvar, hse_elt: hisexp): instr
// end of [instr_update_ptrinc]

(* ****** ****** *)

fun instr_funcall (
  loc: location
, tmpret: tmpvar, _fun: primval, hse_fun: hisexp, _arg: primvalist
) : instr // end of [instr_funcall]

(* ****** ****** *)

fun instr_cond (
  loc: location, _cond: primval, _then: instrlst, _else: instrlst
) : instr // end of [instr_cond]

(* ****** ****** *)

fun instr_patck (
  loc: location, pmv: primval, pck: patck, pcknt: patckont
) : instr // pattern check
  
(* ****** ****** *)

fun instr_select (
  loc: location
, tmp: tmpvar, pmv: primval, hse_rec: hisexp, hils: hilablst
) : instr // end of [instr_select]

fun instr_selcon (
  loc: location
, tmp: tmpvar, pmv: primval, hse_sum: hisexp, narg: int
) : instr // end of [instr_selcon]

(* ****** ****** *)

fun instr_assgn_varofs (
  loc: location, d2v_l: d2var, ofs: primlablst, pmv_r: primval
) : instr // end of [instr_assgn_varofs]

fun instr_assgn_ptrofs (
  loc: location, pmv_l: primval, ofs: primlablst, pmv_r: primval
) : instr // end of [instr_assgn_ptrofs]

(* ****** ****** *)

fun instr_letpop (loc: location): instr
fun instr_letpush (loc: location, pmds: primdeclst): instr

(* ****** ****** *)

fun instrlst_get_tmpvarset (xs: instrlst): tmpvarset_vt

(* ****** ****** *)

absviewtype instrseq_vtype
viewtypedef instrseq = instrseq_vtype

fun instrseq_make_nil (): instrseq
fun instrseq_get_free (res: instrseq): instrlst

fun instrseq_add (res: !instrseq, x: instr): void
fun instrseq_addlst (res: !instrseq, x: instrlst): void

(* ****** ****** *)

fun funent_make (
  loc: location
, fl: funlab
, level: int
, imparg: s2varlst
, tmparg: s2explstlst
, ret: tmpvar
, inss: instrlst
) : funent // end of [funent_make]

(* ****** ****** *)

fun funent_get_instrlst (fent: funent): instrlst

(* ****** ****** *)

absviewtype ccompenv_vtype
viewtypedef ccompenv = ccompenv_vtype

fun ccompenv_make (): ccompenv
fun ccompenv_free (env: ccompenv): void

(* ****** ****** *)

fun fprint_ccompenv (out: FILEref, env: !ccompenv): void

(* ****** ****** *)

fun ccompenv_get_tmplevel (env: !ccompenv): int
fun ccompenv_inc_tmplevel (env: !ccompenv): void
fun ccompenv_dec_tmplevel (env: !ccompenv): void

(* ****** ****** *)

absview ccompenv_push_v

fun ccompenv_pop
  (pfpush: ccompenv_push_v | env: !ccompenv): void
// end of [ccompenv_pop]

fun ccompenv_push (env: !ccompenv): (ccompenv_push_v | void)

(* ****** ****** *)

fun ccompenv_add_varbind
  (env: !ccompenv, d2v: d2var, pmv: primval): void
// end of [ccompenv_add_varbind]

fun ccompenv_find_varbind
  (env: !ccompenv, d2v: d2var): Option_vt (primval)
// end of [ccompenv_find_varbind]

(* ****** ****** *)

fun ccompenv_add_impdec (env: !ccompenv, imp: hiimpdec): void
fun ccompenv_add_fundec (env: !ccompenv, hfd: hifundec): void
fun ccompenv_add_staload (env: !ccompenv, fenv: filenv): void

(* ****** ****** *)

fun hipatck_ccomp (
  env: !ccompenv, res: !instrseq
, fail: patckont, hip: hipat, pmv: primval
) : void // end of [hipatck_ccomp]

fun himatch_ccomp (
  env: !ccompenv, res: !instrseq
, level: int, hip: hipat, pmv: primval // HX: [pmv] matches [hip]
) : void // end of [himatch_ccomp]

(* ****** ****** *)

fun hifunarg_ccomp (
  env: !ccompenv, res: !instrseq
, fl: funlab, level: int, loc_fun: location, hips: hipatlst
) : void // end of [hifunarg_ccomp]

(* ****** ****** *)

fun hidexp_ccomp
  (env: !ccompenv, res: !instrseq, hde: hidexp): primval
fun hidexplst_ccomp
  (env: !ccompenv, res: !instrseq, hdes: hidexplst): primvalist

fun hidexp_ccomp_ret
  (env: !ccompenv, res: !instrseq, tmpret: tmpvar, hde: hidexp): void
// end of [hidexp_ccomp_ret]

(* ****** ****** *)

fun hidexp_ccomp_funlab_arg_body (
  env: !ccompenv
, fl: funlab // HX: needed for recursion
, imparg: s2varlst
, tmparg: s2explstlst
, prolog: instrlst
, loc_fun: location
, hips_arg: hipatlst
, hde_body: hidexp
) : funent // end of [ccomp_exp_arg_body_funlab]

(* ****** ****** *)

fun hiimpdec_ccomp (
  env: !ccompenv, level: int, imp: hiimpdec
) : void // end of [hiimpdec_ccomp]

fun hiimpdec_ccomp_if (
  env: !ccompenv, level: int, imp: hiimpdec
) : void // end of [hiimpdec_ccomp_if]

(* ****** ****** *)

fun hidecl_ccomp
  (env: !ccompenv, hdc: hidecl): primdec
fun hideclist_ccomp
  (env: !ccompenv, hdcs: hideclist): primdeclst

fun hideclist_ccomp0 (hdcs: hideclist): primdeclst

(* ****** ****** *)

fun emit_time_stamp (out: FILEref): void
fun emit_ats_runtime_incl (out: FILEref): void
fun emit_ats_prelude_cats (out: FILEref): void

(* ****** ****** *)

fun emit_ident (out: FILEref, id: string): void

fun emit_label (out: FILEref, lab: label): void

fun emit_filename (out: FILEref, fil: $FIL.filename): void

fun emit_d2con (out: FILEref, d2c: d2con): void
fun emit_d2cst (out: FILEref, d2c: d2cst): void

fun emit_funlab (out: FILEref, fl: funlab): void

fun emit_tmpvar (out: FILEref, tmp: tmpvar): void

fun emit_tmpdec (out: FILEref, tmp: tmpvar): void
fun emit_tmpdeclst (out: FILEref, tmps: tmpvarlst): void

(* ****** ****** *)

fun emit_hisexp (out: FILEref, hse: hisexp): void

fun emit_hisexplst_sep
  (out: FILEref, hses: hisexplst, sep: string): void
// end of [emit_hisexplst_sep]

fun emit_funtype_arg_res
  (out: FILEref, _arg: hisexplst, _res: hisexp): void
// end of [emit_funtype_arg_res]

(* ****** ****** *)

fun emit_primval (out: FILEref, pmv: primval): void
fun emit_primvalist (out: FILEref, pmvs: primvalist): void

(* ****** ****** *)

fun emit_tmpvar_assgn
  (out: FILEref, tmp: tmpvar, pmv: primval): void
// end of [emit_tmpvar_assgn]

(* ****** ****** *)

fun emit_instr (out: FILEref, ins: instr): void
fun emit_instrlst (out: FILEref, inss: instrlst): void
fun emit_instrlst_ln (out: FILEref, inss: instrlst): void

(* ****** ****** *)

fun emit_funarglst
  (out: FILEref, _arg: hisexplst): void
// end of [emit_funarglst]

(* ****** ****** *)
//
// HX: for emitting the prototype of a function entry
//
fun emit_funent_ptype (out: FILEref, fent: funent): void
//
fun emit_funent_implmnt (out: FILEref, fent: funent): void
//
(* ****** ****** *)

fun emit_primdeclst (out: FILEref, pmds: primdeclst): void

(* ****** ****** *)

fun hiimpdec_tmpcst_match
  (imp: hiimpdec, d2c: d2cst, t2mas: t2mpmarglst): tmpcstmat
// end of [hiimpdec_tmpcst_match]
fun hiimpdeclst_tmpcst_match
  (imps: hiimpdeclst, d2c: d2cst, t2mas: t2mpmarglst): tmpcstmat
// end of [hiimpdeclst_tmpcst_match]

fun ccompenv_tmpcst_match
  (env: !ccompenv, d2c: d2cst, t2mas: t2mpmarglst): tmpcstmat
// end of [ccompenv_tmpcst_match]

(* ****** ****** *)

fun ccomp_tmpcstmat (
  env: !ccompenv, loc0: location, hse0: hisexp
, d2c: d2cst, t2ms: t2mpmarglst, mat: tmpcstmat
) : primval // end of [ccomp_tmpcstmat]

(* ****** ****** *)
//
fun tmpvar_subst
  (tmp: tmpvar, sub: !stasub, sfx: int): tmpvar
fun primval_subst
  (pmv: primval, sub: !stasub, sfx: int): primval
//
fun instr_subst (ins: instr, sub: !stasub, sfx: int): instr
fun instrlst_subst (ins: instrlst, sub: !stasub, sfx: int): instrlst
//
(* ****** ****** *)

fun ccomp_main (
  out: FILEref, flag: int, infil: $FIL.filename, hdcs: hideclist
) : void // end of [ccomp_main]

(* ****** ****** *)

(* end of [pats_ccomp.sats] *)
