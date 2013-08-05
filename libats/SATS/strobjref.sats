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
** Source:
** $PATSHOME/libats/SATS/CODEGEN/strobjref.atxt
** Time of generation: Wed Dec 26 21:28:55 2012
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: April, 2012 *)

(* ****** ****** *)

absvtype strobjref_vtype (l:addr)
vtypedef strobjref (l:addr) = strobjref_vtype (l)
viewtypedef strobjref = [l:addr] strobjref (l)
viewtypedef strobjref0 = [l:addr | l >= null] strobjref (l)
viewtypedef strobjref1 = [l:addr | l >  null] strobjref (l)

(* ****** ****** *)

castfn strobjref2ptr{l:addr} (x: !strobjref (l)): ptr (l)
overload ptrcast with strobjref2ptr

(* ****** ****** *)

fun strobjref_make_nil ():<> strobjref (null)
fun strobjref_make_strptr0 (x: Strptr0):<> strobjref0
fun strobjref_make_strptr1 (x: Strptr1):<> strobjref1

(* ****** ****** *)

fun strobjref_incref
  {l:addr} (x: !strobjref l): strobjref l
// end of [strobjref_ref]

fun strobjref_decref (x: strobjref0): void

(* ****** ****** *)

fun
strobjref_get0_strptr
  {l:agz} (
  x: !strobjref l
) :<> #[l1:agz] (
  minus (strobjref l, strptr l1) | strptr l1
) // end of [strobjref_get0_strptr]

(* ****** ****** *)

fun lt_strobjref_strobjref
  {l1,l2:addr} (x1: !strobjref l1, x2: !strobjref l2):<> bool
overload < with lt_strobjref_strobjref
fun lte_strobjref_strobjref
  {l1,l2:addr} (x1: !strobjref l1, x2: !strobjref l2):<> bool
overload <= with lte_strobjref_strobjref

fun gt_strobjref_strobjref
  {l1,l2:addr} (x1: !strobjref l1, x2: !strobjref l2):<> bool
overload > with gt_strobjref_strobjref
fun gte_strobjref_strobjref
  {l1,l2:addr} (x1: !strobjref l1, x2: !strobjref l2):<> bool
overload >= with gte_strobjref_strobjref

fun eq_strobjref_strobjref
  {l1,l2:addr} (x1: !strobjref l1, x2: !strobjref l2):<> bool
overload = with eq_strobjref_strobjref
fun neq_strobjref_strobjref
  {l1,l2:addr} (x1: !strobjref l1, x2: !strobjref l2):<> bool
overload != with neq_strobjref_strobjref
overload <> with neq_strobjref_strobjref

fun compare_strobjref_strobjref
  {l1,l2:addr} (x1: !strobjref l1, x2: !strobjref l2
) :<> Sgn = "atslib_compare_strobjref_strobjref"
overload compare with compare_strobjref_strobjref

(* ****** ****** *)

fun print_strobjref
  {l:addr} (x: !strobjref l): void
overload print with print_strobjref
fun prerr_strobjref
  {l:addr} (x: !strobjref l): void
overload prerr with prerr_strobjref
fun fprint_strobjref
  {l:addr} (out: FILEref, x: !strobjref l): void
overload fprint with fprint_strobjref

(* ****** ****** *)

(* end of [strobjref.sats] *)
