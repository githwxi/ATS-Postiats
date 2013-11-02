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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: April, 2012 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.strobjref"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // for extern names

(* ****** ****** *)

absvtype strobjref_vtype (l:addr)
vtypedef strobjref (l:addr) = strobjref_vtype (l)
viewtypedef Strobjref = [l:addr] strobjref (l)
viewtypedef Strobjref0 = [l:addr | l >= null] strobjref (l)
viewtypedef Strobjref1 = [l:addr | l >  null] strobjref (l)

(* ****** ****** *)

castfn strobjref2ptr{l:addr} (x: !strobjref (l)): ptr (l)
overload ptrcast with strobjref2ptr

(* ****** ****** *)

fun strobjref_make_nil ():<> strobjref (null)
fun strobjref_make_strptr0 (x: Strptr0):<> Strobjref0
fun strobjref_make_strptr1 (x: Strptr1):<> Strobjref1

(* ****** ****** *)

fun strobjref_incref
  {l:addr} (x: !strobjref l): strobjref l
// end of [strobjref_ref]

fun strobjref_decref (x: Strobjref0): void

(* ****** ****** *)

fun
strobjref_get0_strptr
  {l:agz}
(
  x: !strobjref l
) :<> #[l1:agz]
(
  minus (strobjref l, strptr l1) | strptr (l1)
) // end of [strobjref_get0_strptr]

fun strobjref_get1_strptr (x: !Strobjref1): Strptr1

(* ****** ****** *)
//
fun lt_strobjref_strobjref
  (x1: !Strobjref, x2: !Strobjref):<> bool = "mac#%"
overload < with lt_strobjref_strobjref
fun lte_strobjref_strobjref
  (x1: !Strobjref, x2: !Strobjref):<> bool = "mac#%"
overload <= with lte_strobjref_strobjref
//
fun gt_strobjref_strobjref
  (x1: !Strobjref, x2: !Strobjref):<> bool = "mac#%"
overload > with gt_strobjref_strobjref
fun gte_strobjref_strobjref
  (x1: !Strobjref, x2: !Strobjref):<> bool = "mac#%"
overload >= with gte_strobjref_strobjref
//
fun eq_strobjref_strobjref
  (x1: !Strobjref, x2: !Strobjref):<> bool = "mac#%"
overload = with eq_strobjref_strobjref
fun neq_strobjref_strobjref
  (x1: !Strobjref, x2: !Strobjref):<> bool = "mac#%"
overload != with neq_strobjref_strobjref
overload <> with neq_strobjref_strobjref
//
(* ****** ****** *)

fun compare_strobjref_strobjref
  (x1: !Strobjref, x2: !Strobjref):<> Sgn = "mac#%"
overload compare with compare_strobjref_strobjref

(* ****** ****** *)
//
fun print_strobjref (x: !Strobjref): void
fun prerr_strobjref (x: !Strobjref): void
overload print with print_strobjref
overload prerr with prerr_strobjref
//
fun fprint_strobjref (out: FILEref, x: !Strobjref): void
overload fprint with fprint_strobjref
//
(* ****** ****** *)

(* end of [strobjref.sats] *)
