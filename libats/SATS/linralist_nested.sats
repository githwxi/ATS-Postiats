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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: January, 2013 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atslib_"

(* ****** ****** *)
//
// HX-2013-01:
// the time-complexity for various functions operating on
// random-access lists:
//
// linralist_cons: O(1) // amortized
// linralist_uncons: O(1) // amortized
//
// linralist_length: O(log(n))
//
// linralist_get_at: O(log(n))
// linralist_set_at: O(log(n))
//
(* ****** ****** *)

sortdef t0p = t@ype and vt0p = vt@ype

(* ****** ****** *)
//
// HX: indexed by list length
//
absvtype
ralist_vtype (a:vt@ype+, n:int)
//
stadef ralist = ralist_vtype
//
vtypedef ralist (a:vt0p) = [n:int] ralist (a, n)
vtypedef Ralist (a:vt0p) = [n:int] ralist (a, n)
//
(* ****** ****** *)

prfun lemma_ralist_param
  {a:vt0p}{n:int} (xs: !ralist (INV(a), n)): [n >= 0] void
// end of [lemma_ralist_param]

(* ****** ****** *)

fun{a:vt0p}
linralist_nil ():<> ralist (a, 0)

(* ****** ****** *)

fun{a:vt0p}
linralist_cons {n:int}
  (x: a, xs: ralist (INV(a), n)):<> ralist (a, n+1)
// end of [linralist_cons]

fun{a:vt0p}
linralist_uncons {n:pos}
  (xs: &ralist (INV(a), n) >> ralist (a, n-1)):<!wrt> a
// end of [linralist_uncons]

(* ****** ****** *)

fun{a:t0p}
linralist_head
  {n:pos} (xs: !ralist (INV(a), n)):<> a
// end of [linralist_head]

fun{a:t0p}
linralist_tail
  {n:pos} (xs: ralist (INV(a), n)):<!wrt> ralist (a, n-1)
// end of [linralist_tail]

(* ****** ****** *)

fun{a:vt0p}
linralist_is_nil
  {n:int} (xs: !ralist (INV(a), n)):<> bool (n==0)
// end of [linralist_is_nil]

fun{a:vt0p}
linralist_is_cons
  {n:int} (xs: !ralist (INV(a), n)):<> bool (n > 0)
// end of [linralist_is_cons]

(* ****** ****** *)

fun linralist_length
  {a:vt0p}{n:nat} (xs: !ralist (INV(a), n)):<> int (n)
// end of [linralist_length]

(* ****** ****** *)

fun{a:vt0p}
linralist_getref_at
  {n:int} (
  xs: !ralist (INV(a), n), i: natLt n
) :<> Ptr1 // endfun

(* ****** ****** *)

fun{a:t0p}
linralist_get_at
  {n:int} (
  xs: !ralist (INV(a), n), i: natLt n
) :<> a // endfun

fun{a:t0p}
linralist_set_at
  {n:int} (
  xs: !ralist (INV(a), n), i: natLt n, x: a
) :<!wrt> void // endfun

(* ****** ****** *)

fun{a:t0p}
linralist_listize
  {n:int} (xs: !ralist (INV(a), n)):<!wrt> list_vt (a, n)
// end of [linralist_listize]

fun{a:vt0p}
linralist_listize_free
  {n:int} (xs: ralist (INV(a), n)):<!wrt> list_vt (a, n)
// end of [linralist_listize_free]

(* ****** ****** *)

(* end of [linralist_nested.sats] *)
