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
// Authoremail: gmmhwxiATgmailDOTcom
// Time: October, 2010
//
(* ****** ****** *)
//
// HX: generic lists (fully indexed)
//
(* ****** ****** *)
//
// HX-2012-11-27:
// ported to ATS/Postiats from ATS/Anairiats
//
(* ****** ****** *)

#define
ATS_PACKNAME "ATSLIB.libats.gflist"

(* ****** ****** *)

staload "libats/SATS/ilist_prf.sats" // for intseqs

(* ****** ****** *)

(*
// HX: [stamped_t] is introduced in prelude/basics_pre.sats
// HX: [stamped_vt] is introduced in prelude/basics_pre.sats
*)

(* ****** ****** *)

datatype
gflist
(
  a:t@ype+, ilist(*ind*)
) = // gflist
  | gflist_nil
      (a, ilist_nil) of ()
    // end of [gflist_nil]
  | {x:int}
    {xs:ilist}
    gflist_cons
      (a, ilist_cons(x, xs)) of (stamped_t(a, x), gflist(a, xs))
    // end of [gflist_cons]
// end of [gflist]

(* ****** ****** *)

datavtype
gflist_vt (
  a:vt@ype+, ilist(*ind*)
) =
  | gflist_vt_nil
      (a, ilist_nil) of ()
    // end of [gflis_vt_nil]
  | {x:int}
    {xs:ilist}
    gflist_vt_cons
      (a, ilist_cons (x, xs)) of (stamped_vt (a, x), gflist_vt (a, xs))
    // end of [gflist_vt_cons]
// end of [gflist_vt]

(* ****** ****** *)
//
#define
gflist_sing(x) gflist_cons(x, gflist_nil())
#define
gflist_vt_sing(x) gflist_vt_cons(x, gflist_vt_nil())
//
(* ****** ****** *)

castfn
gflist2list
  {a:t@ype}{xs:ilist}
(
  gflist(INV(a), xs)
) :<> [n:nat] (LENGTH (xs, n) | list(a, n))
// end of [gflist2list]

castfn
list2gflist
  {a:t@ype}{n:int}
(
  xs: list(INV(a), n)
) :<> [xs:ilist] (LENGTH(xs, n) | gflist(a, xs))
// end of [list2gflist]

(* ****** ****** *)

castfn
gflist2list_vt
  {a:vt@ype}{xs:ilist}
(
  gflist_vt(INV(a), xs)
) :<> [n:nat] (LENGTH (xs, n) | list_vt (a, n))
// end of [gflist2list_vt]

castfn
list2gflist_vt
  {a:vt@ype}{n:int}
(
  xs: list_vt(INV(a), n)
) :<> [xs:ilist] (LENGTH(xs, n) | gflist_vt (a, xs))
// end of [list2gflist_vt]

(* ****** ****** *)

castfn
gflist_vt2t
  {a:t@ype}{xs:ilist}
  (xs: gflist_vt(INV(a), xs)):<!wrt> gflist(a, xs)
// end of [gflist_vt2t]

(* ****** ****** *)
//
fun{a:t0p}
gflist_length
  {xs:ilist}
(
  xs: gflist(INV(a), xs)
) :<> [n:nat] (LENGTH(xs, n) | int(n))
// end of [gflist_length]
//
(* ****** ****** *)

fun{a:t0p}
gflist_snoc
  {xs:ilist}{x0:int}
(
  xs: gflist(a, xs), x0: stamped_t(a, x0)
) : [xsx:ilist] (SNOC(xs, x0, xsx) | gflist_vt(a, xsx))

(* ****** ****** *)
//
fun{a:t0p}
gflist_copy
  {xs:ilist}
  (xs: gflist(INV(a), xs)):<> gflist_vt (a, xs)
//
(* ****** ****** *)

fun{a:t0p}
gflist_append
  {xs1,xs2:ilist}
(
  xs1: gflist(INV(a), xs1), xs2: gflist(a, xs2)
) :<> [res:ilist] (APPEND(xs1, xs2, res) | gflist(a, res))
// end of [gflist_append]

(* ****** ****** *)

fun{a:t0p}
gflist_revapp
  {xs1,xs2:ilist}
(
  xs1: gflist(INV(a), xs1), xs2: gflist(a, xs2)
) :<> [res:ilist] (REVAPP(xs1, xs2, res) | gflist(a, res))
// end of [gflist_revapp]

(* ****** ****** *)

fun{a:t0p}
gflist_revapp1_vt
  {xs1,xs2:ilist}
(
  xs1: gflist_vt(INV(a), xs1), xs2: gflist(a, xs2)
) :<!wrt> [res:ilist] (REVAPP(xs1, xs2, res) | gflist(a, res))
// end of [gflist_revapp1_vt]

fun{a:t0p}
gflist_revapp2_vt
  {xs1,xs2:ilist}
(
  xs1: gflist(INV(a), xs1), xs2: gflist_vt(a, xs2)
) :<!wrt> [res:ilist] (REVAPP(xs1, xs2, res) | gflist_vt(a, res))
// end of [gflist_revapp2_vt]

(* ****** ****** *)

fun{a:t0p}
gflist_reverse
  {xs:ilist}
(
  xs: gflist(INV(a), xs)
) :<> [ys:ilist] (REVERSE(xs, ys) | gflist_vt(a, ys))
// end of [gflist_reverse]

(* ****** ****** *)
//
fun{a:t0p}
gflist_get_at
  {xs:ilist}{x0:int}{i:int}
(
  pf: NTH(x0, xs, i) | xs: gflist(INV(a), xs), i: int(i)
) : stamped_t(a, x0) // end-of-function
//
(* ****** ****** *)
//
fun{a:t0p}
gflist_mergesort
  {xs:ilist}
(
  xs: gflist(INV(a), xs)
) : [ys:ilist] (SORT(xs, ys) | gflist_vt(a, ys))
//
fun{a:t0p}
gflist_mergesort$cmp
  {x1,x2:int}
  (x1: stamped_t(a, x1), x2: stamped_t(a, x2)): int(sgn(x1-x2))
//
(* ****** ****** *)

(* end of [gflist.sats] *)
