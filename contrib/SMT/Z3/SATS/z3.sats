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

%{#
#include "Z3/CATS/z3.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.Z3"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_" // prefix for external names

(* ****** ****** *)

#include "./z3_header.sats"

(* ****** ****** *)

(*
Z3_config Z3_mk_config ()
Create a configuration.
*)
fun Z3_mk_config (): Z3_config = "mac#%"

(* 
void Z3_del_config (__in Z3_config c)
Delete the given configuration object.
*)
fun Z3_del_config (cfg: Z3_config): void = "mac#%"

(*
void Z3_set_param_value
(
  __in Z3_config c, __in Z3_string param_id, __in Z3_string param_value
)
Set a configuration parameter.
*)
fun Z3_set_param_value
(
  cfg: !Z3_config, p_id: Z3_string, p_val: Z3_string
) : void = "mac#%" // end of [Z3_set_param_value]
   
(* ****** ****** *)

(*
Z3_context Z3_mk_context (__in Z3_config c)
Create a context using the given configuration.
*)
(*
fun Z3_mk_context (cfg: !Z3_config): Z3_context = "mac#%"
*)

(* 
Z3_context Z3_mk_context_rc (__in Z3_config c)
Create a context using the given configuration. This function is similar to
Z3_mk_context. However, in the context returned by this function, the user
is responsible for managing Z3_ast reference counters. Managing reference
counters is a burden and error-prone, but allows the user to use the memory
more efficiently. The user must invoke Z3_inc_ref for any Z3_ast returned
by Z3, and Z3_dec_ref whenever the Z3_ast is not needed anymore. This idiom
is similar to the one used in BDD (binary decision diagrams) packages such
as CUDD.  *) fun Z3_mk_context_rc (cfg: !Z3_config): Z3_context = "mac#%"

fun Z3_mk_context_rc (cfg: !Z3_config): Z3_context = "mac#%"

(* ****** ****** *)

(*
void
Z3_del_context (__in Z3_context c)
Delete the given logical context.
*)
fun Z3_del_context (ctx: Z3_context): void
 
(* ****** ****** *)

(*
void Z3_inc_ref (__in Z3_context c, __in Z3_ast a)
Increment the reference counter of the given AST. The context c should
have been created using Z3_mk_context_rc. This function is a NOOP if c
was created using Z3_mk_context.
*)
fun Z3_inc_ref
  (ctx: !Z3_context, a: !Z3_ast): Z3_ast = "mac#%"
// end of [Z3_inc_ref]
 
(*
void
Z3_dec_ref (__in Z3_context c, __in Z3_ast a)
Decrement the reference counter of the given AST. The context c should
have been created using Z3_mk_context_rc. This function is a NOOP if c
was created using Z3_mk_context.
*)
fun Z3_dec_ref (ctx: !Z3_context, a: Z3_ast): void = "mac#%"

(* ****** ****** *)
 
(*
void
Z3_update_param_value
(__in Z3_context c, __in Z3_string param_id, __in Z3_string param_value)
*)
fun Z3_update_param_value
  (ctx: !Z3_context, p_id: Z3_string, p_val: Z3_string): void = "mac#%"
// end of [Z3_update_param_value]

(*
Z3_bool
Z3_get_param_value
(__in Z3_context c, __in Z3_string param_id, __out Z3_string_ptr param_value)
*)
fun Z3_get_param_value
(
  ctx: !Z3_context, p_id: Z3_string, p_val: &ptr? >> opt (Z3_string, b)
) : #[b:bool] bool (b) = "mac#%"
 
(* ****** ****** *)

(*
void
Z3_interrupt (__in Z3_context c)
Interrupt the execution of a Z3 procedure. This procedure can be used to
interrupt: solvers, simplifiers and tactics.
*) 
fun Z3_interrupt (ctx: !Z3_context): void = "mac#%"

(* ****** ****** *)

(*
Z3_symbol
Z3_mk_int_symbol (__in Z3_context c, __in int i)
Create a Z3 symbol using an integer.
*)
fun Z3_mk_int_symbol
  (ctx: !Z3_context, i: int): Z3_symbol = "mac#%"
// end of [Z3_mk_int_symbol]
   
(*
Z3_symbol
Z3_mk_string_symbol (__in Z3_context c, __in Z3_string s)
Create a Z3 symbol using a C string.
*)
fun Z3_mk_string_symbol
  (ctx: !Z3_context, str: Z3_string): Z3_symbol = "mac#%"
// end of [Z3_mk_string_symbol]

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

(*
Z3_ast Z3_mk_eq (__in Z3_context c, __in Z3_ast l, __in Z3_ast r)
Create an AST node representing l = r. 
*)
fun Z3_mk_eq
  (ctx: !Z3_context, l: !Z3_ast, r: !Z3_ast): Z3_ast = "mac#%"
// end of [Z3_mk_eq]

(* ****** ****** *)

fun Z3_mk_or2
  (ctx: !Z3_context, a1: !Z3_ast, a2: !Z3_ast): Z3_ast = "mac#%"
// end of [Z3_mk_or2]

fun Z3_mk_and2
  (ctx: !Z3_context, a1: !Z3_ast, a2: !Z3_ast): Z3_ast = "mac#%"
// end of [Z3_mk_and2]

(* ****** ****** *)

(* end of [z3.sats] *)
