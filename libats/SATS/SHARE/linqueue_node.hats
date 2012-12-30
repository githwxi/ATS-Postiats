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

absviewtype
mynode_viewtype (a:viewt@ype+, l:addr)
stadef mynode = mynode_viewtype
viewtypedef mynode (a) = [l:addr] mynode (a, l)
viewtypedef mynode0 (a) = [l:addr | l >= null] mynode (a, l)
viewtypedef mynode1 (a) = [l:addr | l >  null] mynode (a, l)

(* ****** ****** *)

praxi lemma_mynode_param
  {a:vt0p}{l:addr} (nx: !mynode (INV(a), l)): [l >= null] void
// end of [lemma_mynode_param]

(* ****** ****** *)

praxi mynode_free_null {a:vt0p}{l:addr} (nx: mynode (a, l)): void

(* ****** ****** *)

castfn
mynode2ptr {a:vt0p}{l:addr} (nx: !mynode (INV(a), l)):<> ptr (l)

(* ****** ****** *)

fun{a:vt0p}
mynode_getref_elt (nx: mynode1 (INV(a))):<> Ptr1

fun{a:vt0p}
mynode_make_elt (x: a):<> mynode1 (a)
fun{a:vt0p}
mynode_free_elt (nx: mynode1 (INV(a)), res: &(a?) >> a):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
queue_insert_ngc (*last*)
  {n:int} (
  q: !queue (INV(a), n) >> queue (a, n+1), nx: mynode1 (a)
) :<!wrt> void // end of [queue_insert_ngc]

(* ****** ****** *)

fun{a:vt0p}
queue_takeout_ngc (*first*)
  {n:int | n > 0}
  (q: !queue (INV(a), n) >> queue (a, n-1)):<!wrt> mynode1 (a)
// end of [queue_takeout_ngc]

(* ****** ****** *)

(* end of [linqueue_node.hats] *)
