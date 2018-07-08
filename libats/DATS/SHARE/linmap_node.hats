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
// HX: shared by linmap_avltree
//
(* ****** ****** *)

implement{key}
equal_key_key = gequal_val_val<key>
implement{key}
compare_key_key = gcompare_val_val<key>

(* ****** ****** *)

implement
{key,itm}
linmap_search_ref
  (map, k0) = let
//
val p0 = linmap_search_ngc (map, k0)
//
viewtypedef mynode1 = mynode1 (key,itm)
//
in
//
if p0 > 0 then let
//
val nx = $UN.castvwtp0{mynode1}{ptr}(p0)
val p_elt = mynode_getref_itm<key,itm> (nx)
val p0 = $UN.castvwtp0{ptr}{mynode1}(nx)
//
in
  p_elt
end else cptr_null () // end of [if]
//
end // end of [linmap_search_ref]

(* ****** ****** *)

implement
{key,itm}
linmap_takeout
  (map, k0, res) = let
//
val nx =
  linmap_takeout_ngc (map, k0)
val p_nx = mynode2ptr (nx)
//
in
//
if p_nx > 0 then let
  val () =
    res := mynode_getfree_itm (nx)
  // end of [val]
  prval () = opt_some{itm}(res) in true
end else let
  prval () = mynode_free_null (nx)
  prval () = opt_none{itm}(res) in false
end // end of [if]
//
end // end of [linmap_takeout]

(* ****** ****** *)

(* end of [linmap_node.hats] *)
