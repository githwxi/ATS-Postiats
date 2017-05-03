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
map_type
(
  key:t@ype
, itm:t0ype+
) = ptr(*boxed*)
//
typedef
map(key:t0p, itm:t0p) = map_type(key, itm)
//
(* ****** ****** *)
//
fun{key:t0p}
compare_key_key(x1: key, x2: key):<> int
//
(* ****** ****** *)
//
fun{}
funmap_nil{key,itm:t0p}():<> map(key, itm)
fun{}
funmap_make_nil{key,itm:t0p}():<> map(key, itm)
//
(* ****** ****** *)

fun{}
funmap_is_nil
  {key,itm:t0p}(map: map(key, INV(itm))):<> bool
fun{}
funmap_isnot_nil
  {key,itm:t0p}(map: map(key, INV(itm))):<> bool

(* ****** ****** *)

fun{
key,itm:t0p
} funmap_size(map: map(key, INV(itm))):<> size_t

(* ****** ****** *)

fun{
key,itm:t0p
} funmap_search
  (map: map(key, INV(itm)), k: key): Option_vt(itm)
// end of [funmap_search]

(* ****** ****** *)
//
fun{
key,itm:t0p
} funmap_insert
(
  &map(key, INV(itm)) >> _, key, itm
) : Option_vt(itm) // end of [funmap_insert]
//
(* ****** ****** *)
//
fun{
key,itm:t0p
} funmap_takeout
(
  map: &map(key, INV(itm)) >> _, k: key
) : Option_vt(itm) // end of [funmap_takeout]
//
(* ****** ****** *)
//
fun{
key,itm:t0p
} funmap_remove
  (map: &map(key, INV(itm)) >> _, k: key): bool
//
(* ****** ****** *)
//
fun{
key,itm:t@ype
} fprint_funmap
(
  out: FILEref, map: map(key, itm)
) : void // end of [fprint_funmap]
//
fun{}
fprint_funmap$sep(out: FILEref): void // fprint("; ")
fun{}
fprint_funmap$mapto(out: FILEref): void // fprint("->")
//
overload fprint with fprint_funmap
//
(* ****** ****** *)
//
fun{
key,itm:t0p
} funmap_foreach
  (map: map(key, itm)): void
fun
{key:t0p
;itm:t0p}
{env:vt0p}
funmap_foreach_env
  (map: map(key, itm), env: &(env) >> _): void
//
fun
{key:t0p
;itm:t0p}
{env:vt0p}
funmap_foreach$fwork
  (key: key, itm: &itm >> _, env: &(env) >> _): void
//
(* ****** ****** *)
//
fun{
key,itm:t0p
} funmap_foreach_cloref
(
  map: map(key, itm)
, fwork: (key, itm) -<cloref1> void
) : void // end-of-function
//
(* ****** ****** *)
//
fun{
key,itm:t0p
} funmap_listize
  (map: map(key, INV(itm))): list0 @(key, itm)
//
(* ****** ****** *)
//
fun{
key,itm:t0p
} funmap_streamize
  (map: map(key, INV(itm))): stream_vt @(key, itm)
//
(* ****** ****** *)

typedef
map_modtype
(
  key: t0p, itm: t0p
) = $rec{
//
nil = () -<> map(key,itm)
,
size = $d2ctype(funmap_size<key,itm>)
,
is_nil = (map(key,itm)) -<> bool
,
isnot_nil = (map(key,itm)) -<> bool
,
search = $d2ctype(funmap_search<key,itm>)
,
insert = $d2ctype(funmap_insert<key,itm>)
,
remove = $d2ctype(funmap_remove<key,itm>)
,
takeout = $d2ctype(funmap_takeout<key,itm>)
,
listize = $d2ctype(funmap_listize<key,itm>)
,
streamiize = $d2ctype(funmap_streamize<key,itm>)
//
} (* end of [set_modtype] *)

(* ****** ****** *)
//
fun
{key:t0p
;itm:t0p}
funmap_make_module((*void*)): map_modtype(key,itm)
//
(* ****** ****** *)

(* end of [funmap.sats] *)
