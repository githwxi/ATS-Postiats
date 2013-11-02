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

absvtype
deque_vtype (a:vt@ype+, n:int) = ptr

(* ****** ****** *)

stadef deque = deque_vtype
vtypedef deque (a:vt0p, n:int) = deque_vtype (a, n)
vtypedef Deque (a:vt0p) = [n:int] deque (a, n)

(* ****** ****** *)

praxi
lemma_deque_param
  {a:vt0p}{n:int} (dq: !deque (INV(a), n)): [n >= 0] void
// end of [lemma_deque_param]

(* ****** ****** *)

fun{} lindeque_nil{a:vt0p} ():<> deque (a, 0)

(* ****** ****** *)

prfun lindeque_free_nil{a:vt0p} (dq: deque (a, 0)): void

(* ****** ****** *)
//
fun{} lindeque_is_nil
  {a:vt0p}{n:int} (dq: !deque (INV(a), n)):<> bool (n==0)
fun{} lindeque_isnot_nil
  {a:vt0p}{n:int} (dq: !deque (INV(a), n)):<> bool (n > 0)
//
(* ****** ****** *)

fun{a:vt0p}
lindeque_length {n:int} (dq: !deque (INV(a), n)):<> int (n)

(* ****** ****** *)
//
fun{a:vt0p}
lindeque_insert_at
  {n:int}{i:nat | i <= n}
(
  dq: &deque (INV(a), n) >> deque (a, n+1), i: int i, x: a
) : void // end of [lindeque_insert_at]
//
fun{a:vt0p}
lindeque_insert_atbeg{n:int}
  (dq: &deque (INV(a), n) >> deque (a, n+1), x: a): void
fun{a:vt0p}
lindeque_insert_atend{n:int}
  (dq: &deque (INV(a), n) >> deque (a, n+1), x: a): void
//
(* ****** ****** *)
//
fun{a:vt0p}
lindeque_takeout_at
  {n:int}{i:nat | i < n}
(
  dq: &deque (INV(a), n) >> deque (a, n-1), i: int i
) : a // end of [lindeque_takeout_at]
//
fun{a:vt0p}
lindeque_takeout_atbeg{n:pos}
  (dq: &deque (INV(a), n) >> deque (a, n-1)): (a)
fun{a:vt0p}
lindeque_takeout_atend{n:pos}
  (dq: &deque (INV(a), n) >> deque (a, n-1)): (a)
//
(* ****** ****** *)

(* end of [lindeque.hats] *)
