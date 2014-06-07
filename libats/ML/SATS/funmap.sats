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
// HX: for maps of elements of type (a)
//
abstype
map_type (key:t@ype, itm:t0ype+) = ptr
typedef
map (key:t0p, itm:t0p) = map_type (key, itm)
//
(* ****** ****** *)

fun{key:t0p}
compare_key_key (x1: key, x2: key):<> int

(* ****** ****** *)

fun{} funmap_nil{key,itm:t0p} ():<> map (key, itm)
fun{} funmap_make_nil{key,itm:t0p} ():<> map (key, itm)

(* ****** ****** *)

fun{
} funmap_is_nil
  {key,itm:t0p} (map: map (key, INV(itm))):<> bool
fun{
} funmap_isnot_nil
  {key,itm:t0p} (map: map (key, INV(itm))):<> bool

(* ****** ****** *)

fun{
key,itm:t0p
} funmap_size (map: map (key, INV(itm))):<> size_t

(* ****** ****** *)

fun{
key,itm:t0p
} funmap_search
  (map: map (key, INV(itm)), k: key): Option_vt (itm)
// end of [funmap_search]

(* ****** ****** *)

fun{
key,itm:t0p
} funmap_insert
  (map: &map (key, INV(itm)) >> _, key, itm): Option_vt (itm)
// end of [funmap_insert]

(* ****** ****** *)

fun{
key,itm:t0p
} funmap_takeout
  (map: &map (key, INV(itm)) >> _, k: key): Option_vt (itm)
// end of [funmap_takeout]

(* ****** ****** *)

fun{
key,itm:t0p
} funmap_remove (map: &map (key, INV(itm)) >> _, k: key): bool

(* ****** ****** *)

fun{
key,itm:t0p
} funmap_listize (map: map (key, INV(itm))): list0 @(key, itm)

(* ****** ****** *)

(* end of [funmap.sats] *)
