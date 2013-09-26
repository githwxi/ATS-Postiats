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
// Start Time: June, 2012
//
(* ****** ****** *)
//
// HX: for handling macro expansion during typechecking
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef location = $LOC.location

staload
SEXP2 = "./pats_staexp2.sats"
typedef s2var = $SEXP2.s2var
typedef s2exp = $SEXP2.s2exp

staload
SUTIL = "./pats_staexp2_util.sats"
viewtypedef stasub = $SUTIL.stasub

staload
DEXP2 = "./pats_dynexp2.sats"
typedef d2var = $DEXP2.d2var
typedef p2at  = $DEXP2.p2at
typedef d2exp = $DEXP2.d2exp
typedef d2mac = $DEXP2.d2mac
typedef d2exparglst = $DEXP2.d2exparglst

(* ****** ****** *)

datatype m2val =
//
  | M2Vint of int
  | M2Vbool of bool
  | M2Vchar of char
  | M2Vfloat of string
  | M2Vstring of string
  | M2Vunit of ()
//
  | M2Vscode of s2exp // static code
  | M2Vdcode of d2exp // dynamic code
//
  | M2Vlist of m2valist
//
  | M2Verr of ()
// end of [m2val]

where m2valist = List (m2val)

(* ****** ****** *)

val m2val_true : m2val and m2val_false : m2val

(* ****** ****** *)

fun print_m2val (x: m2val): void
overload print with print_m2val
fun prerr_m2val (x: m2val): void
overload prerr with prerr_m2val
fun fprint_m2val : fprint_type (m2val)

fun fprint_m2valist : fprint_type (m2valist)

(* ****** ****** *)

fun liftval2dexp (loc0: location, m2v: m2val): d2exp

(* ****** ****** *)

absviewtype alphenv_viewtype
viewtypedef alphenv = alphenv_viewtype

fun alphenv_nil ():<> alphenv

fun alphenv_sadd (
  env: &alphenv, s2v: s2var, s2v_new: s2var
) : void // end of [alphenv_sadd]
fun alphenv_dadd (
  env: &alphenv, d2v: d2var, d2v_new: d2var
) : void // end of [alphenv_dadd]

fun alphenv_sfind
  (env: !alphenv, s2v: s2var): Option_vt (s2var)
// end of [alphenv_sfind]
fun alphenv_dfind
  (env: !alphenv, d2v: d2var): Option_vt (d2var)
// end of [alphenv_dfind]

fun alphenv_pop (env: &alphenv): void
fun alphenv_push (env: &alphenv): void

fun alphenv_free (env: alphenv): void

(* ****** ****** *)

absviewtype evalctx_viewtype
viewtypedef evalctx = evalctx_viewtype

fun evalctx_nil ():<> evalctx

fun print_evalctx (ctx: !evalctx): void
overload print with print_evalctx
fun prerr_evalctx (ctx: !evalctx): void
overload prerr with prerr_evalctx
fun fprint_evalctx : fprint_vtype (evalctx)

fun evalctx_sadd
  (ctx: evalctx, s2v: s2var, m2v: m2val): evalctx
// end of [evalctx_sadd]

fun evalctx_dadd
  (ctx: evalctx, d2v: d2var, m2v: m2val): evalctx
// end of [evalctx_dadd]

fun evalctx_dfind
  (ctx: !evalctx, d2v: d2var): Option_vt (m2val)
// end of [evalctx_dfind]

fun evalctx_free (ctx: evalctx): void

(* ****** ****** *)

fun eval0_d2exp (
  loc0: location, ctx: !evalctx, env: &alphenv, d2e: d2exp
) : m2val // end of [eval0_d2exp]

(* ****** ****** *)

fun stasub_make_evalctx (ctx: !evalctx): stasub

(* ****** ****** *)

typedef
eval1_type (a:type) =
  (location(*loc0*), !evalctx, &alphenv, a) -> a
// end of [eval1_type]

fun eval1_listmap {a:type}{n:int} (
  loc0: location, ctx: !evalctx, env: &alphenv, xs: list(a, n), f: eval1_type (a)
) : list (a, n) // end of [eval1_listmap]

fun eval1_d2exp : eval1_type (d2exp)

(* ****** ****** *)

fun eval0_app_mac_long (
  loc0: location
, d2m: d2mac, ctx: !evalctx, env: &alphenv, d2as: d2exparglst
) : m2val // end of [eval0_app_mac_long]

fun eval0_app_mac_short (
  loc0: location
, d2m: d2mac, ctx: !evalctx, env: &alphenv, d2as: d2exparglst
) : d2exp // end of [eval0_app_mac_short]

(* ****** ****** *)

fun dmacro_eval_decode (d2e: d2exp): d2exp
fun dmacro_eval_xstage (d2e: d2exp): d2exp

(* ****** ****** *)
//
// HX: for expanding macros in short form
//
fun dmacro_eval_app_short (
  loc0: location, d2m: d2mac, d2as: d2exparglst
) : d2exp // end of [dmacro_eval_app_short]

(* ****** ****** *)

(* end of [pats_dmacro2.sats] *)
