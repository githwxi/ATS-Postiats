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
vtypedef hashtbl
  (key:t0p, itm: vt0p) = hashtbl_vtype (key, itm)
//
(* ****** ****** *)

fun{key:t0p}
hash_key (x: key):<> ulint
fun{key:t0p}
equal_key_key (x1: key, x2: key):<> bool

(* ****** ****** *)
//
// HX: the number of stored elements
//
fun hashtbl_get_size
  {key:t0p;itm:vt0p} (p: !hashtbl (key, itm)):<> size_t
// end of [hashtbl_get_size]

(* ****** ****** *)
//
// HX: the array size of the hashtable
//
fun hashtbl_get_capacity
  {key:t0p;itm:vt0p} (p: !hashtbl (key, itm)):<> sizeGte(1)
// end of [hashtbl_get_capacity]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} hashtbl_insert_any
  (!hashtbl (key, itm), key, itm): void
// end of [hashtbl_insert_any]

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
hashtbl_foreach (tbl: !hashtbl (key, itm)): void
fun
{key:t0p
;itm:vt0p}
{env:vt0p}
hashtbl_foreach_env (tbl: !hashtbl (key, itm), &env >> _): void

(* ****** ****** *)

(* end of [linhashtbl.hats] *)
