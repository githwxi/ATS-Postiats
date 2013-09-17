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
// Start Time: October, 2011
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload
INT = "./pats_intinf.sats"
typedef intinf = $INT.intinf

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"
typedef d2cst = d2cst_type // abstract
typedef d2var = d2var_type // abstract

(* ****** ****** *)

datatype p3at_node =
//
  | P3Tany of d2var // wildcard
  | P3Tvar of (d2var) // mutability from the context
//
  | P3Tcon of (pckind, d2con, int(*npf*), p3atlst(*arg*))
//
  | P3Tint of (int)
  | P3Tintrep of string(*rep*)
  | P3Tbool of (bool)
  | P3Tchar of (char)
  | P3Tfloat of (string)  
  | P3Tstring of (string)  
//
  | P3Ti0nt of i0nt
  | P3Tf0loat of f0loat
//
  | P3Tempty (* empty pattern *)
//
  | P3Trec of (int(*knd*), int(*npf*), labp3atlst)
  | P3Tlst of (int(*lin*), s2exp(*elt*), p3atlst) // pattern list
//
  | P3Trefas of (d2var, p3at) // referenced pattern
//
  | P3Texist of (s2varlst, p3at) // existential opening
//
  | P3Tvbox of (d2var) // vbox pattern
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
, p3at_dvaropt= d2varopt // for presevation purpose
, p3at_type_left= s2expopt // for presevation purpose
} // end of [p3at]

and p3atlst = List (p3at)
and p3atopt = Option (p3at)

and labp3atlst = List (labp3at)

(* ****** ****** *)

fun print_p3at (x: p3at): void
overload print with print_p3at
fun prerr_p3at (x: p3at): void
overload prerr with prerr_p3at
fun fprint_p3at : fprint_type (p3at)
overload fprint with fprint_p3at
fun fprint_p3atlst : fprint_type (p3atlst)
overload fprint with fprint_p3atlst

(* ****** ****** *)

fun p3at_make_node (
  loc: location, s2e: s2exp, node: p3at_node
) : p3at // end of [p3at_make_node]

fun p3at_any (
  loc: location, s2e: s2exp, d2v: d2var
) : p3at // end of [p3at_any]

fun p3at_var (
  loc: location, s2e: s2exp, d2v: d2var
) : p3at // end of [p3at_var]

fun p3at_con (
  loc: location
, s2e: s2exp, pck: pckind, d2c: d2con, npf: int, arg: p3atlst
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
fun p3at_float (
  loc: location, s2f: s2exp, rep: string
) : p3at // end of [p3at_float]
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
  loc: location, s2f: s2exp, lin: int, s2e_elt: s2exp, p3ts: p3atlst
) : p3at // end of [p3at_lst]

fun p3at_refas (
  loc: location, s2f: s2exp, d2v: d2var, p3t: p3at
) : p3at // end of [p3at_refas]

fun p3at_exist (
  loc: location, s2f: s2exp, s2vs: s2varlst, p3t: p3at
) : p3at // end of [p3at_exist]

fun p3at_vbox
  (loc: location, s2f: s2exp, d2v: d2var): p3at
// end of [p3at_vbox]

fun p3at_ann (
  loc: location, s2f: s2exp, p3t: p3at, ann: s2exp
) : p3at // end of [p3at_ann]

fun p3at_err (loc: location, s2f: s2exp): p3at

(* ****** ****** *)

fun p3at_get_type (p3t: p3at): s2exp
fun p3at_set_type
  (p3t: p3at, s2f: s2exp): void = "patsopt_p3at_set_type"
// end of [p3at_set_type]

fun p3at_get_dvaropt (p3t: p3at): d2varopt
fun p3at_set_dvaropt
  (p3t: p3at, opt: d2varopt): void = "patsopt_p3at_set_dvaropt"
// end of [p3at_set_dvaropt]

fun p3at_get_type_left (p3t: p3at): s2expopt
fun p3at_set_type_left
  (p3t: p3at, opt: s2expopt): void = "patsopt_p3at_set_type_left"
// end of [p3at_set_type_left]

(* ****** ****** *)

fun p3at_is_prf (p3t: p3at): bool

(* ****** ****** *)

fun p3at_is_lincon (p3t: p3at): bool
fun p3at_is_unfold (p3t: p3at): bool

(* ****** ****** *)

datatype
d3ecl_node =
//
  | D3Cnone of ()
  | D3Clist of d3eclist
//
// HX: needed for compiling abstract types
//
  | D3Csaspdec of (s2aspdec)
//
  | D3Cextcode of (int(*knd*), int(*pos*), string(*code*))  
//
  | D3Cdatdecs of (int(*knd*), s2cstlst)
  | D3Cexndecs of (d2conlst) // HX: exception decls
  | D3Cdcstdecs of (dcstkind, d2cstlst)
//
  | D3Cimpdec of (
      int(*knd*), i3mpdec // knd=0/1 : implement/primplmnt
    ) // end of [D3Cimpdec]
//
  | D3Cfundecs of (funkind, s2qualst(*decarg*), f3undeclst)
//
  | D3Cvaldecs of (valkind, v3aldeclst)
  | D3Cvaldecs_rec of (valkind, v3aldeclst)
//
  | D3Cvardecs of
      (v3ardeclst) // local variable declarations
    // end of [D3Cvardecs]
  | D3Cprvardecs of
      (prv3ardeclst) // local proof variable declarations
    // end of [D3Cprvardecs]
//
  | D3Cinclude of d3eclist (* file inclusion *)
//
  | D3Cstaload of
    (
      filename, int(*flag*), filenv, int(*loaded*)
    ) // end of [D3Cstaload]
  | D3Cdynload of (filename)
//
  | D3Clocal of (d3eclist(*head*), d3eclist(*body*))
// end of [d3ecl_node]

and d3exp_node =
//
  | D3Ecst of (d2cst) // dynamic constants
  | D3Evar of (d2var) // dynamic variables
//
  | D3Eint of (int)
  | D3Eintrep of (string(*rep*))
  | D3Ebool of (bool)
  | D3Echar of (char)
  | D3Efloat of string(*rep*)
  | D3Estring of string(*val*)
//
  | D3Ei0nt of i0nt
  | D3Ef0loat of f0loat
//
  | D3Ecstsp of ($SYN.cstsp)
//
  | D3Etop of () // unspecified value
  | D3Eempty of () // the void-value of void-type
//
  | D3Eextval of (string(*name*))
  | D3Eextfcall of (string(*fun*), d3explst(*arg*))
//
  | D3Econ of (d2con, int(*npf*), d3explst(*arg*))
//
  | D3Etmpcst of (d2cst, t2mpmarglst)
  | D3Etmpvar of (d2var, t2mpmarglst)
//
  | D3Efoldat of (d3exp)
  | D3Efreeat of (d3exp)
//
  | D3Eitem of
      (d2itm, t2mpmarglst) // HX: for temporary use
    // end of [D3Eitem]
//
  | D3Elet of (d3eclist, d3exp)
//
  | D3Eapp_sta of d3exp // static application
  | D3Eapp_dyn of (d3exp, int(*npf*), d3explst)
//
  | D3Eif of (
      d3exp(*cond*), d3exp(*then*), d3exp(*else*)
    ) // end of [D3Eif]
  | D3Esif of (
      s2exp(*cond*), d3exp(*then*), d3exp(*else*)
    ) // end of [D3Esif]
//
  | D3Ecase of (
      caskind, d3explst(*values*), c3laulst(*clauses*)
    ) // end of [D3Ecase]
  | D3Escase of (s2exp(*value*), sc3laulst(*clauses*))
//
  | D3Elst of (* list expression *)
      (int(*lin*), s2exp(*elt*), d3explst)
  | D3Etup of (* tuple expression *)
      (int(*tupknd*), int(*npf*), d3explst)
  | D3Erec of (* record expression *)
      (int(*recknd*), int(*npf*), labd3explst)
  | D3Eseq of (d3explst) // sequencing
//
  | D3Eselab of (d3exp, d3lablst) // record/tuple field selection
//
  | D3Eptrofvar of (d2var) // taking the address of
  | D3Eptrofsel of (d3exp, s2exp(*root*), d3lablst) // taking the address of
//
  | D3Eviewat of (d3exp, d3lablst) // taking the atview of // it is to be erased
//
  | D3Erefarg of
      // refval=1/0: call-by-ref/val argument
      // freeknd=1/0: to be freed or not after call
      (int(*refval*), int(*freeknd*), d3exp) 
    // end of [D3Erefarg]
//
  | D3Esel_var of (d2var, s2exp(*root*), d3lablst) // call-by-val/ref
  | D3Esel_ptr of
      (d3exp, s2exp(*root*), d3lablst) // pointed record/tuple field selection
  | D3Esel_ref of
      (d3exp, s2exp(*root*), d3lablst) // referenced record/tuple field selection
//
  | D3Eassgn_var of (d2var(*left*), s2exp(*root*), d3lablst, d3exp(*right*))
  | D3Eassgn_ptr of (d3exp(*left*), s2exp(*root*), d3lablst, d3exp(*right*))
  | D3Eassgn_ref of (d3exp(*left*), s2exp(*root*), d3lablst, d3exp(*right*))
//
  | D3Exchng_var of (d2var(*left*), s2exp(*root*), d3lablst, d3exp(*right*))
  | D3Exchng_ptr of (d3exp(*left*), s2exp(*root*), d3lablst, d3exp(*right*))
  | D3Exchng_ref of (d3exp(*left*), s2exp(*root*), d3lablst, d3exp(*right*))
//
  | D3Eviewat_assgn of
      (d3exp, d3lablst, d3exp) // returing the atview of // it is to be erased
//
  | D3Earrpsz of
      (s2exp(*elt*), d3explst, int(*size*))
  | D3Earrinit of // For instance, @[int](1,2,3)
      (s2exp(*elt*), d3exp(*asz*), d3explst(*elt*))
//
  | D3Eraise of (d3exp) // HX: raised exception
//
  | D3Eeffmask of (s2eff, d3exp) // $effmask(s2eff, d3exp)
//
  | D3Evcopyenv of (int(*knd*), d2var) // $vcopyenv_v/vcopyenv_vt
//
  | D3Elam_dyn of // dynamic abstraction
      (int(*lin*), int(*npf*), p3atlst, d3exp)
  | D3Elaminit_dyn of // dynamic flat funtion closure
      (int(*lin*), int(*npf*), p3atlst, d3exp)
  | D3Elam_sta of // static abstraction
      (s2varlst(*s2vs*), s2explst(*s2ps*), d3exp)
  | D3Elam_met of (s2explst(*met*), d3exp) // term. metric
//
  | D3Edelay of d3exp(*eval*) // delayed computation
  | D3Eldelay of (d3exp(*eval*), d3expopt(*free*)) // delayed LC
  | D3Elazy_force of (int(*lin*), d3exp) // lazy-value evaluation
//
  | D3Eloop of (* for/while-loops *)
    (
      d3expopt(*init*), d3exp(*test*), d3expopt(*post*), d3exp(*body*)
    )
  | D3Eloopexn of int(*knd*) (* knd=0/1: break/continue *)
//
  | D3Etrywith of (d3exp(*try-exp*), c3laulst(*with-clauses*))
//
  | D3Eann_type of (d3exp, s2exp)
//
  | D3Eerr of () // indication of error
// end of [d3exp_node]

and d3lab_node =
  | D3LABlab of (label) | D3LABind of (d3explst)
// end of [d3lab_node]

where
d3ecl = '{
  d3ecl_loc= location, d3ecl_node= d3ecl_node
} // end of [d3ecl]

and d3eclist = List (d3ecl)
and d3eclistopt = Option (d3eclist)

and d3exp = '{
  d3exp_loc= location
, d3exp_type= s2exp // HX: it may still be s2Var
, d3exp_node= d3exp_node
} // end of [d3exp]

and d3explst = List (d3exp)
and d3expopt = Option (d3exp)

and labd3exp = dl0abeled (d3exp)
and labd3explst = List (labd3exp)

(* ****** ****** *)

and d3lab = '{
  d3lab_loc= location
, d3lab_node= d3lab_node
, d3lab_overld= d2symopt
} // end of [d3lab]

and d3lablst = List (d3lab)

(* ****** ****** *)

and gm3at = '{
  gm3at_loc= location
, gm3at_exp= d3exp
, gm3at_pat= p3atopt
} // end of [gm3at]

and gm3atlst = List (gm3at)

and c3lau (n:int) = '{
  c3lau_loc= location
, c3lau_pat= list (p3at, n)
, c3lau_gua= gm3atlst // clause guard
, c3lau_seq= int // sequentiality
, c3lau_neg= int // negativativity
, c3lau_body= d3exp // expression body
} // end of [c3lau]

and c3lau = [n:nat] c3lau (n)

and c3laulst
  (n:int) = List (c3lau (n))
and c3laulst = [n:nat] c3laulst (n)
and c3laulst_vt
  (n:int) = List_vt (c3lau (n))

and sc3lau = '{
  sc3lau_loc= location
, sc3lau_pat= sp2at
, sc3lau_body= d3exp
} // end of [sc3lau]

and sc3laulst = List (sc3lau)

(* ****** ****** *)

and i3mpdec = '{
  i3mpdec_loc= location
, i3mpdec_cst= d2cst
, i3mpdec_imparg= s2varlst
, i3mpdec_tmparg= s2explstlst
, i3mpdec_def= d3exp
} // end of [i3mpdec]

(* ****** ****** *)

and f3undec = '{
  f3undec_loc= location
, f3undec_var= d2var
, f3undec_def= d3exp
} // end of [f3undec]

and f3undeclst = List f3undec

(* ****** ****** *)

and v3aldec = '{
  v3aldec_loc= location
, v3aldec_pat= p3at
, v3aldec_def= d3exp
} // end of [v3aldec]

and v3aldeclst = List (v3aldec)

(* ****** ****** *)

and v3ardec = '{
  v3ardec_loc= location
, v3ardec_knd= int
, v3ardec_dvar_ptr= d2var
, v3ardec_dvar_view= d2var
, v3ardec_type= s2exp
, v3ardec_ini= d3expopt
} // end of [v3ardec]

and v3ardeclst = List (v3ardec)

(* ****** ****** *)

and prv3ardec = '{
  prv3ardec_loc= location
, prv3ardec_dvar= d2var, prv3ardec_type= s2exp, prv3ardec_ini= d3exp
} // end of [prv3ardec]

and prv3ardeclst = List (prv3ardec)

(* ****** ****** *)

fun d3exp_get_type (d3e: d3exp): s2exp
fun d3explst_get_type (d3es: d3explst): s2explst

fun d3exp_set_type
  (d3e: d3exp, s2f: s2exp): void = "patsopt_d3exp_set_type"
// end of [d3exp_set_type]

(* ****** ****** *)

fun d3exp_is_prf (d3e: d3exp): bool

(* ****** ****** *)

fun print_d3exp (d3e: d3exp): void
overload print with print_d3exp
fun prerr_d3exp (d3e: d3exp): void
overload prerr with prerr_d3exp
fun fprint_d3exp : fprint_type (d3exp)
fun fprint_d3explst : fprint_type (d3explst)

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

fun d3exp_float
  (loc: location, s2f: s2exp, rep: string): d3exp
// end of [d3exp_float]

(* ****** ****** *)

fun d3exp_i0nt (
  loc: location, s2f: s2exp, x: i0nt
) : d3exp // end of [d3exp_i0nt]

fun d3exp_f0loat
  (loc: location, s2f: s2exp, x: f0loat): d3exp
// end of [d3exp_float]

(* ****** ****** *)

fun d3exp_top (loc: location, s2f: s2exp): d3exp
fun d3exp_empty (loc: location, s2f: s2exp): d3exp

(* ****** ****** *)

fun d3exp_cstsp
  (loc: location, s2f: s2exp, x: $SYN.cstsp): d3exp
// end of [d3exp_cstsp]

(* ****** ****** *)

fun d3exp_extval
  (loc: location, s2f: s2exp, name: string): d3exp
// end of [d3exp_extval]

fun d3exp_extfcall
  (loc: location, s2f: s2exp, _fun: string, _arg: d3explst): d3exp
// end of [d3exp_extfcall]

(* ****** ****** *)

fun d3exp_cst
  (loc: location, s2f: s2exp, d2c: d2cst): d3exp
// end of [d3exp_cst]

fun d3exp_con (
  loc: location
, s2f_res: s2exp, d2c: d2con, npf: int, d3es: d3explst
) : d3exp // end of [d3exp_con]

(* ****** ****** *)

fun d3exp_foldat (loc: location, d3e: d3exp): d3exp
fun d3exp_freeat (loc: location, d3e: d3exp): d3exp

(* ****** ****** *)

fun d3exp_tmpcst (
  loc: location, s2f: s2exp, d2c: d2cst, t2mas: t2mpmarglst
) : d3exp // end of [d3exp_tmpcst]
fun d3exp_tmpvar (
  loc: location, s2f: s2exp, d2v: d2var, t2mas: t2mpmarglst
) : d3exp // end of [d3exp_tmpvar]

(* ****** ****** *)

fun d3exp_item (
  loc: location, s2f: s2exp, d2i: d2itm, t2mas: t2mpmarglst
) : d3exp // end of [d3exp_item]

(* ****** ****** *)

fun d3exp_let
  (loc: location, d3cs: d3eclist, d3e: d3exp): d3exp
// end of [d3exp_let]
 
(* ****** ****** *)

fun d3exp_app_sta
  (loc: location, s2f: s2exp, d3e: d3exp): d3exp
// end of [d3exp_app_sta]
fun d3exp_app_unista
  (loc: location, s2f: s2exp, d3e: d3exp): d3exp
// end of [d3exp_app_unista]

fun d3exp_app_dyn (
  loc: location
, s2f: s2exp, s2fe: s2eff, _fun: d3exp, npf: int, _arg: d3explst
) : d3exp // end of [d3exp_app_dyn]

(* ****** ****** *)

fun d3exp_lst (
  loc: location
, s2f0: s2exp, lin: int, s2f_elt: s2exp, d3es: d3explst
) : d3exp // end of [d3exp_lst]

fun d3exp_tup (
  loc: location
, s2f0: s2exp, tupknd: int, npf: int, d3es: d3explst
) : d3exp // end of [d3exp_tup]

fun d3exp_rec (
  loc: location
, s2f0: s2exp, recknd: int, npf: int, ld3es: labd3explst
) : d3exp // end of [d3exp_rec]

fun d3exp_seq
  (loc: location, s2f: s2exp, d3es: d3explst): d3exp
// end of [d3exp_seq]

(* ****** ****** *)

fun d3exp_if (
  loc: location
, s2e_if: s2exp
, _cond: d3exp, _then: d3exp, _else: d3exp
) : d3exp // end of [d3exp_if]

fun d3exp_sif (
  loc: location
, s2e_sif: s2exp
, _cond: s2exp, _then: d3exp, _else: d3exp
) : d3exp // end of [d3exp_sif]

(* ****** ****** *)

fun d3exp_case (
  loc: location
, s2e_case: s2exp
, knd: caskind, d3es: d3explst, c3ls: c3laulst
) : d3exp // end of [d3exp_case]

fun d3exp_scase (
  loc: location
, s2e_scase: s2exp
, s2e_val: s2exp, sc3ls: sc3laulst
) : d3exp // end of [d3exp_scase]

(* ****** ****** *)

fun d3exp_sel_var (
  loc: location, s2e: s2exp, d2v: d2var, s2rt: s2exp, d3ls: d3lablst
) : d3exp // end of [d3exp_sel_var]
fun d3exp_sel_ptr (
  loc: location, s2e: s2exp, d3e: d3exp, s2rt: s2exp, d3ls: d3lablst
) : d3exp // end of [d3exp_sel_ptr]
fun d3exp_sel_ref (
  loc: location, s2e: s2exp, d3e: d3exp, s2rt: s2exp, d3ls: d3lablst
) : d3exp // end of [d3exp_sel_ref]

(* ****** ****** *)

fun d3exp_assgn_var (
  loc: location, d2v_l: d2var, s2rt: s2exp, d3ls: d3lablst, d3e_r: d3exp
) : d3exp // end of [d3exp_assgn_var]
fun d3exp_assgn_ptr (
  loc: location, d3e_l: d3exp, s2rt: s2exp, d3ls: d3lablst, d3e_r: d3exp
) : d3exp // end of [d3exp_assgn_ptr]
fun d3exp_assgn_ref (
  loc: location, d3e_l: d3exp, s2rt: s2exp, d3ls: d3lablst, d3e_r: d3exp
) : d3exp // end of [d3exp_assgn_ref]

(* ****** ****** *)

fun d3exp_xchng_var (
  loc: location, d2v_l: d2var, s2rt: s2exp, d3ls: d3lablst, d3e_r: d3exp
) : d3exp // end of [d3exp_xchng_var]
fun d3exp_xchng_ptr (
  loc: location, d3e_l: d3exp, s2rt: s2exp, d3ls: d3lablst, d3e_r: d3exp
) : d3exp // end of [d3exp_xchng_ptr]
fun d3exp_xchng_ref (
  loc: location, d3e_l: d3exp, s2rt: s2exp, d3ls: d3lablst, d3e_r: d3exp
) : d3exp // end of [d3exp_xchng_ref]

(* ****** ****** *)

fun d3exp_refarg (
  loc: location, s2e: s2exp, refval: int, freeknd: int, d3e: d3exp
) : d3exp // end of [d3exp_refarg]

(* ****** ****** *)

fun d3exp_arrpsz (
  loc: location
, s2e_arrpsz: s2exp, elt: s2exp, d3es: d3explst, asz: int
) : d3exp // end of [d3exp_arrpsz]

fun d3exp_arrinit (
  loc: location
, s2e_arr: s2exp, elt: s2exp, asz: d3exp, d3es: d3explst
) : d3exp // end of [d3exp_arrinit]

(* ****** ****** *)

fun d3exp_raise
  (loc: location, s2f: s2exp, d3e: d3exp): d3exp
// end of [d3exp_raise]

(* ****** ****** *)

fun d3exp_effmask
  (loc: location, s2fe: s2eff, d3e: d3exp): d3exp
// end of [d3exp_effmask]

(* ****** ****** *)

fun d3exp_vcopyenv
  (loc: location, s2f: s2exp, knd: int, d2v: d2var): d3exp

(* ****** ****** *)

fun d3exp_selab
  (loc: location, s2f: s2exp, d3e: d3exp, d3ls: d3lablst): d3exp
// end of [d3exp_selab]

(* ****** ****** *)

fun d3exp_ptrofvar
  (loc: location, s2f: s2exp, d2v: d2var): d3exp
fun d3exp_ptrofsel (
  loc: location, s2f: s2exp, d3e: d3exp, s2rt: s2exp, d3ls: d3lablst
) : d3exp // end of [d3exp_ptrofsel]

(* ****** ****** *)

fun d3exp_viewat
  (loc: location, s2at: s2exp, d3e: d3exp, d3ls: d3lablst): d3exp
// end of [d3exp_viewat]
fun d3exp_viewat_assgn
  (loc: location, d3e_l: d3exp, d3ls: d3lablst, d3e_r: d3exp): d3exp
// end of [d3exp_viewat_assgn]

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

fun d3exp_lam_met (
  loc: location, met: s2explst, body: d3exp
) : d3exp // end of [d3exp_lam_met]

(* ****** ****** *)

fun d3exp_delay
  (loc: location, s2e: s2exp, _eval: d3exp): d3exp
fun d3exp_ldelay
(
  loc: location, s2e: s2exp, _eval: d3exp, _free: d3expopt
) : d3exp // end of [d3exp_ldelay]
fun d3exp_lazy_force
(
  loc: location, s2e_res: s2exp, lin: int, delayed: d3exp
) : d3exp // end of [d3exp_lazy_force]

(* ****** ****** *)

fun d3exp_loop
(
  loc: location
, init: d3expopt, test: d3exp, post: d3expopt, body: d3exp
) : d3exp // end of [d3exp_loop]

fun d3exp_loopexn (loc: location, knd: int): d3exp

(* ****** ****** *)

fun d3exp_trywith (
  loc: location, d3e: d3exp, c3ls: c3laulst
) : d3exp // end of [d3exp_trywith]

(* ****** ****** *)

fun d3exp_ann_type
  (loc: location, d3e: d3exp, s2f: s2exp): d3exp
// end of [d3exp_ann_type]

(* ****** ****** *)

fun d3exp_err (loc: location): d3exp
fun d3exp_void_err (loc: location): d3exp

(* ****** ****** *)

fun d3lab_lab
  (loc: location, lab: label, opt: d2symopt): d3lab
fun d3lab_ind (loc: location, ind: d3explst): d3lab

(* ****** ****** *)

fun gm3at_make (
  loc: location, d3e: d3exp, opt: p3atopt
) : gm3at // end of [gm3at_make]

fun c3lau_make
  {n:nat} (
  loc: location
, p3ts: list (p3at, n)
, gua: gm3atlst
, seq: int, neg: int
, body: d3exp
): c3lau (n) // end of [c3lau_make]

fun sc3lau_make (
  loc: location, sp2t: sp2at, d3e: d3exp
) : sc3lau // end of [sc3lau_make]

(* ****** ****** *)

fun i3mpdec_make (
  loc: location, d2c: d2cst
, imparg: s2varlst, tmparg: s2explstlst, def: d3exp
) : i3mpdec // end of [i3mpdec_make]

(* ****** ****** *)

fun f3undec_make (
  loc: location, d2v: d2var, def: d3exp
) : f3undec // end of [f3undec_make]

fun v3aldec_make (
  loc: location, p3t: p3at, def: d3exp
) : v3aldec // end of [v3aldec_make]

(* ****** ****** *)

fun v3ardec_make (
  loc: location, knd: int (*0/1:sta/dyn*)
, d2v: d2var, d2vw: d2var, s2e0: s2exp, ini: d3expopt
) : v3ardec // end of [v3ardec_make]

fun prv3ardec_make (
  loc: location, d2v: d2var, s2e0: s2exp, ini: d3exp
) : prv3ardec // end of [prv3ardec_make]

(* ****** ****** *)

fun d3ecl_make_node
  (loc: location, node: d3ecl_node): d3ecl
// end of [d3ecl_make_node]

(* ****** ****** *)

fun print_d3ecl (d3c: d3ecl): void
overload print with print_d3ecl
fun prerr_d3ecl (d3c: d3ecl): void
overload prerr with prerr_d3ecl
fun fprint_d3ecl : fprint_type (d3ecl)

(* ****** ****** *)

fun d3ecl_none (loc: location): d3ecl
fun d3ecl_list (loc: location, xs: d3eclist): d3ecl

(* ****** ****** *)

fun d3ecl_saspdec (loc: location, d2c: s2aspdec): d3ecl

(* ****** ****** *)

fun d3ecl_extcode
  (loc: location, knd: int, pos: int, code: string): d3ecl
// end of [d3ecl_extcode]

(* ****** ****** *)

fun d3ecl_datdecs
  (loc: location, knd: int, s2cs: s2cstlst): d3ecl
// end of [d3ecl_datdecs]

(* ****** ****** *)

fun d3ecl_exndecs (loc: location, d2cs: d2conlst): d3ecl

(* ****** ****** *)

fun d3ecl_dcstdecs
  (loc: location, knd: dcstkind, d2cs: d2cstlst): d3ecl
// end of [d3ecl_dcstdecs]

(* ****** ****** *)

fun d3ecl_impdec
  (loc: location, knd: int, d3c: i3mpdec) : d3ecl
// end of [d3ecl_impdec]

(* ****** ****** *)

fun d3ecl_fundecs (
  loc: location, knd: funkind, decarg: s2qualst, f3ds: f3undeclst
) : d3ecl // end of [d3ecl_fundecs]

fun d3ecl_valdecs (
  loc: location, knd: valkind, v3ds: v3aldeclst
) : d3ecl // end of [d3ecl_valdecs]

fun d3ecl_valdecs_rec (
  loc: location, knd: valkind, v3ds: v3aldeclst
) : d3ecl // end of [d3ecl_valdecs_rec]

fun d3ecl_vardecs (loc: location, v3ds: v3ardeclst): d3ecl
fun d3ecl_prvardecs (loc: location, v3ds: prv3ardeclst): d3ecl

(* ****** ****** *)

fun d3ecl_include (loc: location, d3cs: d3eclist): d3ecl

(* ****** ****** *)

fun d3ecl_staload
(
  loc: location
, fil: filename, loadflag: int, fenv: filenv, loaded: int
) : d3ecl // end of [d2ecl_staload]

fun d3ecl_dynload (loc: location, fil: filename): void

(* ****** ****** *)

fun d3ecl_dynload (loc: location, fil: filename): d3ecl

(* ****** ****** *)

fun d3ecl_local
  (loc: location, head: d3eclist, body: d3eclist): d3ecl
// end of [d3ecl_local]

(* ****** ****** *)

(* end of [pats_dynexp3.sats] *)
