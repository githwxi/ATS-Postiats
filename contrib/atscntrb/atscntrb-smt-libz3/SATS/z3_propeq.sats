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

(*
Z3_ast Z3_mk_true (__in Z3_context c)
Create an AST node representing true.
*)
fun Z3_mk_true (ctx: !Z3_context): Z3_ast = "mac#%"
 
(*
Z3_ast Z3_mk_false (__in Z3_context c)
Create an AST node representing false. 
*)
fun Z3_mk_false (ctx: !Z3_context): Z3_ast = "mac#%"

(* ****** ****** *)

(*
Z3_ast Z3_mk_eq
(
  __in Z3_context c, __in Z3_ast l, __in Z3_ast r
)
Create an AST node representing l = r. 
*)
fun Z3_mk_eq
(
  ctx: !Z3_context, left: !Z3_ast, right: !Z3_ast
) : Z3_ast = "mac#%" // end of [Z3_mk_eq]

(* ****** ****** *)

fun Z3_mk_not
  (ctx: !Z3_context, a: !Z3_ast): Z3_ast = "mac#%"
// end of [Z3_mk_not]
  
(* ****** ****** *)

fun Z3_mk_or2
  (ctx: !Z3_context, a0: !Z3_ast, a1: !Z3_ast): Z3_ast = "mac#%"
// end of [Z3_mk_or2]

fun Z3_mk_and2
  (ctx: !Z3_context, a0: !Z3_ast, a1: !Z3_ast): Z3_ast = "mac#%"
// end of [Z3_mk_and2]

(* ****** ****** *)

fun Z3_mk_implies
  (ctx: !Z3_context, a0: !Z3_ast, a1: !Z3_ast): Z3_ast = "mac#%"
// end of [Z3_mk_implies]

(* ****** ****** *)

fun Z3_mk_ite // if-then-else
(
  ctx: !Z3_context, a_cond: !Z3_ast, a_then: !Z3_ast, a_else: !Z3_ast
) : Z3_ast = "mac#%" // end-of-function

(* ****** ****** *)

(* end of [z3_propeq.sats] *)
