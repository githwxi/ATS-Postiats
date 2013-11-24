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
staload "./pats_counter.sats"

(* ****** ****** *)
//
abst@ype stamp_t0ype = count
//
typedef stamp = stamp_t0ype
typedef stampopt = Option (stamp)
//
(* ****** ****** *)

fun stamp_get_int (x: stamp):<> int

(* ****** ****** *)

fun lt_stamp_stamp (x1: stamp, x2: stamp):<> bool
overload < with lt_stamp_stamp

fun lte_stamp_stamp (x1: stamp, x2: stamp):<> bool
overload <= with lte_stamp_stamp

fun eq_stamp_stamp (x1: stamp, x2: stamp):<> bool
overload = with eq_stamp_stamp

fun neq_stamp_stamp (x1: stamp, x2: stamp):<> bool
overload <> with neq_stamp_stamp

fun compare_stamp_stamp (x1: stamp, x2: stamp):<> Sgn
overload compare with compare_stamp_stamp

(* ****** ****** *)

fun tostring_stamp (x: stamp): string
fun tostring_prefix_stamp (prfx: string, x: stamp): string

(* ****** ****** *)

fun fprint_stamp : fprint_type (stamp)

(* ****** ****** *)

fun // HX: datasort
s2rtdat_stamp_make (): stamp
//
fun s2cst_stamp_make (): stamp
//
fun s2var_stamp_make (): stamp
fun s2Var_stamp_make (): stamp
//
(* ****** ****** *)

fun s2hole_stamp_make (): stamp

(* ****** ****** *)
//
fun d2con_stamp_make (): stamp
//
fun d2cst_stamp_make (): stamp
//
fun d2mac_stamp_make (): stamp
//
fun d2var_stamp_make (): stamp
//
(* ****** ****** *)

fun hitype_stamp_make (): stamp

(* ****** ****** *)

fun tmplab_stamp_make (): stamp
fun tmpvar_stamp_make (): stamp

(* ****** ****** *)

fun funlab_stamp_make (): stamp

(* ****** ****** *)
//
absviewtype stampset_viewtype
viewtypedef stampset_vt = stampset_viewtype
//
fun stampset_vt_nil ():<> stampset_vt
fun stampset_vt_is_nil (xs: !stampset_vt):<> bool
fun stampset_vt_isnot_nil (xs: !stampset_vt):<> bool
fun stampset_vt_is_member (xs: !stampset_vt, x: stamp):<> bool
fun stampset_vt_add (xs: stampset_vt, x: stamp):<> stampset_vt
fun stampset_vt_free (xs: stampset_vt):<> void
//
(* ****** ****** *)

(* end of [pats_stamp.sats] *)
