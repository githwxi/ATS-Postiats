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
// Start Time: March, 2011
//
(* ****** ****** *)

fun eqref_type {a:type} (x1: a, x2: a):<> bool

(* ****** ****** *)
//
// HX: case-insensitive string comparision
//
fun strcasecmp (x1: string, x2: string): int

(* ****** ****** *)
//
// HX: the [base] of the representation is contained
fun llint_make_string (rep: string): llint // in the [rep]

(* ****** ****** *)

fun{a:t@ype}
fprintlst (
  out: FILEref
, xs: List a
, sep: string
, fprint: (FILEref, a) -> void
) : void // end of [fprintlst]

fun{a:t@ype}
fprintopt (
  out: FILEref
, opt: Option a
, fprint: (FILEref, a) -> void
) : void // end of [fprintopt]

(* ****** ****** *)
//
abstype lstord (a: type) // HX: for ordered lists
//
fun lstord_nil {a:type} (): lstord (a)
fun lstord_sing {a:type} (x: a): lstord (a)
fun lstord_insert {a:type} (
  xs: lstord a, x: a, cmp: (a, a) -<fun> int
) : lstord (a) // end of [lstord_insert]
fun lstord_union {a:type} (
  xs: lstord a, ys: lstord a, cmp: (a, a) -<fun> int
) : lstord (a) // end of [lstord_union]
fun lstord_get_dups
  {a:type} (xs: lstord a, cmp: (a, a) -<fun> int): List (a)
// end of [lstord_get_dups]
fun lstord_listize // identity
  {a:type} (xs: lstord a): List (a)
// end of [lstord_listize]

(* ****** ****** *)

local

staload Q = "libats/SATS/linqueue_arr.sats"
stadef QUEUE = $Q.QUEUE

in // in of [local]

fun queue_get_strptr1
  {m,n:int}
  {st,ln:nat | st+ln <= n} (
  q: &QUEUE (uchar, m, n), st: size_t st, ln: size_t ln
) : strptr1 // end of [queue_get_strptr1]

end // end of [local]

(* ****** ****** *)

(* end of [pats_utils.sats] *)
