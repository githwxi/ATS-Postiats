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
(* Start time: December, 2012 *)
(* Authoremail: hwxiATcsDOTbuDOTedu *)

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "libats/SATS/funmap_list.sats"

(* ****** ****** *)
//
#include "./SHARE/funmap.hats" // code reuse
//
(* ****** ****** *)
//
assume
map_type
(key:t0p, itm: vt0p) = List0 @(key, itm)
// end of [map_type]
//
(* ****** ****** *)

implement{} funmap_nil () = list_nil ()
implement{} funmap_make_nil () = list_nil ()

(* ****** ****** *)

implement{}
funmap_is_nil (map) =
  case+ map of list_nil _ => true | list_cons _ => false
// end of [funmap_is_nil]

implement{}
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
funmap_insert
(
  map, k0, x0, res
) = let
//
typedef ki = @(key, itm)
//
val ans =
  funmap_takeout<key,itm>(map, k0, res)
val () =
  (map := list_cons{ki}( @(k0, x0), map ))
// end of [val]
//
in
  ans
end // end of [funmap_insert]

(* ****** ****** *)

implement
{key,itm}
funmap_insert_any
  (map, k0, x0) = let
//
typedef ki = @(key, itm)
//
in
  map := list_cons{ki}( @(k0, x0), map )
end // end of [funmap_insert_any]

(* ****** ****** *)

implement
{key,itm}
funmap_takeout
  (map, k0, res) = let
//
typedef map = map (key, itm)
//
fun loop
(
  map: &map >> _
, kxs1: List0 @(key, itm)
, kxs2: List0_vt @(key, itm)
, k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) = let
//
typedef ki = @(key, itm)
//
in
//
case+ kxs1 of
| list_cons
    (kx, kxs1) => let
    val iseq = equal_key_key<key> (k0, kx.0)
  in
    if iseq then let
      val () = res := kx.1
      prval () = opt_some {itm} (res)
      val () = map := list_reverse_append1_vt (kxs2, kxs1)
    in
      true
    end else
      loop (map, kxs1, list_vt_cons{ki}(kx, kxs2), k0, res)
    // end of [if]
  end // end of [list_cons]
| list_nil () => let
    val () = list_vt_free<ki> (kxs2)
    prval () = opt_none {itm} (res) in false
  end // end of [list_nil]
//
end // end of [loop]
//
in
  loop (map, map, list_vt_nil (), k0, res)
end // end of [funmap_takeout]

(* ****** ****** *)

implement
{key,itm}{env}
funmap_foreach_env
  (map, env) = let
//
vtypedef ki = @(key, itm)
//
implement{ki}{env}
list_foreach$cont (kx, env) = true
implement
list_foreach$fwork<ki><env> (kx, env) =
  funmap_foreach$fwork<key,itm><env> (kx.0, kx.1, env)
//
in
  list_foreach_env<ki><env> (map, env)
end // end of [funmap_foreach_env]

(* ****** ****** *)

(* end of [funmap_list.dats] *)
