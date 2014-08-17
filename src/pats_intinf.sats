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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: May, 2011
//
(* ****** ****** *)

abstype intinf_type
typedef intinf = intinf_type

(* ****** ****** *)

fun intinf_make_int (i: int): intinf
fun intinf_make_size (sz: size_t): intinf

(* ****** ****** *)

(*
//
// HX: [rep] is unsigned!
// 0 -> base 8; 0x -> base 16; _ => base 10
//
*)
fun intinf_make_string
  (rep: string): intinf = "ext#patsopt_intinf_make_string"
// end of [intinf_make_string]

(* ****** ****** *)

fun
intinf_make_base_string_ofs
  {n:int} {i:nat | i <= n}
(
  base: intBtwe(2,36), rep: string n, ofs: int i
) : intinf // end of [intinf_make_base_string_ofs]

(* ****** ****** *)

fun fprint_intinf (out: FILEref, x: intinf): void

(* ****** ****** *)
//
// HX: this is unsafe because of potential overflow
//
fun intinf_get_int (n: intinf):<> int

(* ****** ****** *)

fun lt_intinf_int (x1: intinf, x2: int):<> bool
overload < with lt_intinf_int
fun lte_intinf_int (x1: intinf, x2: int):<> bool
overload <= with lte_intinf_int

fun gt_intinf_int (x1: intinf, x2: int):<> bool
overload > with gt_intinf_int
fun gte_intinf_int (x1: intinf, x2: int):<> bool
overload >= with gte_intinf_int

fun eq_intinf_int (x1: intinf, x2: int):<> bool
fun eq_int_intinf (x1: int, x2: intinf):<> bool
fun eq_intinf_intinf (x1: intinf, x2: intinf):<> bool
overload = with eq_intinf_int
overload = with eq_int_intinf
overload = with eq_intinf_intinf

fun neq_intinf_int (x1: intinf, x2: int):<> bool
fun neq_int_intinf (x1: int, x2: intinf):<> bool
fun neq_intinf_intinf (x1: intinf, x2: intinf):<> bool
overload != with neq_intinf_int
overload != with neq_int_intinf
overload != with neq_intinf_intinf

fun compare_intinf_int (x1: intinf, x2: int):<> int
fun compare_intinf_intinf (x1: intinf, x2: intinf):<> int

(* ****** ****** *)
//
fun neg_intinf (x: intinf):<> intinf
//
fun add_intinf_int (x1: intinf, x2: int):<> intinf
fun add_int_intinf (x1: int, x2: intinf):<> intinf
fun add_intinf_intinf (x1: intinf, x2: intinf):<> intinf
//
fun sub_intinf_intinf (x1: intinf, x2: intinf):<> intinf
//
fun mul_intinf_int (x1: intinf, x2: int):<> intinf
fun mul_int_intinf (x1: int, x2: intinf):<> intinf
fun mul_intinf_intinf (x1: intinf, x2: intinf):<> intinf
//
overload ~ with neg_intinf
overload + with add_intinf_int
overload + with add_int_intinf
overload + with add_intinf_intinf
overload - with sub_intinf_intinf
overload * with mul_intinf_int
overload * with mul_int_intinf
overload * with mul_intinf_intinf
//
(* ****** ****** *)
//
abstype intinfset_type
typedef intinfset = intinfset_type
//
typedef intinflst = List (intinf)
vtypedef intinflst_vt = List_vt (intinf)
//
fun intinfset_sing (x: intinf): intinfset
fun intinfset_is_member (xs: intinfset, x: intinf): bool
fun intinfset_add (xs: intinfset, x: intinf): intinfset
//
fun intinfset_listize (xs: intinfset): intinflst_vt
//
fun fprint_intinfset (out: FILEref, xs: intinfset): void
//
(* ****** ****** *)

(* end of [pats_intinf.sats] *)
