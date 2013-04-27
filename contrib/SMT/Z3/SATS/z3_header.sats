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
typedef Z3_bool = bool
//
macdef Z3_true = $extval (Z3_bool, "Z3_true")
macdef Z3_false = $extval (Z3_bool, "Z3_false")
//
(* ****** ****** *)

typedef Z3_string = string

(* ****** ****** *)

absvtype
Z3_config_vtype = ptr
vtypedef
Z3_config = Z3_config_vtype

(* ****** ****** *)

absvtype
Z3_context_vtype = ptr
vtypedef
Z3_context = Z3_context_vtype

(* ****** ****** *)

abstype Z3_symbol_type = ptr
typedef Z3_symbol = Z3_symbol_type

(* ****** ****** *)
//
abstype Z3_ast_type = ptr
//
(* ****** ****** *)

abstype Z3_sort_type = ptr
typedef Z3_sort = Z3_sort_type

abstype Z3_func_decl_type = ptr
typedef Z3_func_decl = Z3_func_decl_type

abstype Z3_app_type = ptr
typedef Z3_app = Z3_app_type

abstype Z3_pattern_type = ptr
typedef Z3_pattern = Z3_pattern_type

abstype Z3_constructor_type = ptr
typedef Z3_constructor = Z3_constructor_type

(* ****** ****** *)
//
absvtype Z3_ast_vtype = ptr
vtypedef Z3_ast_vt = Z3_ast_vtype
//
(* ****** ****** *)

absvtype Z3_params_vtype = ptr
vtypedef Z3_params = Z3_params_vtype

absvtype Z3_param_descrs_vtype = ptr
vtypedef Z3_param_descrs = Z3_param_descrs_vtype

absvtype Z3_model_vtype = ptr
vtypedef Z3_model = Z3_model_vtype

absvtype Z3_func_interp_vtype = ptr
vtypedef Z3_func_interp = Z3_func_interp_vtype

absvtype Z3_func_entry_vtype = ptr
vtypedef Z3_func_entry = Z3_func_entry_vtype

absvtype Z3_fixedpoint_vtype = ptr
vtypedef Z3_fixedpoint = Z3_fixedpoint_vtype

absvtype Z3_ast_vector_vtype = ptr
vtypedef Z3_ast_vector = Z3_ast_vector_vtype

absvtype Z3_ast_map_vtype = ptr
vtypedef Z3_ast_map = Z3_ast_map_vtype

absvtype Z3_goal_vtype = ptr
vtypedef Z3_goal = Z3_goal_vtype

absvtype Z3_tactic_vtype = ptr
vtypedef Z3_tactic = Z3_tactic_vtype

absvtype Z3_probe_vtype = ptr
vtypedef Z3_probe = Z3_probe_vtype

absvtype Z3_apply_result_vtype = ptr
vtypedef Z3_apply_result = Z3_apply_result_vtype

absvtype Z3_solver_vtype = ptr
vtypedef Z3_solver = Z3_solver_vtype

absvtype Z3_stats_vtype = ptr
vtypedef Z3_stats = Z3_stats_vtype

(* ****** ****** *)

(* end of [z3_header.sats] *)
