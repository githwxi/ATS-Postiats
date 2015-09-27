(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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

sortdef t0p = t@ype

(* ****** ****** *)
//
abstype
mset_type (a:t@ype+) = ptr
typedef mset (a:t0p) = mset_type (a)
//
(* ****** ****** *)

fun{a:t0p}
compare_elt_elt (x1: a, x2: a):<> int

(* ****** ****** *)

fun{}
funmset_nil {a:t0p} ():<> mset(a)
fun{}
funmset_make_nil {a:t0p} ():<> mset(a)

(* ****** ****** *)
//
fun{a:t0p}
funmset_sing
  (x0: a):<> mset(a) // singleton mset
fun{a:t0p}
funmset_make_sing
  (x0: a):<> mset(a) // singleton mset
//
(* ****** ****** *)

fun{a:t0p}
funmset_make_list (xs: List(INV(a))):<> mset(a)

(* ****** ****** *)

fun{}
funmset_is_nil {a:t0p} (xs: mset(INV(a))):<> bool
fun{}
funmset_isnot_nil {a:t0p} (xs: mset(INV(a))):<> bool

(* ****** ****** *)

fun{a:t0p}
funmset_size (xs: mset(INV(a))):<> size_t

(* ****** ****** *)
//
fun{a:t0p}
funmset_is_member(xs: mset(INV(a)), x: a): bool
fun{a:t0p}
funmset_isnot_member(xs: mset(INV(a)), x: a): bool
//
(* ****** ****** *)

fun{a:t0p}
funmset_get_ntime (xs: mset(INV(a)), x: a): intGte(0)

(* ****** ****** *)

(* end of [funmset.hats] *)
