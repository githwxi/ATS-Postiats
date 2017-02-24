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
// Authoremail: hwxiATcsDOTbuDOTedu
// Time: October, 2010
//
(* ****** ****** *)
//
// HX: generic linear lists (fully indexed)
//
(* ****** ****** *)
//
// HX-2012-11-27:
// ported to ATS/Postiats from ATS/Anairiats
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.gflist_vt"

(* ****** ****** *)
//
// HX: for handling
// integer sequences
//
staload
"libats/SATS/ilist_prf.sats"
//
staload "libats/SATS/gflist.sats"
//
(* ****** ****** *)
//
fun{a:vt0p}
gflist_vt_length
  {xs:ilist}
(
  xs: !gflist_vt(INV(a), xs)
) :<> [n:nat] (LENGTH(xs, n) | int(n))
// end of [gflist_vt_length]
//
(* ****** ****** *)
//
fun{a:vt0p}
gflist_vt_snoc
  {xs:ilist}{x0:int}
(
  xs: gflist_vt(a, xs), x0: stamped_vt(a, x0)
) :<!wrt>
[xsx:ilist] (SNOC(xs, x0, xsx) | gflist_vt(a, xsx))
//
(* ****** ****** *)
//
fun{a:vt0p}
gflist_vt_append
  {xs1,xs2:ilist}
(
  xs1: gflist_vt(INV(a), xs1), xs2: gflist_vt(a, xs2)
) :<!wrt>
[res:ilist] (APPEND(xs1, xs2, res) | gflist_vt(a, res))
// end of [gflist_vt_append]
//
(* ****** ****** *)

fun{a:vt0p}
gflist_vt_revapp
  {xs1,xs2:ilist}
(
  xs1: gflist_vt(INV(a), xs1), xs2: gflist_vt(a, xs2)
) :<!wrt>
[res:ilist] (REVAPP(xs1, xs2, res) | gflist_vt(a, res))
// end of [gflist_vt_revapp]
//
fun{a:vt0p}
gflist_vt_reverse
  {xs:ilist}
(
  xs: gflist_vt(INV(a), xs)
) :<!wrt> [ys:ilist] (REVERSE(xs, ys) | gflist_vt(a, ys))
// end of [gflist_vt_reverse]
//
(* ****** ****** *)
//
fun{a:vt0p}
gflist_vt_mergesort
  {xs:ilist}
(
  xs: gflist_vt(INV(a), xs)
) : [ys:ilist] (SORT(xs, ys) | gflist_vt(a, ys))
// end of [gflist_vt_mergesort]
//
fun{a:vt0p}
gflist_vt_mergesort$cmp
  {x1,x2:int}
  (x1: &stamped_vt(a, x1), x2: &stamped_vt(a, x2)): int(sgn(x1-x2))
//
(* ****** ****** *)

(* end of [gflist_vt.sats] *)
