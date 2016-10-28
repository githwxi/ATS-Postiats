(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmmhwxiATgmailDOTcom *)
(* Start time: October, 2016 *)

(* ****** ****** *)
//
abstype
qlistref_vt0ype_type(a:vt@ype) = ptr
//
typedef
qlistref(a:vt0ype) = qlistref_vt0ype_type(a)
//
(* ****** ****** *)
//
fun{}
qlistref_make_nil
  {a:vt0ype}((*void*)):<!wrt> qlistref(a)
//
(* ****** ****** *)

fun
{a:vt0p}
qlistref_is_nil(q0: qlistref(a)): bool
fun
{a:vt0p}
qlistref_isnot_nil(q0: qlistref(a)): bool

(* ****** ****** *)

fun
{a:vt0p}
qlistref_length(q0: qlistref(a)): intGte(0)

(* ****** ****** *)
//
fun
{a:vt0p}
qlistref_insert(qlistref(a), a):<!ref> void
//
(* ****** ****** *)
//
fun
{a:vt0p}
qlistref_takeout_exn(qlistref(a)):<!ref> (a)
fun
{a:vt0p}
qlistref_takeout_opt(qlistref(a)):<!ref> Option_vt(a)
//
(* ****** ****** *)
//
fun
{a:vt0p}
qlistref_takeout_list(qlistref(a)):<!ref> List0_vt(a)
//
(* ****** ****** *)
//
// overloading for certain symbols
//
(* ****** ****** *)
//
overload iseqz with qlistref_is_nil
overload isneqz with qlistref_isnot_nil
//
(* ****** ****** *)

overload length with qlistref_length

(* ****** ****** *)
//
overload .insert with qlistref_insert
//
(* ****** ****** *)
//
overload .takeout with qlistref_takeout_exn
overload .takeout_opt with qlistref_takeout_opt
//
(* ****** ****** *)

(* end of [qlistref.sats] *)
