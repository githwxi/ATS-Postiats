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

staload "libats/SATS/funmap_list.sats"

(* ****** ****** *)

implement
{key}
equal_key_key
  (k1, k2) = gequal_val<key> (k1, k2)
// end of [equal_key_key]

(* ****** ****** *)
//
// HX-2012-12-26:
// the file should be included here
// before [map_type] is assumed
//
#include "./funmap_share.hats" // in current dir
//
(* ****** ****** *)

assume
map_type
  (key:t0p, itm: vt0p) = List0 @(key, itm)
// end of [map_type]

(* ****** ****** *)

implement{key,itm} funmap_nil () = list_nil ()

(* ****** ****** *)

implement
{key,itm}
funmap_is_nil (map) =
  case+ map of list_nil _ => true | list_cons _ => false
// end of [funmap_is_nil]

implement
{key,itm}
funmap_isnot_nil (map) =
  case+ map of list_nil _ => false | list_cons _ => true
// end of [funmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
funmap_size
  (map) = g1int2uint (list_length (map))
// end of [funmap_size]

(* ****** ****** *)

implement
{key,itm}
funmap_search
  (map, k0, res) = let
//
fun search (
  kxs: List @(key, itm)
, k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) = let
in
//
case+ kxs of
| list_cons
    (kx, kxs) => let
    val iseq =
      equal_key_key<key> (k0, kx.0)
    // end of [val]
  in
    if iseq then let
      val () = res := kx.1
      prval () = opt_some {itm} (res) in true
    end else
      search (kxs, k0, res)
    // end of [if]
  end // end of [list_cons]
| list_nil () => let
    prval () = opt_none {itm} (res) in false
  end // end of [list_nil]
//
end // end of [search]
//
in
//
  $effmask_all (search (map, k0, res))
//
end // end of [funmap_search]

(* ****** ****** *)

implement
{key,itm}
funmap_listize (map) = list_copy<(key,itm)> (map)

(* ****** ****** *)

(* end of [funmap_list.dats] *)
