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
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
(* ****** ****** *)

absvtype deque_vtype (a:viewt@ype+, n:int)
vtypedef deque (a:vt0p, n:int) = deque_vtype (a, n)
vtypedef Deque (a:vt0p) = [n:int] deque (a, n)

(* ****** ****** *)

praxi
lemma_deque_param
  {a:vt0p}{n:int} (dq: !deque (INV(a), n)): [n >= 0] void
// end of [lemma_deque_param]

(* ****** ****** *)

fun deque_nil{a:vt0p} (): deque (a, 0)

(* ****** ****** *)

prfun deque_free_nil{a:vt0p} (dq: !deque (a, 0)): void

(* ****** ****** *)
//
fun deque_is_nil
  {a:vt0p}{n:int} (dq: !deque (INV(a), n)): bool (n==0)
fun deque_isnot_nil
  {a:vt0p}{n:int} (dq: !deque (INV(a), n)): bool (n > 0)
//
(* ****** ****** *)
//
fun{a:vt0p}
deque_insert_at
  {n:int}{i:nat | i <= n}
(
  dq: &deque (INV(a), n) >> deque (a, n+1), i: int i, x: a
) : void // end of [deque_insert_at]
//
fun{a:vt0p}
deque_insert_atbeg{n:int}
  (dq: &deque (INV(a), n) >> deque (a, n+1), x: a): void
fun{a:vt0p}
deque_insert_atend{n:int}
  (dq: &deque (INV(a), n) >> deque (a, n+1), x: a): void
//
(* ****** ****** *)
//
fun{a:vt0p}
deque_takeout_at{n:int}{i:nat | i < n}
  (dq: &deque (INV(a), n) >> deque (a, n-1), i: int i): a
//
fun{a:vt0p}
deque_takeout_atbeg{n:pos} (dq: &deque (INV(a), n) >> deque (a, n-1)): a
fun{a:vt0p}
deque_takeout_atend{n:pos} (dq: &deque (INV(a), n) >> deque (a, n-1)): a
//
(* ****** ****** *)

absvtype
lindeque_node_vtype (a: vt@ype+, l:addr)

(* ****** ****** *)
//
stadef mynode = lindeque_node_vtype // HX: local shorthand
//
vtypedef
mynode (a:vt0p) = [l:addr] mynode (a, l)
vtypedef
mynode0 (a:vt0p) = [l:addr | l >= null] mynode (a, l)
vtypedef
mynode1 (a:vt0p) = [l:addr | l >  null] mynode (a, l)
//
(* ****** ****** *)

castfn
mynode2ptr
  {a:vt0p}{l:addr} (nx: !mynode (INV(a), l)):<> ptr (l)
// end of [mynode2ptr]

(* ****** ****** *)
//
fun{a:t0p} mynode_null ():<> mynode (a, null)
//
praxi
mynode_free_null {a:t0p} (nx: mynode (a, null)): void
//
(* ****** ****** *)

fun{a:vt0p} mynode_make_elt (x: a):<!wrt> mynode1 (a)

(* ****** ****** *)

(* end of [lindeque_dllist.sats] *)
