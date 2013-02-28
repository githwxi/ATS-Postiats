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

sortdef tk = tkind
sortdef t0p = t@ype and vt0p = vt@ype

(* ****** ****** *)
//
// HX-2013-02:
// for sets of nonlinear elements
//
absvtype set_vtype (tk:tkind, a:t@ype+)

(* ****** ****** *)

stadef set = set_vtype // end of [stadef]

(* ****** ****** *)

fun{a:t0p}
compare_elt_elt (x1: &a, x2: &a):<> int

(* ****** ****** *)

fun{
tk:tk}{a:t0p
} linset_is_member (xs: !set (tk, a), x0: a):<> bool
fun{
tk:tk}{a:t0p
} linset_isnot_member (xs: !set (tk, a), x0: a):<> bool

(* ****** ****** *)

(* end of [linset.sats] *)
