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
(* Authoremail: gmhwxiATgmailDOTcom*)
(* Start time: December, 2016 *)

(* ****** ****** *)
//
staload
"./GraphSearch.dats"
//
(* ****** ****** *)
//
staload
"./../../../../STL/DATS/queue_queue.dats"
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
  ((*void*)): queue(node)
extern
fun{}
theSearchStore_unget
  (stk: queue(node)): void
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
  queue_insert(theStore, nx);
  theSearchStore_unget(theStore)
)
else
(
  theSearchStore_unget(theStore)
)
//
end // end of [theSearchStore_insert]
//
(* ****** ****** *)

implement
theSearchStore_choose<>
  ((*void*)) = opt where
{
//
val
theStore =
theSearchStore_get()
//
val
opt =
queue_takeout_opt(theStore)
//
val () =
theSearchStore_unget(theStore)
//
} (* end of [theSearchStore_choose] *)
//
(* ****** ****** *)
//
extern
fun{}
GraphSearch_bfs_queue
  (stk: queue(node)): void
//
implement
{}(*tmp*)
GraphSearch_bfs_queue
  (store) = () where
{
//
val
p_store =
$UN.castvwtp1{ptr}(store)
//
implement
theSearchStore_get<>() =
  $UN.castvwtp1{queue(node)}(p_store)
implement
theSearchStore_unget<>(store) =
{
  prval () = $UN.cast2void(store)
}
//
val () = GraphSearch((*void*))
//
val () = queue_free_all(store)
//
} (* end of [GraphSearch_bfs_queue] *)
//
(* ****** ****** *)

(* end of [GraphSearch_bfs.dats] *)
