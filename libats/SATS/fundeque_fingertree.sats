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

(*
**
** A functional concatenable deque implementation based on fingertrees.
** Please see the JFP paper by Hinze and Paterson on fingertrees for more
** details on this interesting data structure.
**
** Contributed by
**   Robbie Harwood (rharwood AT cs DOT bu DOT edu)
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
**
** Time: November, 2010
**
*)

(*
** Ported to ATS2 by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: May, 2012
*)

(* ****** ****** *)
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)
//
// HX: indexed by deque size
//
abstype
deque_t0ype_int_type (elt:t@ype+, n:int)
//
stadef deque = deque_t0ype_int_type
typedef deque (a:t@ype) = [n:int] deque (a, n)
//
typedef Deque (a:t@ype) = [n:int] deque (a, n)
//
(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

prfun lemma_deque_param
  {a:t0p}{n:int} (xs: deque (INV(a), n)): [n >= 0] void
// end of [lemma_deque_param]

(* ****** ****** *)

fun{} fundeque_nil {a:t0p} ():<> deque (a, 0)

(* ****** ****** *)

fun{a:t0p}
fundeque_cons{n:nat}
  (x: a, xt: deque (INV(a), n)):<> deque (a, n+1)
// end of [fundeque_cons]

fun{a:t0p}
fundeque_uncons{n:pos}
  (xt: &deque (INV(a), n) >> deque (a, n-1)):<!wrt> a
// end of [fundeque_uncons]

(* ****** ****** *)

fun{a:t0p}
fundeque_snoc{n:nat}
  (xt: deque (INV(a), n), x: a):<> deque (a, n+1)
// end of [fundeque_snoc]

fun{a:t0p}
fundeque_unsnoc{n:pos}
  (xt: &deque (INV(a), n) >> deque (a, n-1)):<!wrt> a
// end of [fundeque_unsnoc]

(* ****** ****** *)

fun{} fundeque_is_nil
  {a:t0p}{n:nat} (xt: deque (INV(a), n)): bool (n==0)
// end of [fundeque_is_nil]

fun{} fundeque_is_cons
  {a:t0p}{n:nat} (xt: deque (INV(a), n)): bool (n > 0)
// end of [fundeque_is_cons]

(* ****** ****** *)

fun fundeque_size
  {a:t0p}{n:nat} (xt: deque (INV(a), n)):<> size_t (n)
// end of [fundeque_size]

(* ****** ****** *)

fun{a:t0p}
fundeque_get_atbeg {n:pos} (xt: deque (INV(a), n)):<> a

fun{a:t0p}
fundeque_get_atend {n:pos} (xt: deque (INV(a), n)):<> a

(* ****** ****** *)

fun fundeque_append
  {a:t0p}{n1,n2:nat}
  (xt1: deque (INV(a), n1), xt2: deque (a, n2)):<> deque (a, n1+n2)
// end of [fundeque_append]

(* ****** ****** *)

fun{
a:t0p}{env:vt0p
} fundeque_foreach$fwork (x: a, env: &env): void
fun{a:t0p}
fundeque_foreach (xs: Deque (INV(a))): void
fun{
a:t0p}{env:vt0p
} fundeque_foreach_env (xs: Deque (INV(a)), env: &(env)>>env): void

(* ****** ****** *)

fun{
a:t0p}{env:vt0p
} fundeque_rforeach$fwork (x: a, env: &env): void
fun{a:t0p}
fundeque_rforeach (xs: Deque (INV(a))): void
fun{
a:t0p}{env:vt0p
} fundeque_rforeach_env (xs: Deque (INV(a)), env: &(env)>>env): void

(* ****** ****** *)

(* end of [fundeque_fingertree.sats] *)
