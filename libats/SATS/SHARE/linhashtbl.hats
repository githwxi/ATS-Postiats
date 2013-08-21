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
(* Start time: August, 2013 *)

(* ****** ****** *)
//
absvtype
hashtbl_vtype
  (key:t@ype, itm:vt@ype+) = ptr
//
stadef hashtbl = hashtbl_vtype
//
(* ****** ****** *)

fun{key:t0p}
hash_key (x: key):<> ulint
fun{key:t0p}
equal_key_key (x1: key, x2: key):<> bool

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_make_nil (cap: sizeGte(1)): hashtbl (key, itm)

(* ****** ****** *)
//
// HX: the number of stored elements
//
fun{} hashtbl_get_size
  {key:t0p;itm:vt0p} (p: !hashtbl (key, INV(itm))):<> size_t
// end of [hashtbl_get_size]

(* ****** ****** *)
//
// HX: the array size of the hashtable
//
fun{} hashtbl_get_capacity
  {key:t0p;itm:vt0p} (p: !hashtbl (key, INV(itm))):<> sizeGte(1)
// end of [hashtbl_get_capacity]

(* ****** ****** *)

fun{
key:t0p;itm:t0p
} hashtbl_search (
  tbl: !hashtbl (key, INV(itm))
, k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b)(*found*) // end of [hashtbl_search]

fun{
key:t0p;itm:vt0p
} hashtbl_search_ref
  (tbl: !hashtbl (key, INV(itm)), k0: key): cPtr0 (itm)
// end of [hashtbl_search_ref]

fun{
key:t0p;itm:t0p
} hashtbl_search_opt
  (tbl: !hashtbl (key, INV(itm)), k0: key): Option_vt (itm)
// end of [hashtbl_search_opt]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_insert (
  tbl: !hashtbl (key, INV(itm))
, k0: key, x0: itm, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // endfun
fun{
key:t0p;itm:vt0p
} hashtbl_insert_opt
  (tbl: !hashtbl (key, INV(itm)), k0: key, x0: itm): Option_vt (itm)
// end of [hashtbl_insert_opt]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_insert_any
  (!hashtbl (key, INV(itm)), key, itm): void
// end of [hashtbl_insert_any]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_takeout (
  tbl: !hashtbl (key, INV(itm))
, k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // endfun
fun{
key:t0p;itm:vt0p
} hashtbl_takeout_opt
  (tbl: !hashtbl (key, INV(itm)), k0: key): Option_vt (itm)
// end of [hashtbl_takeout_opt]

(* ****** ****** *)

fun{
key:t0p;itm:t0p
} hashtbl_remove (
  tbl: !hashtbl (key, INV(itm)), k0: key): bool
// end of [hashtbl_remove]

(* ****** ****** *)
//
fun{
} fprint_hashtbl$sep (out: FILEref): void // "; "
fun{
} fprint_hashtbl$mapto (out: FILEref): void // "->"
//
fun{
key,itm:t@ype
} fprint_hashtbl
  (out: FILEref, tbl: !hashtbl (key, INV(itm))): void
//
overload fprint with fprint_hashtbl
//
(* ****** ****** *)

fun
{key:t0p
;itm:vt0p}
{env:vt0p}
hashtbl_foreach$fwork
  (k: key, x: &itm >> _, &env >> _): void
fun
{key:t0p
;itm:vt0p}
hashtbl_foreach (tbl: !hashtbl (key, INV(itm))): void
fun
{key:t0p
;itm:vt0p}
{env:vt0p}
hashtbl_foreach_env (tbl: !hashtbl (key, INV(itm)), &env >> _): void

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_listize_free
  (tbl: hashtbl (key, INV(itm))):<!wrt> List_vt @(key, itm)
// end of [hashtbl_listize_free]

(* ****** ****** *)

(* end of [linhashtbl.hats] *)
