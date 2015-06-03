(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: June, 2015 *)

(* ****** ****** *)

#define
ATS_PACKNAME "ATSLIB.libats.funmap_rbtree"
#define
ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/funmap_rbtree.sats"

(* ****** ****** *)

implement
{key}
compare_key_key
  (k1, k2) = gcompare_val_val<key> (k1, k2)
// end of [compare_key_key]

(* ****** ****** *)
//
#define BLK 0; #define RED 1
//
sortdef clr = {c:nat | c <= 1}
//
typedef color(c:int) = int(c)
typedef color = [c:clr] color(c)
//
(* ****** ****** *)
//
// HX-2012-12-26:
// the file should be included here
// before [map_type] is assumed
//
#include "./SHARE/funmap.hats" // code reuse
//
(* ****** ****** *)
//
datatype rbtree
(
  key:t@ype, itm: t@ype
, int(*color*), int(*bheight*), int(*violation*)
) =
  | E (key, itm, BLK, 0, 0)
  | {c,cl,cr:clr}{bh:nat}{v:int}
    {c == BLK && v == 0 ||
     c == RED && v == cl+cr}
    T (key, itm, c, bh+1-c, v) of
    (
      color c, key, itm
    , rbtree0 (key, itm, cl, bh), rbtree0 (key, itm, cr, bh)
    ) (* end of [T] *)
// end of [datatype rbtree]
//
where
rbtree0
(
  key:t@ype, itm:t@ype, c:int, bh:int
) =
  rbtree (key, itm, c, bh, 0(*violation*))
// end of [rbtree0]
//
(* ****** ****** *)
//
assume
map_type
(
  key:t0p, itm:t0p
) = [c:clr;bh:nat] rbtree0 (key, itm, c, bh)
// end of [map_type]
//
(* ****** ****** *)

implement{} funmap_nil () = E ()
implement{} funmap_make_nil () = E ()

(* ****** ****** *)

implement
{}(*tmp*)
funmap_is_nil (map) =
  case+ map of E _ => true | T _ => false
// end of [funmap_is_nil]

implement
{}(*tmp*)
funmap_isnot_nil (map) =
  case+ map of T _ => true | E _ => false
// end of [funmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
funmap_size
  (map) = let
//
typedef
rbtree0
(
  c:int, bh:int
) = rbtree0(key, itm, c, bh)
//
fun
aux
{c:clr}
{bh:nat}
(
  t0: rbtree0(c, bh), res: size_t
) : size_t = let
in
//
case+ t0 of
| T (
    _, _, _, tl, tr
  ) => let
    val res = succ(res)
    val res = aux (tl, res)
    val res = aux (tr, res)
  in
    res
  end // end of [B]
| E ((*void*)) => res
//
end // end of [aux]
//
in
  $effmask_all (aux (map, i2sz(0)))
end // end of [funmap_size]

(* ****** ****** *)

implement
{key,itm}
funmap_search
  (map, k0, res) = let
//
typedef
rbtree0
(
  c:int, bh:int
) = rbtree0(key, itm, c, bh)
//
fun
search
{c:clr}
{bh:nat} .<bh,c>.
(
  t0: rbtree0(c, bh)
, res: &itm? >> opt (itm, b)
) :<!wrt> #[b:bool] bool(b) = let
in
//
case+ t0 of
| T (
    _(*h*), k, x, tl, tr
  ) => let
    val sgn =
      compare_key_key<key> (k0, k)
    // end of [val]
  in
    case+ 0 of
    | _ when sgn < 0 => search (tl, res)
    | _ when sgn > 0 => search (tr, res)
    | _ => let
        val () = res := x
        prval () = opt_some{itm}(res) in true
      end // end of [_]
  end // end of [B]
| E () => 
    let prval () = opt_none{itm}(res) in false end
  // end of [E]
//
end // end of [search]
//
in
  search (map, res)
end // end of [funmap_search]

(* ****** ****** *)

(* end of [funmap_rbtree.dats] *)
