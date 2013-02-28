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

sortdef tk = tkind
sortdef t0p = t@ype and vt0p = vt@ype

(* ****** ****** *)

absvtype
map_vtype (tk:tk, key:t@ype, itm:vt@ype+)
stadef map = map_vtype

(* ****** ****** *)

fun{key:t0p}
equal_key_key (x1: key, x2: key):<> bool

fun{key:t0p}
compare_key_key (x1: key, x2: key):<> int

(* ****** ****** *)

fun{
tk:tk
} linmap_nil
   {key:t0p;itm:vt0p} ():<> map (tk, key, itm)
// end of [linmap_nil]

fun{
tk:tk
} linmap_make_nil
  {key:t0p;itm:vt0p} ():<!wrt> map (tk, key, itm)
// end of [linmap_make_nil]

(* ****** ****** *)

fun{
tk:tk
} linmap_is_nil
  {key:t0p;itm:vt0p} (map: !map (tk, key, INV(itm))):<> bool
// end of [listmap_is_nil]

fun{
tk:tk
} linmap_isnot_nil
  {key:t0p;itm:vt0p} (map: !map (tk, key, INV(itm))):<> bool
// end of [listmap_isnot_nil]

(* ****** ****** *)
//
// HX: this function is O(1)
//
fun
{tk:tk}
{key:t0p;itm:vt0p}
linmap_size (map: !map (tk, key, INV(itm))):<> size_t

(* ****** ****** *)

fun
{tk:tk}
{key:t0p;itm:t0p}
linmap_search (
  map: !map (tk, key, INV(itm)), k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b)(*found*) // endfun

(* ****** ****** *)

fun
{tk:tk}
{key:t0p;itm:vt0p}
linmap_search_ref
  (map: !map (tk, key, INV(itm)), k0: key): Ptr0
// end of [linmap_search_ref]

fun
{tk:tk}
{key:t0p;itm:t0p}
linmap_search_opt
  (map: !map (tk, key, INV(itm)), k0: key): Option_vt (itm)
// end of [linmap_search_opt]

(* ****** ****** *)
//
// HX-2012-12:
// if [k0] occurs in [map], [x0] replaces the
// item associated with [k0] in [map] while the
// item is stored in [res] instead.
//
fun
{tk:tk}
{key:t0p;itm:vt0p}
linmap_insert (
  map: &map (tk, key, INV(itm)) >> _
, k0: key, x0: itm, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // endfun

fun
{tk:tk}
{key:t0p;itm:vt0p}
linmap_insert_opt
  (map: &map (tk, key, INV(itm)) >> _, k0: key, x0: itm): Option_vt (itm)
// end of [linmap_insert_opt]

(* ****** ****** *)
//
// HX-2012-12:
// insertion always happens regardless whether
// [k0] is associated with some item in [map]
//
fun
{tk:tk}
{key:t0p;itm:vt0p}
linmap_insert_any
  (map: &map (tk, key, INV(itm)) >> _, k0: key, x0: itm): void
// end of [linmap_insert_any]

(* ****** ****** *)

fun
{tk:tk}
{key:t0p;itm:vt0p}
linmap_takeout (
  map: &map (tk, key, INV(itm)) >> _, k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // endfun

fun
{tk:tk}
{key:t0p;itm:vt0p}
linmap_takeout_opt
  (map: &map (tk, key, INV(itm)) >> _, k0: key): Option_vt (itm)
// end of [linmap_takeout_opt]

fun
{tk:tk}
{key:t0p;itm:t0p}
linmap_remove (
  map: &map (tk, key, INV(itm)) >> _, k0: key): bool
// end of [linmap_remove]

(* ****** ****** *)

fun
{key:t0p;itm:vt0p}
{env:vt0p}
linmap_foreach$cont
  (k: key, x: &itm, env: &env): bool
// endfun

fun
{key:t0p;itm:vt0p}
{env:vt0p}
linmap_foreach$fwork
  (k: key, x: &itm, env: &(env) >> _): void
// endfun

fun
{tk:tk}
{key:t0p;itm:vt0p}
linmap_foreach (map: !map (tk, key, INV(itm))): void

fun
{tk:tk}
{key:t0p;itm:vt0p}
{env:vt0p}
linmap_foreach_env
  (map: !map (tk, key, INV(itm)), env: &(env) >> _): void
// end of [linmap_foreach_env]

(* ****** ****** *)

fun
{tk:tk}
{key:t0p;itm:t0p}
linmap_free (map: map (tk, key, INV(itm))):<!wrt> void

fun
{itm:vt0p}
linmap_freelin$clear (x: &itm >> _?):<!wrt> void
fun{
tk:tk
}{
key:t0p;
itm:vt0p
} linmap_freelin (map: map (tk, key, INV(itm))):<!wrt> void

(* ****** ****** *)
//
// HX: a linear map can be properly freed only if it is empty
//
fun
{tk:tk}
{key:t0p;itm:vt0p}
linmap_free_ifnil (
  map: !map (tk, key, INV(itm)) >> opt (map (tk, key, itm), b)
) :<!wrt> #[b:bool] bool (b)(*~freed*) // end of [linmap_free_ifnil]
//
(* ****** ****** *)

(*
//
// HX: listization is done in the in-order fashion
//
*)
//
fun
{tk:tk}
{key:t0p;itm:t0p}
linmap_listize
  (map: !map (tk, key, INV(itm))):<!wrt> List_vt @(key, itm)
// end of [linmap_listize]

fun
{tk:tk}
{key:t0p;itm:vt0p}
linmap_listize_free
  (map: map (tk, key, INV(itm))):<!wrt> List_vt @(key, itm)
// end of [linmap_listize_free]

(* ****** ****** *)

(* end of [linmap.hats] *)
