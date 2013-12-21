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
// HX-2012-12:
// the map implementation is based on AVL trees
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
HT = "libats/SATS/hashtbl_chain.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)

staload "libats/SATS/hashfun.sats"
staload "libats/ML/SATS/hashtblref.sats"

(* ****** ****** *)
//
// HX: 31 and 37 are top choices
//
implement
hash_key<string> (str) =
  string_hash_multiplier (31UL, 61803398875UL, str)
//
(* ****** ****** *)

implement
{key}(*tmp*)
$HT.hash_key = hash_key<key>
implement
{key}(*tmp*)
$HT.equal_key_key = equal_key_key<key>

(* ****** ****** *)
//
extern
castfn
hashtbl_encode
  {key,itm:t0p}
  ($HT.hashtbl (key, INV(itm))): hashtbl (key, itm)
extern
castfn
hashtbl_decode
  {key,itm:t0p}
  (hashtbl (key, INV(itm))): $HT.hashtbl (key, itm)
//
(* ****** ****** *)

#define htencode hashtbl_encode
#define htdecode hashtbl_decode

(* ****** ****** *)
//
implement
{key,itm}
hashtbl_make_nil (cap) =
  htencode($HT.hashtbl_make_nil<key,itm> (cap))
//
(* ****** ****** *)

implement{}
hashtbl_get_size
  (tbl) = nitm where
{
//
val tbl = htdecode (tbl)
val nitm = $HT.hashtbl_get_size (tbl)
prval () = $UN.cast2void (tbl)
//
} (* end of [hashtbl_get_size] *)

(* ****** ****** *)

implement{}
hashtbl_get_capacity
  (tbl) = cap where
{
//
val tbl = htdecode (tbl)
val cap = $HT.hashtbl_get_capacity (tbl)
prval () = $UN.cast2void (tbl)
//
} (* end of [hashtbl_get_capacity] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_search
  (tbl, k) = opt where
{
//
val tbl = htdecode (tbl)
val opt = $HT.hashtbl_search_opt (tbl, k)
prval () = $UN.cast2void (tbl)
//
} (* end of [hashtbl_search] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_search_ref
  (tbl, k) = cptr where
{
//
val tbl = htdecode (tbl)
val cptr = $HT.hashtbl_search_ref (tbl, k)
prval () = $UN.cast2void (tbl)
//
} (* end of [hashtbl_search_ref] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_insert
  (tbl, k, x) = opt where
{
//
val tbl = htdecode (tbl)
val opt = $HT.hashtbl_insert_opt<key,itm> (tbl, k, x)
prval () = $UN.cast2void (tbl)
//
} (* hashtbl_insert *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_insert_any
  (tbl, k, x) = () where
{
//
val tbl = htdecode (tbl)
val () = $HT.hashtbl_insert_any<key,itm> (tbl, k, x)
prval () = $UN.cast2void (tbl)
//
} (* hashtbl_insert_any *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_takeout
  (tbl, k) = opt where
{
//
val tbl = htdecode (tbl)
val opt = $HT.hashtbl_takeout_opt (tbl, k)
prval () = $UN.cast2void (tbl)
//
} (* end of [hashtbl_takeout] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_remove
  (tbl, k) = ans where
{
//
val tbl = htdecode (tbl)
val ans = $HT.hashtbl_remove (tbl, k)
prval () = $UN.cast2void (tbl)
//
} (* end of [hashtbl_remove] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_takeout_all
  (tbl) = kxs where
{
//
val tbl = htdecode (tbl)
val kxs = $HT.hashtbl_takeout_all (tbl)
prval () = $UN.cast2void (tbl)
val kxs = list0_of_list_vt{(key,itm)}(kxs)
//
} (* end of [hashtbl_takeout_all] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_listize1
  (tbl) = kxs where
{
//
typedef ki = @(key, itm)
//
val tbl = htdecode (tbl)
val kxs = $HT.hashtbl_listize1 (tbl)
prval () = $UN.cast2void (tbl)
val kxs = list0_of_list_vt{(key,itm)}(kxs)
//
} (* end of [hashtbl_listize1] *)

(* ****** ****** *)

(* end of [hashtblref.dats] *)
