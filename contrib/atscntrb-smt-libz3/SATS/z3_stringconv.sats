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
void
Z3_set_ast_print_mode
  (__in Z3_context c, __in Z3_ast_print_mode mode)
Select mode for the format used for pretty-printing AST nodes.
*) 
fun Z3_set_ast_print_mode
  (ctx: !Z3_context, mode: Z3_ast_print_mode): void
// end of [Z3_set_ast_print_mode]
 
(* ****** ****** *)

(*
Z3_string
Z3_ast_to_string (__in Z3_context c, __in Z3_ast a)
Convert the given AST node into a string.
*)
fun Z3_ast_to_string (ctx: !Z3_context, a: !Z3_ast): vStrptr1

(* ****** ****** *)

(*
Z3_string
Z3_pattern_to_string (__in Z3_context c, __in Z3_pattern p)
*)
fun Z3_pattern_to_string (ctx: !Z3_context, p: !Z3_pattern): vStrptr1
 
(* ****** ****** *)

(*
Z3_string
Z3_func_decl_to_string (__in Z3_context c, __in Z3_func_decl d)
*) 
fun Z3_func_decl_to_string (ctx: !Z3_context, d: !Z3_func_decl): vStrptr1

(* ****** ****** *)

(*
Z3_string
Z3_model_to_string (__in Z3_context c, __in Z3_model m)
*)
fun Z3_model_to_string (ctx: !Z3_context, m: !Z3_model): vStrptr1

(* ****** ****** *)

(* end of [z3_stringconv.sats] *)
