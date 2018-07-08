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
// HX-2015-03-15:
// For quickly building a funmap interface
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
typedef
mymap = map(key, itm)
typedef
mymap_modtype = map_modtype(key, itm)
//
(* ****** ****** *)
//
extern
fun
myfunmap_nil():<> mymap
and
myfunmap_make_nil():<> mymap
//
(* ****** ****** *)
//
extern
fun
myfunmap_is_nil(mymap):<> bool
and
myfunmap_isnot_nil(mymap):<> bool
//
overload .is_nil with myfunmap_is_nil
overload .isnot_nil with myfunmap_isnot_nil
//
(* ****** ****** *)
//
extern
fun
myfunmap_size(mymap): size_t
//
overload .size with myfunmap_size
//
(* ****** ****** *)
//
extern
fun
myfunmap_search
  (mymap, key): Option_vt(itm)
//
overload .search with myfunmap_search
//
(* ****** ****** *)
//
extern
fun
myfunmap_insert
  (&mymap >> _, key, itm): Option_vt(itm)
//
overload .insert with myfunmap_insert
//
(* ****** ****** *)
//
extern
fun
myfunmap_remove
  (&mymap >> _, k: key): bool
//
overload .remove with myfunmap_remove
//
extern
fun
myfunmap_takeout
  (&mymap >> _, k: key): Option_vt(itm)
//
overload .takeout with myfunmap_takeout
//
(* ****** ****** *)
//
extern
fun
fprint_myfunmap
  (out: FILEref, mymap): void
//
overload fprint with fprint_myfunmap of 10
//
(* ****** ****** *)
//
extern
fun
myfunmap_foreach_cloref
(
  mymap, fwork: (key, itm) -<cloref1> void
) : void // end-of-function
//
extern
fun
myfunmap_foreach_method
  (mymap)
  (fwork: (key, itm) -<cloref1> void): void
//
overload .foreach with myfunmap_foreach_method
//
(* ****** ****** *)
//
extern
fun
myfunmap_listize
  (map: mymap): list0 @(key, itm)
//
overload .listize with myfunmap_listize
//
(* ****** ****** *)
//
extern
fun
myfunmap_streamize
  (map: mymap): stream_vt @(key, itm)
//
overload .streamize with myfunmap_streamize
//
(* ****** ****** *)
//
extern
fun
myfunmap_make_module((*void*)): mymap_modtype
//
(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/funmap.sats"
//
staload _ = "libats/DATS/qlist.dats"
//
staload _ = "libats/DATS/funmap_avltree.dats"
//
staload _(*anon*) = "libats/ML/DATS/funmap.dats"
//
in (* in-of-local *)
//
(* ****** ****** *)
//
implement
myfunmap_nil
  ((*void*)) = funmap_nil{key,itm}()
implement
myfunmap_make_nil
  ((*void*)) = funmap_make_nil{key,itm}()
//
(* ****** ****** *)
//
implement
myfunmap_size(map) = funmap_size<key,itm>(map)
//
implement
myfunmap_search
  (map, k) = funmap_search<key,itm>(map, k)
//
implement
myfunmap_insert
  (map, k, x) = funmap_insert<key,itm>(map, k, x)
//
(* ****** ****** *)
//
implement
myfunmap_remove
  (map, k) = funmap_remove<key,itm>(map, k)
implement
myfunmap_takeout
  (map, k) = funmap_takeout<key,itm>(map, k)
//
implement
fprint_myfunmap
  (out, map) = fprint_funmap<key,itm>(out, map)
//
(* ****** ****** *)
//
implement
myfunmap_foreach_cloref
  (map, fwork) =
  funmap_foreach_cloref<key,itm>(map, fwork)
implement
myfunmap_foreach_method
  (map) =
(
lam(fwork) => myfunmap_foreach_cloref(map, fwork)
) (* myfunmap_foreach_method *)
//
(* ****** ****** *)
//
implement
myfunmap_listize
  (map) = funmap_listize<key,itm>(map)
//
(* ****** ****** *)
//
implement
myfunmap_streamize
  (map) = funmap_streamize<key,itm>(map)
//
(* ****** ****** *)
//
// HX-2016-07-31:
// creating a module(record):
//
implement
myfunmap_make_module
  ((*void*)) = funmap_make_module<key,itm>()
//
(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [myfunmap.hats] *)
