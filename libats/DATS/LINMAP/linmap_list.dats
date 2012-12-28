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

staload "libats/SATS/linmap_list.sats"

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
// before [map_viewtype] is assumed
//
#include "./linmap_share.hats" // in current dir
//
(* ****** ****** *)

assume
map_viewtype
  (key:t0p, itm: vt0p) = List0_vt @(key, itm)
// end of [map_viewtype]

(* ****** ****** *)

implement{key,itm} linmap_nil () = list_vt_nil ()

(* ****** ****** *)

implement
{key,itm}
linmap_is_nil (map) =
  case+ map of list_vt_nil _ => true | list_vt_cons _ => false
// end of [linmap_is_nil]

implement
{key,itm}
linmap_isnot_nil (map) =
  case+ map of list_vt_nil _ => false | list_vt_cons _ => true
// end of [linmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
linmap_size
  (map) = g1int2uint (list_vt_length (map))
// end of [linmap_size]

(* ****** ****** *)

implement
{key,itm}
linmap_free (map) = list_vt_free<(key,itm)> (map)

(* ****** ****** *)

implement
{key,itm}
linmap_search_ref
  (map, k0) = let
//
viewtypedef keyitm = @(key, itm)
//
fun loop
  {n:nat} .<n>. (
  kxs: !list_vt (keyitm, n), k0: key
) :<> Ptr0 = let
in
//
case+ kxs of
| @list_vt_cons (kx, kxs1) => let
    val iseq = equal_key_key<key> (kx.0, k0)
  in
    if iseq then let
      val res = addr@ (kx.1)
      prval () = fold@ (kxs) in res
    end else let
      val res = loop (kxs1, k0)
      prval () = fold@ (kxs) in res
    end // end of [if]
  end // end of [list_vt_cons]
| @list_vt_nil () => let
    prval () = fold@ (kxs) in the_null_ptr
  end // end of [list_vt_cons]
//
end // end of [loop]
//
in
  loop (map, k0)
end // end of [linmap_search_ref]

(* ****** ****** *)

implement
{key,itm}
linmap_insert_any
  (map, k0, x0) = (map := list_vt_cons ( @(k0, x0), map ))
// end of [linmap_insert_any]

(* ****** ****** *)

implement
{key,itm}{env}
linmap_foreach_env
  (map, env) = let
//
viewtypedef keyitm = @(key, itm)
//
implement
list_vt_foreach$cont<keyitm><env> (kx, env) = linmap_foreach$cont (kx.0, kx.1, env)
implement
list_vt_foreach$fwork<keyitm><env> (kx, env) = linmap_foreach$fwork (kx.0, kx.1, env)
//
in
  list_vt_foreach_env (map, env)
end // end of [linmap_foreach_env]

(* ****** ****** *)

implement
{key,itm}
linmap_listize
  (map) = list_vt_copy<(key,itm)> (map)
// end of [linmap_listize]

implement {key,itm} linmap_listize_free (map) = map

(* ****** ****** *)

(* end of [linmap_list.dats] *)
