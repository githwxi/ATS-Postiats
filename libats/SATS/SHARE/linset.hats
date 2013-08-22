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
//
// HX: shared by linset_avltree
// HX: shared by linset_listord
//
(* ****** ****** *)
//
// HX-2013-02:
// for sets of nonlinear elements
//
absvtype set_vtype (a:t@ype+)
vtypedef set (a:t0p) = set_vtype (a)

(* ****** ****** *)

fun{a:t0p}
compare_elt_elt (x1: &a, x2: &a):<> int

(* ****** ****** *)

fun{a:t0p}
linset_is_member (xs: !set (a), x0: a):<> bool
fun{a:t0p}
linset_isnot_member (xs: !set (a), x0: a):<> bool

(* ****** ****** *)

fun{a:t0p}
linset_free (xs: set (a)):<!wrt> void

fun{a:t0p}
linset_copy (xs: !set (a)):<!wrt> set (a)

(* ****** ****** *)



(* ****** ****** *)

(* end of [linset.hats] *)
