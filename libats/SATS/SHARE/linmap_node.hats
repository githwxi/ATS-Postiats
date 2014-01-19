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
(* Start time: December, 2012 *)

(* ****** ****** *)
//
// HX: shared by linmap_list
//
(* ****** ****** *)

absvtype
linmap_node_vtype
  (key:t@ype, itm:vt@ype+, l:addr) = ptr(l)
// end of [linmap_node_vtype]

(* ****** ****** *)
//
stadef mynode = linmap_node_vtype // HX: local shorthand
//
vtypedef
mynode (key:t0p, itm:vt0p) = [l:addr] mynode (key, itm, l)
vtypedef
mynode0 (key:t0p, itm:vt0p) = [l:addr | l >= null] mynode (key, itm, l)
vtypedef
mynode1 (key:t0p, itm:vt0p) = [l:addr | l >  null] mynode (key, itm, l)
//
(* ****** ****** *)

castfn
mynode2ptr
  {key:t0p;itm:vt0p}
  {l:addr} (nx: !mynode (key, INV(itm), l)):<> ptr (l)
// end of [mynode2ptr]

(* ****** ****** *)
//
fun{}
mynode_null
  {key:t0p;itm:vt0p} ():<> mynode (key, itm, null)
//
praxi
mynode_free_null
  {key:t0p;itm:vt0p} (nx: mynode (key, itm, null)): void
//
(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} mynode_make_keyitm
  (k: key, x: itm):<!wrt> mynode1 (key, itm)
// end of [mynode_make_keyitm]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} mynode_get_key
  (nx: !mynode1 (key, INV(itm))):<> key
fun{
key:t0p;itm:vt0p
} mynode_getref_itm
  (nx: !mynode1 (key, INV(itm))):<> cPtr1 (itm)

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} mynode_free_keyitm
(
  nx: mynode1(key, INV(itm)), k0: &key? >> _, x0: &itm? >> _
) :<!wrt> void // end of [mynode_free_keyitm]

fun{
key:t0p;itm:vt0p
} mynode_getfree_itm (nx: mynode1 (key, INV(itm))):<!wrt> itm

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} linmap_search_ngc
  (map: !map (key, INV(itm)), k0: key): Ptr0(*mynode*)
// end of [linmap_search_ngc]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} linmap_insert_ngc
(
  map: &map (key, INV(itm)) >> _, nx: mynode1 (key, itm)
) : mynode0 (key, itm) // endfun

fun{
key:t0p;itm:vt0p
} linmap_insert_any_ngc
(
  map: &map (key, INV(itm)) >> _, nx: mynode1 (key, itm)
) : void // end of [linmap_insert_any_ngc]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} linmap_takeout_ngc
  (map: &map (key, INV(itm)) >> _, k0: key): mynode0 (key, itm)
// end of [linmap_takeout_ngc]

(* ****** ****** *)

(* end of [linmap_node.hats] *)
