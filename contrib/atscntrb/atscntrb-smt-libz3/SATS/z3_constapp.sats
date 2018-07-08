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
** Start Time: April, 2013
**
** Author: William Blair 
** Authoremail: wdblair AT bu DOT edu
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
/*
// Declare and create a constant. 
*/
fun Z3_mk_const
(
  ctx: !Z3_context, s: Z3_symbol, ty: !Z3_sort
) : Z3_ast = "mac#%" // end of [Z3_mk_const]

(* ****** ****** *)

/*
// Declare and create a fresh constant.
*/
fun Z3_mk_fresh_const
(
  ctx: !Z3_context, prfix: Z3_string, ty: !Z3_sort
) : Z3_ast = "mac#%" // end of [Z3_mk_fresh_const]

(* ****** ****** *)

fun
Z3_mk_func_decl
  {n:nat}
(
  ctx: !Z3_context
, sym: Z3_symbol, n: int(n)
, domain: &RD(array(Z3_sort, n)), range: !Z3_sort
) : Z3_func_decl = "mac#%" // end-of-function

(* ****** ****** *)

fun
Z3_mk_func_decl_0
(
  ctx: !Z3_context
, sym: Z3_symbol, res: !Z3_sort
) : Z3_func_decl = "mac#%" // end-of-function

fun
Z3_mk_func_decl_1
(
  ctx: !Z3_context
, sym: Z3_symbol, arg: !Z3_sort, res: !Z3_sort
) : Z3_func_decl = "mac#%" // end-of-function

fun
Z3_mk_func_decl_2
(
  ctx: !Z3_context
, sym: Z3_symbol, a0: !Z3_sort, a1: !Z3_sort, r: !Z3_sort
) : Z3_func_decl = "mac#%" // end-of-function

(* ****** ****** *)
  
fun
Z3_mk_app{n:nat}
(
  ctx: !Z3_context
, fd: !Z3_func_decl, n: int(n), args: &RD(array(Z3_ast, n))
) : Z3_ast = "mac#%" // end-of-fun
  
(* ****** ****** *)

fun
Z3_mk_app_0
(
  ctx: !Z3_context, fd: !Z3_func_decl
) : Z3_ast = "mac#%" // end-of-fun

fun
Z3_mk_app_1
(
  ctx: !Z3_context, fd: !Z3_func_decl, arg: !Z3_ast
) : Z3_ast = "mac#%" // end of [Z3_mk_app_1]

fun
Z3_mk_app_2
(
  ctx: !Z3_context, fd: !Z3_func_decl, a0: !Z3_ast, a1: !Z3_ast
) : Z3_ast = "mac#%" // end of [Z3_mk_app_2]

(* ****** ****** *)
//
fun
Z3_func_decl_inc_ref{l:addr}
  (ctx: !Z3_context, fd: !Z3_func_decl(l)): Z3_func_decl(l) = "mac#%"
// end of [Z3_func_decl_inc_ref]
//
fun
Z3_func_decl_dec_ref(ctx: !Z3_context, fd: Z3_func_decl): void = "mac#%"
//
(* ****** ****** *)

(* end of [z3_constapp.sats] *)
