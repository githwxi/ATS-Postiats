(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2011
//
(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

abstype s2cstref_type // boxed type
typedef s2cstref = s2cstref_type

fun s2cstref_make (name: string): s2cstref

fun s2cstref_get_cst (r: s2cstref): s2cst
fun s2cstref_get_exp (r: s2cstref, arg: Option_vt s2explst): s2exp
fun s2cstref_unget_exp (r: s2cstref, s2e: s2exp): Option_vt (s2explst)
fun s2cstref_equ_cst (r: s2cstref, s2c: s2cst): bool
fun s2cstref_equ_exp (r: s2cstref, s2e: s2exp): bool

(* ****** ****** *)
//
val the_true_bool : s2cstref
val the_false_bool : s2cstref
//
val the_bool_t0ype : s2cstref
val the_bool_bool_t0ype : s2cstref
//
val the_int_t0ype : s2cstref
val the_int_int_t0ype : s2cstref
//
val the_char_t0ype : s2cstref
val the_char_char_t0ype : s2cstref
//
val the_string_type : s2cstref
val the_double_t0ype : s2cstref
//
val the_void_t0ype : s2cstref
//
val the_exception_viewtype : s2cstref
//
val the_list0_t0ype_type : s2cstref
//
val the_at_viewt0ype_addr_view: s2cstref
//
val the_sizeof_viewt0ype_int: s2cstref
//
(* ****** ****** *)
//
fun s2exp_bool
  (b: bool): s2hnf (* static boolean terms *)
// end of [s2exp_bool]
//
fun s2exp_bool_t0ype (): s2hnf // bool0
fun s2exp_bool_bool_t0ype (b: bool): s2hnf // bool1(b)
//
(* ****** ****** *)
//
fun s2exp_int_t0ype (): s2hnf // int0
fun s2exp_int_int_t0ype (i: int): s2hnf // int1(i)
//
(* ****** ****** *)

fun s2exp_char_t0ype (): s2hnf // char0
fun s2exp_char_char_t0ype (b: char): s2hnf // char1(b)

(* ****** ****** *)

fun s2exp_string_type (): s2hnf // string0
fun s2exp_double_t0ype (): s2hnf // double

(* ****** ****** *)

fun s2exp_void_t0ype (): s2hnf // void

(* ****** ****** *)

fun s2exp_list0_t0ype_type (s2e: s2exp): s2hnf

(* ****** ****** *)

fun stacst2_initialize (): void

(* ****** ****** *)

(* end of [pats_stacst2.sats] *)
