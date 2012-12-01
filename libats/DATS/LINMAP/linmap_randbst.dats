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

staload "libats/SATS/linmap_randbst.sats"

(* ****** ****** *)
//
// HX-2012-12-01:
// the file should be included here
// before [map_viewtype] is assumed
//
#include "./linmap_share.hats" // in current dir
//
(* ****** ****** *)
//
// HX: for linear binary search trees
//
dataviewtype
bstree (
  key:t@ype, itm: viewt@ype+, int(*size*)
) =
  | BSTnil (
      key, itm, 0
    ) of (
      // argmentless
    ) // end of [BSTnil]
  | {nl,nr:nat}
    BSTcons (
      key, itm, 1+nl+nr
    ) of (
      int (1+nl+nr), key, itm, bstree (key, itm, nl), bstree (key, itm, nr)
    ) // end of [BSTcons]
// end of [bstree]
//
(* ****** ****** *)

assume
map_viewtype
  (key:t0p, itm: vt0p) = [n:nat] bstree (key, itm, n)
// end of [map_viewtype]

(* ****** ****** *)

implement{}
linmap_is_nil (map) =
  case+ map of BSTnil _ => true | BSTcons _ => false
// end of [linmap_is_nil]

(* ****** ****** *)

local

fun{
key:t0p;itm:vt0p
} search_ref
  {n:nat} .<n>. (
  t: !bstree (key, itm, n), k0: key
) :<> Ptr0 = let
in
//
case+ t of
| @BSTcons (
    _(*sz*), k, x, tl, tr
  ) => let
    val sgn = compare_key_key (k0, k)
  in
    case+ 0 of
    | _ when sgn < 0 => let
        val res = search_ref (tl, k0) in fold@ (t); res
      end // end of [_]
    | _ when sgn > 0 => let
        val res = search_ref (tr, k0) in fold@ (t); res
      end // end of [_]
    | _ => let
        val res = addr@ (x) in fold@ (t); res
      end // end of [_]
  end // end of [BSTcons]
| BSTnil () => the_null_ptr
//
end // end of [search_ref]

in // in of [local]

implement
{key,itm}
linmap_search_ref
  (map, k0) = search_ref<key,itm> (map, k0)
// end of [linmap_search_ref]

end // end of [local]

(* ****** ****** *)

local

fun{
key:t0p;itm:t0p
} _free
  {n:nat} .<n>. (
  t: bstree (key, itm, n)
) :<!wrt> void = let
in
//
case+ t of
| ~BSTcons (
    _, _, _, tl, tr
  ) => let
    val () = _free (tl)
    and () = _free (tr) in (*nothing*)
  end // end of [BSTcons]
| ~BSTnil () => ()
//
end // end of [_free]

in // in of [local]

implement
{key,itm}
linmap_free (map) = _free<key,itm> (map)

end // end of [local]

(* ****** ****** *)

implement
{key,itm}
linmap_listize
  (map) = let
//
typedef ki = @(key, itm)
//
fun aux
  {m,n:nat} .<n>. (
  t: !bstree (key, itm, n), res: list_vt (ki, m)
) :<> list_vt (ki, m+n) = let
in
//
case+ t of
| BSTcons (
    _, k, i, tl, tr
  ) => res where {
    val res = aux (tr, res)
    val res = list_vt_cons ((k, i), res)
    val res = aux (tl, res)
  } // end of [BSTcons]
| BSTnil () => res
//
end // end of [aux]
//
in
  aux (map, list_vt_nil ())
end // end of [linmap_listize]

implement
{key,itm}
linmap_listize_free
  (map) = let
//
viewtypedef ki = @(key, itm)
//
fun aux
  {m,n:nat} .<n>. (
  t: bstree (key, itm, n), res: list_vt (ki, m)
) :<!wrt> list_vt (ki, m+n) = let
in
//
case+ t of
| ~BSTcons (
    _, k, i, tl, tr
  ) => res where {
    val res = aux (tr, res)
    val res = list_vt_cons ((k, i), res)
    val res = aux (tl, res)
  } // end of [BSTcons]
| ~BSTnil () => res
//
end // end of [aux]
//
in
  aux (map, list_vt_nil ())
end // end of [linmap_listize_free]

(* ****** ****** *)

(* end of [linmap_randbst.dats] *)
