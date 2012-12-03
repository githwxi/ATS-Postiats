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

staload "libats/SATS/linmap_skiplist.sats"

(* ****** ****** *)
//
// HX-2012-12-01:
// the file should be included here
// before [map_viewtype] is assumed
//
// #include "./linmap_share.hats" // in current dir
//
(* ****** ****** *)

abstype
node_type
  (l:addr, key:t@ype, itm:viewt@ype+)
stadef node = node_type
typedef
node0 (key:t0p, itm:vt0p) = [l:addr] node (l, key, itm)
typedef
node1 (key:t0p, itm:vt0p) = [l:addr | l > null] node (l, key, itm)

(* ****** ****** *)

extern
castfn
node2ptr
  {key:t0p;itm:vt0p}
  {l:addr} (nx: node (l, key, itm)):<> ptr (l)
// end of [node2ptr]

(* ****** ****** *)

extern
fun{}
node_nil {key:t0p;itm:vt0p} ():<> node (null, key, itm)

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} node_get_key (nx: node1 (key, itm)):<> key
extern
fun{
key:t0p;itm:vt0p
} node_getref_item (nx: node1 (key, itm)):<> Ptr1

(* ****** ****** *)

abstype
nodearr_type
  (key:t@ype, itm:viewt@ype+, int(*size*))
stadef nodearr = nodearr_type

extern
fun nodearr_get_node
  {key:t0p;itm:vt0p}{n:int} (
  nxa: nodearr (key, itm, n), i: natLt n
) :<> node0 (key, itm) // endfun

extern
fun nodearr_getref_node
  {key:t0p;itm:vt0p}{n:int}
  (nxa: nodearr (key, itm, n), i: natLt n):<> Ptr1
// end of [nodearr_getref_node]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} node_get_nodearr_size (
  nx: node1 (key, itm), n: &int? >> int n
) :<> #[n:nat] nodearr (key, itm, n)

(* ****** ****** *)

datavtype
skiplist (
  key:t@ype, itm:viewt@ype+
) =
  | {lgN:nat}
    SKIPLIST (key, itm) of (nodearr(key, itm, lgN), int(lgN))
// end of [skiplist]

(* ****** ****** *)

assume
map_viewtype
  (key:t0p, itm:vt0p) = skiplist (key, itm)
// end of [map_viewtype]

(* ****** ****** *)
//
// HX: returning node pointer
//
extern
fun{
key:t0p;itm:vt0p
} node_search_ref
  (nx: node1 (key, itm), k0: key):<> node0 (key, itm)
// end of [node_search_ref]
extern
fun{
key:t0p;itm:vt0p
} nodearr_search_ref {n:int}
  (nxa: nodearr (key, itm, n), ni: natLte n, k0: key):<> node0 (key, itm)
// end of [nodearr_search_ref]

(* ****** ****** *)

implement
{key,itm}
node_search_ref
  (nx, k0) = let
//
  val k = node_get_key (nx)
  val sgn = compare_key_key (k0, k)
//
in
//
if sgn < 0 then let
  var n: int
  val nxa = node_get_nodearr_size (nx, n)
  val res = nodearr_search_ref (nxa, n, k0)
in
  res
end else (
  if sgn > 0 then node_nil () else nx
) // end of [if]
//
end // end of [node_search_ref]

implement
{key,itm}
nodearr_search_ref
  (nxa, ni, k0) = let
in
//
if ni > 0 then let
  val ni = ni - 1
  val nx = nodearr_get_node (nxa, ni)
  val p_nx = node2ptr (nx)
in
  if p_nx > the_null_ptr then let
    val nx1 = node_search_ref (nx, k0)
    val p_nx1 = node2ptr (nx)
  in
    if p_nx1 > the_null_ptr then nx1 else nodearr_search_ref (nxa, ni, k0)
  end else
    nodearr_search_ref (nxa, ni, k0)
  // end of [if]
end else
  node_nil ()
// end of [if]
//
end // end of [nodearr_search_ref]

(* ****** ****** *)

implement
{key,itm}
linmap_search_ref
  (map, k0) = let
in
//
case+ map of
| SKIPLIST
    (nxa, lgN) => let
    val nx =
      nodearr_search_ref (nxa, lgN, k0)
    val p_nx = node2ptr (nx)
  in 
    if p_nx > the_null_ptr
      then node_getref_item (nx) else the_null_ptr
    // end of [if]
  end // end of [SKIPLIST]
//
end // end of [linmap_search_ref]

(* ****** ****** *)

(* end of [linmap_skiplist.dats] *)
