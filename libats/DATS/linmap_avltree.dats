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

staload "libats/SATS/linmap_avltree.sats"

(* ****** ****** *)

#include "./SHARE/linmap.hats" // code reuse

(* ****** ****** *)

stadef mytkind = $extkind"atslib_linmap_avltree"

(* ****** ****** *)
//
// HX: maximal height difference of two siblings
//
#define HTDF 1
#define HTDF1 (HTDF+1)
#define HTDF_1 (HTDF-1)
//
(* ****** ****** *)

datavtype avltree
(
  key: t@ype, itm:vt@ype+, int(*height*)
) =
  | {hl,hr:nat |
     hl <= hr+HTDF;
     hr <= hl+HTDF}
    B (key, itm, 1+max(hl,hr)) of
    (
      int (1+max(hl,hr)), key, itm, avltree (key, itm, hl), avltree (key, itm, hr)
    )
  | E (key, itm, 0) of ((*void*))
// end of [datavtype avltree]

(* ****** ****** *)

vtypedef avltree
  (key:t0p, itm:vt0p) = [h:nat] avltree (key, itm, h)
// end of [avltree]

vtypedef avltree_inc
  (key:t0p, itm:vt0p, h:int) =
  [h1:nat | h <= h1; h1 <= h+1] avltree (key, itm, h1)
// end of [avltree_inc]

vtypedef avltree_dec
  (key:t0p, itm:vt0p, h:int) =
  [h1:nat | h1 <= h; h <= h1+1] avltree (key, itm, h1)
// end of [avltree_dec]

(* ****** ****** *)

assume
map_vtype (key:t0p, itm: vt0p) = avltree (key, itm)
// end of [map_vtype]

(* ****** ****** *)

implement{} linmap_nil () = E ()
implement{} linmap_make_nil () = E ()

(* ****** ****** *)

implement{}
linmap_is_nil (map) =
  case+ map of E _ => true | B _ => false
// end of [linmap_is_nil]

implement{}
linmap_isnot_nil (map) =
  case+ map of B _ => true | E _ => false
// end of [linmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
linmap_size
  (map) = let
//
fun aux
(
  t0: !avltree (key, itm), res: size_t
) : size_t = let
in
//
case+ t0 of
| B (
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
end // end of [linmap_size]

(* ****** ****** *)

implement
{key,itm}
linmap_search_ref
  (map, k0) = let
//
fun search
  {h:nat} .<h>. (
  t0: !avltree (key, itm, h)
) :<!wrt> cPtr0(itm) = let
in
//
case+ t0 of
//
| @B (
    _(*h*), k, x, tl, tr
  ) => let
    val sgn =
      compare_key_key<key> (k0, k)
    // end of [val]
  in
    case+ 0 of
    | _ when sgn < 0 => let
        val res = search (tl)
        prval () = fold@ (t0) in res
      end // end of [sgn < 0]
    | _ when sgn > 0 => let
        val res = search (tr)
        prval () = fold@ (t0) in res
      end // end of [sgn > 0]
    | _ (*sgn = 0*) => let
        val p_x = addr@x
        prval () = fold@ (t0) in $UN.ptr2cptr(p_x)
      end // end of [sgn = 0]
  end // end of [let] // end of [B]
//
| E ((*void*)) => cptr_null{itm}()
//
end // end of [search]
//
in
  search (map)
end // end of [linmap_search_ref]

(* ****** ****** *)

(* end of [linmap_avltree.dats] *)
