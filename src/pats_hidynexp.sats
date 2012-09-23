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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: July, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"

(* ****** ****** *)

datatype
hipat_node =
  | HIPany of () // wildcard
  | HIPvar of (d2var) // mutability from the context
//
  | HIPint of int
  | HIPbool of bool
  | HIPchar of char
  | HIPstring of string
  | HIPfloat of string (* float point pattern *)
  | HIPempty of () // empty pattern
(*
  | HIPcon of (* constructor pattern *)
      (int (*freeknd*), d2con_t, hipatlst, hityp(*sum*))
  | HIPcon_any of (* constructor pattern with unused arg *)
      (int(*freeknd*), d2con_t)
  | HIPint of (* integer pattern *)
      (string, intinf_t)
*)
  | HIPrec of (* record pattern *)
      (int(*knd*), labhipatlst, hisexp(*tyrec*))
  | HIPlst of (hisexp(*element*), hipatlst)
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
  hipat_loc= location, hipat_type= hisexp, hipat_node= hipat_node
} // end of [hipat]

and hipatlst = List (hipat)
and hipatopt = Option (hipat)

and labhipatlst = List (labhipat)

(* ****** ****** *)

fun print_hipat (hip: hipat): void
overload print with print_hipat
fun prerr_hipat (hip: hipat): void
overload prerr with prerr_hipat
fun fprint_hipat : fprint_type (hipat)

fun fprint_hipatlst : fprint_type (hipatlst)
fun fprint_labhipatlst : fprint_type (labhipatlst)

(* ****** ****** *)

fun hipat_make_node
  (loc: location, hse: hisexp, node: hipat_node): hipat

fun hipat_any (loc: location, hse: hisexp): hipat
fun hipat_var (loc: location, hse: hisexp, d2v: d2var): hipat

fun hipat_int (loc: location, hse: hisexp, i: int): hipat
fun hipat_bool (loc: location, hse: hisexp, b: bool): hipat
fun hipat_char (loc: location, hse: hisexp, c: char): hipat
fun hipat_string (loc: location, hse: hisexp, str: string): hipat
fun hipat_float (loc: location, hse: hisexp, rep: string): hipat

fun hipat_empty (loc: location, hse: hisexp): hipat

fun hipat_rec (
  loc: location
, hse: hisexp, knd: int, lhips: labhipatlst, hse_rec: hisexp
) : hipat // end of [hipat_rec]

fun hipat_lst (
  loc: location, hse: hisexp, hse_elt: hisexp, hips: hipatlst
) : hipat // end of [hipat_lst]

fun hipat_refas (
  loc: location, hse: hisexp, d2v: d2var, hip: hipat
) : hipat // end of [hipat_refas]

fun hipat_ann
  (loc: location, hse: hisexp, hip: hipat, ann: hisexp): hipat
// end of [hipat_ann]

(* ****** ****** *)

datatype
hidecl_node =
  | HIDnone of ()
  | HIDlist of hideclist
  | HIDsaspdec of s2aspdec
//
  | HIDfundecs of
      (funkind, s2qualst(*decarg*), hifundeclst)
    // end of [HIDfundecs]
//
  | HIDvaldecs of (valkind, hivaldeclst)
  | HIDvaldecs_rec of (valkind, hivaldeclst)
// end of [hidecl_node]

and hidexp_node =
//
  | HDEvar of d2var // dynamic variables
//
  | HDEbool of bool // boolean constants
  | HDEchar of char // constant characters
  | HDEstring of string // constant strings
//
  | HDEi0nt of i0nt // integer constants
  | HDEf0loat of f0loat // floating point constants
//
  | HDEextval of (string(*name*)) // external values
//
  | HDElet of (hideclist, hidexp)
//
  | HDEapp of
      (hisexp(*fun*), hidexp, hidexplst) // app_dyn
    // end of [HDEapp]
//
  | HDErec of
      (int(*knd*), labhidexplst, hisexp(*tyrec*))
    // end of [HDErec]
//
(*
  | HDEarrinit of (* array construction *)
      (hityp(*eltyp*), hidexpopt(*asz*), hidexplst(*elt*))
  | HDEarrsize of (* arraysize construction *)
      (hityp(*eltyp*), hidexplst(*elt*))
  | HDEassgn_ptr of (* assignment to a pointer with offsets *)
      (hidexp, hilablst, hidexp)
  | HDEassgn_var of (* assignment to a variable with ofsets *)
      (d2var_t, hilablst, hidexp)
*)
  | HDElam of (hipatlst, hidexp) // HX: lam_dyn
//
  | HDEtmpcst of (d2cst, hisexplstlst)
  | HDEtmpvar of (d2var, hisexplstlst)
//
// end of [hidexp_node]

and labhidexp = LABHIDEXP of (label, hidexp)

where hidecl = '{
  hidecl_loc= location, hidecl_node= hidecl_node
}

and hideclist = List (hidecl)

and hidexp = '{
  hidexp_loc= location
, hidexp_type= hisexp
, hidexp_node= hidexp_node
}

and hidexplst = List (hidexp)
and hidexpopt = Option (hidexp)

and labhidexplst = List (labhidexp)

(* ****** ****** *)

and hivaldec = '{
  hivaldec_loc= location
, hivaldec_pat= hipat
, hivaldec_def= hidexp
} // end of [hivaldec]

and hivaldeclst = List (hivaldec)

(* ****** ****** *)

and hifundec = '{
  hifundec_loc= location
, hifundec_var= d2var
, hifundec_def= hidexp
} // end of [hifundec]

and hifundeclst = List (hifundec)

(* ****** ****** *)

fun fprint_hidexp : fprint_type (hidexp)
fun fprint_hidexplst : fprint_type (hidexplst)
fun fprint_labhidexplst : fprint_type (labhidexplst)

fun fprint_hidecl : fprint_type (hidecl)
fun fprint_hideclist : fprint_type (hideclist)

fun fprint_hifundec : fprint_type (hifundec)
fun fprint_hivaldec : fprint_type (hivaldec)

(* ****** ****** *)

fun hidexp_make_node
  (loc: location, hse: hisexp, node: hidexp_node): hidexp
// end of [hidexp_make_node]

(* ****** ****** *)

fun hidexp_var
  (loc: location, hse: hisexp, d2v: d2var): hidexp
// end of [hidexp_var]

(* ****** ****** *)

fun hidexp_bool
  (loc: location, hse: hisexp, b: bool): hidexp
fun hidexp_char
  (loc: location, hse: hisexp, c: char): hidexp
fun hidexp_string
  (loc: location, hse: hisexp, str: string): hidexp

(* ****** ****** *)

fun hidexp_i0nt
  (loc: location, hse: hisexp, tok: i0nt): hidexp
fun hidexp_f0loat
  (loc: location, hse: hisexp, tok: f0loat): hidexp

(* ****** ****** *)

fun hidexp_extval
  (loc: location, hse: hisexp, name: string): hidexp

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

(* ****** ****** *)

fun hidexp_rec (
  loc: location
, hse: hisexp, knd: int, lhses: labhidexplst, hse_rec: hisexp
) : hidexp // end of [hidexp_rec]

(* ****** ****** *)

fun hidexp_lam
  (loc: location, hse: hisexp, hips: hipatlst, hde: hidexp): hidexp
// end of [hidexp_lam]

(* ****** ****** *)

fun hidexp_tmpcst (
  loc: location, hse: hisexp, d2c: d2cst, tmparg: hisexplstlst
) : hidexp // end of [hidexp_tmpcst]
fun hidexp_tmpvar (
  loc: location, hse: hisexp, d2v: d2var, tmparg: hisexplstlst
) : hidexp // end of [hidexp_tmpvar]

(* ****** ****** *)

fun hifundec_make
  (loc: location, d2v: d2var, def: hidexp): hifundec
// end of [hifundec_make]

fun hivaldec_make
  (loc: location, pat: hipat, def: hidexp): hivaldec
// end of [hivaldec_make]

(* ****** ****** *)

fun hidecl_make_node
  (loc: location, node: hidecl_node): hidecl
// end of [hidecl_make_node]

fun hidecl_none (loc: location): hidecl
fun hidecl_list (loc: location, hids: hideclist): hidecl

fun hidecl_fundecs (
  loc: location, knd: funkind, decarg: s2qualst, hfds: hifundeclst
) : hidecl // end of [hidecl_fundecs]

fun hidecl_valdecs
  (loc: location, knd: valkind, hvds: hivaldeclst): hidecl
// end of [hidecl_valdecs]

fun hidecl_valdecs_rec
  (loc: location, knd: valkind, hvds: hivaldeclst): hidecl
// end of [hidecl_valdecs_rec]

(* ****** ****** *)

(* end of [pats_hidynexp.sats] *)
