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
// Start Time: March, 2011
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"
typedef intinf = $INTINF.intinf

(* ****** ****** *)

staload "./pats_stamp.sats"
staload "./pats_symbol.sats"
staload "./pats_location.sats"

(* ****** ****** *)

(*
** HX-2013-11: JSON value representation
*)

datatype
jsonval =
  | JSONnul of ()
  | JSONint of (int)
  | JSONintinf of (intinf)
  | JSONbool of (bool)
  | JSONfloat of (double)
  | JSONstring of (string)
  | JSONloc of (location)
  | JSONlist of (jsonvalist)
  | JSONlablist of labjsonvalist
  | JSONoption of (jsonvalopt)
// end of [jsonval]

where
jsonvalist = List (jsonval)
and
labjsonval = @(string, jsonval)
and
labjsonvalist = List0 (labjsonval)
and
jsonvalopt = Option (jsonval)

(* ****** ****** *)
//
fun jsonval_int (x: int): jsonval
fun jsonval_intinf (x: intinf): jsonval
//
fun jsonval_bool (x: bool): jsonval
fun jsonval_double (x: double): jsonval
fun jsonval_string (x: string): jsonval
//
fun jsonval_loc (loc: location): jsonval
//
fun jsonval_sing (x: jsonval): jsonval
fun jsonval_pair (x1: jsonval, x2: jsonval): jsonval
fun jsonval_list (xs: jsonvalist): jsonval
//
fun jsonval_labval1
  (l1: string, x1: jsonval): jsonval
//
fun jsonval_labval2
(
  l1: string, x1: jsonval
, l2: string, x2: jsonval
) : jsonval // end of [jsonval_labval2]
//
fun
jsonval_labval3
(
  l1: string, x1: jsonval
, l2: string, x2: jsonval
, l3: string, x3: jsonval
) : jsonval // end of [jsonval_labval3]
//
fun
jsonval_labval4
(
  l1: string, x1: jsonval
, l2: string, x2: jsonval
, l3: string, x3: jsonval
, l4: string, x4: jsonval
) : jsonval // end of [jsonval_labval4]
//
(* ****** ****** *)

fun
jsonval_lablist (lxs: labjsonvalist): jsonval

(* ****** ****** *)
//
fun jsonval_none (): jsonval
fun jsonval_some (x: jsonval): jsonval
//
(* ****** ****** *)
//
fun fprint_jsonval
  (out: FILEref, x: jsonval): void
fun fprint_jsonvalist
  (out: FILEref, xs: jsonvalist): void
fun fprint_labjsonvalist
  (out: FILEref, lxs: labjsonvalist): void
//
overload fprint with fprint_jsonval
overload fprint with fprint_jsonvalist
overload fprint with fprint_labjsonvalist
//
(* ****** ****** *)

typedef
jsonize_ftype (a:t@ype) = (a) -> jsonval

(* ****** ****** *)

fun jsonize_funclo : jsonize_ftype (funclo)

(* ****** ****** *)

fun jsonize_caskind : jsonize_ftype (caskind)

(* ****** ****** *)

fun jsonize_funkind : jsonize_ftype (funkind)
fun jsonize_valkind : jsonize_ftype (valkind)

(* ****** ****** *)

fun jsonize_stamp : jsonize_ftype (stamp)
fun jsonize_symbol : jsonize_ftype (symbol)
fun jsonize_location : jsonize_ftype (location)

(* ****** ****** *)

fun
jsonize_ignored{a:type} (x: a): jsonval

(* ****** ****** *)

fun
jsonize_list_fun{a:type}
  (xs: List (a), f: jsonize_ftype (a)): jsonval
// end of [jsonize_list_fun]

(* ****** ****** *)

(* end of [pats_jsonize.sats] *)
