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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linmap_list.sats"

(* ****** ****** *)

#include "./SHARE/linmap.hats" // code reuse

(* ****** ****** *)

stadef
mytkind = $extkind"atslib_linmap_list"
assume
map_vtype (k:t0p, i:vt0p) = List0_vt @(k, i)

(* ****** ****** *)

implement{}
linmap_nil () = list_vt_nil ()

(* ****** ****** *)

implement{}
linmap_is_nil
  (map) = ans where {
  val ans = (
    case+ map of list_vt_nil _ => true | list_vt_cons _ => false
  ) : bool // end of [val]
} // end of [linmap_is_nil]

implement{}
linmap_isnot_nil
  (map) = ans where {
  val ans = (
    case+ map of list_vt_nil _ => false | list_vt_cons _ => true
  ) : bool // end of [val]
} // end of [linmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
linmap_size (map) = g1int2uint (list_vt_length (map))

(* ****** ****** *)

implement
{key,itm}
linmap_free (map) = list_vt_free<(key,itm)> (map)

(* ****** ****** *)

implement
{key,itm}
linmap_insert_any
  (map, k0, x0) = let
  val () = map := list_vt_cons ( @(k0, x0), map )
in
  // nothing
end // end of [linmap_insert_any]

(* ****** ****** *)

implement
{key,itm}{env}
linmap_foreach_env
  (map, env) = let
//
vtypedef ki = @(key, itm)
//
implement
list_vt_foreach$cont<ki><env> (kx, env) = linmap_foreach$cont (kx.0, kx.1, env)
implement
list_vt_foreach$fwork<ki><env> (kx, env) = linmap_foreach$fwork (kx.0, kx.1, env)
//
in
  list_vt_foreach_env (map, env)
end // end of [linmap_foreach_env]

(* ****** ****** *)

implement
{key,itm}
linmap_listize_free (map) = map // [map] is just a list

(* ****** ****** *)
//
// HX: ngc-functions make no use of malloc/free!
//
(* ****** ****** *)

implement
{key,itm}
linmap_search_ngc
  (map, k0) = let
//
vtypedef ki = @(key, itm)
//
fun loop
  {n:nat} .<n>. (
  kxs: !list_vt (ki, n), k0: key
) :<> Ptr0 = let
in
//
case+ kxs of
| @list_vt_cons
    (kx, kxs1) => let
    val iseq =
      equal_key_key<key> (kx.0, k0)
    // end of [val]
  in
    if iseq then let
      prval () = fold@ (kxs)
    in
      $UN.castvwtp1{Ptr1} (kxs)
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
  loop (map, k0) // HX: Ptr1
end // end of [linmap_search_ngc]

(* ****** ****** *)

implement
{key,itm}
linmap_takeout_ngc
  (map, k0) = let
//
vtypedef ki = @(key, itm)
vtypedef mynode0 = mynode0 (key, itm)
vtypedef mynode1 = mynode1 (key, itm)
//
fun loop (
  kxs: &List0_vt (ki) >> _, k0: key
) : mynode0 = let
//
vtypedef kis = List0_vt (ki)
//
in
//
case+ kxs of
| @list_vt_cons
    (kx, kxs1) => let
    val iseq =
      equal_key_key<key> (kx.0, k0)
    // end of [val]
  in
    if iseq then let
      val p1 = addr@ (kxs1)
      prval () = fold@ (kxs)
      val res = $UN.castvwtp0{mynode1} (kxs)
      val () = kxs := $UN.castvwtp0{kis} (p1)
    in
      res
    end else let
      val res = loop (kxs1, k0)
      prval () = fold@ (kxs) in res
    end // end of [if]
  end // end of [list_vt_cons]
| @list_vt_nil () => let
    prval () = fold@ (kxs) in mynode_null ()
  end // end of [list_vt_cons]
//
end // end of [loop]
//
in
  loop (map, k0) // HX: mynode0
end // end of [linmap_takeout_ngc]

(* ****** ****** *)

(* end of [linmap_list.dats] *)
