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
(* Start time: May, 2012 *)

(* ****** ****** *)
//
// HX: shared by funralist_nested
//
(* ****** ****** *)
//
// HX-2013-01:
// the time-complexity for various functions operating on
// random-access lists:
//
// funralist_cons: O(1) // amortized
// funralist_uncons: O(1) // amortized
//
// funralist_length: O(log(n))
//
// funralist_lookup: O(log(n))
// funralist_update: O(log(n))
//
(* ****** ****** *)
//
// HX: indexed by list length
//
abstype
ralist_type (a:t@ype+, n:int) = ptr
//
(* ****** ****** *)
//
stadef ralist = ralist_type
typedef ralist (a:t0p) = [n:int] ralist (a, n)
typedef Ralist (a:t0p) = [n:int] ralist (a, n)
//
(* ****** ****** *)

prfun lemma_ralist_param
  {a:t0p}{n:int} (xs: ralist (INV(a), n)): [n >= 0] void
// end of [lemma_ralist_param]

(* ****** ****** *)

fun{}
funralist_nil{a:t0p}():<> ralist (a, 0)
fun{}
funralist_make_nil{a:t0p}():<> ralist (a, 0)

(* ****** ****** *)

fun{a:t0p}
funralist_make_list
  {n:int}(xs: list (INV(a), n)): ralist (a, n)
// end of [funralist_make_list]

(* ****** ****** *)

fun{a:t0p}
funralist_cons{n:int}
  (x: a, xs: ralist (INV(a), n)):<> ralist (a, n+1)
// end of [funralist_cons]

fun{a:t0p}
funralist_uncons{n:pos}
  (xs: &ralist (INV(a), n) >> ralist (a, n-1)):<!wrt> a
// end of [funralist_uncons]

(* ****** ****** *)

fun{
} funralist_is_nil
  {a:t0p}{n:int} (xs: ralist (INV(a), n)):<> bool(n==0)
// end of [funralist_is_nil]

fun{
} funralist_is_cons
  {a:t0p}{n:int} (xs: ralist (INV(a), n)):<> bool(n > 0)
// end of [funralist_is_cons]

(* ****** ****** *)

fun{
} funralist_length
  {a:t0p}{n:nat} (xs: ralist (INV(a), n)):<> int (n)
// end of [funralist_length]

(* ****** ****** *)

fun{a:t0p}
funralist_head
  {n:pos} (xs: ralist (INV(a), n)):<> a
fun{a:t0p}
funralist_tail
  {n:pos} (xs: ralist (INV(a), n)):<> ralist (a, n-1)
// end of [funralist_tail]

(* ****** ****** *)

fun{a:t0p}
funralist_get_at{n:int}
  (xs: ralist (INV(a), n), i: natLt n):<> a
fun{a:t0p}
funralist_lookup{n:int}
  (xs: ralist (INV(a), n), i: natLt n):<> a
//
overload [] with funralist_get_at
//
(* ****** ****** *)

fun{a:t0p}
funralist_set_at{n:int}
(
  xs: ralist (INV(a), n), i: natLt n, x0: a
) :<> ralist (a, n) // endfun
fun{a:t0p}
funralist_update{n:int}
(
  xs: ralist (INV(a), n), i: natLt n, x0: a
) :<> ralist (a, n) // endfun

(* ****** ****** *)

fun{}
fprint_funralist$sep (out: FILEref): void
fun{a:t0p}
fprint_funralist
  (out: FILEref, xs: Ralist(INV(a))): void
overload fprint with fprint_funralist

(* ****** ****** *)
//
fun{a:t0p}{env:vt0p}
funralist_foreach$fwork (x: a, env: &(env) >> _): void
//
fun{a:t0p}
funralist_foreach (xs: Ralist (INV(a))): void
fun{a:t0p}{env:vt0p}
funralist_foreach_env (xs: Ralist (INV(a)), env: &(env)>>env): void
//
(* ****** ****** *)

fun{a:t0p}
funralist_listize
  {n:int} (xs: ralist (INV(a), n)):<!wrt> list_vt (a, n)
// end of [funralist_listize]

(* ****** ****** *)

(* end of [funralist.hats] *)
