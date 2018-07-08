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
macdef Z3_true = $extval(Z3_bool, "Z3_true")
macdef Z3_false = $extval(Z3_bool, "Z3_false")
//
(* ****** ****** *)
//  
typedef Z3_lbool = int // -1/0/1: false/undef/true
//
macdef Z3_L_TRUE = $extval(Z3_lbool, "Z3_L_TRUE")
macdef Z3_L_FALSE = $extval(Z3_lbool, "Z3_L_FALSE")
macdef Z3_L_UNDEF = $extval(Z3_lbool, "Z3_L_UNDEF")
//  
(* ****** ****** *)

typedef Z3_string = string

(* ****** ****** *)
//
absvtype
Z3_config_vtype(l:addr) = ptr
stadef Z3_config = Z3_config_vtype
vtypedef
Z3_config = [l:addr] Z3_config (l)
//
(* ****** ****** *)
//
absvtype
Z3_context_vtype(l:addr) = ptr
stadef Z3_context = Z3_context_vtype
vtypedef
Z3_context = [l:addr] Z3_context(l)
//
(* ****** ****** *)
//
abst@ype
Z3_symbol_type = $extype"Z3_symbol"
//
typedef Z3_symbol: t0ype = Z3_symbol_type
//
(* ****** ****** *)
//
absvtype
Z3_ast_vtype(l:addr) = ptr
stadef Z3_ast = Z3_ast_vtype
vtypedef Z3_ast = [l:addr] Z3_ast(l)
//
(* ****** ****** *)

absvtype
Z3_sort_vtype(l:addr) = ptr
stadef Z3_sort = Z3_sort_vtype
vtypedef Z3_sort = [l:addr] Z3_sort(l)

absvtype
Z3_func_decl_vtype(l:addr) = ptr
stadef Z3_func_decl = Z3_func_decl_vtype
vtypedef
Z3_func_decl = [l:addr] Z3_func_decl(l)

absvtype
Z3_app_vtype(l:addr) = ptr
stadef Z3_app = Z3_app_vtype
vtypedef
Z3_app = [l:addr] Z3_app (l)

absvtype
Z3_pattern_vtype(l:addr) = ptr
stadef Z3_pattern = Z3_pattern_vtype
vtypedef Z3_pattern = [l:addr] Z3_pattern(l)

(* ****** ****** *)

absvtype
Z3_constructor_vtype(l:addr) = ptr
stadef
Z3_constructor = Z3_constructor_vtype
vtypedef
Z3_constructor = [l:addr] Z3_constructor(l)

(* ****** ****** *)

absvtype
Z3_params_vtype(l:addr) = ptr
stadef Z3_params = Z3_params_vtype
vtypedef Z3_params = [l:addr] Z3_params (l)

(* ****** ****** *)

absvtype
Z3_params_descrs_vtype(l:addr) = ptr
stadef
Z3_params_descrs = Z3_params_descrs_vtype
vtypedef
Z3_params_descrs = [l:addr] Z3_params_descrs(l)

(* ****** ****** *)

absvtype
Z3_model_vtype(l:addr) = ptr
stadef Z3_model = Z3_model_vtype
vtypedef
Z3_model = [l:addr] Z3_model (l)

(* ****** ****** *)

absvtype
Z3_func_interp_vtype(l:addr) = ptr
stadef Z3_func_interp = Z3_func_interp_vtype
vtypedef
Z3_func_interp = [l:addr] Z3_func_interp_vtype(l)

(* ****** ****** *)

absvtype
Z3_func_entry_vtype(l:addr) = ptr
stadef Z3_func_entry = Z3_func_entry_vtype
vtypedef
Z3_func_entry = [l:addr] Z3_func_entry_vtype (l)

(* ****** ****** *)

absvtype
Z3_fixedpoint_vtype(l:addr) = ptr
stadef Z3_fixedpoint = Z3_fixedpoint_vtype
vtypedef
Z3_fixedpoint = [l:addr] Z3_fixedpoint_vtype (l)

(* ****** ****** *)

absvtype
Z3_ast_vector_vtype(l:addr) = ptr
stadef Z3_ast_vector = Z3_ast_vector_vtype
vtypedef
Z3_ast_vector = [l:addr] Z3_ast_vector_vtype (l)

(* ****** ****** *)

absvtype
Z3_ast_map_vtype(l:addr) = ptr
stadef Z3_ast_map = Z3_ast_map_vtype
vtypedef
Z3_ast_map = [l:addr] Z3_ast_map_vtype (l)

(* ****** ****** *)

absvtype
Z3_goal_vtype(l:addr) = ptr
stadef Z3_goal = Z3_goal_vtype
vtypedef Z3_goal = [l:addr] Z3_goal_vtype (l)

(* ****** ****** *)

absvtype
Z3_tactic_vtype(l:addr) = ptr
stadef Z3_tactic = Z3_tactic_vtype
vtypedef Z3_tactic = [l:addr] Z3_tactic_vtype (l)

(* ****** ****** *)

absvtype
Z3_probe_vtype(l:addr) = ptr
stadef Z3_probe = Z3_probe_vtype
vtypedef Z3_probe = [l:addr] Z3_probe_vtype (l)

(* ****** ****** *)

absvtype
Z3_apply_result_vtype(l:addr) = ptr
stadef
Z3_apply_result = Z3_apply_result_vtype
vtypedef
Z3_apply_result = [l:addr] Z3_apply_result_vtype(l)

(* ****** ****** *)

absvtype
Z3_solver_vtype(l:addr) = ptr
stadef Z3_solver = Z3_solver_vtype
vtypedef
Z3_solver = [l:addr] Z3_solver_vtype(l)

(* ****** ****** *)

absvtype
Z3_stats_vtype(l:addr) = ptr
stadef Z3_stats = Z3_stats_vtype
vtypedef Z3_stats = [l:addr] Z3_stats_vtype(l)

(* ****** ****** *)

abst@ype Z3_ast_print_mode = int

(* ****** ****** *)

(* end of [z3_header.sats] *)
