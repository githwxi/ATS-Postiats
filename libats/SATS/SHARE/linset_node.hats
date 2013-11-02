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
// HX: shared by linset_listord (* ordered list *)
// HX: shared by linset_avltree (* AVL-tree-based *)
//
(* ****** ****** *)

absvtype
linset_node_vtype (a:t@ype+, l:addr) = ptr

(* ****** ****** *)
//
// HX: local shorthand
//
stadef mynode = linset_node_vtype
//
vtypedef
mynode (a:t0p) = [l:addr] mynode (a, l)
vtypedef
mynode0 (a:t0p) = [l:addr | l >= null] mynode (a, l)
vtypedef
mynode1 (a:t0p) = [l:addr | l >  null] mynode (a, l)
//
(* ****** ****** *)

castfn
mynode2ptr
  {a:t0p}{l:addr} (nx: !mynode (INV(a), l)):<> ptr (l)
// end of [mynode2ptr]

overload ptrcast with mynode2ptr

(* ****** ****** *)
//
fun{}
mynode_null{a:t0p} ():<> mynode (a, null)
//
praxi
mynode_free_null{a:t0p} (nx: mynode (a, null)): void
//
(* ****** ****** *)

fun{a:t0p}
mynode_make_elt (x: a):<!wrt> mynode1 (a)

(* ****** ****** *)

fun{}
mynode_free{a:t0p} (mynode1 (a)):<!wrt> void

(* ****** ****** *)

fun{a:t0p}
mynode_get_elt (nx: !mynode1 (INV(a))):<> a
fun{a:t0p}
mynode_set_elt{l:agz}
  (nx: !mynode (a?, l) >> mynode (a, l), x0: a):<!wrt> void
// end of [mynode_set_elt]

(* ****** ****** *)

fun{a:t0p}
mynode_getfree_elt (nx: mynode1 (INV(a))):<!wrt> a

(* ****** ****** *)

fun{a:t0p}
linset_insert_ngc
(
  set: &set(INV(a)) >> _, nx0: mynode1 (a)
) :<!wrt> mynode0 (a) // endfun

(* ****** ****** *)

fun{a:t0p}
linset_takeout_ngc
  (set: &set(INV(a)) >> _, x0: a):<!wrt> mynode0 (a)
// end of [linset_takeout_ngc]

(* ****** ****** *)

fun{a:t0p}
linset_takeoutmax_ngc
  (set: &set(INV(a)) >> _):<!wrt> mynode0 (a)
// end of [linset_takeoutmax]

(* ****** ****** *)

fun{a:t0p}
linset_takeoutmin_ngc
  (set: &set(INV(a)) >> _):<!wrt> mynode0 (a)
// end of [linset_takeoutmin]

(* ****** ****** *)

(* end of [linset_node.hats] *)
