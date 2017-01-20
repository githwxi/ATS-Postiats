(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(*
** Start Time: June, 2015
**
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
*)

(* ****** ****** *)
//
#ifndef
ATSCNTRB_SMT_Z3_Z3_HEADER
#include "./z3_header.sats"
#endif // end of [ifndef]
//
(* ****** ****** *)
//
fun
Z3_mk_bound
(
  ctx: !Z3_context, index: intGte(0), ty: !Z3_sort
) : Z3_ast = "mac#%"
//
(* ****** ****** *)
//
fun
Z3_mk_pattern
  {n:nat}
(
  ctx: !Z3_context, n: int(n), terms: &array(Z3_ast, n)
) : Z3_pattern = "mac#%"
//
(* ****** ****** *)

fun
Z3_mk_forall
  {npat,ndec:int}
(
  ctx		: !Z3_context
, weight	: intGte(0)
, npat		: int(npat)
, patterns	: &array(Z3_pattern, npat)
, ndec		: int(ndec)
, sorts		: &array(Z3_sort, ndec)
, names		: &array(Z3_symbol, ndec)
, body		: !Z3_ast
) : Z3_ast = "mac#%" // end-of-function

fun
Z3_mk_exists
  {npat,ndec:int}
(
  ctx		: !Z3_context
, weight	: intGte(0)
, npat		: int(npat)
, patterns	: &array(Z3_pattern, npat)
, ndec		: int(ndec)
, sorts		: &array(Z3_sort, ndec)
, names		: &array(Z3_symbol, ndec)
, body		: !Z3_ast
) : Z3_ast = "mac#%" // end-of-function

(* ****** ****** *)

fun
Z3_mk_quantifier
  {npat,ndec:int}
(
  ctx		: !Z3_context
, kind          : bool // forall=true
, weight	: intGte(0)
, npat		: int(npat)
, patterns	: &array(Z3_pattern, npat)
, ndec		: int(ndec)
, sorts		: &array(Z3_sort, ndec)
, names		: &array(Z3_symbol, ndec)
, body		: !Z3_ast
) : Z3_ast = "mac#%" // end-of-function

fun
Z3_mk_quantifier_nwp
  {ndec:int}
(
  ctx		: !Z3_context
, kind          : bool // forall=true
, ndec		: int(ndec)
, sorts		: &array(Z3_sort, ndec)
, names		: &array(Z3_symbol, ndec)
, body		: !Z3_ast
) : Z3_ast = "mac#%" // end-of-function

(* ****** ****** *)
//
fun
Z3_pattern_inc_ref
  {l:addr}
(
  ctx: !Z3_context, pat: !Z3_pattern(l)
) : Z3_pattern(l) = "mac#%" // endfun
//
fun
Z3_pattern_dec_ref
  (ctx: !Z3_context, pat: Z3_pattern): void = "mac#%"
//
(* ****** ****** *)

(* end of [z3_quantifier.sats] *)
