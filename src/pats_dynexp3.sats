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
// Start Time: October, 2011
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload LOC = "pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload
INT = "pats_intinf.sats"
typedef intinf = $INT.intinf

(* ****** ****** *)

staload "pats_staexp2.sats"
typedef s2exp = s2exp
staload "pats_staexp2_util.sats"
typedef s2hnf = s2hnf
staload "pats_dynexp2.sats"
typedef d2cst = d2cst_type // abstract
typedef d2var = d2var_type // abstract

(* ****** ****** *)

datatype p3at_node =
  | P3Tany of () // wildcard
  | P3Tvar of (int(*refknd*), d2var)
  | P3Tempty (* empty pattern *)
//
  | P3Tann of (p3at, s2hnf) // ascribed pattern
// end of [p3at_node]

where p3at = '{
  p3at_loc= location
, p3at_node= p3at_node
, p3at_type= s2hnf
} // end of [p3at]

and p3atlst = List (p3at)
and p3atopt = Option p3at

(* ****** ****** *)

fun p3at_var (
  loc: location, s2f: s2hnf, knd: int, d2v: d2var
) : p3at // end of [p3at_var]

fun p3at_ann (
  loc: location, s2f: s2hnf, p3t: p3at, ann: s2hnf
) : p3at // end of [p3at_ann]

(* ****** ****** *)

datatype
d3ecl_node =
  | D3Cnone
  | D3Clist of d3eclist
  | D3Cdatdec of (int(*knd*), s2cstlst)
  | D3Cvaldecs of v3aldeclst
  | D3Cfundecs of (funkind, s2qualst(*decarg*), f3undeclst)
// end of [d3ecl_node]

and
d3exp_node =
//
  | D3Evar of d2var
  | D3Ebool of bool
  | D3Echar of char
  | D3Eint of (* dynamic integer *)
      (string, intinf)
  | D3Eintsp of (* dynamic specified integer *)
      (string, intinf)
  | D3Efloat of string(*rep*)
  | D3Estring of string(*val*)
  | D3Eempty of () // the void-value of void-type
  | D3Eextval of (string(*rep*))
  | D3Ecst of d2cst
  | D3Econ of (d2con, int(*npf*), d3explst(*arg*))
//
  | D3Elam_dyn of // dynamic abstraction
      (int(*lin*), int(*npf*), p3atlst, d3exp)
  | D3Elaminit_dyn of // dynamic flat funtion closure
      (int(*lin*), int(*npf*), p3atlst, d3exp)
//
  | D3Eerr of () // indication of error
// end of [d3exp_node]

where
d3ecl = '{
  d3ecl_loc= location
, d3ecl_node= d3ecl_node
}

and d3eclist = List (d3ecl)

and d3exp = '{
  d3exp_loc= location
, d3exp_type= s2hnf
, d3exp_node= d3exp_node
} // end of [d3exp]

and d3explst = List (d3exp)
and d3expopt = Option (d3exp)
and d3explstlst = List (d3explst)

(* ****** ****** *)

and v3aldec = '{
  v3aldec_loc= location
, v3aldec_pat= p3at
, v3aldec_def= d3exp
} // end of [v3aldec]

and v3aldeclst = List (v3aldec)

(* ****** ****** *)

and f3undec = '{
  f3undec_loc= location
, f3undec_var= d2var
, f3undec_def= d3exp
} // end of [f3undec]

and f3undeclst = List f3undec

(* ****** ****** *)

and v3ardec = '{
  v3ardec_loc= location
, v3ardec_knd= int
, v3ardec_dvar_ptr= d2var
, v3ardec_dvar_view= d2var
, v3ardec_typ= s2exp
, v3ardec_ini= d3expopt
} // end of [v3ardec]

and v3ardeclst = List v3ardec

(* ****** ****** *)

fun d3exp_var
  (loc: location, s2f: s2hnf, d2v: d2var): d3exp
// end of [d3exp_var]

(* ****** ****** *)

fun d3exp_int (
  loc: location, s2f: s2hnf, rep: string, inf: intinf
) : d3exp // end of [d3exp_int]

fun d3exp_bool
  (loc: location, s2f: s2hnf, b: bool): d3exp
// end of [d3exp_bool]

fun d3exp_char
  (loc: location, s2f: s2hnf, c: char): d3exp
// end of [d3exp_char]

fun d3exp_string
  (loc: location, s2f: s2hnf, str: string): d3exp
// end of [d3exp_string]

fun d3exp_float
  (loc: location, s2f: s2hnf, rep: string): d3exp
// end of [d3exp_float]

(* ****** ****** *)

fun d3exp_empty
  (loc: location, s2f: s2hnf): d3exp

fun d3exp_extval
  (loc: location, s2f: s2hnf, rep: string): d3exp
// end of [d3exp_extval]

(* ****** ****** *)

fun d3exp_cst
  (loc: location, s2f: s2hnf, d2c: d2cst): d3exp
// end of [d3exp_cst]

fun d3exp_con (
  loc: location, res: s2hnf, d2c: d2con, npf: int, d3es: d3explst
) : d3exp // end of [d3exp_con]

(* ****** ****** *)

fun d3exp_lam_dyn (
  loc: location, typ: s2hnf
, lin: int, npf: int, arg: p3atlst, body: d3exp
) : d3exp // end of [d3exp_lam_dyn]
fun d3exp_laminit_dyn (
  loc: location, typ: s2hnf
, lin: int, npf: int, arg: p3atlst, body: d3exp
) : d3exp // end of [d3exp_laminit_dyn]

(* ****** ****** *)

fun d3exp_err (loc: location): d3exp

(* ****** ****** *)

fun f3undec_make (
  loc: location, d2v: d2var, def: d3exp
) : f3undec // end of [f3undec_make]

(* ****** ****** *)

fun d3ecl_none (loc: location): d3ecl
fun d3ecl_list (loc: location, xs: d3eclist): d3ecl

(* ****** ****** *)

fun d3ecl_datdec
  (loc: location, knd: int, s2cs: s2cstlst): d3ecl
// end of [d3ecl_datdec]

(* ****** ****** *)

fun d3ecl_valdecs (
  loc: location, knd: valkind, d3cs: v3aldeclst
) : d3ecl // end of [d3ecl_valdecs]

fun d3ecl_fundecs (
  loc: location, knd: funkind, decarg: s2qualst, d3cs: f3undeclst
) : d3ecl // end of [d3ecl_fundecs]

fun d3ec_vardecs (loc: location, ds: v3ardeclst): d3ecl

(* ****** ****** *)

(* end of [pats_dynexp3.sats] *)
