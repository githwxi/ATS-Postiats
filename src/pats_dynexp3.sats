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

staload LOC = "pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload
INTINF = "pats_intinf.sats"
typedef intinf = $INTINF.intinf

(* ****** ****** *)

staload "pats_staexp2.sats"
typedef s2exp = s2exp
staload "pats_dynexp2.sats"
typedef d2cst = d2cst_type // abstract
typedef d2var = d2var_type // abstract

(* ****** ****** *)

datatype p3at_node =
  | P3Tany of () // wildcard
  | P3Tvar of (int(*refknd*), d2var)
  | P3Tempty (* empty pattern *)
//
  | P3Tann of (p3at, s2exp) // ascribed pattern
// end of [p3at_node]

where p3at = '{
  p3at_loc= location
, p3at_node= p3at_node
, p3at_typ= s2exp
} // end of [p3at]

and p3atlst = List (p3at)
and p3atopt = Option p3at

(* ****** ****** *)

datatype d3exp_node =
  | D3Eint of (* dynamic integer *)
      (string, intinf)
  | D3Eintsp of (* dynamic specified integer *)
      (string, intinf)
// end of [d3exp_node]

where
d3exp = '{
  d3exp_loc= location
, d3exp_typ= s2exp
, d3exp_node= d3exp_node
} // end of [d3exp]

and d3explst = List (d3exp)
and d3expopt = Option (d3exp)
and d3explstlst = List (d3explst)

(* ****** ****** *)

fun d3exp_bool
  (loc: location, s2e: s2exp, b: bool): d3exp
// end of [d3exp_bool]

fun d3exp_char
  (loc: location, s2e: s2exp, c: char): d3exp
// end of [d3exp_char]

(* ****** ****** *)

(* end of [pats_dynexp3.sats] *)
