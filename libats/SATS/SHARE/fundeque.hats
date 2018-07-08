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
// HX: shared by fundeque_fngtree
//
(* ****** ****** *)
//
// HX: indexed by deque size
//
abstype
deque_type
(elt:t@ype+, n:int) = ptr
//
(* ****** ****** *)
//
stadef deque = deque_type
//
typedef deque(a:t0p) = [n:int] deque(a, n)
typedef Deque(a:t0p) = [n:int] deque(a, n)
//
(* ****** ****** *)

prfun
lemma_deque_size
  {a:t0p}{n:int} (xs: deque(INV(a), n)): int(n)
// end of [lemma_deque_size]

prfun
lemma_deque_param
  {a:t0p}{n:int} (xs: deque(INV(a), n)): [n >= 0] void
// end of [lemma_deque_param]

(* ****** ****** *)

fun{}
fundeque_nil{a:t0p} ():<> deque(a, 0)
fun{}
fundeque_make_nil{a:t0p} ():<> deque(a, 0)

(* ****** ****** *)
//
fun
{a:t0p}
fundeque_cons{n:int}
  (x: a, xs: deque(INV(a), n)):<> deque(a, n+1)
// end of [fundeque_cons]
//
fun
{a:t0p}
fundeque_uncons{n:pos}
  (xs: &deque(INV(a), n) >> deque(a, n-1)):<!wrt> (a)
// end of [fundeque_uncons]
//
(* ****** ****** *)
//
fun
{a:t0p}
fundeque_snoc{n:int}
  (xs: deque(INV(a), n), x: a):<> deque(a, n+1)
// end of [fundeque_snoc]
//
fun
{a:t0p}
fundeque_unsnoc{n:pos}
  (xs: &deque(INV(a), n) >> deque(a, n-1)):<!wrt> (a)
// end of [fundeque_unsnoc]
//
(* ****** ****** *)
//
fun
{a:t0p}
fundeque_size
  {n:int}(xs: deque(INV(a), n)):<> size_t(n)
//
(* ****** ****** *)
//
fun{}
fundeque_is_nil
  {a:t0p}{n:int}(xs: deque(INV(a), n)):<> bool(n==0)
// end of [fundeque_is_nil]
//
fun{}
fundeque_is_cons
  {a:t0p}{n:int}(xs: deque(INV(a), n)):<> bool(n > 0)
// end of [fundeque_is_cons]
//
(* ****** ****** *)
//
fun
{a:t0p}
fundeque_get_atbeg{n:pos}(xs: deque(INV(a), n)):<> (a)
fun
{a:t0p}
fundeque_get_atend{n:pos}(xs: deque(INV(a), n)):<> (a)
//
fun
{a:t0p}
fundeque_get_atbeg_opt(xs: Deque(INV(a))):<> Option_vt(a)
fun
{a:t0p}
fundeque_get_atend_opt(xs: Deque(INV(a))):<> Option_vt(a)
//
(* ****** ****** *)
//
fun
{a:t0p}
fundeque_takeout_atbeg_opt
  (xs: &Deque (INV(a)) >> _):<!wrt> Option_vt (a)
// end of [fundeque_takeout_atbeg_opt]
//
fun
{a:t0p}
fundeque_takeout_atend_opt
  (xs: &Deque (INV(a)) >> _):<!wrt> Option_vt (a)
// end of [fundeque_takeout_atend_opt]
//
(* ****** ****** *)
//
fun
{a:t0p}
fundeque_append
  {n1,n2:int}
  (deque(INV(a), n1), deque(a, n2)):<> deque(a, n1+n2)
//
(* ****** ****** *)
//
fun{}
fprint_fundeque$sep(out: FILEref): void
//
fun{a:t0p}
fprint_fundeque
  (out: FILEref, xs: Deque(INV(a))): void
//
(* ****** ****** *)
//
fun
{a:t0p}
fundeque_foreach(xs: Deque(INV(a))): void
//
fun
{a:t0p}
{env:vt0p}
fundeque_foreach$fwork(x: a, env: &env>>_): void
fun
{a:t0p}
{env:vt0p}
fundeque_foreach_env(xs: Deque(INV(a)), env: &(env)>>_): void
//
(* ****** ****** *)
//
fun
{a:t0p}
fundeque_rforeach(xs: Deque(INV(a))): void
//
fun
{a:t0p}
{env:vt0p}
fundeque_rforeach$fwork(x: a, env: &env>>_): void
fun
{a:t0p}
{env:vt0p}
fundeque_rforeach_env(xs: Deque(INV(a)), env: &(env)>>_): void
//
(* ****** ****** *)
//
fun
{a:t0p}
fundeque_listize
  {n:int}(xs: deque(INV(a), n)):<!wrt> list_vt(a, n)
// end of [fundeque_listize]
//
(* ****** ****** *)
//
// overloading for certain symbols
//
(* ****** ****** *)
//
overload iseqz with fundeque_is_nil
overload isneqz with fundeque_is_cons
//
(* ****** ****** *)
//
overload fprint with fprint_fundeque
//
(* ****** ****** *)
//
overload .size with fundeque_size
//
(* ****** ****** *)
//
overload .head with fundeque_get_atbeg
overload .last with fundeque_get_atend
//
(* ****** ****** *)

(* end of [fundeque.hats] *)
