(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: April, 2011
//
(* ****** ****** *)

staload "pats_basics.sats"
staload "pats_syntax.sats"
staload "pats_staexp1.sats"

(* ****** ****** *)

datatype p1at_node =
//
  | P1Tany of () // wildcard: (_)
  | P1Tanys of () // wildcards: _
  | P1Tdqid of // constructor (qualified) / variable (unqualified)
      (d0ynq, symbol)
  | P1Tref of symbol // refvar pattern
//
  | P1Tint of i0nt  // int constant
  | P1Tchar of c0har // char constant
  | P1Tfloat of f0loat // floating point constant
  | P1Tstring of s0tring // string constant
  | P1Tempty of () // empty pattern
//
  | P1Tapp_sta of (p1at, s1vararglst) // static application
  | P1Tapp_dyn of (p1at, location(*arg*), int(*npf*), p1atlst) // constructor
//
  | P1Tlist of (int (*pfarity*), p1atlst) // pattern list
//
  | P1Tlst of p1atlst // list pattern
  | P1Ttup of (* boxed/unboxed tuples *)
      (int (*tupknd*), int (*pfarity*), p1atlst)
  | P1Trec of (* boxed/unboxed records *)
      (int (*recknd*), int (*pfarity*), labp1atlst)
//
  | P1Tfree of p1at (* freed constructor *)
//
  | P1Tas of (symbol, p1at) // [as] pattern
  | P1Trefas of (symbol, p1at) // refvar [as] pattern
//
  | P1Texist of (s1arglst, p1at) // existentially qualified
  | P1Tsvararg of s1vararg (* static argument *)
//
  | P1Tann of (p1at, s1exp(*ann*)) // ascribed pattern
// end of [p1at_node]

and labp1at_node =
  | LABP1ATnorm of (l0ab, p1at) | LABP1ATomit of ()
// end of [labp1at_node]

where p1at = '{
  p1at_loc= location, p1at_node= p1at_node
}
and p1atlst = List (p1at)
and p1atopt = Option (p1at)

and labp1at = '{
  labp1at_loc= location, labp1at_node= labp1at_node
}
and labp1atlst = List (labp1at)

(* ****** ****** *)

fun p1at_any (loc: location): p1at
fun p1at_anys (loc: location): p1at
fun p1at_ide (_: location, id: symbol): p1at
fun p1at_dqid (loc: location, dq: d0ynq, id: symbol): p1at
fun p1at_ref (loc: location, id: symbol): p1at

fun p1at_int (loc: location, int: i0nt): p1at
fun p1at_char (loc: location, char: c0har): p1at
fun p1at_float (loc: location, char: f0loat): p1at
fun p1at_string (loc: location, char: s0tring): p1at
fun p1at_empty (loc: location): p1at

fun p1at_app_dyn (
  loc: location
, p1t: p1at, loc_arg: location, npf: int, p1ts: p1atlst
) : p1at // end of [p1at_app_dyn]
fun p1at_app_sta
  (loc: location, p1t: p1at, s1as: s1vararglst): p1at
// end of [p1at_app_sta]

fun p1at_list (loc: location, npf: int, xs: p1atlst): p1at

fun p1at_lst (loc: location, xs: p1atlst): p1at
fun p1at_tup (loc: location, knd: int, npf: int, xs: p1atlst): p1at
fun p1at_rec (loc: location, knd: int, npf: int, xs: labp1atlst): p1at

fun p1at_free (loc: location, p1t: p1at): p1at

fun p1at_as (loc: location, id: symbol, p1t: p1at): p1at
fun p1at_refas (loc: location, id: symbol, p1t: p1at): p1at

fun p1at_exist
  (loc: location, arg: s1arglst, p1t: p1at): p1at
fun p1at_svararg (loc: location, arg: s1vararg): p1at

fun p1at_ann (loc: location, p1t: p1at, s1e: s1exp): p1at

fun fprint_p1at : fprint_type (p1at)
fun fprint_p1atlst : fprint_type (p1atlst)

fun fprint_labp1at : fprint_type (labp1at)

(* ****** ****** *)

typedef
i1nvarg = '{
  i1nvarg_loc= location
, i1nvarg_sym= symbol
, i1nvarg_typ= s1expopt
} // end of [i1nvarg]

typedef i1nvarglst = List i1nvarg

typedef i1nvresstate = '{
 i1nvresstate_qua= s1qualst, i1nvresstate_arg= i1nvarglst
} // end of [i1nvresstate]

typedef
loopi1nv = '{
  loopi1nv_loc= location
, loopi1nv_qua= s1qualst (* quantifier *)
, loopi1nv_met= s1explstopt (* metric *)
, loopi1nv_arg= i1nvarglst (* argument *)
, loopi1nv_res= i1nvresstate (* result *)
} // end of [loopi1nv]

(* ****** ****** *)

fun i1nvarg_make
  (loc: location, id: symbol, opt: s1expopt): i1nvarg
// end of [i1nvarg_make]

fun i1nvresstate_make
  (s1qs: s1qualst, arg: i1nvarglst): i1nvresstate
val i1nvresstate_nil: i1nvresstate

fun loopi1nv_make (
  loc: location
, qua: s1qualst, met: s1explstopt, arg: i1nvarglst, res: i1nvresstate
) : loopi1nv // end of [loopi1nv_make]

fun loopi1nv_nil (loc0: location): loopi1nv

(* ****** ****** *)

typedef intlst = List (int)

(* ****** ****** *)

datatype d1ecl_node =
  | D1Cnone
  | D1Clist of d1eclist
//
  | D1Csymintr of (* overloaded symbol intr *)
      i0delst
  | D1Csymelim of (* overloaded symbol elim *)
      i0delst
  | D1Coverload of (i0de, dqi0de) // overloading declaration
//
  | D1Ce1xpdef of (symbol, e1xp)
  | D1Ce1xpundef of (symbol) // HX: undefining
//
  | D1Cdatsrts of d1atsrtdeclst // datasorts
  | D1Csrtdefs of s1rtdeflst // sort definitions
  | D1Cstacsts of s1tacstlst // static constants
  | D1Cstacons of (int(*knd*), s1taconlst) // static constructors
  | D1Cstavars of s1tavarlst // static variables
  | D1Csexpdefs of (int(*knd*), s1expdeflst) // static definitions
  | D1Csaspdec of s1aspdec // static assumption
//
  | D1Cdatdecs of (int(*knd*), d1atdeclst, s1expdeflst) // DT declarations
  | D1Cexndecs of e1xndeclst // exception declaration
//
  | D1Cclassdec of (i0de, s1expopt)
//
  | D1Cextype of (* external type *)
      (string (*name*), s1exp (*definition*))
  | D1Cextype of (* external type *)
      (int(*knd*), string (*name*), s1exp (*definition*))
  | D1Cextval of (* external value *)
      (string (*name*), d1exp (*definition*))
  | D1Cextcode of (
      int (*knd: 0/1*), int (*pos: 0/1/2 : top/?/end*), string (*code*)
    ) // end of [D1Cextcode]
//
  | D1Cdcstdecs of (dcstkind, q1marglst, d1cstdeclst) // dyn constants
//
  | D1Cmacdefs of (int(*knd*), bool(*isrec*), m1acdeflst)
  | D1Cvaldecs of (valkind, bool(*isrec*), v1aldeclst) // val declarations
  | D1Cfundecs of (funkind, q1marglst, f1undeclst) // function declaration
  | D1Cvardecs of v1ardeclst (* variable declaration *)
  | D1Cimpdec of (s1marglst, i1mpdec) (* implementation *)
//
  | D1Cinclude of d1eclist (* inclusion *)
  | D1Cstaload of (* staloading a file *)
      (Option symbol, filename, int (*loadflag*), d1eclist)
  | D1Cdynload of filename (* dynloading a file *)
//
  | D1Clocal of (d1eclist(*head*), d1eclist(*body*)) // local declaration
// end of [d1ecl_node]

and d1exp_node =
//
  | D1Edqid of (d0ynq, symbol) // qualified ids
//
  | D1Eint of i0nt // dynamic integers
  | D1Ebool of bool // boolean constants
  | D1Echar of c0har // dynamic characters
  | D1Efloat of f0loat (* dynamic floats *)
  | D1Estring of s0tring (* dynamic strings *)
  | D1Ecstsp of cstsp // special constants
  | D1Eempty (* empty expression *)
  | D1Etop of () // uninitialized expression
//
  | D1Eextval of
      (s1exp (*type*), string (*code*)) // external value
    // end of [D1Eextval]
//
  | D1Eloopexn of int(*knd*)
//
  | D1Edecseq of // decseq as exp
      d1eclist (* HX: note that there is no [D2Edecseq] *)
//
  | D1Efoldat of (* fold at a given address *)
      (s1exparglst, d1exp)
  | D1Efreeat of (* free at a given address *)
      (s1exparglst, d1exp)
//
  | D1Etmpid of (dqi0de, t1mpmarglst) (* template instantiation *)
//
  | D1Elet of (d1eclist, d1exp(*body*))
  | D1Ewhere of (d1exp(*body*), d1eclist)
//
  | D1Eapp_dyn of (* dynamic application *)
      (d1exp, location(*arg*), int (*pfarity*), d1explst)
  | D1Eapp_sta of (* static application *)
      (d1exp, s1exparglst)
  | D1Eidextapp of (symbol, intlst(*ns*), d1explst) // ns: arity list
//
  | D1Elist of (int(*pfarity*), d1explst) // temporary
//
  | D1Eifhead of
      (i1nvresstate, d1exp, d1exp, d1expopt)
  | D1Esifhead of
      (i1nvresstate, s1exp, d1exp, d1exp) // HX: no dangling else-branch
  | D1Ecasehead of (* case-expression *)
      (caskind, i1nvresstate, d1explst, c1laulst)
  | D1Escasehead of (i1nvresstate, s1exp, sc1laulst)
//
  | D1Elst of (* dynamic list-expression *)
      (int (*lin*), s1expopt, d1explst)
  | D1Etup of (* dynamic tuple-expression *)
      (int (*tupknd*), int (*pfarity*), d1explst)
  | D1Erec of (* dynamic record-expression *)
      (int (*recknd*), int (*pfarity*), labd1explst)
  | D1Eseq of (* dynamic sequence-expression *)
      d1explst
//
  | D1Earrsub of (* array subscription *)
      (d1exp, location(*ind*), d1explstlst(*ind*))
  | D1Earrinit of (* array initialization *)
      (s1exp (*eltyp*), d1expopt (*asz*), d1explst (*elt*))
  | D1Earrsize of (* arraysize expression *)
      (s1expopt (*element type*), d1explst (*elements*))
//
  | D1Eraise of d1exp // raised exception
  | D1Edelay of (int(*knd*), d1exp(*body*)) // $delay and $ldelay
//
  | D1Eptrof of d1exp // taking the address of
  | D1Eviewat of d1exp // taking view at a given address
  | D1Esel of (int(*knd*), d1exp, d1lab)
//
  | D1Esexparg of s1exparg (* for temporary use *)
  | D1Eexist of (s1exparg, d1exp) // witness-carrying expression
//
  | D1Elam_dyn of (* dynamic abstraction: alloc/init *)
      (int (*lin*), p1at, d1exp)
  | D1Elaminit_dyn of (* dynamic abstraction initialization *)
      (int (*lin*), p1at, d1exp)
  | D1Elam_met of (* metric abstraction *)
      (location (*loc_arg*), s1explst, d1exp)
  | D1Elam_sta_ana of (* static abstraction: analysis *)
      (location (*loc_arg*), s1arglst, d1exp)
  | D1Elam_sta_syn of (* static abstraction: synthesis *)
      (location (*loc_arg*), s1qualst, d1exp)
  | D1Efix of // dynamic fixed-point expression
      (int(*knd: 0/1: flat/boxed*), i0de, d1exp)
//
  | D1Etrywith of (i1nvresstate, d1exp, c1laulst)
//
  | D1Efor of ( // for-loop
      loopi1nv
    , d1exp(*ini*)
    , d1exp(*test*)
    , d1exp(*post*)
    , d1exp(*body*)
    ) // end of [D1Efor]
  | D1Ewhile of (loopi1nv, d1exp, d1exp) // while-loop
//
  | D1Emacsyn of (macsynkind, d1exp) // macro syntax
//
  | D1Eann_effc of (* ascribed with effects *)
      (d1exp, effcst)
  | D1Eann_funclo of (* ascribed with funtype *)
      (d1exp, funclo)
  | D1Eann_type of (* ascribed dynamic expressions *)
      (d1exp, s1exp)
// end of [d1exp_node]

and d1lab_node =
  | D1LABlab of label | D1LABind of d1explstlst
// end of [d1lab_node]

(* ****** ****** *)

where d1ecl = '{
  d1ecl_loc= location, d1ecl_node= d1ecl_node
} // end of [d1ec]

and d1eclist = List (d1ecl)

(* ****** ****** *)

and d1exp = '{
  d1exp_loc= location, d1exp_node= d1exp_node
}
and d1explst = List (d1exp)
and d1expopt = Option (d1exp)
and d1explstlst = List (d1explst)

and labd1exp = l0abeled (d1exp)
and labd1explst = List (labd1exp)

(* ****** ****** *)

and d1lab = '{
  d1lab_loc= location, d1lab_node= d1lab_node
}

(* ****** ****** *)

and m1atch = '{
  m1atch_loc= location, m1atch_exp= d1exp, m1atch_pat= p1atopt
} // end of [m1atch]

and m1atchlst = List m1atch

(* ****** ****** *)

and c1lau = '{
  c1lau_loc= location
, c1lau_pat= p1at
, c1lau_gua= m1atchlst
, c1lau_seq= int
, c1lau_neg= int
, c1lau_exp= d1exp
} // end of [c1lau]

and c1laulst = List c1lau

(* ****** ****** *)

and sc1lau = '{
  sc1lau_loc= location
, sc1lau_pat= sp1at
, sc1lau_exp= d1exp
} // end of [sc1lau]

and sc1laulst = List sc1lau

(* ****** ****** *)

and m1acdef = '{
  m1acdef_loc= location
, m1acdef_sym= symbol
, m1acdef_arg= m0acarglst // HX: yes: m0acarglst
, m1acdef_def= d1exp
} // end of [m1acdef]

and m1acdeflst = List m1acdef

(* ****** ****** *)

and v1aldec = '{
  v1aldec_loc= location
, v1aldec_pat= p1at
, v1aldec_def= d1exp
, v1aldec_ann= witht1ype
} // end of [v1aldec]

and v1aldeclst = List (v1aldec)

(* ****** ****** *)

and f1undec = '{
  f1undec_loc= location
, f1undec_sym= symbol
, f1undec_sym_loc= location
, f1undec_def= d1exp
, f1undec_ann= witht1ype
} // end of [f1undec]

and f1undeclst = List f1undec

(* ****** ****** *)

and v1ardec = '{
  v1ardec_loc= location
, v1ardec_knd= int (* BANG: knd = 1 *)
, v1ardec_sym= symbol
, v1ardec_sym_loc= location
, v1ardec_typ= s1expopt
, v1ardec_wth= i0deopt
, v1ardec_ini= d1expopt
} // end of [v1ardec]

and v1ardeclst = List v1ardec

(* ****** ****** *)

and i1mpdec = '{
  i1mpdec_loc= location
, i1mpdec_qid= impqi0de
, i1mpdec_tmparg= t1mpmarglst
, i1mpdec_def= d1exp
} // end of [i1mpdec]

(* ****** ****** *)
//
// HX: dynamic expressions
//
(* ****** ****** *)

fun d1exp_ide (loc: location, id: symbol): d1exp
fun d1exp_dqid
  (loc: location, dq: d0ynq, id: symbol): d1exp
// end of [d1exp_dqid]
fun d1exp_opid (loc: location, id: symbol): d1exp

fun d1exp_int (loc: location, x: i0nt): d1exp
fun d1exp_char (loc: location, x: c0har): d1exp
fun d1exp_float (loc: location, x: f0loat): d1exp
fun d1exp_string (loc: location, x: s0tring): d1exp
fun d1exp_cstsp (loc: location, x: cstsp): d1exp
fun d1exp_empty (loc: location): d1exp
fun d1exp_top (loc: location): d1exp

fun d1exp_extval
  (loc: location, _type: s1exp, _code: string): d1exp
// end of [d1exp_extval]

fun d1exp_loopexn (loc: location, knd: int): d1exp

fun d1exp_foldat
  (loc: location, arg: s1exparglst, d1e: d1exp): d1exp
fun d1exp_freeat
  (loc: location, arg: s1exparglst, d1e: d1exp): d1exp

fun d1exp_tmpid
  (loc: location, qid: dqi0de, decarg: t1mpmarglst): d1exp
// end of [d1exp_tmpid]

(* ****** ****** *)

fun d1exp_let (
  loc: location, d1cs: d1eclist, body: d1exp
) : d1exp // end of [d1exp_let]

fun d1exp_where (
  loc: location, body: d1exp, d1cs: d1eclist
) : d1exp // end of [d1exp_where]

(* ****** ****** *)

fun d1exp_app_sta (
  loc: location, d1e: d1exp, s1as: s1exparglst
) : d1exp // end of [d1exp_app_sta]

fun d1exp_app_dyn (
  loc: location
, d1e: d1exp, loc_arg: location, npf: int, d1es: d1explst
) : d1exp // end of [d1exp_app_dyn]

fun d1exp_idextapp (
  loc: location, id: symbol, ns: intlst, d1es: d1explst
) : d1exp // end of [d1exp_idextapp]

(* ****** ****** *)

fun d1exp_list
  (loc: location, npf: int, d1es: d1explst): d1exp
// end of [d1exp_list]

(* ****** ****** *)

fun d1exp_ifhead (
  loc: location
, inv: i1nvresstate
, _cond: d1exp
, _then: d1exp
, _else: d1expopt
) : d1exp // end of [d1exp_if]

fun d1exp_sifhead (
  loc: location
, inv: i1nvresstate
, _cond: s1exp
, _then: d1exp
, _else: d1exp
) : d1exp // end of [d1exp_if]

fun d1exp_casehead (
  loc: location
, knd: caskind
, inv: i1nvresstate
, d1es: d1explst, c1las: c1laulst
) : d1exp // end of [d1exp_casehead]

fun d1exp_scasehead (
  loc: location
, inv: i1nvresstate
, s1e: s1exp, c1las: sc1laulst
) : d1exp // end of [d1exp_scasehead]

(* ****** ****** *)

fun d1exp_lst (
  loc: location, knd: int, elt: s1expopt, d1es: d1explst
) : d1exp // end of [d1exp_lst]
fun d1exp_tup (
  loc: location, knd: int, npf: int, d1es: d1explst
) : d1exp // end of [d1exp_tup]
fun d1exp_rec (
  loc: location, knd: int, npf: int, ld1es: labd1explst
) : d1exp // end of [d1exp_rec]
fun d1exp_seq (loc: location, d1es: d1explst): d1exp

(* ****** ****** *)

fun d1exp_arrsub
  (loc: location, arr: d1exp, ind: location, ind: d1explstlst): d1exp
// end of [d1exp_arrsub]

fun d1exp_arrinit (
  loc: location, elt: s1exp, asz: d1expopt, d1es: d1explst
) : d1exp // end of [d1exp_arrinit]

fun d1exp_arrsize
  (loc: location, elt: s1expopt, d1es: d1explst): d1exp
// end of [d1exp_arrsize]

(* ****** ****** *)

fun d1exp_sexparg (loc: location, s1a: s1exparg): d1exp
fun d1exp_exist (loc: location, s1a: s1exparg, d1e: d1exp): d1exp

(* ****** ****** *)

fun d1exp_lam_dyn
  (loc: location, lin: int, arg: p1at, body: d1exp): d1exp

fun d1exp_laminit_dyn
  (loc: location, lin: int, arg: p1at, body: d1exp): d1exp

fun d1exp_lam_met (
  loc: location, loc_arg: location, met: s1explst, body: d1exp
) : d1exp // end of [d1exp_lam_met]

fun d1exp_lam_sta_ana (
  loc: location, loc_arg: location, arg: s1arglst, body: d1exp
) : d1exp // end of [d1exp_lam_sta_ana]

fun d1exp_lam_sta_syn (
  loc: location, loc_arg: location, arg: s1qualst, body: d1exp
) : d1exp // end of [d1exp_lam_sta_syn]

fun d1exp_fix
  (loc: location, knd: int, id: i0de, d1e: d1exp): d1exp
// end of [d1exp_fix]

(* ****** ****** *)

fun d1exp_raise (loc: location, d1e: d1exp): d1exp
fun d1exp_delay (loc: location, knd: int, d1e: d1exp): d1exp

(* ****** ****** *)

fun d1exp_ptrof (loc: location, d1e: d1exp): d1exp
fun d1exp_viewat (loc: location, d1e: d1exp): d1exp

(* ****** ****** *)

fun d1exp_sel
  (loc: location, kind: int, root: d1exp, lab: d1lab): d1exp
// end of [d1exp_sel]

(* ****** ****** *)

fun d1exp_trywith (
  loc: location, inv: i1nvresstate, d1e: d1exp, handler: c1laulst
) : d1exp // end of [d1exp_trywith]

(* ****** ****** *)

fun d1exp_for (
  loc: location
, inv: loopi1nv
, init: d1exp, test: d1exp, post: d1exp, body: d1exp
) : d1exp // end of [d1exp_for]

fun d1exp_while (
  loc: location, inv: loopi1nv, test: d1exp, body: d1exp
) : d1exp // end of [d1exp_while]

(* ****** ****** *)

fun d1exp_macsyn
  (loc: location, knd: macsynkind, d1e: d1exp): d1exp
// end of [d1exp_macsyn]

(* ****** ****** *)

fun d1exp_ann_effc
  (loc: location, d1e: d1exp, efc: effcst): d1exp
fun d1exp_ann_funclo
  (loc: location, d1e: d1exp, fc: funclo): d1exp
fun d1exp_ann_funclo_opt
  (loc: location, d1e: d1exp, fc: funclo): d1exp
fun d1exp_ann_type (loc: location, d1e: d1exp, s1e: s1exp): d1exp

(* ****** ****** *)

fun fprint_d1exp : fprint_type (d1exp)
fun print_d1exp (x: d1exp): void
and prerr_d1exp (x: d1exp): void

fun fprint_d1explst : fprint_type (d1explst)
fun fprint_d1expopt : fprint_type (d1expopt)

(* ****** ****** *)

fun labd1exp_make (l: l0ab, d1e: d1exp): labd1exp

fun fprint_labd1exp : fprint_type (labd1exp)
fun fprint_labd1explst : fprint_type (labd1explst)

(* ****** ****** *)

fun d1exp_is_metric (d1e: d1exp): bool
fun d1exp_make_e1xp (loc: location, exp: e1xp): d1exp

(* ****** ****** *)

fun d1lab_lab (loc: location, lab: label): d1lab
fun d1lab_ind (loc: location, ind: d1explstlst): d1lab

(* ****** ****** *)

fun m1atch_make
  (loc: location, d1e: d1exp, opt: p1atopt): m1atch
// end of [m1atch_make]

fun c1lau_make (
  loc: location
, pat: p1at, gua: m1atchlst, seq: int, neg: int, body: d1exp
) : c1lau // end of [c1lau_make]

fun sc1lau_make
  (loc: location, pat: sp1at, body: d1exp): sc1lau
// end of [sc1lau_make]

(* ****** ****** *)
//
// HX: for supporting syndef
//
(* ****** ****** *)

typedef
fsyndef = (location, d1explst) -<fun1> d1exp

fun d1exp_app_syndef (
  loc: location, d1e_fun: d1exp, d1e_arg: d1exp
) : d1exp // end of [d1exp_app_syndef]

fun d1exp_idextapp_resolve (loc0: location, d1e: d1exp): d1exp

(* ****** ****** *)
//
// HX: for various itemized declarations
//
(* ****** ****** *)

fun m1acdef_make (
  loc: location, id: symbol, arg: m0acarglst, def: d1exp
) : m1acdef // end of [m1acdef_make]

(* ****** ****** *)

fun v1aldec_make
  (loc: location, pat: p1at, def: d1exp, typ: witht1ype): v1aldec
// end of [v1aldec_make]

fun f1undec_make (
  loc: location, id: symbol, loc_id: location, def: d1exp, typ: witht1ype
) : f1undec // end of [f1undec_make]

fun v1ardec_make (
  loc: location
, knd: int (* BANG: knd = 1 *)
, id: symbol, loc_id: location
, typ: s1expopt, wth: i0deopt, def: d1expopt
) : v1ardec // end of [v1ardec_make]

fun i1mpdec_make
  (loc: location, qid: impqi0de, tmparg: t1mpmarglst, def: d1exp): i1mpdec
// end of [i1mpdec_make]

(* ****** ****** *)
//
// HX: declarations
//
(* ****** ****** *)

fun d1ecl_none (loc: location): d1ecl

fun d1ecl_list (loc: location, ds: d1eclist): d1ecl

fun d1ecl_symintr (loc: location, ids: i0delst): d1ecl
fun d1ecl_symelim (loc: location, ids: i0delst): d1ecl
fun d1ecl_overload (loc: location, id: i0de, qid: dqi0de): d1ecl

fun d1ecl_e1xpdef
  (loc: location, id: symbol, def: e1xp): d1ecl
fun d1ecl_e1xpundef (loc: location, id: symbol): d1ecl

fun d1ecl_datsrts (loc: location, ds: d1atsrtdeclst): d1ecl

fun d1ecl_srtdefs (loc: location, ds: s1rtdeflst): d1ecl

fun d1ecl_stacsts (loc: location, ds: s1tacstlst): d1ecl
fun d1ecl_stacons (loc: location, knd: int, ds: s1taconlst): d1ecl
fun d1ecl_stavars (loc: location, ds: s1tavarlst): d1ecl

fun d1ecl_sexpdefs
  (loc: location, knd: int, ds: s1expdeflst): d1ecl
// end of [d1ecl_sexpdefs]

fun d1ecl_saspdec (loc: location, d: s1aspdec): d1ecl

fun d1ecl_datdecs (
  loc: location, knd: int, ds1: d1atdeclst, ds2: s1expdeflst
) : d1ecl // end of [d1ecl_datdecs]

fun d1ecl_exndecs (loc: location, ds: e1xndeclst): d1ecl

fun d1ecl_classdec (loc: location, id: i0de, sup: s1expopt): d1ecl

fun d1ecl_dcstdecs (
  loc: location, dck: dcstkind, qarg: q1marglst, ds: d1cstdeclst
) : d1ecl // end of [d1ec_dcstdecs]

fun d1ecl_extype (
  loc: location, name: string, def: s1exp
) : d1ecl // end of [d1ecl_extype]
fun d1ecl_extype2 (
  loc: location, knd: int, name: string, def: s1exp
) : d1ecl // end of [d1ecl_extype]
fun d1ecl_extval (
  loc: location, name: string, def: d1exp
) : d1ecl // end of [d1ecl_extval]
fun d1ecl_extcode (
  loc: location, knd: int, pos: int, code: string
) : d1ecl // end of [d1ecl_extcode]

fun d1ecl_macdefs (
  loc: location, knd: int, isrec: bool, ds: m1acdeflst
) : d1ecl // end of [d1ecl_macdefs]

fun d1ecl_valdecs (
  loc: location, knd: valkind, isrec: bool, ds: v1aldeclst
) : d1ecl // end of [d1ecl_valdecs]

fun d1ecl_fundecs (
  loc: location, knd: funkind, qarg: q1marglst, ds: f1undeclst
) : d1ecl // end of [d1ecl_fundecs]

fun d1ecl_vardecs (loc: location, ds: v1ardeclst): d1ecl

fun d1ecl_impdec
  (loc: location, decarg: s1marglst, d1c: i1mpdec): d1ecl
// end of [d1ecl_impdec]

(* ****** ****** *)

fun d1ecl_include (loc: location, ds: d1eclist): d1ecl

fun
d1ecl_staload (
  loc: location
, idopt: symbolopt
, fil: filename
, loadflag: int
, d1cs: d1eclist
) : d1ecl // end of [d1ec_staload]

fun d1ecl_dynload (loc: location, fil: filename): d1ecl

(* ****** ****** *)

fun d1ecl_local (loc: location, ds1: d1eclist, ds2: d1eclist): d1ecl

(* ****** ****** *)

fun fprint_d1ecl : fprint_type (d1ecl)
fun fprint_d1eclist : fprint_type (d1eclist)

(* ****** ****** *)

(* end of [pats_dynexp1.sats] *)
