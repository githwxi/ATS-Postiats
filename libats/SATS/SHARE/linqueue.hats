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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: December, 2012 *)

(* ****** ****** *)
//
// HX-2012-12:
// [a]: item type; [n]: queue size
//
absviewtype
queue_viewtype (a:viewt@ype+, n:int)
stadef queue = queue_viewtype
//
(* ****** ****** *)

praxi lemma_queue_param
  {a:vt0p}{n:int} (q: !queue (INV(a), n)): [n>=0] void
// end of [lemma_queue_param]

(* ****** ****** *)

fun{a:vt0p}
queue_make (): queue (a, 0)

fun{a:vt0p}
queue_free (q: queue (a, 0)):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
queue_is_empty
  {n:int} (q: !queue (a, n)):<> bool (n == 0)
// end of [queue_is_empty]

fun{a:vt0p}
queue_isnot_empty
  {n:nat} (q: !queue (INV(a), n)):<> bool (n > 0)
// end of [queue_isnot_empty]

(* ****** ****** *)

fun{a:vt0p}
queue_size {n:int} (q: !queue (INV(a), n)):<> size_t (n)

(* ****** ****** *)

fun{a:vt0p}
queue_insert (*last*)
  {n:int} (
  q: !queue (INV(a), n) >> queue (a, n+1), x: a
) :<!wrt> void // end of [queue_insert]

(* ****** ****** *)

fun{a:vt0p}
queue_takeout (*first*)
  {n:int | n > 0}
  (q: !queue (INV(a), n) >> queue (a, n-1)):<!wrt> a
// end of [queue_takeout]

(* ****** ****** *)

fun{
a:vt0p}{env:vt0p
} queue_foreach$cont (x: &a, env: &env): void
fun{
a:vt0p}{env:vt0p
} queue_foreach$fwork (x: &a, env: &(env) >> _): void
fun{
a:vt0p
} queue_foreach {n:int} (q: !queue (INV(a), n)): void
fun{
a:vt0p}{env:vt0p
} queue_foreach_env {n:int} (q: !queue (INV(a), n), env: &(env) >> _): void

(* ****** ****** *)

(* end of [linqueue.hats] *)
