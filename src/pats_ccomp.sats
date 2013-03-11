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
SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload
SYN = "./pats_syntax.sats"
typedef i0nt = $SYN.i0nt
typedef f0loat = $SYN.f0loat

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload
S2EUT = "./pats_staexp2_util.sats"
vtypedef stasub = $S2EUT.stasub 

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

fun the_dyncstlst_get (): d2cstlst
fun the_dyncstlst_add (d2c: d2cst): void

(* ****** ****** *)

fun the_saspdeclst_get (): hideclist
fun the_saspdeclst_add (hid: hidecl): void

fun the_extcodelst_get (): hideclist
fun the_extcodelst_add (hid: hidecl): void

fun the_staloadlst_get (): hideclist
fun the_staloadlst_add (hid: hidecl): void

(* ****** ****** *)

abstype tmplab_type
typedef tmplab = tmplab_type

fun tmplab_make (): tmplab

fun tmplab_get_stamp (x: tmplab): stamp

fun print_tmplab (x: tmplab): void
overload print with print_tmplab
fun prerr_tmplab (x: tmplab): void
overload prerr with prerr_tmplab
fun fprint_tmplab : fprint_type (tmplab)

(* ****** ****** *)

abstype tmpvar_type
typedef tmpvar = tmpvar_type
//
typedef tmpvarlst = List (tmpvar)
typedef tmpvaropt = Option (tmpvar)
//
vtypedef tmpvarlst_vt = List_vt (tmpvar)
vtypedef tmpvaropt_vt = Option_vt (tmpvar)

(* ****** ****** *)

absvtype tmpvarset_vtype
vtypedef tmpvarset_vt = tmpvarset_vtype

absvtype tmpvarmap_vtype (a:type)
vtypedef tmpvarmap_vt (a:type) = tmpvarmap_vtype (a)

(* ****** ****** *)

fun tmpvar_make
  (loc: location, hse: hisexp): tmpvar
fun tmpvar_make_ret
  (loc: location, hse: hisexp): tmpvar

fun tmpvar_get_loc (tmp: tmpvar): location

fun tmpvar_get_type (tmp: tmpvar): hisexp

fun tmpvar_get_topknd (tmp: tmpvar): int // 0/1: local/(static)top

fun tmpvar_get_origin (tmp: tmpvar): tmpvaropt
fun tmpvar_get_suffix (tmp: tmpvar): int

fun tmpvar_get_stamp (tmp: tmpvar): stamp

(* ****** ****** *)

fun print_tmpvar (x: tmpvar): void
overload print with print_tmpvar
fun prerr_tmpvar (x: tmpvar): void
overload prerr with prerr_tmpvar
fun fprint_tmpvar : fprint_type (tmpvar) // implemented in [pats_ccomp_tmpvar.dats]

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

fun tmpvarmap_vt_nil {a:type} ():<> tmpvarmap_vt (a)
fun tmpvarmap_vt_free {a:type} (map: tmpvarmap_vt(a)):<> void

fun tmpvarmap_vt_search
  {a:type} (map: !tmpvarmap_vt(a), tmp: tmpvar): Option_vt (a)
fun tmpvarmap_vt_insert
  {a:type} (map: &tmpvarmap_vt(a), tmp: tmpvar, x: a): bool(*found*)
fun tmpvarmap_vt_remove
  {a:type} (map: &tmpvarmap_vt(a), tmp: tmpvar): bool(*found*)

(* ****** ****** *)
//
// HX: function label
//
abstype ccomp_funlab_type
typedef funlab = ccomp_funlab_type
typedef funlablst = List (funlab)
typedef funlabopt = Option (funlab)
//
fun print_funlab (x: funlab): void
overload print with print_funlab
fun prerr_funlab (x: funlab): void
overload prerr with prerr_funlab
fun fprint_funlab : fprint_type (funlab)
//
fun
funlab_make (
  name: string
, level: int
, hse0: hisexp
, qopt: d2cstopt
, t2mas: t2mpmarglst
, stamp: stamp
) : funlab // end of [funlab_make]
//
fun funlab_make_type (hse: hisexp): funlab
fun funlab_make_dcst_type (d2c: d2cst, hse: hisexp): funlab
fun funlab_make_dvar_type (d2v: d2var, hse: hisexp): funlab
fun funlab_make_tmpcst_type
   (d2c: d2cst, t2ms: t2mpmarglst, hse: hisexp): funlab
// end of [funlab_make_tmpcst_typ]
//
fun funlab_get_d2copt
  (flab: funlab): d2cstopt // qualifier
//
fun funlab_get_name (flab: funlab): string
//
fun funlab_get_level (flab: funlab): int
//
fun funlab_get_tmpknd (flab: funlab): int
fun funlab_set_tmpknd (flab: funlab, knd: int): void
//
fun funlab_get_type (flab: funlab): hisexp
fun funlab_get_funclo (flab: funlab): funclo
fun funlab_get_type_arg (flab: funlab): hisexplst
fun funlab_get_type_res (flab: funlab): hisexp
//
fun funlab_get_ncopy (flab: funlab): int
fun funlab_set_ncopy (flab: funlab, cnt: int): void
fun funlab_incget_ncopy (flab: funlab): int
//
fun funlab_get_origin (flab: funlab): funlabopt
fun funlab_set_origin (flab: funlab, opt: funlabopt): void
//
fun funlab_get_suffix (flab: funlab): int
fun funlab_set_suffix (flab: funlab, sfx: int): void
//
fun funlab_get_tmparg (flab: funlab): t2mpmarglst
//
fun funlab_get_stamp (flab: funlab): stamp
//
(* ****** ****** *)
//
// HX: function entry
//
abstype funent_type
typedef funent = funent_type
typedef funentlst = List (funent)
typedef funentopt = Option (funent)
vtypedef funentopt_vt = Option_vt (funent)
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
//
fun funent_get_lab (fent: funent): funlab
//
fun funent_get_level (fent: funent): int
//
fun funent_get_imparg (fent: funent): s2varlst
fun funent_get_tmparg (fent: funent): s2explstlst
//
fun funent_get_tmpret (fent: funent): tmpvar // return value
//
fun funent_get_tmpvarlst (fent: funent): tmpvarlst
//
(* ****** ****** *)

fun funlab_get_funent (flab: funlab): funentopt
fun funlab_set_funent (flab: funlab, opt: funentopt): void

(* ****** ****** *)

fun the_funlablst_get (): funlablst
fun the_funlablst_add (flab: funlab): void
fun the_funlablst_addlst (fls: funlablst): void

(* ****** ****** *)

fun hifundec_get_funlabopt
  (hfd: hifundec): Option (funlab)
fun hifundec_set_funlabopt
  (hfd: hifundec, opt: Option (funlab)): void

(* ****** ****** *)

fun hiimpdec_get_funlabopt
  (imp: hiimpdec): Option (funlab)
fun hiimpdec_set_funlabopt
  (imp: hiimpdec, opt: Option (funlab)): void

(* ****** ****** *)

datatype tmpsub =
  | TMPSUBcons of (s2var, s2exp, tmpsub) | TMPSUBnil of ()
typedef tmpsubopt = Option (tmpsub)
vtypedef tmpsubopt_vt = Option_vt (tmpsub)
 
fun fprint_tmpsub : fprint_type (tmpsub)
fun fprint_tmpsubopt : fprint_type (tmpsubopt)

(* ****** ****** *)

fun tmpsub_append (xs1: tmpsub, xs2: tmpsub): tmpsub

(* ****** ****** *)

fun tmpsub2stasub (xs: tmpsub): stasub

(* ****** ****** *)

datatype
tmpcstmat =
  | TMPCSTMATsome of (hiimpdec, tmpsub)
  | TMPCSTMATsome2 of (d2cst, s2explstlst, funlab)
  | TMPCSTMATnone of ()
// end of [tmpcstmat]

fun fprint_tmpcstmat : fprint_type (tmpcstmat)
fun fprint_tmpcstmat_kind : fprint_type (tmpcstmat) // 1/0:found/not

(* ****** ****** *)

datatype
primcstsp =
  | PMCSTSPmyfil of ($FIL.filename)
  | PMCSTSPmyloc of ($LOC.location)
  | PMCSTSPmyfun of (funlab) // HX: for function name
// end of [primcstsp]

fun fprint_primcstsp : fprint_type (primcstsp)

(* ****** ****** *)

abstype ccomp_instrlst_type
typedef instrlst = ccomp_instrlst_type

datatype
primdec_node =
//
  | PMDnone of () 
  | PMDlist of (primdeclst)
//
  | PMDsaspdec of (s2aspdec)
//
  | PMDdatdecs of (s2cstlst)
  | PMDexndecs of (d2conlst)
//
  | PMDfundecs of (
      funkind, s2qualst, hifundeclst
    ) // end of [PMDfundecs]
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
  | PMDimpdec of (hiimpdec)
//
  | PMDstaload of (filenv) // HX: staloading
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
  | PMVint of (int)
  | PMVintrep of (string)
//
  | PMVbool of (bool)
  | PMVchar of (char)
  | PMVfloat of (string)
  | PMVstring of (string)
//
  | PMVi0nt of (i0nt)
  | PMVf0loat of (f0loat)
//
  | PMVsizeof of (hisexp)
//
  | PMVcstsp of (primcstsp)
//
  | PMVtop of ()
  | PMVempty of ()
//
  | PMVextval of (string(*name*))
//
  | PMVcastfn of (d2cst, primval)
//
  | PMVselcon of (primval, hisexp(*tysum*), label)
  | PMVselect of (primval, hisexp(*tyroot*), primlab)
  | PMVselect2 of (primval, hisexp(*tyroot*), primlablst)
//
  | PMVsel_var of (primval, hisexp(*tyroot*), primlablst)
  | PMVsel_ptr of (primval, hisexp(*tyroot*), primlablst)
//
  | PMVptrof of (primval)
  | PMVptrofsel of (primval, hisexp(*tyroot*), primlablst)
//
  | PMVrefarg of (int(*knd*), primval)
//
  | PMVfunlab of (funlab)
  | PMVfunlab2 of (d2var, funlab)
//
  | PMVtmpltcst of (d2cst, t2mpmarglst) // for template constants
  | PMVtmpltcstmat of (d2cst, t2mpmarglst, tmpcstmat) // for matched template constants
  | PMVtmpltvar of (d2var, t2mpmarglst) // for template variables
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

and labprimvalist = List (labprimval)
and labprimvalist_vt = List_vt (labprimval)

and primlab = '{
  primlab_loc= location
, primlab_node= primlab_node
} // end of [primlab]

and primlablst = List (primlab)

(* ****** ****** *)

fun print_primdec (pmd: primdec): void
overload print with print_primdec
fun prerr_primdec (pmd: primdec): void
overload prerr with prerr_primdec
fun fprint_primdec : fprint_type (primdec)
fun fprint_primdeclst : fprint_type (primdeclst)

(* ****** ****** *)

fun primdec_none (loc: location): primdec

(* ****** ****** *)

fun primdec_list (loc: location, pmds: primdeclst): primdec

(* ****** ****** *)

fun primdec_saspdec
  (loc: location, d2c: s2aspdec): primdec
// end of [primdec_saspdec]

(* ****** ****** *)

fun primdec_datdecs
  (loc: location, s2cs: s2cstlst): primdec
// end of [primdec_datdecs]

fun primdec_exndecs
  (loc: location, d2cs: d2conlst): primdec
// end of [primdec_exndecs]

(* ****** ****** *)

fun primdec_fundecs (
  loc: location, knd: funkind, decarg: s2qualst, hfds: hifundeclst
) : primdec // end of [primdec_fundecs]

(* ****** ****** *)

fun primdec_valdecs (
  loc: location, knd: valkind, hvds: hivaldeclst, inss: instrlst
) : primdec // end of [primdec_valdecs]
fun primdec_valdecs_rec (
  loc: location, knd: valkind, hvds: hivaldeclst, inss: instrlst
) : primdec // end of [primdec_valdecs_rec]

(* ****** ****** *)

fun primdec_vardecs
  (loc: location, hvds: hivardeclst, inss: instrlst): primdec
// end of [primdec_vardecs]

(* ****** ****** *)

fun primdec_impdec
  (loc: location, imp: hiimpdec): primdec
// end of [primdec_impdec]

(* ****** ****** *)

fun primdec_staload (loc: location, fenv: filenv): primdec

(* ****** ****** *)

fun primdec_local
  (loc: location, _head: primdeclst, _body: primdeclst): primdec
// end of [primdec_local]

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

fun primval_is_void (pmv: primval): bool

(* ****** ****** *)

fun primval_is_top (pmv: primval): bool (* uninitiated *)
fun primval_is_empty (pmv: primval): bool (* value of size(0) *)

(* ****** ****** *)

fun primval_is_nshared (pmv: primval): bool // left-val/field-sel

(* ****** ****** *)

fun primlab_is_lab (pml: primlab): bool
fun primlab_is_ind (pml: primlab): bool

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
fun primval_intrep
  (loc: location, hse: hisexp, rep: string): primval

(* ****** ****** *)

fun primval_bool
  (loc: location, hse: hisexp, b: bool): primval
fun primval_char
  (loc: location, hse: hisexp, c: char): primval
fun primval_float
  (loc: location, hse: hisexp, rep: string): primval
fun primval_string
  (loc: location, hse: hisexp, str: string): primval

(* ****** ****** *)

fun primval_i0nt
  (loc: location, hse: hisexp, tok: i0nt): primval
fun primval_f0loat
  (loc: location, hse: hisexp, tok: f0loat): primval

(* ****** ****** *)

fun primval_sizeof
  (loc: location, hse: hisexp, hselt: hisexp): primval
// end of [primval_sizeof]

(* ****** ****** *)

fun primval_cstsp
  (loc: location, hse: hisexp, cstsp: primcstsp): primval
// end of [primval_cstsp]

(* ****** ****** *)

fun primval_top (loc: location, hse: hisexp): primval
fun primval_empty (loc: location, hse: hisexp): primval

(* ****** ****** *)

fun primval_extval
  (loc: location, hse: hisexp, name: string): primval
// end of [primval_extval]

(* ****** ****** *)

fun primval_castfn (
  loc: location, hse: hisexp, d2c: d2cst, arg: primval
) : primval // end of [primval_castfn]

(* ****** ****** *)

fun primval_selcon (
  loc: location, hse: hisexp, pmv: primval, hse_sum: hisexp, lab: label
) : primval // end of [primval_selcon]
fun primval_select (
  loc: location, hse: hisexp, pmv: primval, hse_rt: hisexp, pml: primlab
) : primval // end of [primval_select]
fun primval_select2 (
  loc: location, hse: hisexp, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : primval // end of [primval_select2]

(* ****** ****** *)

fun primval_sel_var (
  loc: location, hse: hisexp, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : primval // end of [primval_sel_var]
fun primval_sel_ptr (
  loc: location, hse: hisexp, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : primval // end of [primval_sel_ptr]

(* ****** ****** *)

fun primval_ptrof
  (loc: location, hse: hisexp, pmv: primval): primval
// end of [primval_ptrof]

fun primval_ptrofsel (
  loc: location
, hse: hisexp, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : primval // end of [primval_ptrofsel]

(* ****** ****** *)

fun primval_refarg
  (loc: location, hse: hisexp, knd: int, pmv: primval): primval
// end of [primval_refarg]

(* ****** ****** *)

fun primval_funlab
  (loc: location, hse: hisexp, flab: funlab): primval
// end of [primval_funlab]

fun primval_funlab2
  (loc: location, hse: hisexp, d2v: d2var, flab: funlab): primval
// end of [primval_funlab2]

(* ****** ****** *)

fun primval_tmpltcst (
  loc: location, hse: hisexp, d2c: d2cst, t2mas: t2mpmarglst
) : primval // end of [primval_tmpltcst]

fun primval_tmpltvar (
  loc: location, hse: hisexp, d2v: d2var, t2mas: t2mpmarglst
) : primval // end of [primval_tmpltvar]

fun primval_tmpltcstmat (
  loc: location
, hse: hisexp, d2c: d2cst, t2mas: t2mpmarglst, mat: tmpcstmat
) : primval // end of [primval_tmpltcstmat]

(* ****** ****** *)

fun primval_err (loc: location, hse: hisexp): primval

(* ****** ****** *)

fun primval_make_sizeof (loc: location, hselt: hisexp): primval

(* ****** ****** *)

fun primval_make_funlab
  (loc: location, flab: funlab): primval

fun primval_make_funlab2
  (loc: location, d2v: d2var, flab: funlab): primval
// end of [primval_make_funlab2]

(* ****** ****** *)

fun primval_make_tmp (loc: location, tmp: tmpvar): primval

fun primval_make_ptrof (loc: location, pmv: primval): primval
fun primval_make_ptrofsel
  (loc: location, pmv: primval, hse_rt: hisexp, pmls: primlablst): primval
// end of [primval_make_ptrofsel]

fun primval_make_refarg (loc: location, knd: int, pmv: primval): primval

(* ****** ****** *)

fun primlab_lab (loc: location, lab: label): primlab
fun primlab_ind (loc: location, ind: primvalist): primlab

(* ****** ****** *)

datatype patck =
//
  | PATCKint of (int)
  | PATCKbool of (bool)
  | PATCKchar of (char)
  | PATCKstring of (string)
//
  | PATCKi0nt of (i0nt)
  | PATCKf0loat of (f0loat)
//
  | PATCKcon of (d2con)
  | PATCKexn of (d2con)
//
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

fun print_patck (x: patck): void
overload print with print_patck
fun prerr_patck (x: patck): void
overload prerr with prerr_patck
fun fprint_patck : fprint_type (patck)

fun print_patckont (x: patckont): void
overload print with print_patckont
fun prerr_patckont (x: patckont): void
overload prerr with prerr_patckont
fun fprint_patckont : fprint_type (patckont)

(* ****** ****** *)

fun patckont_is_none (fail: patckont): bool

(* ****** ****** *)

datatype
instr_node =
//
  | INSfunlab of (funlab)
//
  | INSmove_val of (tmpvar, primval)
//
  | INSpmove_val of (tmpvar(*ptr*), primval)
//
  | INSmove_arg_val of (int(*arg*), primval)
//
  | INSfuncall of
      (tmpvar, primval(*fun*), hisexp, primvalist(*arg*))
    // end of [INSfuncall]
//    
  | INScond of ( // conditinal instruction
      primval(*test*), instrlst(*then*), instrlst(*else*)
    ) // end of [INScond]
//
  | INSswitch of (ibranchlst) // switch statement
//
  | INSletpop of ()
  | INSletpush of (primdeclst)
//
  | INSmove_con of
      (tmpvar, d2con, hisexp, labprimvalist(*arg*))
//
  | INSmove_ref of (tmpvar, primval) // tmp := ref (pmv)
//
  | INSmove_boxrec of
      (tmpvar, labprimvalist(*arg*), hisexp)
  | INSmove_fltrec of
      (tmpvar, labprimvalist(*arg*), hisexp)
//
  | INSpatck of (primval, patck, patckont) // pattern check
//
(*
  | INSmove_selcon of
      (tmpvar, primval, hisexp(*tysum*), label)
    // end of [INSmove_selcon]
  | INSmove_select of
      (tmpvar, primval, hisexp(*tyroot*), primlab)
    // end of [INSmove_select]
  | INSmove_select2 of
      (tmpvar, primval, hisexp(*tyroot*), primlablst)
    // end of [INSmove_select2]
*)
//
  | INSmove_ptrofsel of
      (tmpvar, primval, hisexp(*tyroot*), primlablst)
    // end of [INSmove_ptrofsel]
//
  | INSstore_varofs of
      (primval(*left*), hisexp(*tyroot*), primlablst(*ofs*), primval(*right*))
  | INSstore_ptrofs of
      (primval(*left*), hisexp(*tyroot*), primlablst(*ofs*), primval(*right*))
//
  | INSxstore_varofs of
      (primval(*left*), hisexp(*tyroot*), primlablst(*ofs*), primval(*right*))
  | INSxstore_ptrofs of
      (primval(*left*), hisexp(*tyroot*), primlablst(*ofs*), primval(*right*))
//
  | INSmove_list_nil of (tmpvar)
  | INSpmove_list_nil of (tmpvar)
  | INSpmove_list_cons of (tmpvar, hisexp(*elt*))
  | INSmove_list_phead of // hd <- &(tl->val)
      (tmpvar(*hd*), tmpvar(*tl*), hisexp(*elt*))
  | INSmove_list_ptail of // tl_new <- &(tl_old->next)
      (tmpvar(*new*), tmpvar(*old*), hisexp(*elt*))
//
  | INSmove_arrpsz_ptr of (tmpvar, tmpvar)
//
  | INSstore_arrpsz_asz of (tmpvar, int(*asz*))
  | INSstore_arrpsz_ptr of (tmpvar, hisexp(*elt*), int(*asz*))
//
  | INSupdate_ptrinc of (tmpvar, hisexp(*elt*))
  | INSupdate_ptrdec of (tmpvar, hisexp(*elt*))
//
  | INStmpdec of (tmpvar) // HX-2013-01: this is a no-op
//
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

and ibranchlst = List (ibranch)

(* ****** ****** *)

fun print_instr (x: instr): void
overload print with print_instr
fun prerr_instr (x: instr): void
overload prerr with prerr_instr
fun fprint_instr : fprint_type (instr)
fun fprint_instrlst : fprint_type (instrlst)

(* ****** ****** *)

fun instr_funlab (loc: location, flab: funlab): instr

(* ****** ****** *)

fun instr_move_val (
  loc: location, tmp: tmpvar, pmv: primval
) : instr // end of [instr_move_val]

fun instr_pmove_val (
  loc: location, tmp: tmpvar, pmv: primval
) : instr // end of [instr_pmove_val]

(* ****** ****** *)

fun instr_move_arg_val
  (loc: location, arg: int, pmv: primval): instr
// end of [instr_move_arg_val]

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

fun instr_switch (loc: location, xs: ibranchlst): instr

(* ****** ****** *)

fun instr_letpop (loc: location): instr
fun instr_letpush (loc: location, pmds: primdeclst): instr

(* ****** ****** *)

fun instr_move_con (
  loc: location
, tmp: tmpvar, d2c: d2con, hse_sum: hisexp, lpmvs: labprimvalist
) : instr // end of [instr_move_con]

(* ****** ****** *)

fun instr_move_ref
  (loc: location, tmp: tmpvar, pmv: primval): instr
// end of [instr_move_ref]

(* ****** ****** *)

fun instr_move_boxrec (
  loc: location, tmp: tmpvar, arg: labprimvalist, hse: hisexp
) : instr // end of [instr_move_boxrec]
fun instr_move_fltrec (
  loc: location, tmp: tmpvar, arg: labprimvalist, hse: hisexp
) : instr // end of [instr_move_fltrec]
fun instr_move_fltrec2 (
  loc: location, tmp: tmpvar, arg: labprimvalist, hse: hisexp
) : instr // end of [instr_move_fltrec2]

(* ****** ****** *)

fun instr_patck (
  loc: location, pmv: primval, pck: patck, pcknt: patckont
) : instr // pattern check
  
(* ****** ****** *)

fun instr_move_selcon (
  loc: location
, tmp: tmpvar, hse: hisexp, pmv: primval, hse_sum: hisexp, lab: label
) : instr // end of [instr_move_selcon]
fun instr_move_select (
  loc: location
, tmp: tmpvar, hse: hisexp, pmv: primval, hse_rt: hisexp, pml: primlab
) : instr // end of [instr_move_select]
fun instr_move_select2 (
  loc: location
, tmp: tmpvar, hse: hisexp, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : instr // end of [instr_move_select2]

(* ****** ****** *)

fun instr_move_ptrofsel (
  loc: location
, tmp: tmpvar, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : instr // end of [instr_move_ptrofsel]

(* ****** ****** *)

(*
fun instr_load_varofs (
  loc: location
, tmp: tmpvar, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : instr // end of [instr_load_varofs]
fun instr_load_ptrofs (
  loc: location
, tmp: tmpvar, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : instr // end of [instr_load_ptrofs]
*)

(* ****** ****** *)

fun instr_store_varofs (
  loc: location
, pmv_l: primval, hse_rt: hisexp, pmls: primlablst, pmv_r: primval
) : instr // end of [instr_store_varofs]

fun instr_store_ptrofs (
  loc: location
, pmv_l: primval, hse_rt: hisexp, pmls: primlablst, pmv_r: primval
) : instr // end of [instr_store_ptrofs]

(* ****** ****** *)

fun instr_xstore_varofs (
  loc: location
, pmv_l: primval, hse_rt: hisexp, pmls: primlablst, pmv_r: primval
) : instr // end of [instr_xstore_varofs]

fun instr_xstore_ptrofs (
  loc: location
, pmv_l: primval, hse_rt: hisexp, pmls: primlablst, pmv_r: primval
) : instr // end of [instr_xstore_ptrofs]

(* ****** ****** *)

fun instr_move_list_nil
  (loc: location, tmp: tmpvar): instr
fun instr_pmove_list_nil
  (loc: location, tmp: tmpvar): instr
fun instr_pmove_list_cons
  (loc: location, tmp: tmpvar, elt: hisexp): instr

(* ****** ****** *)

fun instr_move_list_phead
  (loc: location, tmphd: tmpvar, tmptl: tmpvar, elt: hisexp): instr
fun instr_move_list_ptail
  (loc: location, tl_new: tmpvar, tl_old: tmpvar, elt: hisexp): instr

(* ****** ****** *)

fun instr_move_arrpsz_ptr
  (loc: location, tmp: tmpvar, psz: tmpvar): instr

(* ****** ****** *)

fun instr_store_arrpsz_asz
  (loc: location, tmp: tmpvar, asz: int) : instr
fun instr_store_arrpsz_ptr (
  loc: location, tmp: tmpvar, hse_elt: hisexp, asz: int
) : instr // end of [instr_store_arrpsz_asz]

(* ****** ****** *)

fun instr_update_ptrinc
  (loc: location, tmpelt: tmpvar, hse_elt: hisexp): instr
// end of [instr_update_ptrinc]
fun instr_update_ptrdec
  (loc: location, tmpelt: tmpvar, hse_elt: hisexp): instr
// end of [instr_update_ptrdec]

(* ****** ****** *)

fun instr_tmpdec (loc: location, tmp: tmpvar): instr

(* ****** ****** *)

fun ibranch_make (tlab: tmplab, inss: instrlst): ibranch

(* ****** ****** *)

fun primlab_lab (loc: location, lab: label): primlab
fun primlab_ind (loc: location, ind: primvalist): primlab

(* ****** ****** *)

fun instrlst_get_tmpvarset (xs: instrlst): tmpvarset_vt
fun primdeclst_get_tmpvarset (xs: primdeclst): tmpvarset_vt

(* ****** ****** *)

absvtype instrseq_vtype
vtypedef instrseq = instrseq_vtype

(* ****** ****** *)

fun instrseq_make_nil (): instrseq
fun instrseq_get_free (res: instrseq): instrlst

fun instrseq_add (res: !instrseq, x: instr): void

fun instrseq_add_tmpdec
  (res: !instrseq, loc: location, tmp: tmpvar): void

fun instrseq_addlst (res: !instrseq, x: instrlst): void

(* ****** ****** *)

fun funent_make (
  loc: location
, level: int
, flab: funlab
, imparg: s2varlst
, tmparg: s2explstlst
, tmpsub: tmpsubopt
, tmpret: tmpvar
, inss: instrlst
, tmplst: tmpvarlst
) : funent // end of [funent_make]

fun funent_make2 (
  loc: location
, level: int
, flab: funlab
, imparg: s2varlst
, tmparg: s2explstlst
, tmpret: tmpvar
, inss: instrlst
) : funent // end of [funent_make2]

(* ****** ****** *)

fun funent_get_tmpsub (fent: funent): tmpsubopt
fun funent_set_tmpsub
  (fent: funent, opt: tmpsubopt): void = "patsopt_funent_set_tmpsub"
// end of [funent_set_tmpsub]

fun funent_get_instrlst (fent: funent): instrlst

(* ****** ****** *)

absvtype ccompenv_vtype
vtypedef ccompenv = ccompenv_vtype

fun ccompenv_make (): ccompenv
fun ccompenv_free (env: ccompenv): void

(* ****** ****** *)

fun fprint_ccompenv (out: FILEref, env: !ccompenv): void

(* ****** ****** *)

fun ccompenv_get_tmplevel (env: !ccompenv): int
fun ccompenv_inc_tmplevel (env: !ccompenv): void
fun ccompenv_dec_tmplevel (env: !ccompenv): void

(* ****** ****** *)

fun ccompenv_get_tmprecdepth (env: !ccompenv): int
fun ccompenv_inc_tmprecdepth (env: !ccompenv): void
fun ccompenv_dec_tmprecdepth (env: !ccompenv): void

(* ****** ****** *)

absview ccompenv_push_v

fun ccompenv_push
  (env: !ccompenv): (ccompenv_push_v | void)
fun ccompenv_pop
  (pfpush: ccompenv_push_v | env: !ccompenv): void
fun ccompenv_localjoin
  (pf1: ccompenv_push_v, pf2: ccompenv_push_v | env: !ccompenv): void

(* ****** ****** *)

fun ccompenv_add_varbind
  (env: !ccompenv, d2v: d2var, pmv: primval): void
// end of [ccompenv_add_varbind]

fun ccompenv_find_varbind
  (env: !ccompenv, d2v: d2var): Option_vt (primval)
// end of [ccompenv_find_varbind]

(* ****** ****** *)

fun ccompenv_add_fundec (env: !ccompenv, hfd: hifundec): void
fun ccompenv_add_impdec (env: !ccompenv, imp: hiimpdec): void
fun ccompenv_add_staload (env: !ccompenv, fenv: filenv): void

(* ****** ****** *)

fun ccompenv_add_tmpsub (env: !ccompenv, tsub: tmpsub): void
fun ccompenv_add_impdecloc (env: !ccompenv, imp: hiimpdec): void
fun ccompenv_add_tmpcstmat (env: !ccompenv, tmpmat: tmpcstmat): void

(* ****** ****** *)

fun ccompenv_add_fundecsloc (
  env: !ccompenv
, knd: funkind, decarg: s2qualst, hfds: hifundeclst
) : void // end of [ccompenv_add_fundecsloc]

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
, flab: funlab, level: int, loc_fun: location, hips: hipatlst
) : void // end of [hifunarg_ccomp]

(* ****** ****** *)

typedef
hidexp_ccomp_funtype =
  (!ccompenv, !instrseq, hidexp) -> primval
fun hidexp_ccomp : hidexp_ccomp_funtype

typedef
hidexp_ccomp_ret_funtype =
  (!ccompenv, !instrseq, tmpvar(*ret*), hidexp) -> void
fun hidexp_ccomp_ret : hidexp_ccomp_ret_funtype
fun hidexp_ccomp_ret_case : hidexp_ccomp_ret_funtype

(* ****** ****** *)

fun hidexplst_ccomp
  (env: !ccompenv, res: !instrseq, hdes: hidexplst): primvalist
// end of [hidexplst_ccomp]

fun labhidexplst_ccomp
  (env: !ccompenv, res: !instrseq, lhdes: labhidexplst): labprimvalist
// end of [labhidexplst_ccomp]

(* ****** ****** *)

fun hidexp_ccomp_funlab_arg_body (
  env: !ccompenv
, flab: funlab // HX: needed for recursion
, imparg: s2varlst
, tmparg: s2explstlst
, prolog: instrlst
, loc_fun: location
, hips_arg: hipatlst
, hde_body: hidexp
) : funent // end of [hidexp_ccomp_arg_body_funlab]

(* ****** ****** *)

fun hiclaulst_ccomp (
  env: !ccompenv
, pmvs: primvalist
, hicls: hiclaulst
, tmpret: tmpvar
, fail: patckont
) : ibranchlst // end of [hiclaulst_ccomp]

(* ****** ****** *)

fun hilab_ccomp
  (env: !ccompenv, res: !instrseq, hil: hilab): primlab
fun hilablst_ccomp
  (env: !ccompenv, res: !instrseq, hils: hilablst): primlablst

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

fun emit_text
  (out: FILEref, txt: string): void
// end of [emit_text]

fun emit_lparen (out: FILEref): void
fun emit_rparen (out: FILEref): void

fun emit_newline (out: FILEref): void

(* ****** ****** *)

fun emit_location (out: FILEref, x: location): void

(* ****** ****** *)

fun emit_int (out: FILEref, x: int): void
fun emit_bool (out: FILEref, x: bool): void
fun emit_char (out: FILEref, x: char): void
fun emit_string (out: FILEref, x: string): void

(* ****** ****** *)

fun emit_ATSPMVint (out: FILEref, x: int): void
fun emit_ATSPMVintrep (out: FILEref, x: string): void

fun emit_ATSPMVbool (out: FILEref, x: bool): void
fun emit_ATSPMVchar (out: FILEref, x: char): void
fun emit_ATSPMVfloat (out: FILEref, rep: string): void
fun emit_ATSPMVstring (out: FILEref, str: string): void

fun emit_ATSPMVi0nt (out: FILEref, tok: $SYN.i0nt): void
fun emit_ATSPMVf0loat (out: FILEref, tok: $SYN.f0loat): void

(* ****** ****** *)

fun emit_symbol (out: FILEref, sym: symbol): void

(* ****** ****** *)

fun emit_time_stamp (out: FILEref): void
fun emit_ats_ccomp_header (out: FILEref): void
fun emit_ats_ccomp_prelude (out: FILEref): void

(* ****** ****** *)

fun emit_ident (out: FILEref, id: string): void

fun emit_label (out: FILEref, lab: label): void
fun emit_atslabel (out: FILEref, lab: label): void
fun emit_labelext (out: FILEref, knd: int, lab: label): void

fun emit_filename (out: FILEref, fil: $FIL.filename): void

(* ****** ****** *)

fun emit_primcstsp (out: FILEref, pmc: primcstsp): void

(* ****** ****** *)

fun emit_s2cst (out: FILEref, d2c: s2cst): void // HX: global
fun emit2_s2cst (out: FILEref, d2c: s2cst): void // HX: local

(* ****** ****** *)

fun emit_d2con (out: FILEref, d2c: d2con): void
fun emit_d2cst (out: FILEref, d2c: d2cst): void // HX: global
fun emit2_d2cst (out: FILEref, d2c: d2cst): void // HX: local

(* ****** ****** *)

fun emit_saspdec (out: FILEref, hid: hidecl): void
fun emit_extcode (out: FILEref, hid: hidecl): void
fun emit_staload (out: FILEref, hid: hidecl): void

(* ****** ****** *)

fun emit_d2cst_exdec (out: FILEref, d2c: d2cst): void
fun emit_d2cstlst_exdec (out: FILEref, d2cs: d2cstlst): void

(* ****** ****** *)

fun emit_sizeof (out: FILEref, hselt: hisexp): void

(* ****** ****** *)

fun emit_tmplab (out: FILEref, tlab: tmplab): void
fun emit_tmplabint (out: FILEref, tlab: tmplab, i: int): void

(* ****** ****** *)

fun emit_tmpvar (out: FILEref, tmp: tmpvar): void

(* ****** ****** *)

fun emit_funlab (out: FILEref, flab: funlab): void // HX: global
fun emit2_funlab (out: FILEref, flab: funlab): void // HX: local

(* ****** ****** *)

fun emit_tmpdec (out: FILEref, tmp: tmpvar): void
fun emit_tmpdeclst (out: FILEref, tmps: tmpvarlst): void

(* ****** ****** *)
//
// HX-2013-01:
// these are implemented in [pats_hitype.dats]
//
abstype hitype_type
typedef hitype = hitype_type
typedef hitypelst = List (hitype)

fun print_hitype (hit: hitype): void
overload print with print_hitype
fun prerr_hitype (hit: hitype): void
overload prerr with prerr_hitype
fun fprint_hitype : fprint_type (hitype)
fun fprint_hitypelst : fprint_type (hitypelst)

(* ****** ****** *)

fun hisexp_typize (hse: hisexp): hitype
fun emit_hitype (out: FILEref, hit: hitype): void

(* ****** ****** *)

fun emit_hisexp (out: FILEref, hse: hisexp): void
fun emit_hisexplst_sep
  (out: FILEref, hses: hisexplst, sep: string): void
// end of [emit_hisexplst_sep]

(* ****** ****** *)

fun emit_funtype_arg_res
  (out: FILEref, _arg: hisexplst, _res: hisexp): void
// end of [emit_funtype_arg_res]

(* ****** ****** *)

fun emit_primval (out: FILEref, pmv: primval): void
fun emit_primvalist (out: FILEref, pmvs: primvalist): void

(* ****** ****** *)

fun emit_primval_deref
  (out: FILEref, pmv: primval, hse_rt: hisexp): void
// end of [emit_primval_deref]

(* ****** ****** *)

fun emit_primlab (out: FILEref, extknd: int, pml: primlab): void

(* ****** ****** *)

fun emit_instr (out: FILEref, ins: instr): void
fun emit_instrlst (out: FILEref, inss: instrlst): void
fun emit_instrlst_ln (out: FILEref, inss: instrlst): void

(* ****** ****** *)

fun emit_instr_patck (out: FILEref, ins: instr): void

(* ****** ****** *)

fun emit_funarglst (out: FILEref, _arg: hisexplst): void

(* ****** ****** *)

fun emit_the_tmpdeclst (out: FILEref): void
fun emit_the_funlablst (out: FILEref): void
fun emit_the_primdeclst (out: FILEref): void
fun emit_the_typedeflst (out: FILEref): void
fun emit_the_dyncstlst_exdec (out: FILEref): void

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

(* ****** ****** *)

datatype
hiimpdec2 =
HIIMPDEC2 of (hiimpdec, tmpsub, s2explstlst)

fun fprint_hiimpdec2 (out: FILEref, imp2: !hiimpdec2): void

fun hiimpdec2_tmpcst_match
  (imp2: hiimpdec2, d2c: d2cst, t2mas: t2mpmarglst): tmpcstmat
// end of [hiimpdec2_tmpcst_match]

(* ****** ****** *)

fun tmpcstmat_tmpcst_match
  (mat: tmpcstmat, d2c: d2cst, t2mas: t2mpmarglst): tmpcstmat
// end of [tmpcstmat_tmpcst_match]

(* ****** ****** *)

fun ccompenv_tmpcst_match
  (env: !ccompenv, d2c: d2cst, t2mas: t2mpmarglst): tmpcstmat
// end of [ccompenv_tmpcst_match]

(* ****** ****** *)

fun ccomp_tmpcstmat (
  env: !ccompenv, loc0: location, hse0: hisexp
, d2c: d2cst, t2ms: t2mpmarglst, tmpmat: tmpcstmat
) : primval // end of [ccomp_tmpcstmat]

(* ****** ****** *)

fun t2mpmarglst_subst
  (loc0: location, sub: !stasub, t2mas: t2mpmarglst): t2mpmarglst
// end of [t2mpmarglst_subst]

fun t2mpmarglst_tsubst
  (loc0: location, tsub: tmpsub, t2mas: t2mpmarglst): t2mpmarglst
// end of [t2mpmarglst_tsubst]

(* ****** ****** *)
//
fun funlab_subst
  (sub: !stasub, flab: funlab): funlab
//
fun funent_subst
  (env: !ccompenv, sub: !stasub, flab2: funlab, fent: funent, sfx: int): funent
//
(* ****** ****** *)

fun the_toplevel_getref_tmpvarlst (): Ptr1
fun the_toplevel_getref_primdeclst (): Ptr1

(* ****** ****** *)

fun ccomp_main (
  out: FILEref, flag: int, infil: $FIL.filename, hdcs: hideclist
) : void // end of [ccomp_main]

(* ****** ****** *)

(* end of [pats_ccomp.sats] *)
