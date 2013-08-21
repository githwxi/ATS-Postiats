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
(* Start time: March, 2013 *)

(* ****** ****** *)

staload "libats/SATS/linmap.sats"
staload AVL = "libats/SATS/linmap_avltree.sats"

(* ****** ****** *)

#include "./SHARE/linmap.hats" // code reuse

(* ****** ****** *)

assume
map_vtype (key:t0p, itm:vt0p) = $AVL.map_vtype (key, itm)

(* ****** ****** *)

implement{}
linmap_nil = $AVL.linmap_nil

(* ****** ****** *)

implement{}
linmap_make_nil = $AVL.linmap_make_nil

(* ****** ****** *)

implement{}
linmap_is_nil = $AVL.linmap_is_nil
implement{}
linmap_isnot_nil = $AVL.linmap_isnot_nil

(* ****** ****** *)

implement
{key,itm}
linmap_size = $AVL.linmap_size

(* ****** ****** *)

implement
{key,itm}
linmap_search = $AVL.linmap_search
implement
{key,itm}
linmap_search_opt = $AVL.linmap_search_opt
implement
{key,itm}
linmap_search_ref = $AVL.linmap_search_ref

(* ****** ****** *)

implement
{key,itm}
linmap_insert = $AVL.linmap_insert
implement
{key,itm}
linmap_insert_opt = $AVL.linmap_insert_opt

(* ****** ****** *)

implement
{key,itm}
linmap_takeout = $AVL.linmap_takeout
implement
{key,itm}
linmap_takeout_opt = $AVL.linmap_takeout_opt
implement
{key,itm}
linmap_remove = $AVL.linmap_remove

(* ****** ****** *)

implement
{key,itm}{env}
linmap_foreach_env (map, env) = let
//
implement
$AVL.linmap_foreach$cont<key,itm><env> = linmap_foreach$cont<key,itm><env>
implement
$AVL.linmap_foreach$fwork<key,itm><env> = linmap_foreach$fwork<key,itm><env>
//
in
  $AVL.linmap_foreach_env<key,itm><env> (map, env)
end // end of [linmap_foreach_env]

(* ****** ****** *)

implement
{key,itm}
linmap_freelin (map) = let
//
implement
$AVL.linmap_freelin$clear<itm> = linmap_freelin$clear<itm>
//
in
  $AVL.linmap_freelin (map)
end // end of [linmap_freelin]

(* ****** ****** *)

implement
{key,itm}
linmap_free_ifnil = $AVL.linmap_free_ifnil

(* ****** ****** *)

implement
{key,itm}
linmap_listize_free = $AVL.linmap_listize_free

(* ****** ****** *)

implement
{key,itm}
linmap_listize
  (map) = let
//
implement
$AVL.linmap_listize$copy<itm> = linmap_listize$copy<itm>
//
in
  $AVL.linmap_listize (map)
end // end of [linmap_listize_copy]

(* ****** ****** *)

(* end of [linmap.dats] *)
