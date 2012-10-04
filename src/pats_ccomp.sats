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
// end of [tmpvar_make]

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

datatype
primdec_node =
  | PMDnone of () 
  | PMDimpdec of ()
  | PMDfundecs of ()
  | PMDvaldecs of ()
  | PMDvardecs of (d2varlst)
  | PMDlocal of (primdeclst, primdeclst)

where
primdec = '{
  primdec_loc= location, primdec_node= primdec_node
} // end of [primdec]

and primdeclst = List (primdec)
and primdeclst_vt = List_vt (primdec)

(* ****** ****** *)

fun fprint_primdec : fprint_type (primdec)
fun fprint_primdeclst : fprint_type (primdeclst)

(* ****** ****** *)

fun primdec_vardecs (loc: location, d2vs: d2varlst): primdec

(* ****** ****** *)

datatype
primval_node =
  | PMVtmp of (tmpvar)
  | PMVtmpref of (tmpvar)
//
  | PMVint of (int)
  | PMVbool of (bool)
  | PMVchar of (char)
  | PMVstring of (string)
//
  | PMVempty of ()
//
  | PMVarg of (int)
  | PMVargref of (int) // call-by-reference
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

(* ****** ****** *)

fun fprint_primval : fprint_type (primval)
fun fprint_primvalist : fprint_type (primvalist)

(* ****** ****** *)

fun fprint_primlab : fprint_type (primlab)

(* ****** ****** *)

fun primval_int
  (loc: location, hse: hisexp, i: int): primval
fun primval_bool
  (loc: location, hse: hisexp, b: bool): primval
fun primval_char
  (loc: location, hse: hisexp, c: char): primval
fun primval_string
  (loc: location, hse: hisexp, str: string): primval

fun primval_empty (loc: location, hse: hisexp): primval

(* ****** ****** *)

datatype
instr_node =
//
  | INSmove_val of (tmpvar, primval)
  | INSmove_arg_val of (int(*arg*), primval)
  | INSTRmove_con of
      (tmpvar, hisexp, d2con, primvalist(*arg*))
  | INSTRmove_ref of (tmpvar, primval)
//
  | INScall of
      (tmpvar, hisexp, primval(*fun*), primvalist(*arg*))
    // end of [INScall]
//    
  | INScond of ( // conditinal instruction
      primval(*test*), instrlst(*then*), instrlst(*else*)
    ) // end of [INScond]
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

fun instr_move_val (
  loc: location, tmp: tmpvar, pmv: primval
) : instr // end of [instr_move_val]

fun instr_move_arg_val
  (loc: location, arg: int, pmv: primval): instr
// end of [instr_move_arg_val]

(* ****** ****** *)

absviewtype instrseq_vtype
viewtypedef instrseq = instrseq_vtype

fun instrseq_make (): instrseq
fun instrseq_add (xs: !instrseq, x: instr): void
fun instrseq_getfree (xs: instrseq): instrlst_vt

(* ****** ****** *)

absviewtype ccompenv_vtype
viewtypedef ccompenv = ccompenv_vtype

fun ccompenv_make (): ccompenv
fun ccompenv_free (env: ccompenv): void

(* ****** ****** *)

fun hidexp_ccomp
  (env: !ccompenv, res: !instrseq, hde: hidexp): primval
fun hidexplst_ccomp
  (env: !ccompenv, res: !instrseq, hdes: hidexplst): primvalist

fun hidexp_ccomp_ret
  (env: !ccompenv, res: !instrseq, hde: hidexp, tmpret: tmpvar): void
// end of [hidexp_ccomp_ret]

(* ****** ****** *)

fun hidecl_ccomp
  (env: !ccompenv, res: !instrseq, hdc: hidecl): primdec
fun hideclist_ccomp
  (env: !ccompenv, res: !instrseq, hdcs: hideclist): primdeclst

fun hideclist_ccomp0 (hdcs: hideclist): primdeclst

(* ****** ****** *)

fun ccomp_main (
  out: FILEref, flag: int, infil: filename, hdcs: hideclist
) : void // end of [ccomp_main]

(* ****** ****** *)

(* end of [pats_ccomp.sats] *)
