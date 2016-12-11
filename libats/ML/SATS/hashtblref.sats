(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: August, 2013 *)

(* ****** ****** *)

#define
ATS_PACKNAME "ATSLIB.libats.ML"
#define
ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
typedef
hashtbl // introduced in [basis.sats]
(key:t@ype, itm:t@ype) = hashtbl(key, itm)
//
(* ****** ****** *)
//
fun{
key:t0p
} hash_key(x: key):<> ulint
//
fun{
key:t0p
} equal_key_key(x1: key, x2: key):<> bool
//
(* ****** ****** *)
//
fun{
key,itm:t0p
} hashtbl_make_nil
  (cap: sizeGte(1)): hashtbl(key, itm)
//
(* ****** ****** *)

fun{}
hashtbl_get_size
  {key,itm:t0p}(hashtbl(key, itm)): size_t
fun{}
hashtbl_get_capacity
  {key,itm:t0p}(hashtbl(key, itm)): sizeGte(1)

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_search
  (hashtbl(key, itm), key): Option_vt(itm)
// end of [hashtbl_search]

fun{
key,itm:t0p
} hashtbl_search_ref
  (tbl: hashtbl(key, itm), k: key): cPtr0(itm)
// end of [hashtbl_search_ref]

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_insert
  (hashtbl(key, itm), key, itm): Option_vt(itm)
// end of [hashtbl_insert]

fun{
key,itm:t0p
} hashtbl_insert_any(hashtbl(key, itm), key, itm): void

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_takeout
  (kxs: hashtbl(key, itm), k0: key): Option_vt(itm)
// end of [hashtbl_takeout]

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_remove
  (kxs: hashtbl(key, itm), key): bool

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_takeout_all
  (kxs: hashtbl(key, itm)): list0 @(key, itm)
// end of [hashtbl_takeout_all]

(* ****** ****** *)
//
fun{
key,itm:t@ype
} fprint_hashtbl
  (out: FILEref, tbl: hashtbl(key, itm)): void
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
fun{
key,itm:t@ype
} fprint_hashtbl_sep_mapto
(
  out: FILEref, tbl: hashtbl(key, itm), sep: string, mapto: string
) : void // end of [fprint_hashtbl_sep_mapto]
//
(* ****** ****** *)
//
fun{
key,itm:t0p
} hashtbl_foreach
  (tbl: hashtbl(key, itm)): void
fun
{key:t0p
;itm:t0p}
{env:vt0p}
hashtbl_foreach_env
  (tbl: hashtbl(key, itm), env: &(env) >> _): void
//
fun
{key:t0p
;itm:t0p}
{env:vt0p}
hashtbl_foreach$fwork
  (key: key, itm: &itm >> _, env: &(env) >> _): void
//
(* ****** ****** *)
//
fun{
key,itm:t0p
} hashtbl_foreach_cloref
(
  tbl: hashtbl(key, itm), fwork: (key, &itm >> _) -<cloref1> void
) : void // end of [hashtbl_foreach_cloref]
//
(* ****** ****** *)
//
fun{
key,itm:t0p
} hashtbl_listize1(hashtbl(key, itm)): list0 @(key, itm)
//
(* ****** ****** *)

(* end of [hashtblref.sats] *)
