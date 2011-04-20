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

staload "pats_syntax.sats"
staload "pats_staexp1.sats"

(* ****** ****** *)

typedef fprint_type (a:t@ype) = (FILEref, a) -> void

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
  | P1Tapp_dyn of (p1at, location(*arg*), int, p1atlst)  // constructor
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
  | D1Cdcstdecs of (dcstkind, q1marglst, d1cstdeclst) // dyn constants
//
  | D1Cextype of (* external type *)
      (string (* extype name *), s1exp (* extype definition *))
  | D1Cextval of (* external type *)
      (string (* extval name *), d1exp (* extval definition *))
  | D1Cextcode of (
      int (*knd: 0/1*), int (*pos: 0/1/2 : top/?/end*), string (*code*)
    ) // end of [D1Cextcode]
(*
  | D1Cvaldecs of (* value declaration *)
      (valkind, v1aldeclst)
  | D1Cvaldecs_par of (* parallel value declaration *)
      v1aldeclst
  | D1Cvaldecs_rec of (* recursive value declaration *)
      v1aldeclst
  | D1Cfundecs of (* function declaration *)
      (funkind, s1qualstlst, f1undeclst)
  | D1Cvardecs of (* variable declaration *)
      v1ardeclst
  | D1Cmacdefs of (* macro declaration *)
      (int (*long/short*), m1acdeflst)
  | D1Cimpdec of (* implementation *)
      (s1arglstlst, i1mpdec)
*)
  | D1Cinclude of d1eclist (* inclusion *)
  | D1Cdynload of (* dynloading a file *)
      filename
  | D1Cstaload of (* staloading a file *)
      (Option symbol, filename, int (*loaded*), int (*loadflag*), d1eclist)
  | D1Clocal of (d1eclist(*head*), d1eclist(*body*)) // local declaration
// end of [d1ecl_node]

and d1exp_node =
//
  | D1Ebool of bool // boolean constants
  | D1Echar of c0har // dynamic character
  | D1Efloat of f0loat (* dynamic floats *)
  | D1Ecstsp of cstsp // special constants
  | D1Eempty (* empty expression *)
//
  | D1Edecseq of // decseq as exp
      d1eclist (* HX: note that there is no [D2Edecseq] *)
//
  | D1Edynload of (* dynamic loading *)
      filename
  | D1Eextval of (* external code *)
      (s1exp (*type*), string (*code*))
//
  | D1Eexist of (* existential sum *)
      (s1exparg, d1exp)
//
  | D1Efoldat of (* fold at a given address *)
      (s1exparglst, d1exp)
  | D1Efreeat of (* free at a given address *)
      (s1exparglst, d1exp)
//
  | D1Eapp_dyn of (* dynamic application *)
      (d1exp, location(*arg*), int (*pfarity*), d1explst)
  | D1Eapp_sta of (* static application *)
      (d1exp, s1exparglst)
//
  | D1Elist of (int(*pfarity*), d1explst) // temporary
//
  | D1Eifhead of
      (i1nvresstate, d1exp, d1exp, d1expopt)
  | D1Esifhead of
      (i1nvresstate, s1exp, d1exp, d1exp) // HX: no dangling else-branch
  | D1Ecasehead of
      (i1nvresstate, d1exp, c1laulst)
  | D1Escasehead of
     (i1nvresstate, s1exp, sc1laulst)
//
  | D1Elst of (* dynamic list expression *)
      (int (*lin*), s1expopt, d1explst)
  | D1Etup of (* dynamic tuple expression *)
      (int (*tupknd*), int (*pfarity*), d1explst)
  | D1Erec of (* dynamic record expression *)
      (int (*recknd*), int (*pfarity*), labd1explst)
//
  | D1Earrsub of (* array subscription *)
      (d1exp, location(*ind*), d1explstlst)
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
  | D1Efor of ( // for-loop
      loopi1nv
    , d1exp(*ini*)
    , d1exp(*test*)
    , d1exp(*post*)
    , d1exp(*body*)
    ) // end of [D1Efor]
  | D1Ewhile of (loopi1nv, d1exp, d1exp) // while-loop
//
  | D1Eann_effc of (* ascribed with effects *)
      (d1exp, effcst)
  | D1Eann_funclo of (* ascribed with funtype *)
      (d1exp, funclo)
  | D1Eann_type of (* ascribed dynamic expressions *)
      (d1exp, s1exp)
// end of [d1exp_node]

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

fun d1ecl_extcode (
  loc: location, knd: int, pos: int, code: string
) : d1ecl // end of [d1ecl_extcode]

fun d1ecl_include (loc: location, ds: d1eclist): d1ecl

fun d1ecl_local (loc: location, ds1: d1eclist, ds2: d1eclist): d1ecl

(* ****** ****** *)

fun fprint_d1ecl : fprint_type (d1ecl)
fun fprint_d1eclist : fprint_type (d1eclist)

(* ****** ****** *)

(* end of [pats_dynexp1.sats] *)
