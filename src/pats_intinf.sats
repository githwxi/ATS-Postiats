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
fun intinf_make_string (rep: string): intinf

(* ****** ****** *)

fun
intinf_make_base_string_ofs
  {n:int} {i:nat | i <= n} (
  base: intBtw(2,36+1), rep: string n, ofs: int i
) : intinf // end of [intinf_make_base_string_ofs]

(* ****** ****** *)

fun fprint_intinf (out: FILEref, x: intinf): void

(* ****** ****** *)

fun eq_intinf_int (x1: intinf, x2: int):<> bool
fun eq_int_intinf (x1: int, x2: intinf):<> bool
fun eq_intinf_intinf (x1: intinf, x2: intinf):<> bool

fun compare_intinf_int (x1: intinf, x2: int):<> int
fun compare_intinf_intinf (x1: intinf, x2: intinf):<> int

(* ****** ****** *)

(* end of [pats_intinf.sats] *)
