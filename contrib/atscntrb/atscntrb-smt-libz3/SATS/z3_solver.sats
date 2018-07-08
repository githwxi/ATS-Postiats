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
//
#ifndef
ATSCNTRB_SMT_Z3_Z3_HEADER
#include "./z3_header.sats"
#endif // end of [#ifndef]
//
(* ****** ****** *)

(*
Z3_solver Z3_mk_solver (__in Z3_context c)
Create a new (incremental) solver. This solver also uses a set of builtin
tactics for handling the first check-sat command, and check-sat commands
that take more than a given number of milliseconds to be solved.
*)
fun
Z3_mk_solver (ctx: !Z3_context): Z3_solver = "mac#%"

(* ****** ****** *)

fun
Z3_mk_simple_solver (ctx: !Z3_context): Z3_solver = "mac#%"
   
(* ****** ****** *)
//
(*
Create a new solver customized for the given logic. It behaves like
Z3_mk_solver if the logic is unknown or unsupported.
*)
fun
Z3_mk_solver_for_logic
  (ctx: !Z3_context, logic: Z3_symbol): Z3_solver = "mac#%"
//
(* ****** ****** *)

fun
Z3_mk_solver_get_help
  (ctx: !Z3_context, solver: !Z3_solver): vStrptr1 = "mac#%"

(* ****** ****** *)

(*
Create a new solver that is implemented using the given tactic. The solver
supports the commands Z3_solver_push and Z3_solver_pop, but it will always
solve each Z3_solver_check from scratch.
*)
fun
Z3_mk_solver_from_tactic
  (ctx: !Z3_context, t: !Z3_tactic): Z3_solver = "mac#%"

(* ****** ****** *)

fun
Z3_solver_inc_ref
  (ctx: !Z3_context, p: !Z3_solver): Z3_solver = "mac#%"
// end of [Z3_solver_inc_ref]

fun
Z3_solver_dec_ref (ctx: !Z3_context, p: Z3_solver): void = "mac#%"

(* ****** ****** *)
//
fun
Z3_solver_get_model
  {l:addr}
  (ctx: !Z3_context, s: !Z3_solver(l))
: [l2:addr]
  vtget1(Z3_solver(l), Z3_model(l2)) = "mac#%"
//
(* ****** ****** *)

fun Z3_solver_pop 
(
  ctx: !Z3_context, s: !Z3_solver, depth: uint
): void = "mac#%" // end of [Z3_solver_pop]

fun Z3_solver_push
(
  ctx: !Z3_context, s: !Z3_solver
) : void = "mac#%" // end of [Z3_solver_push]

(* ****** ****** *)

fun
Z3_solver_assert
(
  ctx: !Z3_context, s: !Z3_solver, f: !Z3_ast
): void = "mac#%" // end of [Z3_solver_assert]

fun Z3_solver_check 
(
  ctx: !Z3_context, s: !Z3_solver
): Z3_lbool = "mac#%" // end of [Z3_solver_check]

(* ****** ****** *)

(* end of [z3_solver.sats] *)
