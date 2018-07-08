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
"ATSLIB.libats.BUCS320.GraphStreamize"
//
(* ****** ****** *)
//
#staload
"./GraphStreamize.dats"
//
(* ****** ****** *)
//
#staload
"libats/ML/SATS/slistref.sats"
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
  ((*void*)): slistref(node)
extern
fun{}
theStreamizeStore_set
  (store: slistref(node)): void
//
(* ****** ****** *)
//
implement
theStreamizeStore_insert<>
  (nx) = let
//
val
store =
theStreamizeStore_get()
//
in
//
if
(nx.is_marked())
then
(
  theStreamizeStore_set(store)
)
else
(
  node_mark(nx);
  slistref_insert(store, nx);
  theStreamizeStore_set(store)
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
store =
theStreamizeStore_get()
//
val opt =
slistref_takeout_opt(store)
//
in
//
case+ opt of
| ~None_vt() => false where
  {
  prval () = opt_none(nx0)
    val () = theStreamizeStore_set(store)
  }
| ~Some_vt(nx) => true where
  {
    val () = (nx0 := nx)
  prval () = opt_some(nx0)
    val () = theStreamizeStore_set(store)
  }
//
end // end of [theStreamizeStore_choose]
//
(* ****** ****** *)
//
extern
fun{}
GraphStreamize_dfs
  (slistref(node)): stream(node)
//
implement
{}(*tmp*)
GraphStreamize_dfs
  (store) = GraphStreamize<>() where
{
//
implement
theStreamizeStore_get<>() = store
implement
theStreamizeStore_set<>(store) = ((*void*))
//
} (* GraphStreamize_dfs *)
//
(* ****** ****** *)

(* end of [GraphStreamize_dfs.dats] *)
