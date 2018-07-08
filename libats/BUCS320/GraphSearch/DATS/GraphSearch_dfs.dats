(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: November, 2016 *)
(* Authoremail: hwxiATcsDOTbuDOTedu *)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats\
.BUCS320.GraphSearch_dfs"
//
(* ****** ****** *)
//
staload "./GraphSearch.dats"
//
(* ****** ****** *)
//
staload
"libats/ML/SATS/slistref.sats"
staload
"libats/ML/SATS/stream_vt.sats"
//
(* ****** ****** *)
//
extern
fun{}
node_mark(node): void
extern
fun{}
node_unmark(node): void
//
extern
fun{}
node_is_marked(node): bool
overload
.is_marked with node_is_marked
//
(* ****** ****** *)
//
extern
fun{}
theSearchStore_get
  ((*void*)): slistref(node)
//
(* ****** ****** *)
//
implement
theSearchStore_insert<>
  (nx) = let
//
val
theStore = theSearchStore_get()
//
in
//
if
~(nx.is_marked())
then
(
  node_mark(nx);
  slistref_insert(theStore, nx)
)
//
end (* end of [theSearchStore_insert] *)
//
implement
theSearchStore_choose<>
  ((*void*)) = let
//
val
theStore = theSearchStore_get()
//
in
  slistref_takeout_opt(theStore)
end // end of [theSearchStore_choose]
//
(* ****** ****** *)
//
extern
fun{}
GraphSearch_dfs
  (store: slistref(node)): void
//
implement
{}(*tmp*)
GraphSearch_dfs(store) =
  GraphSearch<>() where
{
implement theSearchStore_get<>() = store
} (* GraphSearch_dfs *)
//
(* ****** ****** *)

(* end of [GraphSearch_dfs.dats] *)
