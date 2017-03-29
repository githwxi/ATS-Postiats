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

abstype node_type = ptr
abstype nodelst_type = ptr

(* ****** ****** *)

typedef node = node_type
typedef nodelst = nodelst_type

(* ****** ****** *)
//
extern
fun{}
node_get_neighbors(nx: !node): nodelst
//
(* ****** ****** *)
//
extern
fun{}
theStreamizeStore_insert(node): void
extern
fun{}
theStreamizeStore_insert_lst(nodelst): void
//
(* ****** ****** *)
//
extern
fun{}
theStreamizeStore_choose
(
nx0: &node? >> opt(node, b)
) : #[b:bool] bool(b) // endfun
//
extern
fun{}
theStreamizeStore_choose_opt(): Option_vt(node)
//
(* ****** ****** *)
//
implement
theStreamizeStore_choose<>
  (nx0) = let
//
val opt =
theStreamizeStore_choose_opt<>()
//
in
//
case+ opt of
| ~Some_vt(nx) => let
    val () = nx0 := nx
    prval () = opt_some(nx0) in true
  end // end of [Some_vt]
| ~None_vt((*void*)) => let
    prval () = opt_none(nx0) in false
  end // end of [None_vt]
//
end // end of [theStreamizeStore_choose]
//
(* ****** ****** *)
//
extern
fun{}
GraphStreamize((*void*)): stream(node)
//
(* ****** ****** *)

implement
{}(*tmp*)
GraphStreamize
  ((*void*)) =
  streamize() where
{
//
fun
streamize
(
// argless
): stream(node) = $delay
(
let
//
var nx0: node?
val
ans =
theStreamizeStore_choose<>(nx0)
//
in
//
if
(ans)
then let
//
val nx = nx0 where
{
  prval() = opt_unsome(nx0)
}
val nxs =
node_get_neighbors<>(nx)
// end of [val]
val ((*void*)) =
theStreamizeStore_insert_lst<>(nxs)
// end of [val]
//
prval ((*void*)) = topize(nx0)
//
in
  stream_cons(nx, streamize())
end // end of [then]
else let
//
in
//
stream_nil()
  where { prval() = opt_unnone(nx0) }
//
end // end of [else]
//
end // end of [let]
) (* end of [streamize] *)
//
} (* end of [GraphStreamize] *)

(* ****** ****** *)

(* end of [GraphStreamize.dats] *)
