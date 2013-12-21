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
(* Authoremail: gmhwxi AT gmail DOT com *)
(* Start time: August, 2013 *)

(* ****** ****** *)

#define
ATS_PACKNAME "ATSLIB.libats.ML"
#define
ATS_STALOADFLAG 0 // no need for staloading at run-time
#define
ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
// HX: for maps of elements of type (a)
//
abstype
hashtbl_type (key:t@ype, itm:t0ype) = ptr
typedef
hashtbl (key:t0p, itm:t0p) = hashtbl_type (key, itm)
//
(* ****** ****** *)

fun{key:t0p}
hash_key (x: key):<> ulint
fun{key:t0p}
equal_key_key (x1: key, x2: key):<> bool

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_make_nil (cap: sizeGte(1)): hashtbl (key, itm)

(* ****** ****** *)

fun{}
hashtbl_get_size{key,itm:t0p} (hashtbl (key, itm)): size_t
fun{}
hashtbl_get_capacity{key,itm:t0p} (hashtbl (key, itm)): sizeGte(1)

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_search
  (hashtbl (key, itm), key): Option_vt (itm)
// end of [hashtbl_search]

fun{
key,itm:t0p
} hashtbl_search_ref
  (tbl: hashtbl (key, itm), k: key): cPtr0 (itm)
// end of [hashtbl_search_ref]

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_insert
  (hashtbl (key, itm), key, itm): Option_vt (itm)
// end of [hashtbl_insert]

fun{
key,itm:t0p
} hashtbl_insert_any (hashtbl (key, itm), key, itm): void

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_takeout
  (hashtbl (key, itm), key): Option_vt (itm)
// end of [hashtbl_takeout]

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_remove (hashtbl (key, itm), key): bool

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_takeout_all
  (tbl: hashtbl (key, itm)): list0 @(key, itm)
// end of [hashtbl_takeout_all]

(* ****** ****** *)

fun{
key,itm:t0p
} hashtbl_listize1
  (tbl: hashtbl (key, itm)): list0 @(key, itm)
// end of [hashtbl_listize1]

(* ****** ****** *)

(* end of [hashtblref.sats] *)
