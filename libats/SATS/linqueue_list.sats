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
//
// HX: no need for staloading at
#define ATS_STALOADFLAG 0 // run-time
//
(* ****** ****** *)

%{#
#include "libats/CATS/linqueue_list.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats"
#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

#include "./SHARE/linqueue.hats"
#include "./SHARE/linqueue_node.hats"

(* ****** ****** *)

fun{a:vt0p}
queue_takeout_list
  {n:int} (q: !queue (INV(a), n) >> queue (a, 0)):<!wrt> list_vt (a, n)
// end of [queue_takeout_list]

(* ****** ****** *)
//
abst@ype
qstruct_tsz =
  $extype "atslib_linqueue_list_qstruct"
absviewt@ype
qstruct_vt0ype (a:viewt@ype+, n:int) = qstruct_tsz
//
stadef qstruct = qstruct_vt0ype
stadef qstruct = qstruct_tsz // HX: order significant
//
viewtypedef
Qstruct (a:vt0p) = [n:nat] qstruct (a, n)
//
(* ****** ****** *)

fun{a:vt0p}
qstruct_initize
  (q: &qstruct? >> qstruct (a, 0)):<!wrt> void
fun{a:vt0p}
qstruct_uninitize
  (q: &qstruct (a, 0) >> qstruct?):<!wrt> void

(* ****** ****** *)

praxi
qstruct_objfize
  {a:vt0p}{l:addr}{n:int} (
  pf: qstruct (INV(a), n) @ l | p: !ptrlin l >> queue (a, n)
) :<> free_ngc_v (l) // endfun

praxi
qstruct_unobjfize
  {a:vt0p}{l:addr}{n:int} (
  pf: free_ngc_v l | p: ptr l, q: !queue (INV(a), n) >> ptrlin l
) :<> qstruct (a, n) @ l // endfun

(* ****** ****** *)

fun{a:vt0p}
qstruct_insert (*last*)
  {n:int} (q: &qstruct (INV(a), n) >> qstruct (a, n+1), x: a):<!wrt> void
// end of [qstruct_insert]

fun{a:vt0p}
qstruct_takeout (*first*)
  {n:int | n > 0} (q: &qstruct (INV(a), n) >> qstruct (a, n-1)):<!wrt> (a)
// end of [qstruct_takeout]

fun{a:vt0p}
qstruct_takeout_list
  {n:int} (q: &qstruct (INV(a), n) >> qstruct (a, 0)):<!wrt> list_vt (a, n)
// end of [qstruct_takeout_list]

(* ****** ****** *)

(* end of [linqueue_list.sats] *)
