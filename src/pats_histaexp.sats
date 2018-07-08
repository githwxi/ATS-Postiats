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
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

abstype hisexp_funlab_type
typedef funlab = hisexp_funlab_type

fun print_funlab (x: funlab): void
overload print with print_funlab
fun prerr_funlab (x: funlab): void
overload prerr with prerr_funlab
fun fprint_funlab : fprint_type (funlab)

(* ****** ****** *)

datatype
hitnam =
HITNAM of (
  int(*0/1:non/ptr*), int(*0/1:final*), string
) // end of [hitnam]

fun print_hitnam (x: hitnam): void
overload print with print_hitnam
fun prerr_hitnam (x: hitnam): void
overload prerr with prerr_hitnam
fun fprint_hitnam : fprint_type (hitnam)

(* ****** ****** *)

datatype
hisexp_node =
//
  | HSEcst of (s2cst)
//
  | HSEtybox of () // for pointers
  | HSEtyabs of (symbol) // for abstypes
//
  | HSEapp of (hisexp, hisexplst)
//
  | HSEextype of (string(*name*), hisexplstlst)
//
  | HSEfun of (* function type *)
      (funclo, hisexplst(*arg*), hisexp(*res*))
    // end of [HSEfun]
//
  | HSErefarg of (int(*refval*), hisexp)
//
  | HSEtyarr of (hisexp, s2explst) // for arrays
  | HSEtyrec of (tyreckind, labhisexplst) // for records
  | HSEtyrecsin of (labhisexp) // for singleton flat records
  | HSEtysum of (d2con, labhisexplst) // for tagged unions
//
  | HSEtyvar of s2var // for type variables
//
  | HSEtyclo of (funlab) // for flat closure-functions
//
  | HSEvararg of (s2exp) // for variadic funarg
//
  | HSEs2exp of (s2exp)
  | HSEs2zexp of (s2zexp)
// end of [hisexp_node]

and labhisexp =
  | HSLABELED of (label, Option(string), hisexp)
// end of [labhisexp]

where hisexp = '{
  hisexp_name= hitnam, hisexp_node= hisexp_node
} // end of [hisexp]

and hisexplst = List (hisexp)
and hisexpopt = Option (hisexp)
and hisexplstlst = List (hisexplst)

and labhisexplst = List (labhisexp)

(* ****** ****** *)
//
fun print_hisexp (x: hisexp): void
fun prerr_hisexp (x: hisexp): void
//
overload print with print_hisexp
overload prerr with prerr_hisexp
//
fun fprint_hisexp : fprint_type (hisexp)
fun fprint_hisexplst : fprint_type (hisexplst)
//
overload fprint with fprint_hisexp
overload fprint with fprint_hisexplst
//
(* ****** ****** *)
//
val hisexp_tybox : hisexp
//
val hisexp_typtr : hisexp
//
val hisexp_funptr : hisexp
val hisexp_cloptr : hisexp
//
val hisexp_clotyp : hisexp
//
val hisexp_arrptr : hisexp
//
val hisexp_datconptr : hisexp
val hisexp_datcontyp : hisexp
//
val hisexp_exnconptr : hisexp
//
val hisexp_undefined : hisexp
//
(* ****** ****** *)

fun hisexp_int_t0ype () : hisexp
fun hisexp_bool_t0ype () : hisexp
fun hisexp_size_t0ype () : hisexp

(* ****** ****** *)

fun hisexp_void_t0ype () : hisexp

(* ****** ****** *)

fun hisexp_get_boxknd (hse: hisexp): int
fun hisexp_get_extknd (hse: hisexp): int

(* ****** ****** *)

fun hisexp_is_boxed (hse: hisexp): bool

(* ****** ****** *)

fun hisexp_is_void (hse: hisexp): bool
fun hisexp_fun_is_void (hse: hisexp): bool

(* ****** ****** *)

fun hisexp_is_noret (hse: hisexp): bool
fun hisexp_fun_is_noret (hse: hisexp): bool

(* ****** ****** *)

fun hisexp_is_tyarr (hse: hisexp): bool
fun hisexp_is_tyrecsin (hse: hisexp): bool

(* ****** ****** *)

fun labhisexp_get_elt (lhse: labhisexp): hisexp

(* ****** ****** *)

fun hisexp_tyabs (sym: symbol): hisexp

(* ****** ****** *)

fun hisexp_fun
(
  fc: funclo, arg: hisexplst, res: hisexp
) : hisexp // end of [hisexp_fun]

fun hisexp_cst (s2c: s2cst): hisexp

fun hisexp_app
  (_fun: hisexp, _arg: hisexplst): hisexp
// end of [hisexp_app]

(* ****** ****** *)

fun hisexp_extype
  (name: string, arglst: hisexplstlst): hisexp

fun hisexp_refarg (knd: int, hse: hisexp): hisexp

fun hisexp_tyarr (elt: hisexp, dim: s2explst): hisexp

fun hisexp_tyrec (knd: tyreckind, lhses: labhisexplst): hisexp
fun hisexp_tyrecsin (lhse: labhisexp): hisexp // HX: singleton tyrec
fun hisexp_tyrec2 (knd: tyreckind, lhses: labhisexplst): hisexp

fun hisexp_tysum (d2c: d2con, lhses: labhisexplst): hisexp

(* ****** ****** *)

fun hisexp_tyvar (s2v: s2var): hisexp

(* ****** ****** *)

fun hisexp_tyclo (flab: funlab): hisexp

(* ****** ****** *)

fun hisexp_vararg (s2e: s2exp): hisexp // HX: variadic funarg

(* ****** ****** *)

fun hisexp_s2exp (s2e: s2exp): hisexp
fun hisexp_s2zexp (s2ze: s2zexp): hisexp

(* ****** ****** *)

fun hisexp_make_srt (s2t: s2rt): hisexp
fun hisexp_make_srtsym (s2t: s2rt, sym: symbol): hisexp

(* ****** ****** *)

fun hisexp_subst (sub: !stasub, hse: hisexp): hisexp

(* ****** ****** *)

(* end of [pats_histaexp.sats] *)
