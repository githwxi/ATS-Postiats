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

(* ****** ****** *)

abstype funlab_type
typedef funlab = funlab_type
typedef funlablst = List (funlab)

fun print_funlab (x: funlab): void
overload print with print_funlab
fun prerr_funlab (x: funlab): void
overload prerr with prerr_funlab
fun fprint_funlab : fprint_type (funlab)

(* ****** ****** *)

datatype
hitype =
  | HITYPE of (int(*0/1:non/ptr*), string)
// end of [hitype]

fun print_hitype (x: hitype): void
overload print with print_hitype
fun prerr_hitype (x: hitype): void
overload prerr with prerr_hitype
fun fprint_hitype : fprint_type (hitype)

(* ****** ****** *)

fun funlab_get_name (fl: funlab): string
fun funlab_get_level (fl: funlab): int
fun funlab_get_type (fl: funlab): hitype
fun funlab_get_stamp (fl: funlab): stamp

(* ****** ****** *)

datatype
hisexp_node =
  | HSEfun of (* function type *)
      (funclo, hisexplst(*arg*), hisexp(*res*))
//
  | HSEextype of (string(*name*), hisexplstlst)
//
  | HSErefarg of (int(*refval*), hisexp)
//
  | HSEtyclo of funlab // for closures
  | HSEtyarr of (hisexp, s2explstlst)
  | HSEtyrec of (int(*knd*), labhisexplst)
  | HSEtyrecsin of (hisexp) // HX: singleton tyrec
  | HSEtysum of (d2con, hisexplst)
//
  | HSEvararg of () // variadic function argument
(*
  | HSEs2var of s2var_t
  | HSEtyrectemp of (* boxed record type in template *)
      (int(*fltboxknd*), labhityplst) (* knd: flt/box: 0/1 *)
  | HSEtysumtemp of (* constructor type in template *)
      (d2con_t, hityplst)
*)
  | HSEerr of (location, s2exp)
// end of [hisexp_node]

and labhisexp = HSLABELED of (label, Option(string), hisexp)

where hisexp = '{
  hisexp_name= hitype, hisexp_node= hisexp_node
} // end of [hisexp]

and hisexplst = List (hisexp)
and hisexpopt = Option (hisexp)
and hisexplstlst = List (hisexplst)

and labhisexplst = List (labhisexp)

(* ****** ****** *)

fun print_hisexp (x: hisexp): void
overload print with print_hisexp
fun prerr_hisexp (x: hisexp): void
overload prerr with prerr_hisexp
fun fprint_hisexp : fprint_type (hisexp)

fun fprint_hisexplst : fprint_type (hisexplst)

(* ****** ****** *)

fun hisexp_fun (
  fc: funclo, arg: hisexplst, res: hisexp
) : hisexp // end of [hisexp_fun]

fun hisexp_extype
  (name: string, arglst: hisexplstlst): hisexp

fun hisexp_refarg (knd: int, hse: hisexp): hisexp

fun hisexp_tyclo (fl: funlab): hisexp

fun hisexp_tyarr (elt: hisexp, dim: s2explstlst): hisexp

fun hisexp_tyrec (knd: int, lhses: labhisexplst): hisexp
fun hisexp_tyrecsin (hse: hisexp): hisexp // HX: singleton tyrec

fun hisexp_tysum (d2c: d2con, hses: hisexplst): hisexp

fun hisexp_vararg (): hisexp // HX: variadic funarg

fun hisexp_err (loc: location, s2e: s2exp): hisexp

(* ****** ****** *)

(* end of [pats_histaexp.sats] *)
