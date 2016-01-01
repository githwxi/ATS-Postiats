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

staload "./pats_basics.sats"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp

(* ****** ****** *)

staload
LAB = "./pats_label.sats"
typedef label = $LAB.label

(* ****** ****** *)
//
staload
FIL = "./pats_filename.sats"
typedef filename = $FIL.filename
//
staload
LOC = "./pats_location.sats"
typedef loc_t = $LOC.location
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
//
staload
S2EUT =
"./pats_staexp2_util.sats"
vtypedef stasub = $S2EUT.stasub 
//
(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

fun the_exndeclst_get (): hideclist
fun the_exndeclst_add (hid: hidecl): void

(* ****** ****** *)

fun the_saspdeclst_get (): hideclist
fun the_saspdeclst_add (hid: hidecl): void

(* ****** ****** *)

fun the_extypelst_get (): hideclist
fun the_extypelst_add (hid: hidecl): void

(* ****** ****** *)

fun the_extcodelst_get (): hideclist
fun the_extcodelst_add (hid: hidecl): void

(* ****** ****** *)

fun the_staloadlst_get (): hideclist
fun the_staloadlst_add (hid: hidecl): void

fun the_dynloadlst_get (): hideclist
fun the_dynloadlst_add (hid: hidecl): void

(* ****** ****** *)

fun the_dynconlst_get (): d2conlst
fun the_dynconlst_add (d2c: d2con): void

(* ****** ****** *)

fun the_dyncstlst_get (): d2cstlst
fun the_dyncstlst_add (d2c: d2cst): void

(* ****** ****** *)

abstype tmplab_type
typedef tmplab = tmplab_type
typedef tmplabopt = Option (tmplab)

(* ****** ****** *)

fun tmplab_make (loc: loc_t): tmplab
fun tmplab_get_loc (x: tmplab): loc_t
fun tmplab_get_stamp (x: tmplab): stamp

(* ****** ****** *)

fun print_tmplab (x: tmplab): void
fun prerr_tmplab (x: tmplab): void
overload print with print_tmplab
overload prerr with prerr_tmplab
fun fprint_tmplab : fprint_type (tmplab)
overload fprint with fprint_tmplab

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
  (loc: loc_t, hse: hisexp): tmpvar
fun tmpvar_make_ref
  (loc: loc_t, hse: hisexp): tmpvar
fun tmpvar_make_ret
  (loc: loc_t, hse: hisexp): tmpvar

(* ****** ****** *)

fun tmpvar_copy_err (tmp: tmpvar): tmpvar

(* ****** ****** *)
//
fun tmpvar_get_loc (tmp: tmpvar): loc_t
//
fun tmpvar_get_type (tmp: tmpvar): hisexp
//
fun tmpvar_isref (tmp: tmpvar): bool // tmpref?
fun tmpvar_isret (tmp: tmpvar): bool // tmpret?
fun tmpvar_iserr (tmp: tmpvar): bool // tmperr?
//
fun tmpvar_get_topknd
  (tmp: tmpvar): int // knd=0/1: local/(static)top
//
fun tmpvar_get_origin (tmp: tmpvar): tmpvaropt
fun tmpvar_get_suffix (tmp: tmpvar): int
//
fun tmpvar_get_stamp (tmp: tmpvar): stamp // unicity
//
(* ****** ****** *)

fun tmpvar_get_tailcal (tmp: tmpvar): int // if >= 2
fun tmpvar_inc_tailcal (tmp: tmpvar): void // incby 1

(* ****** ****** *)

fun tmpvar_set_tyclo (tmp: tmpvar, fl: funlab): void

(* ****** ****** *)
//
fun print_tmpvar (x: tmpvar): void
fun prerr_tmpvar (x: tmpvar): void
fun fprint_tmpvar : fprint_type (tmpvar)
fun fprint_tmpvaropt : fprint_type (tmpvaropt)
//
overload print with print_tmpvar
overload prerr with prerr_tmpvar
overload fprint with fprint_tmpvar
overload fprint with fprint_tmpvaropt
//
(* ****** ****** *)

fun eq_tmpvar_tmpvar (x1: tmpvar, x2: tmpvar):<> bool
overload = with eq_tmpvar_tmpvar
fun compare_tmpvar_tmpvar (x1: tmpvar, x2: tmpvar):<> int
overload compare with compare_tmpvar_tmpvar

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
abstype d2env_type
//
typedef d2env = d2env_type
//
typedef d2envlst = List (d2env)
vtypedef d2envlst_vt = List_vt (d2env)
//
typedef d2envlstopt = Option (d2envlst)
//
(* ****** ****** *)

fun d2var2env (d2v: d2var): d2env

fun d2env_get_var (x: d2env):<> d2var
fun d2env_get_type (x: d2env):<> hisexp
fun d2env_make (d2v: d2var, hse: hisexp): d2env

fun fprint_d2env : fprint_type (d2env)
overload fprint with fprint_d2env
fun fprint_d2envlst : fprint_type (d2envlst)
overload fprint with fprint_d2envlst

fun fprint_d2envlstopt : fprint_type (d2envlstopt)
overload fprint with fprint_d2envlstopt

(* ****** ****** *)

absvtype d2envset_vtype
vtypedef d2envset_vt = d2envset_vtype

fun d2envset_vt_nil ():<> d2envset_vt
fun d2envset_vt_free (xs: d2envset_vt): void
fun d2envset_vt_ismem (xs: !d2envset_vt, x: d2env):<> bool
fun d2envset_vt_add (xs: d2envset_vt, x: d2env):<> d2envset_vt
fun d2envset_vt_listize (xs: !d2envset_vt):<> List_vt (d2env)
fun d2envset_vt_listize_free (xs: d2envset_vt):<> List_vt (d2env)

fun d2envlst2set (d2es: d2envlst): d2envset_vt

(* ****** ****** *)
//
// HX: function label
//
abstype ccomp_funlab_type
typedef funlab = ccomp_funlab_type
typedef funlablst = List (funlab)
vtypedef funlablst_vt = List_vt (funlab)
typedef funlabopt = Option (funlab)
vtypedef funlabopt_vt = Option_vt (funlab)
//
typedef funlablstopt = Option (funlablst)
//
fun print_funlab (x: funlab): void
fun prerr_funlab (x: funlab): void
overload print with print_funlab
overload prerr with prerr_funlab
//
fun fprint_funlab : fprint_type (funlab)
overload fprint with fprint_funlab
fun fprint_funlablst : fprint_type (funlablst)
overload fprint with fprint_funlablst
//
fun fprint_funlablstopt : fprint_type (funlablstopt)
overload fprint with fprint_funlablstopt
//
(* ****** ****** *)
//
fun
funlab_make
(
  name: string
, level: int
, hse0: hisexp
, fcopt: fcopt_vt
, qopt: d2cstopt
, sopt: d2varopt
, t2mas: t2mpmarglst
, stamp: stamp
) : funlab // end of [funlab_make]
//
fun funlab_make_type (hse: hisexp): funlab
//
fun funlab_make_dcst_type
  (d2c: d2cst, hse: hisexp, opt: fcopt_vt): funlab
fun funlab_make_dvar_type
  (d2v: d2var, hse: hisexp, opt: fcopt_vt): funlab
//
fun
funlab_make_tmpcst_type
(
  d2c: d2cst, t2ms: t2mpmarglst, hse: hisexp, opt: fcopt_vt
) : funlab // endfun
(*
//
// HX-2014-11-01:
// Where is this needed?
//
fun
funlab_make_tmpvar_type
(
   d2v: d2var, t2ms: t2mpmarglst, hse: hisexp, opt: fcopt_vt
) : funlab // endfun
*)
//
(* ****** ****** *)
//
fun funlab_get_name (flab: funlab): string
//
fun funlab_get_level (flab: funlab): int
//
fun funlab_get_tmpknd (flab: funlab): int
fun funlab_set_tmpknd (flab: funlab, knd: int): void
//
fun funlab_get_d2copt (flab: funlab): d2cstopt // global
fun funlab_get_d2vopt (flab: funlab): d2varopt // static
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
fun funlab_get_stamp (flab: funlab):<> stamp
//
(* ****** ****** *)

fun funlab_is_envful (flab: funlab): bool

(* ****** ****** *)
//
// HX: obtaining env+arg-list
//
fun funlab_get_type_fullarg (flab: funlab): hisexplst

(* ****** ****** *)

absvtype funlabset_vtype
vtypedef funlabset_vt = funlabset_vtype

fun funlabset_vt_nil (): funlabset_vt
fun funlabset_vt_free (fls: funlabset_vt): void
fun funlabset_vt_ismem (fls: !funlabset_vt, fl: funlab): bool
fun funlabset_vt_add (fls: funlabset_vt, fl: funlab): funlabset_vt
fun funlabset_vt_listize (fls: !funlabset_vt): funlablst_vt
fun funlabset_vt_listize_free (fls: funlabset_vt): funlablst_vt

fun funlablst2set (fls: funlablst): funlabset_vt

fun fprint_funlabset_vt (out: FILEref, fls: !funlabset_vt): void
overload fprint with fprint_funlabset_vt

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
overload fprint with fprint_funent
//
(* ****** ****** *)

fun funent_is_tmplt (feng: funent): bool

(* ****** ****** *)

fun funent_get_loc (fent: funent): loc_t
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
fun funent_get_flablst (fent: funent): funlablst
fun funent_get_flablst_fin (fent: funent): Option (funlablst)
//
fun funent_get_d2envlst (fent: funent): d2envlst
fun funent_get_d2envlst_fin (fent: funent): Option (d2envlst)
//
fun funent_get_tmpvarlst (fent: funent): tmpvarlst
//
fun funent_get_fnxlablst (fent: funent): funlablst
fun funent_set_fnxlablst
  (fent: funent, fls: funlablst): void = "patsopt_funent_set_fnxlablst"
//
(* ****** ****** *)
(*
// HX: transitive closure of called functions
*)
fun funent_eval_flablst (fent: funent): funlablst
(*
// HX: environvals occurring in called functions
*)
fun funent_eval_d2envlst (fent: funent): d2envlst
//
(* ****** ****** *)

fun funlab_get_funent (flab: funlab): funentopt
fun funlab_set_funent (flab: funlab, opt: funentopt): void

(* ****** ****** *)

fun the_funlablst_get (): funlablst
fun the_funlablst_add (flab: funlab): void
fun the_funlablst_addlst (fls: funlablst): void

(* ****** ****** *)

datatype tmpsub =
  | TMPSUBcons of (s2var, s2exp, tmpsub) | TMPSUBnil of ()
typedef tmpsubopt = Option (tmpsub)
vtypedef tmpsubopt_vt = Option_vt (tmpsub)
 
fun fprint_tmpsub : fprint_type (tmpsub)
fun fprint_tmpsubopt : fprint_type (tmpsubopt)

(* ****** ****** *)

overload fprint with fprint_tmpsub
overload fprint with fprint_tmpsubopt

(* ****** ****** *)

fun tmpsub2stasub (xs: tmpsub): stasub
fun tmpsub_append (xs1: tmpsub, xs2: tmpsub): tmpsub

(* ****** ****** *)

datatype
tmpcstmat =
  | TMPCSTMATnone of ()
  | TMPCSTMATsome of (hiimpdec, tmpsub, int(*knd*))
  | TMPCSTMATsome2 of (d2cst, s2explstlst, funlab)
// end of [tmpcstmat]

fun fprint_tmpcstmat : fprint_type (tmpcstmat)
fun fprint_tmpcstmat_kind : fprint_type (tmpcstmat) // 1/0:found/not

(* ****** ****** *)

datatype
tmpvarmat =
  | TMPVARMATnone of ()
  | TMPVARMATsome of (hifundec, tmpsub, int(*knd*))
  | TMPVARMATsome2 of (d2var, s2explstlst, funlab)
// end of [tmpvarmat]

fun fprint_tmpvarmat : fprint_type (tmpvarmat)
fun fprint_tmpvarmat_kind : fprint_type (tmpvarmat) // 1/0:found/not

(* ****** ****** *)

overload fprint with fprint_tmpcstmat
overload fprint with fprint_tmpvarmat

(* ****** ****** *)

abstype ccomp_instrlst_type
typedef instrlst = ccomp_instrlst_type

(* ****** ****** *)

datatype
primcstsp =
  | PMCSTSPmyfil of (filename)
  | PMCSTSPmyloc of (loc_t)
  | PMCSTSPmyfun of (funlab) // HX: for function name
// end of [primcstsp]

fun fprint_primcstsp : fprint_type (primcstsp)

(* ****** ****** *)

datatype
primdec_node =
//
  | PMDnone of () 
  | PMDlist of (primdeclst)
//
  | PMDsaspdec of (s2aspdec)
//
  | PMDextvar of
      (string(*name*), instrlst)
    // end of [PMDextvar]
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
  | PMDinclude of (int(*knd*), primdeclst)
//
  | PMDstaload of (hidecl) // HX: staloading
//
  | PMDstaloadloc of (filename, symbol, primdeclst)
//
  | PMDdynload of (hidecl) // HX: dynloading
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
  | PMVargenv of (int) // arguments for environvals
//
  | PMVcst of (d2cst) // for constants
  | PMVenv of (d2var) // for environvals
//
  | PMVint of (int)
  | PMVintrep of (string)
//
  | PMVbool of (bool)
  | PMVchar of (char)
  | PMVfloat of (double)
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
  | PMVselptr of (primval, hisexp(*tyroot*), primlablst)
//
  | PMVptrof of (primval)
  | PMVptrofsel of (primval, hisexp(*tyroot*), primlablst)
//
  | PMVrefarg of (int(*knd*), int(*freeknd*), primval)
//
  | PMVfunlab of (funlab)
  | PMVcfunlab of (int(*knd*), funlab)
//
  | PMVd2vfunlab of (d2var, funlab) // for fundecloc reloc
//
  | PMVlamfix of (int(*knd*), primval) // knd=0/1:lam/fix
//
  | PMVtmpltcst of (d2cst, t2mpmarglst) // for template constants
  | PMVtmpltvar of (d2var, t2mpmarglst) // for template variables
//
  | PMVtmpltcstmat of (d2cst, t2mpmarglst, tmpcstmat) // for matched template constants
  | PMVtmpltvarmat of (d2var, t2mpmarglst, tmpvarmat) // for matched template variables
//
  | PMVerror of ()
// end of [primval_node]

and primlab_node =
  | PMLlab of (label) | PMLind of (primvalist(*ind*))
// end of [primlab]

and labprimval = LABPRIMVAL of (label, primval)

(* ****** ****** *)

where
primdec = '{
  primdec_loc= loc_t
, primdec_node= primdec_node
} // end of [primdec]

and primdeclst = List (primdec)
and primdeclst_vt = List_vt (primdec)

and primval =
'{
  primval_loc= loc_t
, primval_type= hisexp
, primval_node= primval_node
} // end of [primval]

and primvalist = List (primval)
and primvalist_vt = List_vt (primval)
and primvalopt = Option (primval)

and labprimvalist = List (labprimval)
and labprimvalist_vt = List_vt (labprimval)

and primlab =
'{
  primlab_loc= loc_t
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

fun primdec_none (loc: loc_t): primdec

(* ****** ****** *)
//
fun primdec_list
  (loc: loc_t, pmds: primdeclst): primdec
//
(* ****** ****** *)

fun
primdec_saspdec
  (loc: loc_t, d2c: s2aspdec): primdec
// end of [primdec_saspdec]

(* ****** ****** *)

fun
primdec_extvar
  (loc: loc_t, name: string, inss: instrlst): primdec
// end of [primdec_extvar]

(* ****** ****** *)

fun primdec_datdecs
  (loc: loc_t, s2cs: s2cstlst): primdec
// end of [primdec_datdecs]

fun primdec_exndecs
  (loc: loc_t, d2cs: d2conlst): primdec
// end of [primdec_exndecs]

(* ****** ****** *)

fun
primdec_fundecs
(
  loc: loc_t
, knd: funkind, decarg: s2qualst, hfds: hifundeclst
) : primdec // end of [primdec_fundecs]

(* ****** ****** *)

fun
primdec_valdecs
(
  loc: loc_t, knd: valkind, hvds: hivaldeclst, inss: instrlst
) : primdec // end of [primdec_valdecs]
fun
primdec_valdecs_rec
(
  loc: loc_t, knd: valkind, hvds: hivaldeclst, inss: instrlst
) : primdec // end of [primdec_valdecs_rec]

(* ****** ****** *)

fun primdec_vardecs
  (loc: loc_t, hvds: hivardeclst, inss: instrlst): primdec
// end of [primdec_vardecs]

(* ****** ****** *)

fun primdec_impdec
  (loc: loc_t, imp: hiimpdec): primdec
// end of [primdec_impdec]

(* ****** ****** *)

fun primdec_include
  (loc: loc_t, knd: int, pmds: primdeclst): primdec

(* ****** ****** *)
//
fun primdec_staload (loc: loc_t, hid: hidecl): primdec
//
fun primdec_staloadloc
(
  loc: loc_t, pfil: filename, nspace: symbol, pmds: primdeclst
) : primdec // end of [primdec_staloadloc]
//
fun primdec_dynload (loc: loc_t, hid: hidecl): primdec
//
(* ****** ****** *)

fun primdec_local
  (loc: loc_t, _head: primdeclst, _body: primdeclst): primdec
// end of [primdec_local]

(* ****** ****** *)
//
fun print_primval (x: primval): void
fun prerr_primval (x: primval): void
//
overload print with print_primval
overload prerr with prerr_primval
//
fun fprint_primval : fprint_type (primval)
fun fprint_primvalist : fprint_type (primvalist)
//
overload fprint with fprint_primval
overload fprint with fprint_primvalist
//
(* ****** ****** *)
//
fun print_primlab (x: primlab): void
fun prerr_primlab (x: primlab): void
//
overload print with print_primlab
overload prerr with prerr_primlab
//
fun fprint_primlab : fprint_type (primlab)
fun fprint_primlablst : fprint_type (primlablst)
//
overload fprint with fprint_primlab
overload fprint with fprint_primlablst
//
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
  (loc: loc_t, hse: hisexp, tmp: tmpvar): primval
fun primval_tmpref
  (loc: loc_t, hse: hisexp, tmp: tmpvar): primval

(* ****** ****** *)

fun primval_arg
  (loc: loc_t, hse: hisexp, narg: int): primval
fun primval_argref
  (loc: loc_t, hse: hisexp, narg: int): primval
fun primval_argtmpref
  (loc: loc_t, hse: hisexp, narg: int): primval
fun primval_argenv
  (loc: loc_t, hse: hisexp, nenv: int): primval

(* ****** ****** *)

fun primval_cst
  (loc: loc_t, hse: hisexp, d2c: d2cst): primval
// end of [primval_cst]

fun primval_env
  (loc: loc_t, hse: hisexp, d2v: d2var): primval
// end of [primval_env]

(* ****** ****** *)

fun primval_int
  (loc: loc_t, hse: hisexp, i: int): primval
fun primval_intrep
  (loc: loc_t, hse: hisexp, rep: string): primval

(* ****** ****** *)

fun primval_bool
  (loc: loc_t, hse: hisexp, b: bool): primval
fun primval_char
  (loc: loc_t, hse: hisexp, c: char): primval
fun primval_float
  (loc: loc_t, hse: hisexp, f: double): primval
fun primval_string
  (loc: loc_t, hse: hisexp, str: string): primval

(* ****** ****** *)

fun primval_i0nt
  (loc: loc_t, hse: hisexp, tok: i0nt): primval
fun primval_f0loat
  (loc: loc_t, hse: hisexp, tok: f0loat): primval

(* ****** ****** *)

fun primval_sizeof
  (loc: loc_t, hse: hisexp, hselt: hisexp): primval
// end of [primval_sizeof]

(* ****** ****** *)

fun primval_cstsp
  (loc: loc_t, hse: hisexp, cstsp: primcstsp): primval
// end of [primval_cstsp]

(* ****** ****** *)

fun primval_top (loc: loc_t, hse: hisexp): primval
fun primval_empty (loc: loc_t, hse: hisexp): primval

(* ****** ****** *)

fun primval_extval
  (loc: loc_t, hse: hisexp, name: string): primval
// end of [primval_extval]

(* ****** ****** *)

fun primval_castfn
(
  loc: loc_t, hse: hisexp, d2c: d2cst, arg: primval
) : primval // end of [primval_castfn]

(* ****** ****** *)

fun primval_selcon
(
  loc: loc_t
, hse: hisexp, pmv: primval, hse_sum: hisexp, lab: label
) : primval // end of [primval_selcon]
fun primval_select
(
  loc: loc_t
, hse: hisexp, pmv: primval, hse_rt: hisexp, pml: primlab
) : primval // end of [primval_select]
fun primval_select2
(
  loc: loc_t
, hse: hisexp, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : primval // end of [primval_select2]

(* ****** ****** *)

fun primval_selptr
(
  loc: loc_t
, hse: hisexp, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : primval // end of [primval_selptr]

(* ****** ****** *)

fun primval_ptrof
  (loc: loc_t, hse: hisexp, pmv: primval): primval
// end of [primval_ptrof]

fun primval_ptrofsel (
  loc: loc_t
, hse: hisexp, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : primval // end of [primval_ptrofsel]

(* ****** ****** *)

fun primval_refarg
(
  loc: loc_t
, hse: hisexp, knd: int, freeknd: int, pmv: primval
) : primval // end of [primval_refarg]

(* ****** ****** *)
//
fun primval_funlab
  (loc: loc_t, hse: hisexp, flab: funlab): primval
fun primval_cfunlab
  (loc: loc_t, hse: hisexp, knd: int, flab: funlab): primval
//
(* ****** ****** *)

fun primval_d2vfunlab
(
  loc: loc_t, hse: hisexp, d2v: d2var, flab: funlab
) : primval // end of [primval_d2vfunlab]

(* ****** ****** *)

fun primval_lamfix (knd: int, pmv_funval: primval): primval

(* ****** ****** *)

fun primval_tmpltcst
(
  loc: loc_t, hse: hisexp, d2c: d2cst, t2mas: t2mpmarglst
) : primval // end of [primval_tmpltcst]

fun primval_tmpltcstmat
(
  loc: loc_t, hse: hisexp, d2c: d2cst, t2mas: t2mpmarglst, mat: tmpcstmat
) : primval // end of [primval_tmpltcstmat]

(* ****** ****** *)

fun primval_tmpltvar
(
  loc: loc_t, hse: hisexp, d2v: d2var, t2mas: t2mpmarglst
) : primval // end of [primval_tmpltvar]

fun primval_tmpltvarmat
(
  loc: loc_t, hse: hisexp, d2v: d2var, t2mas: t2mpmarglst, mat: tmpvarmat
) : primval // end of [primval_tmpltvarmat]

(* ****** ****** *)

fun primval_error (loc: loc_t, hse: hisexp): primval

(* ****** ****** *)

fun primval_make_sizeof (loc: loc_t, hselt: hisexp): primval

(* ****** ****** *)

fun primval_make_funlab
  (loc: loc_t, flab: funlab): primval
fun primval_make2_funlab
  (loc: loc_t, hse0: hisexp, flab: funlab): primval

(* ****** ****** *)

fun primval_make_d2vfunlab
  (loc: loc_t, d2v: d2var, flab: funlab): primval
// end of [primval_make_d2vfunlab]

(* ****** ****** *)

fun primval_make_tmp (loc: loc_t, tmp: tmpvar): primval
fun primval_make_tmpref (loc: loc_t, tmp: tmpvar): primval

(* ****** ****** *)

fun primval_make_ptrofsel
  (loc: loc_t, pmv: primval, hse_rt: hisexp, pmls: primlablst): primval
// end of [primval_make_ptrofsel]

(* ****** ****** *)

fun primlab_lab (loc: loc_t, lab: label): primlab
fun primlab_ind (loc: loc_t, ind: primvalist): primlab

(* ****** ****** *)

datatype patck =
//
  | PATCKcon of (d2con)
//
  | PATCKint of (int)
  | PATCKbool of (bool)
  | PATCKchar of (char)
  | PATCKfloat of (double)
  | PATCKstring of (string)
//
  | PATCKi0nt of (i0nt)
  | PATCKf0loat of (f0loat)
//
// end of [patck]

(* ****** ****** *)

datatype
tmprimval =
  | TPMVnone of (primval)
  | TPMVsome of (tmpvar, primval)
// end of [tmprimval]

(* ****** ****** *)

fun fprint_tmprimval
  (out: FILEref, x: tmprimval): void
overload fprint with fprint_tmprimval

(* ****** ****** *)

typedef
tmpmov = @(
  tmprimval(*src*), tmpvar(*dst*)
) (* end of [tmpmov] *)

typedef tmpmovlst = List (tmpmov)
vtypedef tmpmovlst_vt = List_vt (tmpmov)

(* ****** ****** *)

fun fprint_tmpmovlst
  (out: FILEref, xs: tmpmovlst): void
overload fprint with fprint_tmpmovlst

(* ****** ****** *)

datatype patckont =
  | PTCKNTnone of ()
  | PTCKNTtmplab of tmplab
  | PTCKNTtmplabint of (tmplab, int)
  | PTCKNTtmplabmov of (tmplab, tmpmovlst)
  | PTCKNTcaseof_fail of (loc_t) // run-time failure
  | PTCKNTfunarg_fail of (loc_t, funlab) // run-time failure
  | PTCKNTraise of (tmpvar(*ret*), primval)
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
  | INStmplab of (tmplab)
//
  | INScomment of (string)
//
  | INSmove_val of (tmpvar, primval)
//
  | INSpmove_val of (tmpvar(*ptr*), primval)
//
  | INSmove_arg_val of (int(*arg*), primval)
//
  | INSfcall of // regular funcall
      (tmpvar, primval(*fun*), hisexp, primvalist(*arg*))
  | INSfcall2 of // tail-recursive funcall // ntl: 0/1+ : fun/fnx
      (tmpvar, funlab, int(*ntl*), hisexp, primvalist(*arg*))
//
  | INSextfcall of (tmpvar, string(*fun*), primvalist(*arg*))
  | INSextmcall of (tmpvar, primval(*obj*), string(*mtd*), primvalist(*arg*))
//    
  | INScond of ( // conditinal instruction
      primval(*test*), instrlst(*then*), instrlst(*else*)
    ) // end of [INScond]
//
  | INSfreecon of (primval) // memory dealloc_t
//
  | INSloop of (
      tmplab(*init*)
    , tmplab(*fini*)
    , tmplab(*cont*)
    , instrlst(*init*)
    , primval(*test*), instrlst(*test*)
    , instrlst(*post*)
    , instrlst(*body*)
    ) // end of [INSloop]
  | INSloopexn of
      (int(*knd*), tmplab) // knd=0/1: break/continue
//
  | INScaseof of (ibranchlst) // caseof-branch-statements
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
  | INSstore_ptrofs of
      (primval(*left*), hisexp(*tyroot*), primlablst(*ofs*), primval(*right*))
  | INSxstore_ptrofs of
      (tmpvar, primval(*left*), hisexp(*tyroot*), primlablst(*ofs*), primval(*right*))
//
  | INSraise of (tmpvar(*dummy*), primval) // raising an exception
//
  | INSmove_delay of
      (tmpvar, int(*lin*), hisexp, primval(*thunk*)) // suspending evaluation
  | INSmove_lazyeval of
      (tmpvar, int(*lin*), hisexp, primval(*lazyval*)) // evaluating lazy-values
//
  | INStrywith of (tmpvar(*exn*), instrlst, ibranchlst) // for try-with expressions
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
  | INSclosure_initize of (tmpvar, funlab)
//
  | INStmpdec of (tmpvar) // HX-2013-01: this is a no-op
//
  | INSextvar of (string, primval) // HX-2013-05: extvar def
  | INSdcstdef of (d2cst, primval) // HX-2013-05: global const def
//
// end of [instr_node]

where
instr = '{
  instr_loc= loc_t, instr_node= instr_node
} // end of [instr]

and instrlst = List (instr)
and instrlst_vt = List_vt (instr)
and instrlstopt = Option (instrlst)

and ibranch = '{
  ibranch_loc= loc_t, ibranch_inslst= instrlst
} // end of [ibranch]

and ibranchlst = List (ibranch)

(* ****** ****** *)

fun print_instr (x: instr): void
fun prerr_instr (x: instr): void
overload prerr with prerr_instr
overload print with print_instr
fun fprint_instr : fprint_type (instr)
overload fprint with fprint_instr

fun fprint_instrlst : fprint_type (instrlst)
overload fprint with fprint_instrlst

(* ****** ****** *)

fun instr_funlab (loc: loc_t, flab: funlab): instr
fun instr_tmplab (loc: loc_t, tlab: tmplab): instr

(* ****** ****** *)

fun instr_comment (loc: loc_t, str: string): instr

(* ****** ****** *)

fun instr_move_val
(
  loc: loc_t, tmp: tmpvar, pmv: primval
) : instr // end of [instr_move_val]

fun instr_pmove_val
(
  loc: loc_t, tmp: tmpvar, pmv: primval
) : instr // end of [instr_pmove_val]

(* ****** ****** *)

fun instr_move_arg_val
  (loc: loc_t, arg: int, pmv: primval): instr
// end of [instr_move_arg_val]

(* ****** ****** *)

fun
instr_fcall
(
  loc: loc_t
, tmpret: tmpvar
, pmv_fun: primval, hse_fun: hisexp, pmvs_arg: primvalist
) : instr // end of [instr_fcall]

fun
instr_fcall2
(
  loc: loc_t
, tmpret: tmpvar
, fl: funlab, ntl: int, hse_fun: hisexp, pmvs_arg: primvalist
) : instr // end of [instr_fcall2]

(* ****** ****** *)
//
fun
instr_extfcall
(
  loc: loc_t
, tmpret: tmpvar, _fun: string, _arg: primvalist
) : instr // end of [instr_extfcall]
//
fun
instr_extmcall
(
  loc: loc_t
, tmpret: tmpvar, _obj: primval, _mtd: string, _arg: primvalist
) : instr // end of [instr_extmcall]
//
(* ****** ****** *)

fun instr_cond
(
  loc: loc_t
, _cond: primval, _then: instrlst, _else: instrlst
) : instr // end of [instr_cond]

(* ****** ****** *)

fun instr_freecon (loc: loc_t, pmv: primval): instr

(* ****** ****** *)

fun instr_loop
(
  loc: loc_t
, tlab_init: tmplab
, tlab_fini: tmplab
, tlab_cont: tmplab
, inss_init: instrlst
, pmv_test: primval, inss_test: instrlst
, inss_post: instrlst
, inss_body: instrlst
) : instr // end of [instr_loop]

fun instr_loopexn
(
  loc: loc_t, knd: int, tlab: tmplab
) : instr // end of [instr_loopexn]

(* ****** ****** *)

fun instr_caseof (loc: loc_t, xs: ibranchlst): instr

(* ****** ****** *)

fun instr_letpop (loc: loc_t): instr
fun instr_letpush (loc: loc_t, pmds: primdeclst): instr

(* ****** ****** *)

fun instr_move_con (
  loc: loc_t
, tmp: tmpvar, d2c: d2con, hse_sum: hisexp, lpmvs: labprimvalist
) : instr // end of [instr_move_con]

(* ****** ****** *)

fun instr_move_ref
  (loc: loc_t, tmp: tmpvar, pmv: primval): instr
// end of [instr_move_ref]

(* ****** ****** *)

fun instr_move_boxrec
(
  loc: loc_t, tmp: tmpvar, arg: labprimvalist, hse: hisexp
) : instr // end of [instr_move_boxrec]
fun instr_move_fltrec
(
  loc: loc_t, tmp: tmpvar, arg: labprimvalist, hse: hisexp
) : instr // end of [instr_move_fltrec]
fun instr_move_fltrec2
(
  loc: loc_t, tmp: tmpvar, arg: labprimvalist, hse: hisexp
) : instr // end of [instr_move_fltrec2]

(* ****** ****** *)

fun instr_patck
(
  loc: loc_t, pmv: primval, ptck: patck, ptknt: patckont
) : instr // pattern check
  
(* ****** ****** *)

fun instr_move_selcon (
  loc: loc_t
, tmp: tmpvar, hse: hisexp, pmv: primval, hse_sum: hisexp, lab: label
) : instr // end of [instr_move_selcon]
fun instr_move_select (
  loc: loc_t
, tmp: tmpvar, hse: hisexp, pmv: primval, hse_rt: hisexp, pml: primlab
) : instr // end of [instr_move_select]
fun instr_move_select2 (
  loc: loc_t
, tmp: tmpvar, hse: hisexp, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : instr // end of [instr_move_select2]

(* ****** ****** *)

fun instr_move_ptrofsel
(
  loc: loc_t, tmp: tmpvar
, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : instr // end of [instr_move_ptrofsel]

(* ****** ****** *)

(*
fun instr_load_ptrofs
(
  loc: loc_t, tmp: tmpvar
, pmv: primval, hse_rt: hisexp, pmls: primlablst
) : instr // end of [instr_load_ptrofs]
*)

(* ****** ****** *)

fun instr_store_ptrofs
(
  loc: loc_t
, pmv_l: primval, hse_rt: hisexp, pmls: primlablst
, pmv_r: primval
) : instr // end of [instr_store_ptrofs]

fun instr_xstore_ptrofs
(
  loc: loc_t, tmp: tmpvar
, pmv_l: primval, hse_rt: hisexp, pmls: primlablst
, pmv_r: primval
) : instr // end of [instr_xstore_ptrofs]

(* ****** ****** *)

fun instr_raise
(
  loc: loc_t, tmp: tmpvar, pmv_exn: primval
) : instr // end of [instr_raise]

(* ****** ****** *)

fun instr_move_delay
(
  loc: loc_t, tmp: tmpvar, lin: int, hse: hisexp, thunk: primval
) : instr // end of [instr_move_delay]

fun instr_move_lazyeval
(
  loc: loc_t, tmp: tmpvar, lin: int, hse: hisexp, pmv_lazy: primval
) : instr // end of [instr_move_lazyeval]

(* ****** ****** *)

fun instr_trywith
(
  loc: loc_t
, tmp(*exn*): tmpvar, _try: instrlst, _with: ibranchlst
) : instr // end of [instr_trywith]

(* ****** ****** *)

fun instr_move_list_nil
  (loc: loc_t, tmp: tmpvar): instr
fun instr_pmove_list_nil
  (loc: loc_t, tmp: tmpvar): instr
fun instr_pmove_list_cons
  (loc: loc_t, tmp: tmpvar, elt: hisexp): instr

(* ****** ****** *)

fun instr_move_list_phead
  (loc: loc_t, tmphd: tmpvar, tmptl: tmpvar, elt: hisexp): instr
fun instr_move_list_ptail
  (loc: loc_t, tl_new: tmpvar, tl_old: tmpvar, elt: hisexp): instr

(* ****** ****** *)

fun instr_move_arrpsz_ptr
  (loc: loc_t, tmp: tmpvar, psz: tmpvar): instr

(* ****** ****** *)

fun instr_store_arrpsz_asz
  (loc: loc_t, tmp: tmpvar, asz: int) : instr
fun instr_store_arrpsz_ptr (
  loc: loc_t, tmp: tmpvar, hse_elt: hisexp, asz: int
) : instr // end of [instr_store_arrpsz_asz]

(* ****** ****** *)

fun instr_update_ptrinc
  (loc: loc_t, tmpelt: tmpvar, hse_elt: hisexp): instr
// end of [instr_update_ptrinc]
fun instr_update_ptrdec
  (loc: loc_t, tmpelt: tmpvar, hse_elt: hisexp): instr
// end of [instr_update_ptrdec]

(* ****** ****** *)
//
fun instr_closure_initize
  (loc: loc_t, tmpret: tmpvar, flab: funlab): instr
//
(* ****** ****** *)

fun instr_tmpdec (loc: loc_t, tmp: tmpvar): instr

(* ****** ****** *)

fun instr_extvar (loc: loc_t, xnm: string, pmv: primval): instr
fun instr_dcstdef (loc: loc_t, d2c: d2cst, pmv: primval): instr

(* ****** ****** *)

fun ibranch_make (loc: loc_t, inss: instrlst): ibranch

(* ****** ****** *)

fun primlab_lab (loc: loc_t, lab: label): primlab
fun primlab_ind (loc: loc_t, ind: primvalist): primlab

(* ****** ****** *)

fun instrlst_get_tmpvarset (xs: instrlst): tmpvarset_vt
fun primdeclst_get_tmpvarset (xs: primdeclst): tmpvarset_vt

(* ****** ****** *)

absvtype instrseq_vtype
vtypedef instrseq = instrseq_vtype

(* ****** ****** *)

fun instrseq_make_nil (): instrseq
fun instrseq_get_free (res: instrseq): instrlst

(* ****** ****** *)
//
fun instrseq_add (res: !instrseq, x: instr): void
//
(* ****** ****** *)
//
fun instrseq_add_comment (res: !instrseq, comment: string): void
//
(* ****** ****** *)
//
fun instrseq_add_tmpdec
  (res: !instrseq, loc: loc_t, tmp: tmpvar): void
//
(* ****** ****** *)
//
fun
instrseq_add_extvar
(
  res: !instrseq, loc: loc_t, xnm: string, pmv: primval
) : void // end-of-fun
//
fun instrseq_add_dcstdef
  (res: !instrseq, loc: loc_t, d2c: d2cst, pmv: primval): void
//
(* ****** ****** *)
//
fun instrseq_addlst (res: !instrseq, xs: instrlst): void
fun instrseq_addlst_vt (res: !instrseq, xs: instrlst_vt): void
//
(* ****** ****** *)
//
fun instrseq_add_freeconlst
  (res: !instrseq, loc0: loc_t, pmvs: primvalist_vt): void
//
(* ****** ****** *)

fun hifundec_get_funlabopt (hfd: hifundec): Option (funlab)
fun hifundec_set_funlabopt (hfd: hifundec, opt: Option (funlab)): void

(* ****** ****** *)

fun hiimpdec_get_funlabopt (imp: hiimpdec): Option (funlab)
fun hiimpdec_set_funlabopt (imp: hiimpdec, opt: Option (funlab)): void

(* ****** ****** *)

fun hiimpdec_get_instrlstopt
  (imp: hiimpdec): Option (instrlst)
fun hiimpdec_set_instrlstopt
  (imp: hiimpdec, opt: Option (instrlst)): void

(* ****** ****** *)

typedef
vbindmap = d2varmap (primval)

(* ****** ****** *)

fun fprint_vbindmap (out: FILEref, vbmap: vbindmap): void

(* ****** ****** *)

fun funent_make
(
  loc: loc_t
, flab: funlab
, imparg: s2varlst
, tmparg: s2explstlst
, tmpsub: tmpsubopt
, tmpret: tmpvar
, fls0: funlablst, d2es: d2envlst
, vbmap: vbindmap
, inss_body: instrlst
, tmplst: tmpvarlst
) : funent // end of [funent_make]

fun funent_make2
(
  loc: loc_t
, flab: funlab
, imparg: s2varlst
, tmparg: s2explstlst
, tmpret: tmpvar
, fls0: funlablst, d2es: d2envlst
, vbmap: vbindmap
, inss_body: instrlst
) : funent // end of [funent_make2]

(* ****** ****** *)

fun funent_get_tmpsub (fent: funent): tmpsubopt
fun funent_set_tmpsub
  (fent: funent, opt: tmpsubopt): void = "patsopt_funent_set_tmpsub"
// end of [funent_set_tmpsub]

fun funent_get_vbindmap (fent: funent): vbindmap

fun funent_get_instrlst (fent: funent): instrlst

(* ****** ****** *)
//
datatype
hifundec2 =
HIFUNDEC2 of (hifundec, tmpsub)
//
fun fprint_hifundec2 (out: FILEref, hfd2: hifundec2): void
//
datatype
hiimpdec2 =
HIIMPDEC2 of (hiimpdec, tmpsub, s2explstlst)
//
fun fprint_hiimpdec2 (out: FILEref, imp2: hiimpdec2): void
//
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
//
fun ccompenv_inc_freeconenv (env: !ccompenv): void
fun ccompenv_getdec_freeconenv (env: !ccompenv): primvalist_vt
//
fun ccompenv_add_freeconenv
  (env: !ccompenv, pmv: primval): void
fun ccompenv_add_freeconenv_if
  (env: !ccompenv, pmv: primval, pck: pckind, d2c: d2con): void
//
(* ****** ****** *)

fun ccompenv_get_loopfini (env: !ccompenv): tmplab
fun ccompenv_get_loopcont (env: !ccompenv): tmplab

fun ccompenv_inc_loopexnenv
(
  env: !ccompenv, init: tmplab, fini: tmplab, cont: tmplab
) : void // end of [ccompenv_inc_loopexnenv]

fun ccompenv_dec_loopexnenv (env: !ccompenv): void

(* ****** ****** *)
//
fun ccompenv_dec_tailcalenv (env: !ccompenv): void
//
fun ccompenv_inc_tailcalenv (env: !ccompenv, fl: funlab): void
fun ccompenv_inc_tailcalenv_fnx (env: !ccompenv, fls: funlablst_vt): void
//
fun ccompenv_find_tailcalenv (env: !ccompenv, fl: funlab): int
//
fun
ccompenv_find_tailcalenv_cst
  (env: !ccompenv, d2c: d2cst): funlabopt_vt
fun
ccompenv_find_tailcalenv_var
  (env: !ccompenv, d2v: d2var, ntl: &int): funlabopt_vt
//
fun
ccompenv_find_tailcalenv_tmpcst
  (env: !ccompenv, d2c: d2cst, t2mas: t2mpmarglst): funlabopt_vt
fun
ccompenv_find_tailcalenv_tmpvar
  (env: !ccompenv, d2v: d2var, t2mas: t2mpmarglst, ntl: &int): funlabopt_vt
//
(* ****** ****** *)

(*
fun ccompenv_get_funlevel (env: !ccompenv): int (* function level *)
*)

(* ****** ****** *)
//
fun ccompenv_inc_dvarsetenv (env: !ccompenv): void
fun ccompenv_incwth_dvarsetenv (env: !ccompenv, d2es: d2envlst): void
fun ccompenv_getdec_dvarsetenv (env: !ccompenv): d2envset_vt
//
fun ccompenv_add_dvarsetenv_var (env: !ccompenv, d2v: d2var): void
fun ccompenv_add_dvarsetenv_env (env: !ccompenv, d2e: d2env): void
//
(* ****** ****** *)
//
fun ccompenv_inc_flabsetenv (env: !ccompenv): void
fun ccompenv_getdec_flabsetenv (env: !ccompenv): funlabset_vt
fun ccompenv_add_flabsetenv (env: !ccompenv, fl: funlab): void
//
(* ****** ****** *)
//
fun ccompenv_addlst_dvarsetenv_if
  (env: !ccompenv, flev0: int, d2es: d2envlst): void
fun ccompenv_addlst_flabsetenv_ifmap
  (env: !ccompenv, flev0: int, vbmap: vbindmap, fls0: funlablst_vt): funlablst_vt
//
(* ****** ****** *)
//
fun ccompenv_inc_vbindmapenv (env: !ccompenv): void
fun ccompenv_getdec_vbindmapenv (env: !ccompenv): vbindmap
//
fun ccompenv_add_vbindmapenv (env: !ccompenv, d2v: d2var, pmv: primval): void
fun ccompenv_find_vbindmapenv (env: !ccompenv, d2v: d2var): Option_vt (primval)
//
(* ****** ****** *)
//
absview
ccompenv_push_v
//
fun
ccompenv_push
  (env: !ccompenv): (ccompenv_push_v | void)
//
fun ccompenv_pop
  (pfpush: ccompenv_push_v | env: !ccompenv): void
//
fun ccompenv_localjoin
  (pf1: ccompenv_push_v, pf2: ccompenv_push_v | env: !ccompenv): void
//
(* ****** ****** *)

fun ccompenv_add_vbindmapall
  (env: !ccompenv, d2v: d2var, pmv: primval): void
// end of [ccompenv_add_vbindmapall]
  
fun ccompenv_find_vbindmapall
  (env: !ccompenv, d2v: d2var): Option_vt (primval)
// end of [ccompenv_find_vbindmapall]

(* ****** ****** *)

fun ccompenv_add_vbindmapenvall
  (env: !ccompenv, d2v: d2var, pmv: primval): void
// end of [ccompenv_add_vbindmapenvall]

(* ****** ****** *)
//
fun ccompenv_add_tmpsub (env: !ccompenv, tsub: tmpsub): void
//
(* ****** ****** *)
//
fun ccompenv_add_fundec (env: !ccompenv, hfd: hifundec): void
fun ccompenv_add_fundec2 (env: !ccompenv, hfd2: hifundec2): void
//
fun ccompenv_add_impdec (env: !ccompenv, imp: hiimpdec): void
fun ccompenv_add_impdec2 (env: !ccompenv, imp2: hiimpdec2): void
//
fun ccompenv_add_staload (env: !ccompenv, fenv: filenv): void
//
(* ****** ****** *)
//
fun
ccompenv_add_impdecloc
(
  env: !ccompenv, sub: !stasub, imp: hiimpdec
) : void // end of [ccompenv_add_impdecloc]
//
fun ccompenv_add_fundecsloc
(
  env: !ccompenv
, sub: !stasub, knd: funkind, decarg: s2qualst, hfds: hifundeclst
) : void // end of [ccompenv_add_fundecsloc]
//
fun ccompenv_add_tmpcstmat (env: !ccompenv, tmpmat: tmpcstmat): void
fun ccompenv_add_tmpvarmat (env: !ccompenv, tmpmat: tmpvarmat): void
//
(* ****** ****** *)
//
// HX-2015-01-10:
// [get] and [get2] return the same result
// however, [get2] is supposed to be more efficient
//
fun ccompenv_get_tempenver (env: !ccompenv): d2varlst_vt
fun ccompenv_get2_tempenver (env: !ccompenv): d2varlst_vt
//
fun ccompenv_add_tempenver (env: !ccompenv, d2vs: d2varlst): void
//
(* ****** ****** *)
//
fun
ccompenv_dvarsetenv_add_tempenver (env: !ccompenv, d2es: d2envset_vt): d2envset_vt
//
(* ****** ****** *)

fun hipatck_ccomp
(
  env: !ccompenv, res: !instrseq
, fail: patckont, hip: hipat, pmv: primval
) : void // end of [hipatck_ccomp]

(* ****** ****** *)

fun himatch_ccomp
(
  env: !ccompenv, res: !instrseq
, level: int, hip: hipat, pmv: primval // HX: [pmv] matches [hip]
) : void // end of [himatch_ccomp]

fun himatch2_ccomp
(
  env: !ccompenv, res: !instrseq
, level: int, hip: hipat, pmv: primval // HX: [pmv] matches [hip]
) : void // end of [himatch2_ccomp]

(* ****** ****** *)

fun hifunarg_ccomp
(
  env: !ccompenv, res: !instrseq
, flab: funlab, level: int, loc_fun: loc_t, hips: hipatlst
) : void // end of [hifunarg_ccomp]

(* ****** ****** *)

typedef
hidexp_ccomp_funtype =
  (!ccompenv, !instrseq, hidexp) -> primval
//
fun hidexp_ccomp : hidexp_ccomp_funtype
fun hidexp_ccomp_lam : hidexp_ccomp_funtype
fun hidexp_ccomp_fix : hidexp_ccomp_funtype
fun hidexp_ccomp_loop : hidexp_ccomp_funtype
fun hidexp_ccomp_loopexn : hidexp_ccomp_funtype
//
fun hidexp_ccompv : hidexp_ccomp_funtype  
//
(* ****** ****** *)

typedef
hidexp_ccomp_ret_funtype =
  (!ccompenv, !instrseq, tmpvar(*ret*), hidexp) -> void
//
fun hidexp_ccomp_ret : hidexp_ccomp_ret_funtype
//
fun hidexp_ccomp_ret_case : hidexp_ccomp_ret_funtype
//
fun hidexp_ccomp_ret_raise : hidexp_ccomp_ret_funtype
//
fun hidexp_ccomp_ret_delay : hidexp_ccomp_ret_funtype
fun hidexp_ccomp_ret_ldelay : hidexp_ccomp_ret_funtype
fun hidexp_ccomp_ret_lazyeval : hidexp_ccomp_ret_funtype
//
fun hidexp_ccomp_ret_trywith : hidexp_ccomp_ret_funtype
//
(* ****** ****** *)
//
fun hidexplst_ccomp
  (env: !ccompenv, res: !instrseq, hdes: hidexplst): primvalist
// end of [hidexplst_ccomp]
//
fun hidexplst_ccompv
  (env: !ccompenv, res: !instrseq, hdes: hidexplst): primvalist
// end of [hidexplst_ccompv]
//
(* ****** ****** *)

fun hidexp_ccomp_funlab_arg_body
(
  env: !ccompenv
, flab: funlab // HX: needed for recursion
, imparg: s2varlst
, tmparg: s2explstlst
, prolog: instrlst
, loc_fun: loc_t
, hips_arg: hipatlst
, hde_body: hidexp
) : funent // end of [hidexp_ccomp_arg_body_funlab]

(* ****** ****** *)

fun
hiclaulst_ccomp
(
  env: !ccompenv
, lvl0: int
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

fun
hiimpdec_ccomp
(
  env: !ccompenv, level: int, imp: hiimpdec, knd: int
) : void // end of [hiimpdec_ccomp]

fun
hiimpdec_ccomp_if
(
  env: !ccompenv, level: int, imp: hiimpdec, knd: int
) : void // end of [hiimpdec_ccomp_if]

(* ****** ****** *)

fun hifundeclst_ccomp
(
  env: !ccompenv, lvl0: int
, knd: funkind, decarg: s2qualst, hfds: hifundeclst
) : void // end of [hifundeclst_ccomp]

(* ****** ****** *)

fun hidecl_ccomp
  (env: !ccompenv, hid: hidecl): primdec
fun hideclist_ccomp
  (env: !ccompenv, hids: hideclist): primdeclst

fun hideclist_ccomp0 (hids: hideclist): primdeclst

(* ****** ****** *)
//
// HX-2013-04: for handling environvals
//
fun funent_varbindmap_initize (fent: funent): void
fun funent_varbindmap_initize2 (fent: funent): void
fun funent_varbindmap_uninitize (fent: funent): void
fun the_funent_varbindmap_find (d2v: d2var): Option_vt (primval)
//
(* ****** ****** *)

fun emit_text
  (out: FILEref, txt: string): void
// end of [emit_text]

fun emit_LPAREN (out: FILEref): void
fun emit_RPAREN (out: FILEref): void

fun emit_newline (out: FILEref): void

(* ****** ****** *)
//
fun
emit_location (out: FILEref, x: loc_t): void
//
(* ****** ****** *)

fun emit_int (out: FILEref, x: int): void
fun emit_intinf (out: FILEref, x: intinf): void
fun emit_bool (out: FILEref, x: bool): void
fun emit_char (out: FILEref, x: char): void
fun emit_float (out: FILEref, x: double): void
fun emit_string (out: FILEref, x: string): void

(* ****** ****** *)

fun emit_ATSPMVint (out: FILEref, x: int): void
fun emit_ATSPMVintrep (out: FILEref, x: string): void

fun emit_ATSPMVbool (out: FILEref, x: bool): void
fun emit_ATSPMVchar (out: FILEref, x: char): void
fun emit_ATSPMVfloat (out: FILEref, x: double): void
fun emit_ATSPMVstring (out: FILEref, str: string): void

fun emit_ATSPMVi0nt (out: FILEref, tok: $SYN.i0nt): void
fun emit_ATSPMVf0loat (out: FILEref, tok: $SYN.f0loat): void

(* ****** ****** *)

fun emit_stamp (out: FILEref, x: stamp): void
fun emit_symbol (out: FILEref, x: symbol): void

(* ****** ****** *)

fun emit_time_stamp (out: FILEref): void
fun emit_ats_ccomp_header (out: FILEref): void
fun emit_ats_ccomp_prelude (out: FILEref): void

(* ****** ****** *)

fun emit_ident (out: FILEref, id: string): void

fun emit_label (out: FILEref, lab: label): void
fun emit_atslabel (out: FILEref, lab: label): void
fun emit_labelext (out: FILEref, knd: int, lab: label): void

fun emit_filename (out: FILEref, fil: filename): void

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

fun emit_d2env (out: FILEref, d2e: d2env): void
fun emit_d2var_env (out: FILEref, d2v: d2var): void
fun emit_d2envlst (out: FILEref, d2es: d2envlst, i: int): int(*nenv*)

(* ****** ****** *)

fun emit_exndec (out: FILEref, hid: hidecl): void
fun emit_saspdec (out: FILEref, hid: hidecl): void

(* ****** ****** *)

fun emit_extype (out: FILEref, hid: hidecl): void
fun emit_extcode (out: FILEref, hid: hidecl): void

(* ****** ****** *)

fun emit_staload (out: FILEref, hid: hidecl): void
fun emit_dynload (out: FILEref, hid: hidecl): void

(* ****** ****** *)
//
fun emit_d2con_extdec (out: FILEref, d2c: d2con): void
fun emit_d2conlst_extdec (out: FILEref, d2cs: d2conlst): void
fun emit_d2conlst_initize (out: FILEref, d2cs: d2conlst): void
//
fun emit_d2cst_extdec (out: FILEref, d2c: d2cst): void
fun emit_d2cstlst_extdec (out: FILEref, d2cs: d2cstlst): void
//
(* ****** ****** *)

fun emit_sizeof (out: FILEref, hselt: hisexp): void

(* ****** ****** *)

fun emit_tmplab (out: FILEref, tlab: tmplab): void
fun emit_tmplabint (out: FILEref, tlab: tmplab, i: int): void

(* ****** ****** *)
//
fun emit_set_nfnx (n: int): void
//
fun emit_funarg (out: FILEref, n: int): void
fun emit_funapy (out: FILEref, n: int): void
//
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
// these are implemented in [pats_ccomp_hitype.dats]
//
abstype hitype_type
typedef hitype = hitype_type
typedef hitypelst = List (hitype)
//
fun print_hitype (hit: hitype): void
fun prerr_hitype (hit: hitype): void
fun fprint_hitype : fprint_type (hitype)
fun fprint_hitypelst : fprint_type (hitypelst)
//
overload print with print_hitype
overload prerr with prerr_hitype
overload fprint with fprint_hitype
overload fprint with fprint_hitypelst
//
(* ****** ****** *)
//
// HX: flag=0/1: flatten/regular
//
fun
hisexp_typize(flag: int, hse: hisexp): hitype
//
(* ****** ****** *)

fun emit_hitype (out: FILEref, hit: hitype): void

(* ****** ****** *)

fun emit_hisexp (out: FILEref, hse: hisexp): void
fun emit_hisexplst_sep
  (out: FILEref, hses: hisexplst, sep: string): void
// end of [emit_hisexplst_sep]

fun emit_hisexp_sel (out: FILEref, hse: hisexp): void

(* ****** ****** *)

(*
//
// HX-2016-01-01:
// It is commented out as it is no in use
//
fun emit_funtype_arg_res
  (out: FILEref, _arg: hisexplst, _res: hisexp): void
// end of [emit_funtype_arg_res]
*)

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
//
typedef
emit_instr_type = (FILEref, instr) -> void
//
fun emit_instr : emit_instr_type
//
fun emit_instr_fcall : emit_instr_type
fun emit_instr_fcall2 : emit_instr_type
//
fun emit_instr_extfcall : emit_instr_type
fun emit_instr_extmcall : emit_instr_type
//
fun emit_instr_patck : emit_instr_type
//
(* ****** ****** *)

fun emit_ibranchlst : (FILEref, ibranchlst) -> void

(* ****** ****** *)

fun emit_instrlst (out: FILEref, inss: instrlst): void
fun emit_instrlst_ln (out: FILEref, inss: instrlst): void

(* ****** ****** *)
//
fun emit_funenvlst
  (out: FILEref, d2es: d2envlst): int
fun emit_funarglst
  (out: FILEref, nenv: int, hses_arg: hisexplst): void
//
(* ****** ****** *)
//
fun emit_the_tmpdeclst (out: FILEref): void
fun emit_the_funlablst (out: FILEref): void
fun emit_the_primdeclst (out: FILEref): void
fun emit_the_typedeflst (out: FILEref): void
//
fun emit_the_dynconlst_extdec (out: FILEref): void
fun emit_the_dyncstlst_extdec (out: FILEref): void
//
fun emit_the_primdeclst_valimp (out: FILEref): void
//
(* ****** ****** *)
//
// HX: for emitting the prototype of a function entry
//
fun emit_funent_ptype (out: FILEref, fent: funent): void
//
fun emit_funent_closure (out: FILEref, fent: funent): void
//
fun emit_funent_implmnt (out: FILEref, fent: funent): void
//
(* ****** ****** *)

fun emit_primdeclst (out: FILEref, pmds: primdeclst): void

(* ****** ****** *)
//
fun
funlab_tmparg_match
  (fl0: funlab, t2mas: t2mpmarglst) : bool
(*
fun funlab_tmpcst_match
  (fl: funlab, d2c: d2cst, t2mas: t2mpmarglst): bool
// end of [funlab_tmpcst_match]
*)
(*
fun funlab_tmpvar_match
  (fl: funlab, d2v: d2var, t2mas: t2mpmarglst): bool
// end of [funlab_tmpvar_match]
*)
//
(* ****** ****** *)
//
fun
hiimpdec_tmpcst_match
(
  imp: hiimpdec, d2c: d2cst, t2mas: t2mpmarglst, knd: int
) : tmpcstmat // end of [hiimpdec_tmpcst_match]
//
fun
hiimpdec2_tmpcst_match
(
  imp2: hiimpdec2, d2c: d2cst, t2mas: t2mpmarglst, knd: int
) : tmpcstmat // end of [hiimpdec2_tmpcst_match]
//
fun
hiimpdeclst_tmpcst_match
(
  imps: hiimpdeclst, d2c: d2cst, t2mas: t2mpmarglst, knd: int
) : tmpcstmat // end of [hiimpdeclst_tmpcst_match]
//
(* ****** ****** *)
//
fun hifundec2tmpvarmat
  (hfd: hifundec, t2mas: t2mpmarglst): tmpvarmat
fun hifundecopt2tmpvarmat
  (opt: Option_vt (hifundec), t2mas: t2mpmarglst): tmpvarmat
//
fun hifundec_tmpvar_match
  (hfd: hifundec, d2v: d2var, t2mas: t2mpmarglst): tmpvarmat
// end of [hifundec_tmpvar_match]
fun hifundec2_tmpvar_match
  (hfd2: hifundec2, d2v: d2var, t2mas: t2mpmarglst): tmpvarmat
// end of [hifundec2_tmpvar_match]

(* ****** ****** *)

fun
ccomp_tmpcstmat
(
  env: !ccompenv
, loc0: loc_t, hse0: hisexp
, d2c: d2cst, t2ms: t2mpmarglst, tmpmat: tmpcstmat
) : primval // end-of-function

fun
tmpcstmat_tmpcst_match
  (mat: tmpcstmat, d2c: d2cst, t2mas: t2mpmarglst): tmpcstmat
// end of [tmpcstmat_tmpcst_match]

fun
ccompenv_tmpcst_match
  (env: !ccompenv, d2c: d2cst, t2mas: t2mpmarglst): tmpcstmat
// end of [ccompenv_tmpcst_match]

(* ****** ****** *)

fun
ccomp_tmpvarmat
(
  env: !ccompenv
, loc0: loc_t, hse0: hisexp
, d2v: d2var, t2ms: t2mpmarglst, tmpmat: tmpvarmat
) : primval // end-of-function

fun
tmpvarmat_tmpvar_match
  (mat: tmpvarmat, d2v: d2var, t2mas: t2mpmarglst): tmpvarmat
// end of [tmpvarmat_tmpvar_match]

fun
ccompenv_tmpvar_match
  (env: !ccompenv, d2v: d2var, t2mas: t2mpmarglst): tmpvarmat
// end of [ccompenv_tmpvar_match]

(* ****** ****** *)

fun
t2mpmarglst_subst
  (loc0: loc_t, sub: !stasub, t2mas: t2mpmarglst): t2mpmarglst
// end of [t2mpmarglst_subst]

fun
t2mpmarglst_tsubst
  (loc0: loc_t, tsub: tmpsub, t2mas: t2mpmarglst): t2mpmarglst
// end of [t2mpmarglst_tsubst]

(* ****** ****** *)
//
fun d2envlst_subst
  (sub: !stasub, d2vs: d2envlst): d2envlst_vt
//
(* ****** ****** *)
//
fun funlab_subst
  (sub: !stasub, flab: funlab): funlab
//
fun funent_subst
(
  env: !ccompenv
, sub: !stasub, flab2: funlab, fent: funent, sfx: int
) : funent // end of [funent_subst]

(* ****** ****** *)

fun the_toplevel_getref_tmpvarlst (): Ptr1
fun the_toplevel_getref_primdeclst (): Ptr1

(* ****** ****** *)

fun ccomp_main
(
  out: FILEref, flag: int, infil: filename, hids: hideclist
) : void // end of [ccomp_main]

(* ****** ****** *)

(* end of [pats_ccomp.sats] *)
