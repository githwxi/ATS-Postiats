(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: March, 2017 *)
(* Authoremail: hwxiATcsDOTbuDOTedu *)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.BUCS520.GraphStreamize"
//
(* ****** ****** *)
//
#staload
"./GraphStreamize.dats"
//
(* ****** ****** *)
//
#staload
"libats/SATS/sllist.sats"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
extern
fun{}
node_free(nx: node): void
(*
extern
fun{}
node_copy(nx: !node): node
*)
//
(* ****** ****** *)
//
extern
fun{}
node_mark(!node): void
extern
fun{}
node_unmark(!node): void
//
extern
fun{}
node_is_marked(!node): bool
overload
.is_marked with node_is_marked
//
(* ****** ****** *)
//
extern
fun{}
theStreamizeStore_get
  ((*void*)): Sllist0(node)
extern
fun{}
theStreamizeStore_set
  (store: Sllist0(node)): void
//
(* ****** ****** *)

implement
theStreamizeStore_free<>
  ((*void*)) = let
//
implement
sllist_freelin$clear<node>
  (nx0) =
  $effmask_all(node_free(nx0))
//
in
  sllist_freelin<node>(theStreamizeStore_get<>())
end // end of [theStreamizeStore_free]

(* ****** ****** *)
//
implement
theStreamizeStore_insert<>
  (nx) = let
//
val
theStore =
theStreamizeStore_get()
//
in
//
if
(nx.is_marked())
then
(
  node_free(nx);
  theStreamizeStore_set(theStore)
)
else
(
  node_mark(nx);
  theStreamizeStore_set(sllist_cons(nx, theStore))
)
//
end (* end of [theStreamizeStore_insert] *)
//
(* ****** ****** *)
//
implement
theStreamizeStore_choose<>
  (nx0) = let
//
var
nxs = theStreamizeStore_get()
//
in
//
if
isneqz(nxs)
then let
  val nx = sllist_uncons(nxs)
  val () = theStreamizeStore_set(nxs)
  val () = (nx0 := nx)
  prval () = opt_some(nx0) in true
end // end of [else]
else let
  val () =
  theStreamizeStore_set(nxs)
  prval () = opt_none(nx0) in false
end // end of [then]
//
end // end of [theStreamizeStore_choose]
//
(* ****** ****** *)
//
extern
fun{}
GraphStreamize_dfs
(
store:Sllist0(node)
) : stream_vt(node)
//
implement
{}(*tmp*)
GraphStreamize_dfs(store) =
  GraphStreamize<>() where
{
//
val
store =
$UN.castvwtp0{ptr}(store)
//
implement
theStreamizeStore_get<>
  ((*void*)) = $UN.castvwtp0(store)
implement
theStreamizeStore_set<>
  (store) = { prval() = $UN.cast2void(store) }
//
} (* GraphStreamize_dfs *)
//
(* ****** ****** *)

(* end of [GraphStreamize_dfs.dats] *)
