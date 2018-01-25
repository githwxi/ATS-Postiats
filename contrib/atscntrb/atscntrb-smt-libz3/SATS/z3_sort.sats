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

fun Z3_mk_int_sort(ctx: !Z3_context): Z3_sort = "mac#%"

(* ****** ****** *)

fun Z3_mk_bool_sort(ctx: !Z3_context): Z3_sort = "mac#%"
  
(* ****** ****** *)

fun Z3_mk_real_sort(ctx: !Z3_context): Z3_sort = "mac#%"
  
(* ****** ****** *)
//
fun
Z3_mk_uninterpreted_sort
  (ctx: !Z3_context, name: Z3_symbol): Z3_sort = "mac#%"
//
(* ****** ****** *)
//
fun
Z3_sort_inc_ref{l:addr}
  (ctx: !Z3_context, ty: !Z3_sort(l)): Z3_sort(l) = "mac#%"
// end of [Z3_sort_inc_ref]
//
fun
Z3_sort_dec_ref(ctx: !Z3_context, ty: Z3_sort): void = "mac#%"
//
(* ****** ****** *)

(* end of [z3_sort.sats] *)
