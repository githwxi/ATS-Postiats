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
// Start Time: April, 2011
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

abst@ype effect_t0ype = int
typedef effect = effect_t0ype
typedef effectlst = List (effect)
abst@ype effset_t0ype = uint
typedef effset = effset_t0ype

(* ****** ****** *)

val effect_ntm : effect
val effect_exn : effect
val effect_ref : effect
val effect_wrt : effect
val effectlst_all : effectlst

fun effect_get_name (eff: effect): string

fun print_effect (x: effect): void
overload print with print_effect
fun prerr_effect (x: effect): void
overload prerr with prerr_effect
fun fprint_effect : fprint_type (effect)
fun fprint_effectlst : fprint_type (effectlst)

fun eq_effect_effect (x1: effect, x2: effect):<> bool
overload = with eq_effect_effect

(* ****** ****** *)

val effset_all: effset
and effset_nil: effset
val effset_ntm : effset
val effset_exn : effset
val effset_ref : effset
val effset_wrt : effset

fun effset_sing (eff: effect):<> effset

fun eq_effset_effset (x1: effset, x2: effset):<> bool
overload = with eq_effset_effset

fun effset_add (efs: effset, eff: effect):<> effset
fun effset_del (efs: effset, eff: effect):<> effset

fun effset_isnil (efs: effset):<> bool
fun effset_isall (efs: effset):<> bool
(*
** HX-2012-03:
** [efs] is finite if its sign bit is clr
** [efs] is cofinite if its sign bit is set
*)
fun effset_isfin (efs: effset):<> bool
fun effset_iscof (efs: effset):<> bool

fun effset_ismem (efs: effset, eff: effect):<> bool

fun effset_supset (efs1: effset, efs2: effset):<> bool
fun effset_subset (efs1: effset, efs2: effset):<> bool

(*
** HX: complement and difference
*)
fun effset_cmpl (efs: effset):<> effset
fun effset_diff (efs1: effset, efs2: effset):<> effset
(*
** HX: intersection and union
*)
fun effset_inter (efs1: effset, efs2: effset):<> effset
fun effset_union (efs1: effset, efs2: effset):<> effset

fun effset_is_inter (efs1: effset, efs2: effset):<> bool

(* ****** ****** *)

fun print_effset (efs: effset): void
fun prerr_effset (efs: effset): void
fun fprint_effset : fprint_type (effset)

(* ****** ****** *)

(* end of [pats_effect.sats] *)
