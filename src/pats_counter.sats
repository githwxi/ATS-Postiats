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

staload "./pats_basics.sats"

(* ****** ****** *)

abst@ype
count_t0ype = int
typedef count = count_t0ype
abstype counter_type // ref (count_t)
typedef counter = counter_type

(* ****** ****** *)

fun count_get_int (x: count):<> int

(* ****** ****** *)

fun lt_count_count (x1: count, x2: count):<> bool
overload < with lt_count_count
fun lte_count_count (x1: count, x2: count):<> bool
overload <= with lte_count_count

fun gt_count_count (x1: count, x2: count):<> bool
overload > with lt_count_count
fun gte_count_count (x1: count, x2: count):<> bool
overload >= with lte_count_count

fun eq_count_count (x1: count, x2: count):<> bool
overload = with eq_count_count
fun neq_count_count (x1: count, x2: count):<> bool
overload <> with neq_count_count

fun compare_count_count (x1: count, x2: count):<> Sgn
overload compare with compare_count_count

(* ****** ****** *)

fun fprint_count : fprint_type (count)

(* ****** ****** *)

fun tostring_count (cnt: count): string
fun tostring_prefix_count (pre: string, cnt: count): string

(* ****** ****** *)
//
fun counter_make (): counter
//
fun counter_inc (cntr: counter): void
fun counter_get (cntr: counter): count
fun counter_set (cntr: counter, cnt: count): void
fun counter_reset (cntr: counter): void
//
fun counter_getinc (cntr: counter): count
fun counter_incget (cntr: counter): count
//
(* ****** ****** *)

(* end of [pats_counter.sats] *)
