(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: March, 2015 *)

(* ****** ****** *)
//
// HX-2015-03-12:
// For quickly building a hashmap interface
//
(* ****** ****** *)
//
(*
typedef key = int/string
typedef itm = int/string/...
*)
//
(* ****** ****** *)
//
abstype
myhashtbl_type = ptr
//
typedef
myhashtbl = myhashtbl_type
//
(* ****** ****** *)
//
extern
fun
myhashtbl_make_nil
  (cap: intGte(1)): myhashtbl
//
(* ****** ****** *)
//
extern
fun
myhashtbl_get_size(myhashtbl): intGte(0)
//
overload .size with myhashtbl_get_size
overload .get_size with myhashtbl_get_size
//
extern
fun
myhashtbl_get_capacity(myhashtbl): intGte(1)
//
overload .capacity with myhashtbl_get_capacity
overload .get_capacity with myhashtbl_get_capacity
//
(* ****** ****** *)
//
extern
fun
myhashtbl_search
  (myhashtbl, key): Option_vt(itm)
//
overload .search with myhashtbl_search
//
extern
fun
myhashtbl_search_ref
  (tbl: myhashtbl, k: key): cPtr0(itm)
//
overload .search_ref with myhashtbl_search_ref
//
(* ****** ****** *)
//
extern
fun
myhashtbl_insert
  (myhashtbl, key, itm): Option_vt(itm)
//
overload .insert with myhashtbl_insert
//
extern
fun
myhashtbl_insert_any
  (tbl: myhashtbl, k: key, x: itm): void
//
overload .insert_any with myhashtbl_insert_any
//
(* ****** ****** *)
//
extern
fun
myhashtbl_remove
  (myhashtbl, k: key): bool
//
overload .remove with myhashtbl_remove
//
extern
fun
myhashtbl_takeout
  (myhashtbl, k: key): Option_vt(itm)
//
overload .takeout with myhashtbl_takeout
//
(* ****** ****** *)
//
extern
fun
myhashtbl_takeout_all
  (tbl: myhashtbl): List0 @(key, itm)
//
overload .takeout_all with myhashtbl_takeout_all
//
(* ****** ****** *)
//
extern
fun
fprint_myhashtbl
  (out: FILEref, myhashtbl): void
//
overload fprint with fprint_myhashtbl
//
(* ****** ****** *)
//
extern
fun
myhashtbl_foreach_cloref
(
  tbl: myhashtbl
, fwork: (key, &(itm) >> _) -<cloref1> void
) : void // end-of-function
//
extern
fun
myhashtbl_foreach_method
(
  tbl: myhashtbl
) (fwork: (key, &(itm) >> _) -<cloref1> void): void
//
overload .foreach with myhashtbl_foreach_method
//
(* ****** ****** *)
//
extern
fun
myhashtbl_listize1
  (tbl: myhashtbl): List0 @(key, itm)
//
overload .listize1 with myhashtbl_listize1
//
(* ****** ****** *)

local
//
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/hashtblref.sats"
//
staload _(*anon*) = "libats/DATS/qlist.dats"
//
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
//
assume
myhashtbl_type = hashtbl_type(key, itm)
//
in (* in-of-local *)
//
macdef sz2n(sz) = sz2i(g1ofg0(,(sz)))
//
implement
myhashtbl_make_nil(cap) =
  hashtbl_make_nil<key,itm>(i2sz(cap))
//
(* ****** ****** *)
//
implement
myhashtbl_get_size
  (tbl) = sz2n(hashtbl_get_size<>(tbl))
implement
myhashtbl_get_capacity
  (tbl) = sz2i(hashtbl_get_capacity<>(tbl))
//
(* ****** ****** *)
//
implement
myhashtbl_search
  (tbl, k) = hashtbl_search<key,itm>(tbl, k)
implement
myhashtbl_search_ref
  (tbl, k) = hashtbl_search_ref<key,itm>(tbl, k)
//
(* ****** ****** *)
//
implement
myhashtbl_insert
  (tbl, k, x) = hashtbl_insert<key,itm>(tbl, k, x)
implement
myhashtbl_insert_any
  (tbl, k, x) = hashtbl_insert_any<key,itm>(tbl, k, x)
//
(* ****** ****** *)
//
implement
myhashtbl_remove
  (tbl, k) = hashtbl_remove<key,itm>(tbl, k)
implement
myhashtbl_takeout
  (tbl, k) = hashtbl_takeout<key,itm>(tbl, k)
//
implement
myhashtbl_takeout_all
  (tbl) =
(
  g1ofg0_list(hashtbl_takeout_all<key,itm>(tbl))
) (* myhashtbl_takeout_all *)
//
(* ****** ****** *)
//
implement
fprint_myhashtbl
  (out, tbl) = fprint_hashtbl<key,itm>(out, tbl)
//
(* ****** ****** *)
//
implement
myhashtbl_foreach_cloref
  (tbl, fwork) =
  hashtbl_foreach_cloref<key,itm>(tbl, fwork)
//
implement
myhashtbl_foreach_method(tbl) =
(
  lam(fwork) => myhashtbl_foreach_cloref(tbl, fwork)  
) (* myhashtbl_foreach_method *)
//
(* ****** ****** *)
//
implement
myhashtbl_listize1
  (tbl) = g1ofg0_list(hashtbl_listize1<key,itm>(tbl))
//
end // end of [local]

(* ****** ****** *)

(* end of [myhashtblref.hats] *)
