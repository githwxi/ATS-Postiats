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
#include \
"atscntrb-smt-libz3/CATS/z3.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSCNTRB.libz3"
#define
ATS_STALOADFLAG 0 // no static loading at run-time
//
#define
ATS_EXTERN_PREFIX "atscntrb_" // prefix for extern names
(*
#define
ATS_EXTERN_STATIC "_atscntrb_" // prefix for extern names
*)
//
(* ****** ****** *)
//
#define
ATSCNTRB_SMT_Z3_Z3_HEADER
//
#include "./z3_header.sats"
//
(* ****** ****** *)
  
(*  
void
Z3_API
Z3_get_version
(
  __out unsigned * major
, __out unsigned * minor
, __out unsigned * build_number
, __out unsigned * revision_number
) ;
*)
fun
Z3_get_version
(
  major: &uint? >> _, minor: &uint? >> _
, build: &uint? >> _, revision: &uint? >> _
) : void = "mac#%"
  
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
as CUDD.
*)

fun Z3_mk_context_rc (cfg: !Z3_config): Z3_context = "mac#%"

(* ****** ****** *)

(*
void
Z3_del_context (__in Z3_context c)
Delete the given logical context.
*)
fun Z3_del_context (ctx: Z3_context): void = "mac#%"
 
(* ****** ****** *)

(*
void Z3_inc_ref (__in Z3_context c, __in Z3_ast a)
Increment the reference counter of the given AST. The context c should
have been created using Z3_mk_context_rc. This function is a NOOP if c
was created using Z3_mk_context.
*)
fun Z3_inc_ref{l:addr}
  (ctx: !Z3_context, a: !Z3_ast l): Z3_ast (l) = "mac#%"
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
Z3_bool
Z3_get_param_value
(
  __in Z3_context c
, __in Z3_string param_id, __out Z3_string_ptr param_value
)
*)
fun Z3_get_param_value
(
  ctx: !Z3_context, p_id: Z3_string, p_val: &ptr? >> opt (Z3_string, b)
) : #[b:bool] bool (b) = "mac#%"
 
(*
void
Z3_update_param_value
(__in Z3_context c, __in Z3_string param_id, __in Z3_string param_value)
*)
fun Z3_update_param_value
  (ctx: !Z3_context, p_id: Z3_string, p_val: Z3_string): void = "mac#%"
// end of [Z3_update_param_value]

(* ****** ****** *)

(*
void
Z3_interrupt (__in Z3_context c)
Interrupt the execution of a Z3 procedure. This procedure can be used to
interrupt: solvers, simplifiers and tactics.
*) 
fun Z3_interrupt (ctx: !Z3_context): void = "mac#%"

(* ****** ****** *)

#include "./z3_params.sats"
#include "./z3_params_descrs.sats"

(* ****** ****** *)

#include "./z3_symbol.sats"

(* ****** ****** *)

#include "./z3_sort.sats"

(* ****** ****** *)

#include "./z3_constapp.sats"

(* ****** ****** *)

#include "./z3_propeq.sats"

(* ****** ****** *)

#include "./z3_arithmetic.sats"

(* ****** ****** *)

#include "./z3_bitvector.sats"

(* ****** ****** *)

#include "./z3_numeral.sats"

(* ****** ****** *)

(*
#include "./z3_arrayset.sats"
*)

(* ****** ****** *)

#include "./z3_quantifier.sats"

(* ****** ****** *)

#include "./z3_accessor.sats"
#include "./z3_modifier.sats"

(* ****** ****** *)

#include "./z3_model.sats"

(* ****** ****** *)

(*
#include "./z3_interlog.sats"
*)

(* ****** ****** *)

#include "./z3_stringconv.sats"

(* ****** ****** *)

(*
#include "./z3_parserint.sats"
#include "./z3_errhandle.sats"
*)

(* ****** ****** *)

#include "./z3_fixedpoint.sats"

(* ****** ****** *)

(*
#include "./z3_ast_map"
#include "./z3_ast_vector"
*)

(* ****** ****** *)

#include "./z3_goal.sats"

(* ****** ****** *)

#include "./z3_tactic_probe.sats"

(* ****** ****** *)

#include "./z3_solver.sats"

(* ****** ****** *)

#include "./z3_stats.sats"

(* ****** ****** *)

(* end of [z3.sats] *)
