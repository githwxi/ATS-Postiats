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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: December, 2012 *)

(* ****** ****** *)

sortdef t0p = t@ype

(* ****** ****** *)
//
// HX-2012-12:
// for maps associating keys with items
// of types [key] and [itm], respectively
//
abstype map_type (key:t@ype, itm:t@ype+) = ptr
typedef map(key:t0p, itm:t0p) = map_type(key, itm)

(* ****** ****** *)

fun{key:t0p}
equal_key_key (x1: key, x2: key):<> bool
fun{key:t0p}
compare_key_key (x1: key, x2: key):<> int

(* ****** ****** *)

fun{
} funmap_nil {key,itm:t0p}():<> map(key, itm)
fun{
} funmap_make_nil{key,itm:t0p}():<> map(key, itm)

(* ****** ****** *)

fun{
} funmap_is_nil
  {key,itm:t0p}(map: map(key, INV(itm))):<> bool
fun{
} funmap_isnot_nil
  {key,itm:t0p}(map: map(key, INV(itm))):<> bool

(* ****** ****** *)
//
// HX-2012-12: this function is O(n)-time
//
fun{
key,itm:t@ype
} funmap_size(map: map(key, INV(itm))):<> size_t
//
(* ****** ****** *)

fun{
key,itm:t0p
} funmap_search
(
  map: map(key, INV(itm))
, key: key, res: &itm? >> opt(itm, b)
) : #[b:bool] bool(b)

fun{
key,itm:t0p
} funmap_search_opt
  (map: map(key, INV(itm)), k0: key): Option_vt(itm)
// end of [funmap_search_opt]

(* ****** ****** *)
//
// HX-2012-12:
// if [k0] occurs in [map], [x0] replaces the
// item associated with [k0] in [map] while the
// item is stored in [res] instead.
//
fun{
key,itm:t0p
} funmap_insert
(
  map: &map(key, INV(itm)) >> _
, key: key, x0: itm, res: &itm? >> opt(itm, b)
) : #[b:bool] bool(b)

fun{
key,itm:t0p
} funmap_insert_opt
(
  map: &map(key, INV(itm)) >> _, k0: key, x0: itm
) : Option_vt(itm) // endfun

(* ****** ****** *)
//
// HX-2012-12:
// insertion always happens regardless whether
// [k0] is associated with some item in [map]
//
fun{
key,itm:t0p
} funmap_insert_any
  (map: &map(key, INV(itm)) >> _, k0: key, x0: itm): void
// end of [funmap_insert_any]

(* ****** ****** *)
//
fun{
key,itm:t0p
} funmap_takeout (
  &map(key, INV(itm)) >> _, k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // end-of-function
//
fun{
key,itm:t0p
} funmap_takeout_opt
  (map: &map(key, INV(itm)) >> _, k0: key) : Option_vt (itm)
//
(* ****** ****** *)

fun{
key,itm:t0p
} funmap_remove
  (map: &map(key, INV(itm)) >> _, k0: key): bool
// end of [funmap_remove]

(* ****** ****** *)
//
fun{}
fprint_funmap$sep (out: FILEref): void // "; "
fun{}
fprint_funmap$mapto (out: FILEref): void // "->"
//
fun{
key,itm:t@ype
} fprint_funmap
  (out: FILEref, map: map(key, INV(itm))): void
//
overload fprint with fprint_funmap
//
(* ****** ****** *)
//
fun
{key:t0p
;itm:t0p}
{env:vt0p}
funmap_foreach$fwork
  (k: key, x: itm, env: &(env) >> _): void
// end of [funmap_foreach$fwork]
//
fun{
key,itm:t0p
} funmap_foreach(map: map(key, INV(itm))): void
//
fun
{key:t0p
;itm:t0p}
{env:vt0p}
funmap_foreach_env
  (map: map(key, INV(itm)), env: &(env) >> _): void
// end of [funmap_foreach_env]
//
(* ****** ****** *)

fun{
key,itm:t0p
} funmap_listize
  (xs: map(key, INV(itm))):<!wrt> List_vt @(key, itm)
// end of [funmap_listize]

(* ****** ****** *)
//
fun
{key:t0p
;itm:t0p}
{ki2:t0p}
funmap_flistize$fopr(key, itm): ki2
fun
{key:t0p
;itm:t0p}
{ki2:t0p}
funmap_flistize(kxs: map(key, INV(itm))): List_vt(ki2)
//
(* ****** ****** *)

(* end of [funmap.hats] *)
