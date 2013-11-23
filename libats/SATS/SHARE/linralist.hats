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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: January, 2013 *)

(* ****** ****** *)
//
// HX: shared by linralist_nested
//
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

fun{}
linralist_nil{a:vt0p}():<> ralist (a, 0)
fun{}
linralist_make_nil{a:vt0p}():<> ralist (a, 0)

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
//
fun{a:t0p}
linralist_head
  {n:pos} (xs: !ralist (INV(a), n)):<> a
fun{a:t0p}
linralist_tail
  {n:pos} (xs: ralist (INV(a), n)):<!wrt> ralist (a, n-1)
//
(* ****** ****** *)
//
fun{}
linralist_is_nil{a:vt0p}
  {n:int} (xs: !ralist (INV(a), n)):<> bool(n==0)
fun{}
linralist_is_cons{a:vt0p}
  {n:int} (xs: !ralist (INV(a), n)):<> bool(n > 0)
//
(* ****** ****** *)

fun
linralist_length{a:vt0p}
  {n:nat} (xs: !ralist (INV(a), n)):<> int (n)
// end of [linralist_length]

(* ****** ****** *)

fun{a:vt0p}
linralist_getref_at{n:int}
  (xs: !ralist (INV(a), n), i: natLt n):<> cPtr1 (a)
// end of [linralist_getref_at]

(* ****** ****** *)
//
fun{a:t0p}
linralist_get_at{n:int}
  (xs: !ralist (INV(a), n), i: natLt n):<> a
overload [] with linralist_get_at
//
fun{a:t0p}
linralist_set_at{n:int}
  (xs: !ralist (INV(a), n), i: natLt n, x: a):<!wrt> void
overload [] with linralist_set_at
//
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

(* end of [linralist.hats] *)
