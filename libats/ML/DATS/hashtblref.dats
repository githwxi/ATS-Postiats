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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload HT =
"libats/SATS/hashtbl_chain.sats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)

staload "libats/SATS/hashfun.sats"
staload "libats/ML/SATS/hashtblref.sats"

(* ****** ****** *)

(*
implement
{key}(*tmp*)
hash_key = ghash_val<key>
*)

(* ****** ****** *)

implement
{key}(*tmp*)
equal_key_key = gequal_val_val<key>

(* ****** ****** *)
//
implement
hash_key<int> (key) = let
  val key = $UN.cast{uint32}(key)
in
  $UN.cast{ulint}(inthash_jenkins<>(key))
end // end of [hash_key<int>]
//
implement
hash_key<uint> (key) = let
  val key = $UN.cast{uint32}(key)
in
  $UN.cast{ulint}(inthash_jenkins<>(key))
end // end of [hash_key<uint>]
//
(* ****** ****** *)
//
// HX: 31 and 37 are top choices
//
implement
hash_key<string> (key) =
  string_hash_multiplier (31UL, 31415926536UL, key)
//
(* ****** ****** *)
//
implement
{key}(*tmp*)
$HT.hash_key = hash_key<key>
//
implement
{key}(*tmp*)
$HT.equal_key_key = equal_key_key<key>
//
(* ****** ****** *)
//
extern
castfn
hashtbl_encode
  {key,itm:t0p}
(
  $HT.hashtbl(key, INV(itm))
) : hashtbl(key, itm)
//
extern
castfn
hashtbl_decode
  {key,itm:t0p}
  (hashtbl(key, INV(itm))): $HT.hashtbl(key, itm)
//
(* ****** ****** *)

#define htencode hashtbl_encode
#define htdecode hashtbl_decode

(* ****** ****** *)
//
implement
{key,itm}
hashtbl_make_nil(cap) =
htencode
(
$HT.hashtbl_make_nil<key,itm>(cap)
) (* end of [htencode] *)
//
(* ****** ****** *)

implement
{}(*tmp*)
hashtbl_get_size
  (tbl) = nitm where
{
//
val tbl = htdecode(tbl)
val nitm = $HT.hashtbl_get_size<>(tbl)
//
prval () = $UN.cast2void(tbl)
//
} (* end of [hashtbl_get_size] *)

(* ****** ****** *)

implement
{}(*tmp*)
hashtbl_get_capacity
  (tbl) = cap where
{
//
val tbl = htdecode(tbl)
val cap = $HT.hashtbl_get_capacity<>(tbl)
//
prval () = $UN.cast2void(tbl)
//
} (* end of [hashtbl_get_capacity] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_search
  (tbl, k) = opt where
{
//
val tbl = htdecode(tbl)
val opt =
  $HT.hashtbl_search_opt<key,itm>(tbl, k)
//
prval () = $UN.cast2void(tbl)
//
} (* end of [hashtbl_search] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_search_ref
  (tbl, k) = cptr where
{
//
val tbl = htdecode(tbl)
//
val cptr =
  $HT.hashtbl_search_ref<key,itm>(tbl, k)
//
prval () = $UN.cast2void(tbl)
//
} (* end of [hashtbl_search_ref] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_insert
  (tbl, k, x) = opt where
{
//
val tbl = htdecode(tbl)
//
val opt =
  $HT.hashtbl_insert_opt<key,itm>(tbl, k, x)
//
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
val tbl = htdecode(tbl)
//
val () =
  $HT.hashtbl_insert_any<key,itm>(tbl, k, x)
//
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
val tbl = htdecode(tbl)
//
val opt =
  $HT.hashtbl_takeout_opt<key,itm>(tbl, k)
//
prval () = $UN.cast2void(tbl)
//
} (* end of [hashtbl_takeout] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_remove
  (tbl, k) = ans where
{
//
val tbl = htdecode(tbl)
val ans = $HT.hashtbl_remove<key,itm>(tbl, k)
//
prval () = $UN.cast2void(tbl)
//
} (* end of [hashtbl_remove] *)

(* ****** ****** *)

implement
{key,itm}
hashtbl_takeout_all
  (tbl) = kxs where
{
//
val tbl = htdecode(tbl)
val kxs = $HT.hashtbl_takeout_all<key,itm>(tbl)
val kxs = list0_of_list_vt{(key,itm)}(kxs)
//
prval () = $UN.cast2void(tbl)
//
} (* end of [hashtbl_takeout_all] *)

(* ****** ****** *)

implement
{key,itm}
fprint_hashtbl
  (out, tbl) = let
//
implement
$HT.fprint_hashtbl$sep<> = fprint_hashtbl$sep<>
implement
$HT.fprint_hashtbl$mapto<> = fprint_hashtbl$mapto<>
//
val tbl = htdecode (tbl)
val () = $HT.fprint_hashtbl (out, tbl)
prval () = $UN.cast2void (tbl)
//
in
  // nothing
end // end of [fprint_hashtbl]

(* ****** ****** *)
//
implement{}
fprint_hashtbl$sep(out) = fprint(out, "; ")
implement{}
fprint_hashtbl$mapto(out) = fprint(out, "->")
//
(* ****** ****** *)

implement
{key,itm}
fprint_hashtbl_sep_mapto
  (out, tbl, sep, mapto) = let
//
implement
fprint_hashtbl$sep<>(out) = fprint(out, sep)
implement
fprint_hashtbl$mapto<>(out) = fprint(out, mapto)
//
in
  fprint_hashtbl<key,itm>(out, tbl)
end // end of [fprint_hashtbl_sep_mapto]

(* ****** ****** *)

implement
{key,itm}
hashtbl_foreach_cloref
  (tbl, fwork) = () where
{
//
var env: void = ((*void*))
//
implement
(env)(*tmp*)
$HT.hashtbl_foreach$fwork<key,itm><env>
  (k, x, env) = fwork(k, x)
//
val tbl = htdecode(tbl)
//
val
((*void*)) =
$HT.hashtbl_foreach_env<key,itm><void>
  (tbl, env)
//
prval ((*returned*)) = $UN.cast2void(tbl)
//
} (* end of [hashtbl_foreach_cloref] *)

(* ****** ****** *)
//
implement
{key,itm}
hashtbl_listize0
  (tbl) =
(
hashtbl_takeout_all<key,itm>(tbl)
)
//
(* ****** ****** *)

implement
{key,itm}
hashtbl_listize1
  (tbl) = kxs where
{
//
typedef ki = @(key, itm)
//
val tbl = htdecode(tbl)
//
val kxs = $HT.hashtbl_listize1(tbl)
//
prval
((*returned*)) = $UN.cast2void(tbl)
//
val kxs = list0_of_list_vt{(key,itm)}(kxs)
//
} (* end of [hashtbl_listize1] *)

(* ****** ****** *)

(* end of [hashtblref.dats] *)
