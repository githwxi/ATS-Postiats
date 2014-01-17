(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: August, 2013 *)

(* ****** ****** *)
//
// HX-2012-12:
// the map implementation is based on AVL trees
//
(* ****** ****** *)
//
staload FM =
"libats/SATS/funmap_avltree.sats"
//
(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)

staload "libats/ML/SATS/funmap.sats"

(* ****** ****** *)

assume
map_type (key:t0p, itm:t0p) = $FM.map (key, itm)

(* ****** ****** *)

implement{a}
compare_key_key = gcompare_val<a>
implement{a}
$FM.compare_key_key = compare_key_key<a>

(* ****** ****** *)

implement{}
funmap_nil () = $FM.funmap_nil ()
implement{}
funmap_make_nil () = $FM.funmap_make_nil ()

(* ****** ****** *)

implement{}
funmap_is_nil (map) = $FM.funmap_is_nil (map)
implement{}
funmap_isnot_nil (map) = $FM.funmap_isnot_nil (map)

(* ****** ****** *)
//
implement
{key,itm}
funmap_size (map) = $FM.funmap_size (map)
//
(* ****** ****** *)
//
implement
{key,itm}
funmap_search
  (map, k) = $FM.funmap_search_opt (map, k)
//
(* ****** ****** *)
//
implement
{key,itm}
funmap_insert
  (map, k, x) = $FM.funmap_insert_opt (map, k, x)
//
(* ****** ****** *)
//
implement
{key,itm}
funmap_takeout
  (map, k) = $FM.funmap_takeout_opt (map, k)
//
(* ****** ****** *)
//
implement
{key,itm}
funmap_remove (map, k) = $FM.funmap_remove (map, k)
//
(* ****** ****** *)

implement
{key,itm}
funmap_listize
  (map) = let
  val xs = $effmask_wrt ($FM.funmap_listize (map))
in
  list0_of_list_vt (xs)
end // end of [funmap_listize]

(* ****** ****** *)

(* end of [funmap.dats] *)
