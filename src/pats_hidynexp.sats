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
// Start Time: July, 2012
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"

(* ****** ****** *)
//
fun d2cst_get2_hisexp (d2c: d2cst): hisexpopt
fun d2cst_set2_hisexp (d2c: d2cst, opt: hisexpopt): void
//
fun d2cst_get2_type_arg (d2c: d2cst): hisexplst
fun d2cst_get2_type_res (d2c: d2cst): hisexp
//
(* ****** ****** *)
//
fun d2var_get2_hisexp (d2v: d2var): hisexpopt
fun d2var_set2_hisexp (d2v: d2var, opt: hisexpopt): void
//
(* ****** ****** *)

fun d2cst_get2_funclo (d2c: d2cst): fcopt_vt
fun d2var_get2_funclo (d2v: d2var): fcopt_vt

(* ****** ****** *)

datatype
hipat_node =
  | HIPany of (d2var) // wildcard
  | HIPvar of (d2var) // mutability from the context
//
  | HIPint of int
  | HIPintrep of string
//
  | HIPbool of bool
  | HIPchar of char
  | HIPstring of string
  | HIPfloat of string
//
  | HIPi0nt of $SYN.i0nt
  | HIPf0loat of $SYN.f0loat
//
  | HIPempty of () // empty pattern
//
  | HIPcon of (* constructor pattern *)
      (pckind, d2con, hisexp(*tysum*), labhipatlst)
  | HIPcon_any of (pckind, d2con) // HX: unused arg
//
(*
  | HIPlst of (hisexp(*element*), hipatlst)
*)
  | HIPrec of (* record pattern *)
      (int(*knd*), labhipatlst, hisexp(*tyrec*))
//
  | HIPrefas of (d2var, hipat) // referenced pattern
//
  | HIPann of (hipat, hisexp)
//
  | HIPerr of () // HX: error indication
// end of [hipat_node]

and labhipat = LABHIPAT of (label, hipat)

where
hipat = '{
  hipat_loc= location
, hipat_type= hisexp
, hipat_node= hipat_node
// HX: a variable for storing the value
, hipat_asvar= d2varopt // that matches the pattern
} // end of [hipat]

and hipatlst = List (hipat)
and hipatopt = Option (hipat)

and labhipatlst = List (labhipat)

(* ****** ****** *)

fun print_hipat (hip: hipat): void
fun prerr_hipat (hip: hipat): void
overload print with print_hipat
overload prerr with prerr_hipat
fun fprint_hipat : fprint_type (hipat)
overload fprint with fprint_hipat

fun fprint_hipatlst : fprint_type (hipatlst)
overload fprint with fprint_hipatlst
fun fprint_labhipatlst : fprint_type (labhipatlst)
overload fprint with fprint_labhipatlst

(* ****** ****** *)

fun hipat_get_type (hip: hipat): hisexp
fun labhipatlst_get_type (lhips: labhipatlst): labhisexplst

fun hipat_set_asvar
  (hip: hipat, opt: d2varopt): void = "patsopt_hipat_set_asvar"
// end of [hipat_set_asvar]

(* ****** ****** *)

fun labhipatlst_is_unused (lhips: labhipatlst): bool

(* ****** ****** *)

fun hipat_make_node
  (loc: location, hse: hisexp, node: hipat_node): hipat

(* ****** ****** *)

fun hipat_any (loc: location, hse: hisexp, d2v: d2var): hipat
fun hipat_var (loc: location, hse: hisexp, d2v: d2var): hipat

(* ****** ****** *)

fun
hipat_con
(
  loc: location
, hse: hisexp, pck: pckind
, d2c: d2con, hse_sum: hisexp, lhips: labhipatlst
) : hipat // end of [hipat_con]
fun
hipat_con_any
(
  loc: location, hse: hisexp, pck: pckind, d2c: d2con
) : hipat // end of [hipat_con_any]

(* ****** ****** *)

fun hipat_int (loc: location, hse: hisexp, i: int): hipat
fun hipat_intrep (loc: location, hse: hisexp, rep: string): hipat

(* ****** ****** *)

fun hipat_bool (loc: location, hse: hisexp, b: bool): hipat
fun hipat_char (loc: location, hse: hisexp, c: char): hipat
fun hipat_float (loc: location, hse: hisexp, rep: string): hipat
fun hipat_string (loc: location, hse: hisexp, str: string): hipat

(* ****** ****** *)

fun hipat_i0nt (loc: location, hse: hisexp, tok: i0nt): hipat
fun hipat_f0loat (loc: location, hse: hisexp, tok: f0loat): hipat

(* ****** ****** *)

fun hipat_empty (loc: location, hse: hisexp): hipat

(* ****** ****** *)

fun hipat_lst
(
  loc: location
, lin: int, hse_lst: hisexp, hse_elt: hisexp, hips: hipatlst
) : hipat // end of [hipat_lst]

(* ****** ****** *)

fun hipat_rec (
  loc: location
, hse: hisexp, knd: int, lhips: labhipatlst, hse_rec: hisexp
) : hipat // end of [hipat_rec]
fun hipat_rec2 (
  loc: location
, hse: hisexp, knd: int, lhips: labhipatlst, hse_rec: hisexp
) : hipat // end of [hipat_rec2]

(* ****** ****** *)

fun hipat_refas (
  loc: location, hse: hisexp, d2v: d2var, hip: hipat
) : hipat // end of [hipat_refas]

(* ****** ****** *)

fun hipat_ann
  (loc: location, hse: hisexp, hip: hipat, ann: hisexp): hipat
// end of [hipat_ann]

(* ****** ****** *)

fun hipat_is_wild (hip: hipat): bool
fun hipatlst_is_wild (hips: hipatlst): bool
fun labhipatlst_is_wild (lhips: labhipatlst): bool

(* ****** ****** *)
//
fun hipat_subtest
  (hip1: hipat, hip2: hipat): bool
fun hipatlst_subtest
  (hips1: hipatlst, hips2: hipatlst): bool
fun labhipatlst_subtest
  (lhips1: labhipatlst, lhips2: labhipatlst): bool
//
(* ****** ****** *)

abstype hidynexp_funlab_type // placeholder for [funlab]
abstype hidynexp_hidecl_type // placeholder for [hidecl]
abstype hidynexp_instrlst_type // placeholder for [instrlst]

(* ****** ****** *)

datatype
hidecl_node =
  | HIDnone of ()
  | HIDlist of hideclist
//
  | HIDsaspdec of (s2aspdec)
//
  | HIDextype of (string(*name*), hisexp)
  | HIDextval of (string(*name*), hidexp)
  | HIDextcode of
      (int(*knd*), int(*pos*), string(*code*))
    // end of [HIDextcode]
//
  | HIDexndecs of (d2conlst) // exception decls
  | HIDdatdecs of (int(*knd*), s2cstlst) // DT decls
//
  | HIDdcstdecs of (dcstkind, d2cstlst)
//
  | HIDimpdec of (int(*knd*), hiimpdec)
//
  | HIDfundecs of
      (funkind, s2qualst(*decarg*), hifundeclst)
    // end of [HIDfundecs]
//
  | HIDvaldecs of (valkind, hivaldeclst)
  | HIDvaldecs_rec of (valkind, hivaldeclst)
//
  | HIDvardecs of (hivardeclst) // variable declarations
//
  | HIDinclude of (int(*sta/dyn*), hideclist)
//
  | HIDstaload of
    (
      symbolopt
    , filename, int(*ldflag*), filenv, int(*loaded*)
    ) (* end of [HIDstaload] *)
  | HIDstaloadloc of
      (filename(*pfil*), symbol(*nspace*), hideclist)
    // end of [HIDstaloadloc]
//
  | HIDdynload of (filename)
//
  | HIDlocal of (hideclist (*head*), hideclist (*body*))
// end of [hidecl_node]

and hidexp_node =
//
  | HDEcst of (d2cst) // dynamic constants
  | HDEvar of (d2var) // dynamic variables
//
  | HDEint of int // integer constants
  | HDEintrep of string // integer constants
  | HDEbool of bool // boolean constants
  | HDEchar of char // constant characters
  | HDEfloat of string // constant floats
  | HDEstring of string // constant strings
//
  | HDEi0nt of i0nt // integer constants
  | HDEf0loat of f0loat // floating point constants
//
  | HDEcstsp of ($SYN.cstsp) // special constants
//
  | HDEtop of () // for uninitialized
  | HDEempty of () // for the void value
  | HDEignore of (hidexp) // ignoring the value of hidexp
//
  | HDEextval of (string(*name*)) // externally named values
  | HDEcastfn of (d2cst, hidexp(*arg*)) // castfn application
  | HDEextfcall of
      (string(*fun*), hidexplst(*arg*)) // externally named fcalls
    // end of [HDEextfcall]
//
  | HDEcon of (d2con, hisexp, labhidexplst(*arg*)) // constructors
//
  | HDEtmpcst of (d2cst, t2mpmarglst)
  | HDEtmpvar of (d2var, t2mpmarglst)
//
  | HDEfoldat of () // constructor-folding
  | HDEfreeat of (hidexp) // constructor-freeing
//
  | HDElet of (hideclist, hidexp)
//
  | HDEapp of (hidexp, hisexp(*fun*), hidexplst) // dynamic apps
//
  | HDEif of (
      hidexp(*cond*), hidexp(*then*), hidexp(*else*)
    ) // end f [HDEif]
  | HDEsif of (
      s2exp(*cond*), hidexp(*then*), hidexp(*else*)
    ) // end of [HDEsif]
//
  | HDEcase of (
      caskind, hidexplst(*values*), hiclaulst(*clauses*)
    ) // end of [HDEcase]
//
  | HDElst of (* list expression *)
      (int(*lin*), hisexp(*elt*), hidexplst)
  | HDErec of
      (int(*knd*), labhidexplst, hisexp(*tyrec*))
    // end of [HDErec]
  | HDEseq of (hidexplst) // sequencing
//
// HX: record field selection; array subscripting
//
  | HDEselab of (hidexp, hisexp(*flt*), hilablst)
//
  | HDEptrofvar of (d2var) // taking address of a variable
  | HDEptrofsel of
      (hidexp, hisexp(*root*), hilablst) // taking the address of ...
    // end of [HDEptrofsel]
//
  | HDErefarg of (int(*refval*), int(*freeknd*), hidexp)
//
  | HDEselvar of (d2var, hisexp(*root*), hilablst) // var-path-selction
  | HDEselptr of (hidexp, hisexp(*root*), hilablst) // ptr-path_selection
//
  | HDEassgn_var of
      (d2var(*left*), hisexp(*root*), hilablst, hidexp(*right*))
  | HDEassgn_ptr of
      (hidexp(*left*), hisexp(*root*), hilablst, hidexp(*right*))
//
  | HDExchng_var of
      (d2var(*left*), hisexp(*root*), hilablst, hidexp(*right*))
  | HDExchng_ptr of
      (hidexp(*left*), hisexp(*root*), hilablst, hidexp(*right*))
//
  | HDEarrpsz of (* arrsize construction *)
      (hisexp(*elt*), hidexplst(*elt*), int(*asz*))
  | HDEarrinit of (* array initialization *)
      (hisexp(*elt*), hidexp(*asz*), hidexplst(*elt*), int(*asz*))
//
  | HDEraise of (hidexp(*exn*))
//
  | HDElam of (int(*knd=0/1:flat/boxed*), hipatlst, hidexp) // HX: lam_dyn
//
  | HDEfix of (int(*knd=0/1:flat/boxed*), d2var(*fixvar*), hidexp) // fixed-point
//
  | HDEdelay of hidexp(*eval*) // delayed evaluation
  | HDEldelay of (hidexp(*eval*), hidexp(*free*)) // delayed evaluation
  | HDElazyeval of (int(*lin*), hidexp) // lazy-value evaluation
//
  | HDEloop of (* for/while-loops *)
    (
      hidexpopt(*init*), hidexp(*test*), hidexpopt(*post*), hidexp(*body*)
    )
  | HDEloopexn of (int(*knd*)) (* knd=0/1: break/continue *)
//
  | HDEtrywith of (hidexp(*try-exp*), hiclaulst(*with-clauses*))
//
  | HDEerrexp of ((*void*)) // HX: indication of error
// end of [hidexp_node]

and labhidexp = LABHIDEXP of (label, hidexp)

and hilab_node =
  | HILlab of (label) // field selection
  | HILind of (hidexplst (*index*)) // array subscription
// end of [hilab_node]

where
hidecl = '{
  hidecl_loc= location, hidecl_node= hidecl_node
} (* end of [hidecl] *)

and hideclist = List (hidecl)
and hideclopt = Option (hidecl)
and hideclistopt = Option (hideclist)

and hidexp = '{
  hidexp_loc= location
, hidexp_type= hisexp
, hidexp_node= hidexp_node
}

and hidexplst = List (hidexp)
and hidexpopt = Option (hidexp)

and labhidexplst = List (labhidexp)

(* ****** ****** *)

and hilab = '{
  hilab_loc= location, hilab_node= hilab_node
} // end of [hilab]

and hilablst = List (hilab)

(* ****** ****** *)

and higmat = '{
  higmat_loc= location
, higmat_exp= hidexp
, higmat_pat= hipatopt
} // end of [higmat]

and higmatlst = List (higmat)

(* ****** ****** *)

and hiclau = '{
  hiclau_loc= location
, hiclau_pat= hipatlst (* pattern *)
, hiclau_gua= higmatlst (* clause guard *)
, hiclau_seq= int // sequentiality
, hiclau_neg= int // negativativity
, hiclau_body= hidexp (* clause body *)
} // end of [hiclau]

and hiclaulst = List (hiclau)

(* ****** ****** *)

and hifundec = '{
  hifundec_loc= location
, hifundec_var= d2var
, hifundec_imparg= s2varlst
, hifundec_def= hidexp
, hifundec_hidecl= Option (hidynexp_hidecl_type)
, hifundec_funlab= Option (hidynexp_funlab_type)
} // end of [hifundec]

and hifundeclst = List (hifundec)

(* ****** ****** *)

and hivaldec = '{
  hivaldec_loc= location
, hivaldec_pat= hipat
, hivaldec_def= hidexp
} // end of [hivaldec]

and hivaldeclst = List (hivaldec)

(* ****** ****** *)

and hivardec = '{
  hivardec_loc= location
, hivardec_knd= int
, hivardec_dvar_ptr= d2var
, hivardec_dvar_view= d2var
, hivardec_type= hisexp
, hivardec_init= hidexpopt
} // end of [hivardec]

and hivardeclst = List (hivardec)

(* ****** ****** *)

and hiimpdec = '{
  hiimpdec_loc= location
, hiimpdec_cst= d2cst
, hiimpdec_imparg= s2varlst
, hiimpdec_tmparg= s2explstlst
, hiimpdec_def= hidexp
, hiimpdec_funlab= Option (hidynexp_funlab_type)
, hiimpdec_instrlst= Option (hidynexp_instrlst_type)
} // end of [hiimpdec]

and hiimpdeclst = List (hiimpdec)

(* ****** ****** *)

fun fprint_hidexp : fprint_type (hidexp)
fun print_hidexp (x: hidexp): void
overload print with print_hidexp
fun prerr_hidexp (x: hidexp): void
overload prerr with prerr_hidexp

fun fprint_hidexplst : fprint_type (hidexplst)
fun fprint_hidexpopt : fprint_type (hidexpopt)
fun fprint_labhidexplst : fprint_type (labhidexplst)

(* ****** ****** *)

fun fprint_hilab : fprint_type (hilab)
fun fprint_hilablst : fprint_type (hilablst)

(* ****** ****** *)

fun fprint_hidecl : fprint_type (hidecl)
fun print_hidecl (x: hidecl): void
overload print with print_hidecl
fun prerr_hidecl (x: hidecl): void
overload prerr with prerr_hidecl

fun fprint_hideclist : fprint_type (hideclist)

fun fprint_hifundec : fprint_type (hifundec)
fun fprint_hivaldec : fprint_type (hivaldec)
fun fprint_hivardec : fprint_type (hivardec)
fun fprint_hiimpdec : fprint_type (hiimpdec)

(* ****** ****** *)

fun hidexp_get_type (hde: hidexp): hisexp
fun hidexplst_get_type (hdes: hidexplst): hisexplst
fun labhidexplst_get_type (lhdes: labhidexplst): labhisexplst

(* ****** ****** *)

fun hidexp_is_value (hde: hidexp): bool
fun hidexp_is_lvalue (hde: hidexp): bool

(* ****** ****** *)

fun hidexp_make_node
  (loc: location, hse: hisexp, node: hidexp_node): hidexp
// end of [hidexp_make_node]

(* ****** ****** *)

fun hidexp_var
  (loc: location, hse: hisexp, d2v: d2var): hidexp
// end of [hidexp_var]

fun hidexp_cst
  (loc: location, hse: hisexp, d2c: d2cst): hidexp
// end of [hidexp_cst]

(* ****** ****** *)

fun hidexp_int
  (loc: location, hse: hisexp, i: int): hidexp
fun hidexp_intrep
  (loc: location, hse: hisexp, rep: string): hidexp
fun hidexp_bool
  (loc: location, hse: hisexp, b: bool): hidexp
fun hidexp_char
  (loc: location, hse: hisexp, c: char): hidexp
fun hidexp_float
  (loc: location, hse: hisexp, rep: string): hidexp
fun hidexp_string
  (loc: location, hse: hisexp, str: string): hidexp

(* ****** ****** *)

fun hidexp_i0nt
  (loc: location, hse: hisexp, tok: i0nt): hidexp
fun hidexp_f0loat
  (loc: location, hse: hisexp, tok: f0loat): hidexp

(* ****** ****** *)

fun hidexp_cstsp
  (loc: location, hse: hisexp, x: $SYN.cstsp): hidexp
// end of [hidexp_cstsp]

(* ****** ****** *)

fun hidexp_top
  (loc: location, hse: hisexp): hidexp
fun hidexp_empty
  (loc: location, hse: hisexp): hidexp
fun hidexp_ignore
  (loc: location, hse: hisexp, hde: hidexp): hidexp

(* ****** ****** *)

fun hidexp_extval
  (loc: location, hse: hisexp, name: string): hidexp
// end of [hidexp_extval]

fun hidexp_castfn (
  loc: location, hse: hisexp, d2c: d2cst, arg: hidexp
) : hidexp // end of [hidexp_castfn]

fun hidexp_extfcall (
  loc: location, hse: hisexp, _fun: string, _arg: hidexplst
) : hidexp // end of [hidexp_extfcall]

(* ****** ****** *)

fun hidexp_con (
  loc: location, hse: hisexp
, d2c: d2con, hse_sum: hisexp, lhdes: labhidexplst
) : hidexp // end of [hidexp_con]

(* ****** ****** *)

fun hidexp_tmpcst (
  loc: location, hse: hisexp, d2c: d2cst, t2mas: t2mpmarglst
) : hidexp // end of [hidexp_tmpcst]
fun hidexp_tmpvar (
  loc: location, hse: hisexp, d2v: d2var, t2mas: t2mpmarglst
) : hidexp // end of [hidexp_tmpvar]

(* ****** ****** *)

fun hidexp_foldat (loc: location, hse: hisexp): hidexp
fun hidexp_freeat (loc: location, hse: hisexp, hde: hidexp): hidexp

(* ****** ****** *)

fun hidexp_let
  (loc: location, hse: hisexp, hids: hideclist, hde: hidexp): hidexp
// end of [hidexp_let]

fun hidexp_let_simplify
  (loc: location, hse: hisexp, hids: hideclist, hde: hidexp): hidexp
// end of [hidexp_let_simplify]

(* ****** ****** *)

fun hidexp_app (
  loc: location
, hse: hisexp, hse_fun: hisexp, _fun: hidexp, _arg: hidexplst
) : hidexp // end of [hidexp_app]

fun hidexp_app2 (
  loc: location
, hse: hisexp, hse_fun: hisexp, _fun: hidexp, _arg: hidexplst
) : hidexp // end of [hidexp_app2]

(* ****** ****** *)

fun hidexp_if (
  loc: location
, hse: hisexp, _cond: hidexp, _then: hidexp, _else: hidexp
) : hidexp // end of [hidexp_if]

fun hidexp_sif (
  loc: location
, hse: hisexp, _cond: s2exp, _then: hidexp, _else: hidexp
) : hidexp // end of [hidexp_sif]

(* ****** ****** *)

fun hidexp_case (
  loc: location
, hse: hisexp, knd: caskind, hdes: hidexplst, hcls: hiclaulst
) : hidexp // end of [hidexp_case]

(* ****** ****** *)

fun hidexp_lst (
  loc: location
, hse: hisexp, lin: int, hse_elt: hisexp, hdes: hidexplst
) : hidexp // end of [hidexp_lst]

fun hidexp_rec (
  loc: location
, hse: hisexp, knd: int, lhses: labhidexplst, hse_rec: hisexp
) : hidexp // end of [hidexp_rec]

fun hidexp_seq
  (loc: location, hse: hisexp, hdes: hidexplst): hidexp
// end of [hidexp_seq]

(* ****** ****** *)

fun hidexp_selab (
  loc: location
, hse: hisexp, hde: hidexp, hse_flt: hisexp, hils: hilablst
) : hidexp // end of [hidexp_selab]

(* ****** ****** *)

fun hidexp_ptrofvar
  (loc: location, hse: hisexp, d2v: d2var): hidexp
fun hidexp_ptrofsel (
  loc: location
, hse: hisexp, hde: hidexp, hse_rt: hisexp, hils: hilablst
) : hidexp // end of [hidexp_ptrofsel]

(* ****** ****** *)

fun hidexp_refarg
(
  loc: location, hse: hisexp, refval: int, freeknd: int, hde: hidexp
) : hidexp // end of [hidexp_refarg]

(* ****** ****** *)

fun hidexp_selvar
(
  loc: location
, hse: hisexp, d2v: d2var, hse_rt: hisexp, hils: hilablst
) : hidexp // end of [hidexp_selvar]

fun hidexp_selptr
(
  loc: location
, hse: hisexp, hde: hidexp, hse_rt: hisexp, hils: hilablst
) : hidexp // end of [hidexp_selptr]

(* ****** ****** *)

fun hidexp_assgn_var (
  loc: location
, hse: hisexp, d2v_l: d2var, hse_rt: hisexp, hils: hilablst, hde_r: hidexp
) : hidexp // end of [hidexp_assgn_var]

fun hidexp_assgn_ptr (
  loc: location
, hse: hisexp, hde_l: hidexp, hse_rt: hisexp, hils: hilablst, hde_r: hidexp
) : hidexp // end of [hidexp_assgn_ptr]

(* ****** ****** *)

fun hidexp_xchng_var
(
  loc: location, hse: hisexp
, d2v_l: d2var, hse_rt: hisexp, hils: hilablst, hde_r: hidexp
) : hidexp // end of [hidexp_xchng_var]

fun hidexp_xchng_ptr
(
  loc: location, hse: hisexp
, hde_l: hidexp, hse_rt: hisexp, hils: hilablst, hde_r: hidexp
) : hidexp // end of [hidexp_xchng_ptr]

(* ****** ****** *)

fun hidexp_arrpsz
(
  loc: location, hse: hisexp
, hse_elt: hisexp, hdes_elt: hidexplst, asz: int
) : hidexp // end of [hidexp_arrpsz]

fun hidexp_arrinit
(
  loc: location, hse: hisexp
, hse_elt: hisexp, hde_asz: hidexp, hdes_elt: hidexplst, asz: int
) : hidexp // end of [hidexp_arrinit]

(* ****** ****** *)

fun hidexp_raise
  (loc: location, hse: hisexp, hde_exn: hidexp): hidexp
// end of [hidexp_raise]

(* ****** ****** *)

fun hidexp_lam
(
  loc: location, hse: hisexp, knd: int, hips: hipatlst, hde: hidexp
) : hidexp // end of [hidexp_lam]

(* ****** ****** *)

fun hidexp_fix
(
  loc: location, hse: hisexp, knd: int, f_d2v: d2var, hde_def: hidexp
) : hidexp // end of [hidexp_fix]

(* ****** ****** *)
//
fun hidexp_delay
  (loc: location, hse: hisexp, hde: hidexp): hidexp
fun hidexp_ldelay
  (loc: location, hse: hisexp, _eval: hidexp, _free: hidexp): hidexp
//
fun hidexp_lazyeval
  (loc: location, hse: hisexp, lin: int, hde: hidexp): hidexp
//
(* ****** ****** *)

fun hidexp_loop
(
  loc: location, hse: hisexp
, init: hidexpopt, test: hidexp, post: hidexpopt, body: hidexp
) : hidexp // end of [hidexp_loop]

fun hidexp_loopexn
  (loc: location, hse: hisexp, knd: int): hidexp
// end of [hidexp_loopexn]

(* ****** ****** *)

fun hidexp_trywith
(
  loc: location, hse: hisexp, _try: hidexp, _with: hiclaulst
) : hidexp // end of [hidexp_trywith]

(* ****** ****** *)

fun hidexp_errexp (loc: location, hse: hisexp): hidexp

(* ****** ****** *)

(*
fun un_hidexp_int (hde_int: hidexp): Option_vt (int)
*)

(* ****** ****** *)

fun hilab_lab (loc: location, lab: label): hilab
fun hilab_ind (loc: location, ind: hidexplst): hilab

(* ****** ****** *)

fun higmat_make
  (loc: location, hde: hidexp, opt: hipatopt): higmat
fun hiclau_make
(
  loc: location
, hips: hipatlst, gua: higmatlst, seq: int, neg: int, body: hidexp
) : hiclau // end of [hiclau_make]

(* ****** ****** *)

fun hifundec_make
(
  loc: location, d2v: d2var, imparg: s2varlst, def: hidexp
) : hifundec // end of [hifundec_make]

fun hifundec_get_hideclopt (hfd: hifundec): hideclopt

fun hifundec_getref_hideclopt
  (hfd: hifundec): Ptr1 = "patsopt_hifundec_getref_hideclopt"
fun hifundec_getref_funlabopt
  (hfd: hifundec): Ptr1 = "patsopt_hifundec_getref_funlabopt"

fun hifundeclst_set_hideclopt (hfds: hifundeclst, opt: hideclopt): void

(* ****** ****** *)

fun hivaldec_make
  (loc: location, pat: hipat, def: hidexp): hivaldec
// end of [hivaldec_make]

fun hivardec_make
(
  loc: location, knd: int
, d2v: d2var, d2vw: d2var, type: hisexp, init: hidexpopt
) : hivardec // end of [hivardec_make]

(* ****** ****** *)

fun hiimpdec_make
(
  loc: location
, d2c: d2cst, imparg: s2varlst, tmparg: s2explstlst, def: hidexp
) : hiimpdec // end of [hiimpdec_make]

fun hiimpdec_getref_funlabopt
  (imp: hiimpdec): Ptr1 = "patsopt_hiimpdec_getref_funlabopt"
// end of [hiimpdec_getref_funlabopt]

fun hiimpdec_getref_instrlstopt
  (imp: hiimpdec): Ptr1 = "patsopt_hiimpdec_getref_instrlstopt"
// end of [hiimpdec_getref_instrlstopt]

(* ****** ****** *)

fun hidecl_make_node
  (loc: location, node: hidecl_node): hidecl
// end of [hidecl_make_node]

(* ****** ****** *)

fun hidecl_is_empty (hid: hidecl): bool

(* ****** ****** *)

fun hidecl_none (loc: location): hidecl
fun hidecl_list (loc: location, hids: hideclist): hidecl

fun hidecl_saspdec (loc: location, d2c: s2aspdec): hidecl

(* ****** ****** *)

fun hidecl_extype
  (loc: location, name: string, hse_def: hisexp): hidecl
fun hidecl_extval
  (loc: location, name: string, hde_def: hidexp): hidecl

fun hidecl_extcode
  (loc: location, knd: int, pos: int, code: string): hidecl
// end of [hidecl_extcode]

(* ****** ****** *)

fun hidecl_exndecs
  (loc: location, d2cs: d2conlst) : hidecl

fun hidecl_datdecs
  (loc: location, knd: int, s2cs: s2cstlst) : hidecl
// end of [hidecl_datdecs]

(* ****** ****** *)

fun hidecl_dcstdecs
(
  loc: location, dck: dcstkind, d2cs: d2cstlst
) : hidecl // end of [hidecl_dcstdecs]

fun hidecl_impdec
  (loc: location, knd: int, himp: hiimpdec): hidecl
// end of [hidecl_impdec]

fun hidecl_fundecs
(
  loc: location, knd: funkind, decarg: s2qualst, hfds: hifundeclst
) : hidecl // end of [hidecl_fundecs]

fun hidecl_valdecs
  (loc: location, knd: valkind, hvds: hivaldeclst): hidecl
// end of [hidecl_valdecs]

fun hidecl_valdecs_rec
  (loc: location, knd: valkind, hvds: hivaldeclst): hidecl
// end of [hidecl_valdecs_rec]

fun hidecl_vardecs (loc: location, hvds: hivardeclst): hidecl

(* ****** ****** *)

fun hidecl_include
  (loc: location, stadyn: int, hids: hideclist): hidecl
// end of [hidecl_include]

(* ****** ****** *)

fun hidecl_staload
(
  loc: location
, idopt: symbolopt
, fname: filename, flag: int, fenv: filenv, loaded: int
) : hidecl // end of [hidecl_staload]

fun hidecl_staloadloc
(
  loc: location, pfil: filename, nspace: symbol, hids: hideclist
) : hidecl // end of [hidecl_staloadloc]

(* ****** ****** *)

fun hidecl_dynload (loc: location, cfil: filename): hidecl

(* ****** ****** *)
      
fun hidecl_local
  (loc: location, head: hideclist, body: hideclist): hidecl
// end of [hidecl_local]

(* ****** ****** *)
//
typedef
tmpcstimpmap = d2cstmap (hiimpdeclst)
typedef
tmpcstimpmapopt = Option (tmpcstimpmap)
//
fun tmpcstimpmap_find
  (map: tmpcstimpmap, d2c: d2cst): hiimpdeclst
//
fun tmpcstimpmap_insert
  (map: &tmpcstimpmap, imp: hiimpdec): void
//
fun filenv_get_tmpcstimpmapopt (fenv: filenv): tmpcstimpmapopt
//
(* ****** ****** *)
//
typedef
tmpvardecmap = d2varmap (hifundec)
typedef
tmpvardecmapopt = Option (tmpvardecmap)
//
fun tmpvardecmap_find
  (map: tmpvardecmap, d2v: d2var): Option_vt (hifundec)
//
fun tmpvardecmap_insert
  (map: &tmpvardecmap, hfd: hifundec): void
fun tmpvardecmap_inserts
  (map: &tmpvardecmap, hfds: hifundeclst): void
//
fun filenv_get_tmpvardecmapopt (fenv: filenv): tmpvardecmapopt
//
(* ****** ****** *)

(* end of [pats_hidynexp.sats] *)
