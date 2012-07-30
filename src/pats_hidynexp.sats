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
  | HIPany (* wildcard *)
  | HIPvar of (int(*refknd*), d2var)
  | HIPbool of bool
  | HIPchar of char
(*
  | HIPann of (hipat, hisexp)
  | HIPas of (* referenced pattern *)
      (int(*refkind*), d2var_t, hipat)
  | HIPcon of (* constructor pattern *)
      (int (*freeknd*), d2con_t, hipatlst, hityp(*sum*))
  | HIPcon_any of (* constructor pattern with unused arg *)
      (int(*freeknd*), d2con_t)
  | HIPempty (* empty pattern *)
  | HIPfloat of string (* float point pattern *)
  | HIPint of (* integer pattern *)
      (string, intinf_t)
  | HIPlst of (* list pattern *)
      (hityp(*element*), hipatlst)
  | HIPrec of (* record pattern *)
      (int (*knd*), labhipatlst, hityp(*rec*))
  | HIPstring of (* string pattern *)
      string 
*)
// end of [hipat_node]

where
hipat = '{
  hipat_loc= location, hipat_node= hipat_node
} // end of [hipat]

and hipatlst = List (hipat)
and hipatopt = Option (hipat)

(* ****** ****** *)

fun print_hipat (hip: hipat): void
overload print with print_hipat
fun prerr_hipat (hip: hipat): void
overload prerr with prerr_hipat
fun fprint_hipat : fprint_type (hipat)

(* ****** ****** *)

datatype
hidecl_node =
  | HIDlist of hideclist
  | HIDsaspdec of s2aspdec
// end of [hidecl_node]

and hidexp_node =
  | HIEbool of bool // boolean constants
  | HIEchar of char // constant characters
  | HIEstring of string // constant strings
(*
  | HIEapp of (* dynamic application *)
      (hityp, hiexp, hiexplst)
  | HIEarrinit of (* array construction *)
      (hityp(*eltyp*), hiexpopt(*asz*), hiexplst(*elt*))
  | HIEarrsize of (* arraysize construction *)
      (hityp(*eltyp*), hiexplst(*elt*))
  | HIEassgn_ptr of (* assignment to a pointer with offsets *)
      (hiexp, hilablst, hiexp)
  | HIEassgn_var of (* assignment to a variable with ofsets *)
      (d2var_t, hilablst, hiexp)
*)

where hidecl = '{
  hidecl_loc= location, hidecl_node= hidecl_node
}

and hideclist = List (hidecl)

and hidexp = '{
  hidexp_loc= location, hidexp_node= hidexp_node
}

and hidexplst = List (hidexp)
and hidexpopt = Option (hidexp)

(* ****** ****** *)

fun fprint_hidexp : fprint_type (hidexp)
fun fprint_hidexplst : fprint_type (hidexplst)

fun fprint_hidecl : fprint_type (hidecl)
fun fprint_hideclist : fprint_type (hideclist)

(* ****** ****** *)

(* end of [pats_hidynexp.sats] *)
