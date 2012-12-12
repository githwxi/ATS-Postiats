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

fun linmap_make_nil
  {key:t0p;itm:vt0p} ():<> map (key, itm)
// end of [linmap_make_nil]

(* ****** ****** *)

fun linmap_is_nil
  {key:t0p;itm:vt0p} (map: !map (key, INV(itm))):<> bool
// end of [linmap_is_nil]

fun linmap_isnot_nil
  {key:t0p;itm:vt0p} (map: !map (key, INV(itm))):<> bool
// end of [linmap_isnot_nil]

(* ****** ****** *)

fun linmap_size
  {key:t0p;itm:vt0p} (map: !map (key, INV(itm))):<> size_t
// end of [linmap_size]

(* ****** ****** *)

fun{
key:t0p;itm:t0p
} linmap_search (
  map: !map (key, INV(itm))
, k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // endfun

fun{
key:t0p;itm:vt0p
} linmap_search_ref
  (map: !map (key, INV(itm)), k0: key): Ptr0
// end of [linmap_search_ref]

fun{
key:t0p;itm:t0p
} linmap_search_opt
  (map: !map (key, INV(itm)), k0: key): Option_vt (itm)
// end of [linmap_search_opt]

(* ****** ****** *)

fun linmap_random_lgN
  {n:int | n >= 1} (lgMAX: int (n)): intBtwe (1, n)
// end of [linmap_random_lgN]

(* ****** ****** *)
//
// HX-2012-12:
// if [k0] occurs in [map], [x0] replaces the
// item associated with [k0] in [map] while the
// item is stored in [res] instead.
//
fun{
key:t0p;itm:vt0p
} linmap_insert (
  map: &map (key, INV(itm)) >> _
, k0: key, x0: itm, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // endfun

(* ****** ****** *)
//
// HX-2012-12:
// insertion always happens regardless whether
// [k0] is associated with some item in [map]
//
fun{
key:t0p;itm:vt0p
} linmap_insert_any
  (map: &map (key, INV(itm)) >> _, k0: key, x0: itm): void
// end of [linmap_insert_any]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} linmap_takeout (
  map: &map (key, INV(itm)) >> _
, k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // endfun

fun{
key:t0p;itm:vt0p
} linmap_takeout_opt
  (map: &map (key, INV(itm)) >> _, k0: key): Option_vt (itm)
// end of [linmap_takeout_opt]

fun{
key:t0p;itm:t0p
} linmap_remove
  (map: &map (key, INV(itm)) >> _, k0: key): bool
// end of [linmap_remove]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
}{
env:vt0p
} linmap_foreach$fwork
  (k: key, x: &itm, env: &env): void
// end of [linmap_foreach$fwork]

fun{
key:t0p;itm:vt0p
} linmap_foreach
  (map: !map (key, INV(itm))): void
// end of [linmap_foreach]

fun{
key:t0p;itm:vt0p
}{
env:vt0p
} linmap_foreach_env
  (map: !map (key, INV(itm)), env: &env): void
// end of [linmap_foreach_env]

(* ****** ****** *)

fun{
key:t0p;itm:t0p
} linmap_free (map: map (key, itm)):<!wrt> void
//
// HX: a linear map can be properly freed only if it is empty
//
fun{
key:t0p;itm:vt0p
} linmap_free_vt (
  map: !map (key, itm) >> opt (map (key, itm), b)
) :<!wrt> #[b:bool] bool b(*~freed*) // end of [linmap_free_vt]

(* ****** ****** *)

(*
//
// HX: listization is done ascendingly
//
*)
//
fun{
key:t0p;itm:t0p
} linmap_listize
  (map: !map (key, INV(itm))):<> List_vt @(key, itm)
// end of [linmap_listize]

fun{
key:t0p;itm:vt0p
} linmap_listize_free
  (map: map (key, INV(itm))):<!wrt> List_vt @(key, itm)
// end of [linmap_listize_free]

(* ****** ****** *)

(* end of [linmap_skiplist.sats] *)
