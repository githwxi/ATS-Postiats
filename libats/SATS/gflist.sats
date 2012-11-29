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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: October, 2010
//
(* ****** ****** *)
//
// HX: generic functional lists (fully indexed)
//
(* ****** ****** *)
//
// HX-2012-11-27: ported to ATS/Postiats from ATS/Anairiats
//
(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no need for staloading at run-time

(* ****** ****** *)

staload "libats/SATS/ilist_prf.sats" // for handling integer sequences

(* ****** ****** *)

(*
// HX: [stamped] is introduced in prelude/basics_pre.sats
*)

datatype
gflist (
  a:t@ype+, ilist(*ind*)
) =
  | gflist_nil (a, ilist_nil) of ()
  | {x:int}{xs:ilist}
    gflist_cons
      (a, ilist_cons (x, xs)) of (stamped (a, x), gflist (a, xs))
    // end of [gflist_cons]
// end of [gflist]

(* ****** ****** *)

fun{a:t@ype}
gflist_length
  {xs:ilist}
  (xs: gflist (a, xs)):<> [n:nat] (LENGTH (xs, n) | int n)
// end of [gflist_length]

(* ****** ****** *)

fun{a:t@ype}
gflist_append
  {xs1,xs2:ilist} (
  xs1: gflist (a, xs1), xs2: gflist (a, xs2)
) :<> [res:ilist] (APPEND (xs1, xs2, res) | gflist (a, res))
// end of [gflist_append]

(* ****** ****** *)

fun{a:t@ype}
gflist_revapp
  {xs1,xs2:ilist} (
  xs1: gflist (a, xs1), xs2: gflist (a, xs2)
) :<> [res:ilist] (REVAPP (xs1, xs2, res) | gflist (a, res))
// end of [gflist_revapp]

fun{a:t@ype}
gflist_reverse
  {xs:ilist} (
  xs: gflist (a, xs)
) :<> [ys:ilist] (REVERSE (xs, ys) | gflist (a, ys))
// end of [gflist_reverse]

(* ****** ****** *)

fun{a:t@ype}
gflist_mergesort$cmp {x1,x2:int}
  (x1: stamped (a, x1), x2: stamped (a, x2)): int(sgn(x1-x2))
fun{a:t@ype}
gflist_mergesort {xs:ilist}
  (xs: gflist (a, xs)): [ys:ilist] (SORT (xs, ys) | gflist (a, ys))
// end of [gflist_mergesort]

(* ****** ****** *)

(* end of [gflist.sats] *)
