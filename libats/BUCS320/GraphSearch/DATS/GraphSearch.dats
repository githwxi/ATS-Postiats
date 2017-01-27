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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: November, 2016 *)

(* ****** ****** *)

abstype node = ptr
absvtype nodelst = ptr

(* ****** ****** *)
//
extern
fun{}
node_get_neighbors(nx: node): nodelst
//
(* ****** ****** *)
//
extern
fun{}
process_node(nx: node): bool
//
(* ****** ****** *)
//
extern
fun{}
theSearchStore_insert(node): void
extern
fun{}
theSearchStore_insert_lst(nodelst): void
//
(* ****** ****** *)
//
extern
fun{}
theSearchStore_choose((*void*)): Option_vt(node)
//
(* ****** ****** *)
//
extern
fun{}
GraphSearch(): void
//
(* ****** ****** *)

implement
{}(*tmp*)
GraphSearch
  ((*void*)) = let
//
fun
search
(
// argless
): void = let
//
val
opt =
theSearchStore_choose<>()
//
in
//
case+ opt of
| ~None_vt() => ()
| ~Some_vt(nx) => let
    val cont = process_node<>(nx)
  in
    if cont
      then let
        val nxs =
          node_get_neighbors<>(nx)
        // end of [val]
      in
        theSearchStore_insert_lst<>(nxs); search((*void*))
      end // end of [then]
    // end of [if]
  end (* end of [Some_vt] *)
//
end (* end of [search] *)
//
in
  search((*void*))
end // end of [GraphSearch]

(* ****** ****** *)

(* end of [GraphSearch.dats] *)
