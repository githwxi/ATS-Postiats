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

absviewtype
map_viewtype (key:t@ype, itm:viewt@ype+)
stadef map = map_viewtype

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

fun{key:t0p}
compare_key_key (x1: key, x2: key):<> int

(* ****** ****** *)

fun{
} linmap_make_nil {key:t0p;itm:vt0p} ():<> map (key, itm)

(* ****** ****** *)

fun{
} linmap_is_nil
  {key:t0p;itm:vt0p} (map: !map (key, itm)):<> bool
// end of [linmap_is_nil]

fun{
} linmap_isnot_nil
  {key:t0p;itm:vt0p} (map: !map (key, itm)):<> bool
// end of [linmap_isnot_nil]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} linmap_size (map: !map (key, itm)):<> size_t

(* ****** ****** *)

fun{
key:t0p;itm:t0p
} linmap_free (map: map (key, itm)):<!wrt> void

(* ****** ****** *)

fun{
key:t0p;itm:t0p
} linmap_search (
  map: !map (key, itm), k0: key, res: &itm? >> opt (itm, b)
) :<!wrt> #[b:bool] bool b // end of [linmap_search]

fun{
key:t0p;itm:vt0p
} linmap_search_ref
  (map: !map (key, itm), k0: key):<> Ptr0
// end of [linmap_search_ref]

fun{
key:t0p;itm:t0p
} linmap_search_opt
  (map: !map (key, itm), k0: key):<> Option_vt (itm)
// end of [linmap_search_opt]

(* ****** ****** *)

fun{
} linmap_choose_m_n
  {m,n:nat} (m: int m, n: int n): natLt (2)
// end of [linmap_choose_m_n]
 
(* ****** ****** *)
//
// HX-2012-12:
// if [k0] occurs in [map], [x0] replaces the item
// associated with [k0] in [map]
//
fun{
key:t0p;itm:vt0p
} linmap_insert (
  map: &map (key, itm) >> _
, k0: key, x0: itm, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // end of [linmap_insert]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} linmap_takeout (
  map: &map (key, itm) >> _
, k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // end of [linmap_takeout]

fun{
key:t0p;itm:t0p
} linmap_remove (
  map: &map (key, itm) >> _, k0: key): bool
// end of [linmap_remove]

(* ****** ****** *)

(*
//
// HX: listization is done in the in-order fashion
//
*)
//
fun{key:t0p;itm:t0p}
linmap_listize (m: !map (key, itm)):<> List_vt @(key, itm)
// end of [linmap_listize]

fun{key:t0p;itm:vt0p}
linmap_listize_free (m: map (key, itm)):<!wrt> List_vt @(key, itm)
// end of [linmap_listize_free]

(* ****** ****** *)

(* end of [linmap_randbst.sats] *)
