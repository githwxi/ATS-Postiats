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
staload "pats_staexp2_util.sats"
staload "pats_dynexp2.sats"
typedef d2cst = d2cst_type // abstract
typedef d2var = d2var_type // abstract

(* ****** ****** *)

datatype p3at_node =
//
  | P3Tany of d2var // wildcard
  | P3Tvar of (int(*refknd*), d2var)
//
  | P3Tcon of (int(*freeknd*), d2con, int(*npf*), p3atlst(*arg*))
//
  | P3Tint of (int)
  | P3Tintrep of string(*rep*)
  | P3Tbool of (bool)
  | P3Tchar of (char)
  | P3Tstring of (string)  
//
  | P3Ti0nt of i0nt
  | P3Tf0loat of f0loat
//
  | P3Tempty (* empty pattern *)
//
  | P3Trec of (int(*knd*), int(*npf*), labp3atlst)
  | P3Tlst of (int(*lin*), p3atlst) // pattern list
//
  | P3Texist of (s2varlst, p3at) // existential opening
//
  | P3Tann of (p3at, s2exp) // ascribed pattern
//
  | P3Terr of () // indication of error
// end of [p3at_node]

and labp3at = LABP3AT of (label, p3at)

where p3at = '{
  p3at_loc= location
, p3at_node= p3at_node
, p3at_type= s2exp // HX: it may still be a s2Var
} // end of [p3at]

and p3atlst = List (p3at)
and p3atopt = Option p3at

and labp3atlst = List (labp3at)

(* ****** ****** *)

fun p3at_any (
  loc: location, s2e: s2exp, d2v: d2var
) : p3at // end of [p3at_any]

fun p3at_var (
  loc: location, s2e: s2exp, knd: int, d2v: d2var
) : p3at // end of [p3at_var]

fun p3at_con (
  loc: location
, s2e: s2exp, freeknd: int, d2c: d2con, npf: int, arg: p3atlst
) : p3at // end of [p3at_con]

fun p3at_int (
  loc: location, s2f: s2exp, i: int
) : p3at // end of [p3at_int]
fun p3at_intrep (
  loc: location, s2f: s2exp, rep: string
) : p3at // end of [p3at_intrep]
fun p3at_bool (
  loc: location, s2f: s2exp, b: bool
) : p3at // end of [p3at_bool]
fun p3at_char (
  loc: location, s2f: s2exp, c: char
) : p3at // end of [p3at_char]
fun p3at_string (
  loc: location, s2f: s2exp, str: string
) : p3at // end of [p3at_string]
//
fun p3at_i0nt (
  loc: location, s2f: s2exp, x: i0nt
) : p3at // end of [p3at_i0nt]
fun p3at_f0loat (
  loc: location, s2f: s2exp, x: f0loat
) : p3at // end of [p3at_f0loat]
//
fun p3at_empty (loc: location, s2f: s2exp): p3at

fun p3at_rec (
  loc: location
, s2f: s2exp, knd: int, npf: int, lp3ts: labp3atlst
) : p3at // end of [p3at_rec]
fun p3at_lst (
  loc: location, s2f: s2exp, lin: int, p3ts: p3atlst
) : p3at // end of [p3at_lst]

fun p3at_exist (
  loc: location, s2f: s2exp, s2vs: s2varlst, p3t: p3at
) : p3at // end of [p3at_exist]

fun p3at_ann (
  loc: location, s2f: s2exp, p3t: p3at, ann: s2exp
) : p3at // end of [p3at_ann]

fun p3at_err (loc: location, s2f: s2exp): p3at

(* ****** ****** *)

datatype
d3ecl_node =
  | D3Cnone
  | D3Clist of d3eclist
  | D3Cdatdec of (int(*knd*), s2cstlst)
  | D3Cdcstdec of (dcstkind, d2cstlst)
  | D3Cfundecs of (funkind, s2qualst(*decarg*), f3undeclst)
  | D3Cvaldecs of (valkind, v3aldeclst)
  | D3Cvaldecs_rec of (valkind, v3aldeclst)
// end of [d3ecl_node]

and d3exp_node =
//
  | D3Evar of d2var
  | D3Ecst of d2cst
//
  | D3Eint of (int)
  | D3Eintrep of (string(*rep*))
  | D3Ebool of bool
  | D3Echar of char
  | D3Estring of string(*val*)
  | D3Efloat of string(*rep*)
//
  | D3Ei0nt of i0nt
  | D3Ef0loat of f0loat
//
  | D3Ecstsp of ($SYN.cstsp)
//
  | D3Etop of () // unspecified value
  | D3Eempty of () // the void-value of void-type
//
  | D3Eextval of (string(*rep*))
  | D3Econ of (d2con, int(*npf*), d3explst(*arg*))
//
  | D3Etmpcst of (d2cst, t2mpmarglst)
  | D3Etmpvar of (d2var, t2mpmarglst)
//
  | D3Eitem of d2itm // HX: for temporary use
//
  | D3Elet of (d3eclist, d3exp)
//
  | D3Eapp_sta of d3exp // static application
  | D3Eapp_dyn of (d3exp, int(*npf*), d3explst)
//
  | D3Eif of (
      d3exp(*cond*), d3exp(*then*), d3expopt(*else*)
    ) // end of [D3Eif]
  | D3Ecase of (
      caskind, d3explst(*values*), c3laulst(*clauses*)
    ) // end of [D3Ecase]
//
  | D3Elst of (* list expression *)
      (int(*lin*), s2exp(*elt*), d3explst)
  | D3Etup of (* tuple expression *)
      (int(*tupknd*), int(*npf*), d3explst)
  | D3Erec of (* record expression *)
      (int(*recknd*), int(*npf*), labd3explst)
  | D3Eseq of d3explst // sequencing
//
  | D3Earrinit of // For instance, @[int](1,2,3)
      (s2exp(*elt*), d3exp(*asz*), d3explst(*elt*))
  | D3Earrsize of (d3explst, int(*size*))
//
  | D3Elam_dyn of // dynamic abstraction
      (int(*lin*), int(*npf*), p3atlst, d3exp)
  | D3Elaminit_dyn of // dynamic flat funtion closure
      (int(*lin*), int(*npf*), p3atlst, d3exp)
  | D3Elam_sta of // static abstraction
      (s2varlst(*s2vs*), s2explst(*s2ps*), d3exp)
//
  | D3Eloopexn of (int(*knd*))
//
  | D3Eann_type of (d3exp, s2exp)
//
  | D3Eerr of () // indication of error
// end of [d3exp_node]

where
d3ecl = '{
  d3ecl_loc= location
, d3ecl_node= d3ecl_node
} // end of [d3ecl]

and d3eclist = List (d3ecl)

and d3exp = '{
  d3exp_loc= location
, d3exp_type= s2exp // HX: it may still be s2Var
, d3exp_node= d3exp_node
} // end of [d3exp]

and d3explst = List (d3exp)
and d3expopt = Option (d3exp)
and d3explstlst = List (d3explst)

and labd3exp = dl0abeled (d3exp)
and labd3explst = List (labd3exp)

(* ****** ****** *)

and m3atch = '{
  m3atch_loc= location
, m3atch_exp= d3exp
, m3atch_pat= p3atopt
} // end of [m3atch]

and m3atchlst = List m3atch

and c3lau (n:int) = '{
  c3lau_loc= location
, c3lau_pat= list (p3at, n)
, c3lau_gua= m3atchlst // clause guard
, c3lau_seq= int // sequentiality
, c3lau_neg= int // negativativity
, c3lau_body= d3exp // expression body
} // end of [c3lau]

and c3lau = [n:nat] c3lau (n)

and c3laulst
  (n:int) = List (c3lau (n))
and c3laulst = [n:nat] c3laulst (n)

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
, v3ardec_type= s2exp
, v3ardec_ini= d3expopt
} // end of [v3ardec]

and v3ardeclst = List v3ardec

(* ****** ****** *)

fun d3exp_get_type (d3e: d3exp): s2exp 
fun d3exp_set_type
  (d3e: d3exp, s2f: s2exp): void = "patsopt_d3exp_set_type"
// end of [d3exp_set_type]

(* ****** ****** *)

fun d3exp_var
  (loc: location, s2f: s2exp, d2v: d2var): d3exp
// end of [d3exp_var]

(* ****** ****** *)

fun d3exp_int
  (loc: location, s2f: s2exp, i: int) : d3exp
// end of [d3exp_int]
fun d3exp_intrep
  (loc: location, s2f: s2exp, rep: string) : d3exp
// end of [d3exp_intrep]

fun d3exp_bool
  (loc: location, s2f: s2exp, b: bool): d3exp
// end of [d3exp_bool]

fun d3exp_char
  (loc: location, s2f: s2exp, c: char): d3exp
// end of [d3exp_char]

fun d3exp_string
  (loc: location, s2f: s2exp, str: string): d3exp
// end of [d3exp_string]

(* ****** ****** *)

fun d3exp_i0nt (
  loc: location, s2f: s2exp, x: i0nt
) : d3exp // end of [d3exp_i0nt]

fun d3exp_f0loat
  (loc: location, s2f: s2exp, x: f0loat): d3exp
// end of [d3exp_float]

(* ****** ****** *)

fun d3exp_cstsp
  (loc: location, s2f: s2exp, x: $SYN.cstsp): d3exp
// end of [d3exp_cstsp]

(* ****** ****** *)

fun d3exp_empty
  (loc: location, s2f: s2exp): d3exp

fun d3exp_extval
  (loc: location, s2f: s2exp, rep: string): d3exp
// end of [d3exp_extval]

(* ****** ****** *)

fun d3exp_cst
  (loc: location, s2f: s2exp, d2c: d2cst): d3exp
// end of [d3exp_cst]

fun d3exp_con (
  loc: location
, s2f_res: s2exp, d2c: d2con, npf: int, d3es: d3explst
) : d3exp // end of [d3exp_con]

(* ****** ****** *)

fun d3exp_tmpcst (
  loc: location, s2f: s2exp, d2c: d2cst, t2mas: t2mpmarglst
) : d3exp // end of [d3exp_tmpcst]
fun d3exp_tmpvar (
  loc: location, s2f: s2exp, d2v: d2var, t2mas: t2mpmarglst
) : d3exp // end of [d3exp_tmpvar]

(* ****** ****** *)

fun d3exp_item
  (loc: location, s2f: s2exp, d2i: d2itm): d3exp
// end of [d3exp_item]

(* ****** ****** *)

fun d3exp_let
  (loc: location, d3cs: d3eclist, d3e: d3exp): d3exp
// end of [d3exp_let]
 
(* ****** ****** *)

fun d3exp_app_sta
  (loc: location, s2f: s2exp, d3e: d3exp): d3exp
// end of [d3exp_app_sta]

fun d3exp_app_dyn (
  loc: location
, s2f: s2exp, s2fe: s2eff, _fun: d3exp, npf: int, _arg: d3explst
) : d3exp // end of [d3exp_app_dyn]

(* ****** ****** *)

fun d3exp_lst (
  loc: location, typ: s2exp
, lin: int, s2f_elt: s2exp, d3es: d3explst
) : d3exp // end of [d3exp_lst]

fun d3exp_tup (
  loc: location, typ: s2exp
, tupknd: int, npf: int, d3es: d3explst
) : d3exp // end of [d3exp_tup]

fun d3exp_rec (
  loc: location, typ: s2exp
, recknd: int, npf: int, ld3es: labd3explst
) : d3exp // end of [d3exp_rec]

fun d3exp_seq (
  loc: location, typ: s2exp, d3es: d3explst
) : d3exp // end of [d3exp_seq]

(* ****** ****** *)

fun d3exp_if (
  loc: location
, s2e_if: s2exp
, _cond: d3exp, _then: d3exp, _else: d3expopt
) : d3exp // end of [d3exp_if]

fun d3exp_case (
  loc: location
, s2e_case: s2exp
, knd: caskind, d3es: d3explst, c3ls: c3laulst
) : d3exp // end of [d3exp_case]

(* ****** ****** *)

fun d3exp_arrinit (
  loc: location
, s2e_arr: s2exp, elt: s2exp, asz: d3exp, d3es: d3explst
) : d3exp // end of [d3exp_arrinit]
fun d3exp_arrsize (
  loc: location, s2e_arrsz: s2exp, d3es: d3explst, asz: int
) : d3exp // end of [d3exp_arrsize]

(* ****** ****** *)

fun d3exp_lam_dyn (
  loc: location, typ: s2exp
, lin: int, npf: int, arg: p3atlst, body: d3exp
) : d3exp // end of [d3exp_lam_dyn]
fun d3exp_laminit_dyn (
  loc: location, typ: s2exp
, lin: int, npf: int, arg: p3atlst, body: d3exp
) : d3exp // end of [d3exp_laminit_dyn]

fun d3exp_lam_sta (
  loc: location, typ: s2exp
, s2vs: s2varlst, s2ps: s2explst, body: d3exp
) : d3exp // end of [d3exp_lam_sta]

(* ****** ****** *)

fun d3exp_loopexn
  (loc: location, s2f: s2exp, knd: int): d3exp

(* ****** ****** *)

fun d3exp_ann_type
  (loc: location, d3e: d3exp, s2f: s2exp): d3exp
// end of [d3exp_ann_type]

(* ****** ****** *)

fun d3exp_err (loc: location): d3exp

(* ****** ****** *)

fun m3atch_make (
  loc: location, d3e: d3exp, opt: p3atopt
) : m3atch // end of [m3atch_make]

fun c3lau_make
  {n:nat} (
  loc: location
, pat: list (p3at, n)
, gua: m3atchlst
, seq: int, neg: int
, body: d3exp
): c3lau (n) // end of [c3lau_make]

(* ****** ****** *)

fun f3undec_make (
  loc: location, d2v: d2var, def: d3exp
) : f3undec // end of [f3undec_make]

fun v3aldec_make (
  loc: location, p3t: p3at, def: d3exp
) : v3aldec // end of [v3aldec_make]

(* ****** ****** *)

fun d3ecl_none (loc: location): d3ecl
fun d3ecl_list (loc: location, xs: d3eclist): d3ecl

(* ****** ****** *)

fun d3ecl_datdec
  (loc: location, knd: int, s2cs: s2cstlst): d3ecl
// end of [d3ecl_datdec]

(* ****** ****** *)

fun d3ecl_dcstdec
  (loc: location, knd: dcstkind, d2cs: d2cstlst): d3ecl
// end of [d3ecl_dcstdec]

(* ****** ****** *)

fun d3ecl_fundecs (
  loc: location, knd: funkind, decarg: s2qualst, d3cs: f3undeclst
) : d3ecl // end of [d3ecl_fundecs]

fun d3ecl_valdecs (
  loc: location, knd: valkind, d3cs: v3aldeclst
) : d3ecl // end of [d3ecl_valdecs]

fun d3ecl_valdecs_rec (
  loc: location, knd: valkind, d3cs: v3aldeclst
) : d3ecl // end of [d3ecl_valdecs_rec]

fun d3ec_vardecs (loc: location, ds: v3ardeclst): d3ecl

(* ****** ****** *)

(* end of [pats_dynexp3.sats] *)
