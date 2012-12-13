(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2010 Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see  the  file  COPYING.  If not, write to the Free
** Software Foundation, 51  Franklin  Street,  Fifth  Floor,  Boston,  MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(*
**
** A list-based queue implementation
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: July, 2010 // based on a version done in October, 2008
**
*)

(* ****** ****** *)
//
// HX-2012-12: ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
(* ****** ****** *)

%{#
#include "libats/CATS/linqueue_lst.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)
//
// HX: a: item type; n: current size
//
absviewt@ype
QUEUE (a:viewt@ype+, n: int) =
  $extype "atslib_linqueue_lst_QUEUE"
// end of [QUEUE]
typedef QUEUESZ (a:vt0p) = QUEUE (a, 0)?
viewtypedef QUEUE (a:vt0p) = [n:nat] QUEUE (a, n)

(* ****** ****** *)

fun{a:vt0p}
queue_size {n:nat} (q: &QUEUE (INV(a), n)):<> size_t n

fun queue_is_empty
  {a:vt0p} {n:nat} (q: &QUEUE (INV(a), n)):<> bool (n <= 0)
// end of [queue_is_empty]

fun queue_isnot_empty
  {a:vt0p} {n:nat} (q: &QUEUE (INV(a), n)):<> bool (n > 0)
// end of [queue_isnot_empty]

(* ****** ****** *)

fun{a:vt0p}
queue_initialize
  (q: &QUEUESZ (INV(a)) >> QUEUE (a, 0)):<> void
macdef queue_initize = queue_initialize

fun{a:vt0p}
queue_uninitialize
  {n:nat} (q: &QUEUE (INV(a), n) >> QUEUESZ (a)):<> list_vt (a, n)
macdef queue_uninitize = queue_uninitialize

(* ****** ****** *)

fun{a:vt0p}
queue_insert (*last*)
  {n:nat} (q: &QUEUE (INV(a), n) >> QUEUE (a, n+1), x: a):<> void
// end of [queue_insert]

fun{a:vt0p}
queue_remove (*first*)
  {n:nat | n > 0} (q: &QUEUE (INV(a), n) >> QUEUE (a, n-1)):<> a
// end of [queue_remove]

(* ****** ****** *)

fun{
a:vt0p}{env:vt0p
} queue_foreach$fwork (x: &a, env: &env): void
fun{
a:vt0p
} queue_foreach (q: !QUEUE (a)): void
fun{
a:vt0p}{env:vt0p
} queue_foreach_env (q: !QUEUE (INV(a)), env: &env): void

(* ****** ****** *)

(* end of [linqueue_lst.sats] *)
