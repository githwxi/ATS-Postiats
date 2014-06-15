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
// HX-2013-05: linear deque based on circular doubly-linked list (dllist)
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.lindeque_dllist"

(* ****** ****** *)

#include "./SHARE/lindeque.hats"

(* ****** ****** *)
//
// HX-2013-05: functions of ngc-version
//
(* ****** ****** *)

staload "libats/SATS/dllist.sats"

(* ****** ****** *)
//
fun{a:vt0p}
lindeque_insert_at_ngc
  {n:int}{i:nat | i <= n}
(
  dq: &deque (INV(a), n) >> deque (a, n+1), i: int i, x: g2node1(a)
) : void // end of [lindeque_insert_at_ngc]
//
fun{a:vt0p}
lindeque_insert_atbeg_ngc{n:int}
(
  dq: &deque (INV(a), n) >> deque (a, n+1), nx: g2node1(a)
) :<!wrt> void // end of [lindeque_insert_atbeg_ngc]
fun{a:vt0p}
lindeque_insert_atend_ngc{n:int}
(
  dq: &deque (INV(a), n) >> deque (a, n+1), nx: g2node1(a)
) :<!wrt> void // end of [lindeque_insert_atend_ngc]
//
(* ****** ****** *)
//
fun{a:vt0p}
lindeque_takeout_at_ngc{n:int}{i:nat | i < n}
(
  dq: &deque (INV(a), n) >> deque (a, n-1), i: int i
) : g2node1(a) // end of [lindeque_takeout_at_ngc]
//
fun{a:vt0p}
lindeque_takeout_atbeg_ngc{n:pos}
  (dq: &deque (INV(a), n) >> deque (a, n-1)):<!wrt> g2node1(a)
fun{a:vt0p}
lindeque_takeout_atend_ngc{n:pos}
  (dq: &deque (INV(a), n) >> deque (a, n-1)):<!wrt> g2node1(a)
//
(* ****** ****** *)

fun{a:vt0p}
lindeque2dllist{n:int} (dq: deque (INV(a), n)):<!wrt> dllist (a, 0, n)
// end of [fun]

(* ****** ****** *)

(* end of [lindeque_dllist.sats] *)
