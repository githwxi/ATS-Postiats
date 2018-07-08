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
(* Start time: August, 2013 *)

(* ****** ****** *)
//
absvtype
hashtbl_vtype
  (k:t@ype, i:vt@ype+) = ptr
//
vtypedef
hashtbl
(k:t0p, i:vt0p) = hashtbl_vtype(k, i)
//
(* ****** ****** *)

fun{key:t0p}
hash_key(x: key):<> ulint
fun{key:t0p}
equal_key_key(x1: key, x2: key):<> bool

(* ****** ****** *)
//
// HX: for recapacitizing policy
//
fun{}
hashtbl$recapacitize((*void*)): int
//
(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_make_nil
  (cap: sizeGte(1)): hashtbl(key, itm)

(* ****** ****** *)
//
// HX: the number of stored elements
//
fun{}
hashtbl_get_size
{key:t0p;itm:vt0p}
(tbl: !hashtbl(key, INV(itm))):<> sizeGte(0)
// end of [hashtbl_get_size]

(* ****** ****** *)
//
// HX: the array size of the hashtable
//
fun{}
hashtbl_get_capacity
{key:t0p;itm:vt0p}
(tbl: !hashtbl(key, INV(itm))):<> sizeGte(1)
// end of [hashtbl_get_capacity]

(* ****** ****** *)

fun{
key:t0p;itm:t0p
} hashtbl_search
(
  tbl: !hashtbl(key, INV(itm))
, key: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool(b)(*found*) // end of [hashtbl_search]

fun{
key:t0p;itm:vt0p
} hashtbl_search_ref
  (tbl: !hashtbl(key, INV(itm)), key: key): cPtr0 (itm)
// end of [hashtbl_search_ref]

fun{
key:t0p;itm:t0p
} hashtbl_search_opt
  (tbl: !hashtbl(key, INV(itm)), key: key): Option_vt(itm)
// end of [hashtbl_search_opt]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_insert
(
  tbl: !hashtbl(key, INV(itm))
, key: key, x0: itm, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // endfun
fun{
key:t0p;itm:vt0p
} hashtbl_insert_opt
  (tbl: !hashtbl(key, INV(itm)), key, itm): Option_vt(itm)
// end of [hashtbl_insert_opt]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_insert_any
  (!hashtbl(key, INV(itm)), key, itm): void
// end of [hashtbl_insert_any]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_takeout
(
  tbl: !hashtbl(key, INV(itm))
, key: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // endfun
fun{
key:t0p;itm:vt0p
} hashtbl_takeout_opt
  (!hashtbl(key, INV(itm)), key): Option_vt(itm)
// end of [hashtbl_takeout_opt]

(* ****** ****** *)

fun{
key:t0p;itm:t0p
} hashtbl_remove
  (tbl: !hashtbl(key, INV(itm)), key: key): bool
// end of [hashtbl_remove]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_exchange
  (tbl: !hashtbl(key, INV(itm)), key: key, x0: &itm >> _): bool
// end of [hashtbl_exchange]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_takeout_all
  (tbl: !hashtbl(key, INV(itm))): List0_vt @(key, itm)
// end of [hashtbl_takeout_all]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_reset_capacity
  (tbl: !hashtbl(key, INV(itm)), cap2: sizeGte(1)): bool
// end of [hashtbl_reset_capacity]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_adjust_capacity (!hashtbl(key, INV(itm))): bool

(* ****** ****** *)
//
fun{
key,itm:t@ype
} fprint_hashtbl
  (out: FILEref, tbl: !hashtbl(key, INV(itm))): void
//
overload fprint with fprint_hashtbl
//
fun{}
fprint_hashtbl$sep (out: FILEref): void // default: fprint("; ")
fun{}
fprint_hashtbl$mapto (out: FILEref): void // default: fprint("->")
//
(* ****** ****** *)
//
fun
{key:t0p
;itm:vt0p}
hashtbl_foreach(tbl: !hashtbl(key, INV(itm))): void
fun
{key:t0p
;itm:vt0p}
{env:vt0p}
hashtbl_foreach_env
  (tbl: !hashtbl(key, INV(itm)), env: &env >> _): void
//
fun
{key:t0p
;itm:vt0p}
{env:vt0p}
hashtbl_foreach$fwork(k: key, x: &itm >> _, &env >> _): void
//
(* ****** ****** *)
//
fun
{key:t0p
;itm:vt0p}
hashtbl_foreach_cloref
(
  tbl: !hashtbl(key, INV(itm)), fwork: (key, &itm >> _) -<cloref1> void
) : void // end-of-function
//
(* ****** ****** *)

fun
{key:t0p
;itm:t0p}
hashtbl_free (tbl: hashtbl(key, INV(itm))): void

(* ****** ****** *)
//
fun
{key:t0p
;itm:vt0p}
{ki2:vt0p}
hashtbl_flistize$fopr(k: key, x: itm): ki2
fun
{key:t0p
;itm:vt0p}
{ki2:vt0p}
hashtbl_flistize
  (tbl: hashtbl(key, INV(itm))):<!wrt> List0_vt(ki2)
//
(* ****** ****** *)

fun
{key:t0p
;itm:vt0p}
hashtbl_listize
  (tbl: hashtbl(key, INV(itm))):<!wrt> List0_vt @(key, itm)
// end of [hashtbl_listize]

fun{
key,itm:t0p
} hashtbl_listize1
  (tbl: !hashtbl(key, INV(itm))):<!wrt> List0_vt @(key, itm)
// end of [hashtbl_listize1]

(* ****** ****** *)
//
fun
{key:t0p
;itm:vt0p}
streamize_hashtbl
  (tbl: hashtbl(key, INV(itm))):<!wrt> stream_vt @(key, itm)
// end of [streamize_hashtbl]
//
(* ****** ****** *)

(* end of [hashtbl.hats] *)
