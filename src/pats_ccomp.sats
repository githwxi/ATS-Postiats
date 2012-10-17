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

staload "pats_basics.sats"

(* ****** ****** *)

staload
STMP = "pats_stamp.sats"
typedef stamp = $STMP.stamp

(* ****** ****** *)

staload LAB = "pats_label.sats"
typedef label = $LAB.label

(* ****** ****** *)
//
staload FIL = "pats_filename.sats"
typedef filename = $FIL.filename
//
staload LOC = "pats_location.sats"
typedef location = $LOC.location
//
(* ****** ****** *)

staload
SYN = "pats_syntax.sats"
typedef i0nt = $SYN.i0nt
typedef f0loat = $SYN.f0loat

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

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
typedef tmpvarlst = List (tmpvar)
typedef tmpvaropt = Option (tmpvar)

fun tmpvar_make
  (loc: location, hse: hisexp): tmpvar
fun tmpvar_make_ret
  (loc: location, hse: hisexp): tmpvar

fun tmpvar_get_stamp (tmp: tmpvar): stamp

(* ****** ****** *)

fun fprint_tmpvar : fprint_type (tmpvar)
fun print_tmpvar (x: tmpvar): void
overload print with print_tmpvar
fun prerr_tmpvar (x: tmpvar): void
overload prerr with prerr_tmpvar

fun eq_tmpvar_tmpvar (x1: tmpvar, x2: tmpvar): bool
overload = with eq_tmpvar_tmpvar

fun compare_tmpvar_tmpvar (x1: tmpvar, x2: tmpvar): int
overload = with compare_tmpvar_tmpvar

(* ****** ****** *)
//
// HX: function label
//
abstype ccomp_funlab_type
typedef funlab = ccomp_funlab_type
//
fun print_funlab (x: funlab): void
overload print with print_funlab
fun prerr_funlab (x: funlab): void
overload prerr with prerr_funlab
fun fprint_funlab : fprint_type (funlab)
//
fun funlab_make_type (hse: hisexp): funlab
fun funlab_make_dvar_type (d2v: d2var, hse: hisexp): funlab
fun funlab_make_dcst_type (d2c: d2cst, hse: hisexp): funlab
//
fun funlab_get_name (fl: funlab): string
fun funlab_get_level (fl: funlab): int
fun funlab_get_type (fl: funlab): hisexp
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

fun funlab_get_entry (fl: funlab): funentopt
fun funlab_set_entry (fl: funlab, opt: funentopt): void

(* ****** ****** *)

datatype
primdec_node =
  | PMDnone of () 
  | PMDdcstdecs of (dcstkind, d2cstlst)
  | PMDimpdec of (
      d2cst, s2varlst(*imparg*), s2explstlst(*tmparg*)
    ) // end of [PMDimpdec]
  | PMDfundecs of (d2varlst)
  | PMDvaldecs of (valkind, hipatlst)
  | PMDvaldecs_rec of (valkind, hipatlst)
  | PMDvardecs of (d2varlst)
  | PMDlocal of (primdeclst, primdeclst)
// end of [primdec_node]

where
primdec = '{
  primdec_loc= location, primdec_node= primdec_node
} // end of [primdec]

and primdeclst = List (primdec)
and primdeclst_vt = List_vt (primdec)

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

fun primdec_dcstdecs
  (loc: location, knd: dcstkind, d2cs: d2cstlst): primdec
// end of [primdec_dcstdecs]

(* ****** ****** *)
//
fun primdec_impdec (
  loc: location, d2c: d2cst, imparg: s2varlst, tmparg: s2explstlst
) : primdec // end of [primdec_impdec]
//
fun primdec_fundecs (loc: location, d2vs: d2varlst): primdec
//
fun primdec_valdecs
  (loc: location, knd: valkind, hips: hipatlst): primdec
fun primdec_valdecs_rec
  (loc: location, knd: valkind, hips: hipatlst): primdec
//
fun primdec_vardecs (loc: location, d2vs: d2varlst): primdec
//
(* ****** ****** *)

datatype
primval_node =
  | PMVtmp of (tmpvar)
  | PMVtmpref of (tmpvar)
//
  | PMVarg of (int)
  | PMVargref of (int) // call-by-reference
  | PMVargtmpref of (int) // call-by-reference but treated as tmpvar
//
  | PMVcst of (d2cst)
  | PMVvar of (d2var) // temporary
//
  | PMVtmpcst of (d2cst, t2mpmarglst)
  | PMVtmpvar of (d2var, t2mpmarglst)
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
  | PMVfun of (funlab)
//
  | PMVcastfn of (d2cst, primval)
//
  | PMVerr of ()
// end of [primval_node]

and primlab_node =
  | PMLlab of (label) | PMLind of (primvalist(*ind*))
// end of [primlab]

where
primval = '{
  primval_loc= location
, primval_type= hisexp
, primval_node= primval_node
} // end of [primval]

and primvalist = List (primval)
and primvalist_vt = List_vt (primval)

and primlab = '{
  primlab_loc= location
, primlab_node= primlab_node
}

and primlablst = List (primlab)

(* ****** ****** *)

fun fprint_primval : fprint_type (primval)
fun fprint_primvalist : fprint_type (primvalist)

(* ****** ****** *)

fun fprint_primlab : fprint_type (primlab)
fun fprint_primlablst : fprint_type (primlablst)

(* ****** ****** *)

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

fun primval_i0nt
  (loc: location, hse: hisexp, tok: i0nt): primval
fun primval_f0loat
  (loc: location, hse: hisexp, tok: f0loat): primval

fun primval_empty (loc: location, hse: hisexp): primval

fun primval_extval
  (loc: location, hse: hisexp, name: string): primval
// end of [primval_extval]

fun primval_fun
  (loc: location, hse: hisexp, fl: funlab): primval
// end of [primval_fun]

fun primval_tmpcst (
  loc: location, hse: hisexp, d2c: d2cst, t2mas: t2mpmarglst
) : primval // end of [primval_tmpcst]
fun primval_tmpvar (
  loc: location, hse: hisexp, d2v: d2var, t2mas: t2mpmarglst
) : primval // end of [primval_tmpvar]

(* ****** ****** *)

fun primval_make_funlab (loc: location, fl: funlab): primval

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

fun fprint_patck : fprint_type (patck)

(* ****** ****** *)

datatype
patckont =
  | PTCKNTnone of ()
  | PTCKNTtmplab of tmplab
  | PTCKNTtmplabint of (tmplab, int)
  | PTCKNTcaseof_fail of (location) // run-time failure
  | PTCKNTfunarg_fail of (location, funlab) // run-time failure
  | PTCKNTraise of primval
// end of [patckont]

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
  | INSmove_ref of (tmpvar, primval)
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

absviewtype ccompenv_vtype
viewtypedef ccompenv = ccompenv_vtype

fun ccompenv_make (): ccompenv
fun ccompenv_free (env: ccompenv): void

(* ****** ****** *)

fun fprint_ccompenv (out: FILEref, env: !ccompenv): void

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
, fl: funlab
, imparg: s2varlst
, tmparg: s2explstlst
, prolog: instrlst
, loc_fun: location
, hips_arg: hipatlst
, hde_body: hidexp
) : funent // end of [ccomp_exp_arg_body_funlab]

(* ****** ****** *)

fun hidecl_ccomp
  (env: !ccompenv, res: !instrseq, hdc: hidecl): primdec
fun hideclist_ccomp
  (env: !ccompenv, res: !instrseq, hdcs: hideclist): primdeclst

fun hideclist_ccomp0
  (hdcs: hideclist): (instrlst, primdeclst)
// end of [hideclist_ccomp0]

(* ****** ****** *)

fun ccomp_main (
  out: FILEref, flag: int, infil: filename, hdcs: hideclist
) : void // end of [ccomp_main]

(* ****** ****** *)

(* end of [pats_ccomp.sats] *)
