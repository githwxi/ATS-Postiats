(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: September, 2011
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [float.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

fun{a:t@ype}
g0float_add
  (x: g0float (a), y: g0float (a)):<> g0float (a)
overload + with g0float_add

fun{a:t@ype}
g0float_sub
  (x: g0float (a), y: g0float (a)):<> g0float (a)
overload - with g0float_sub

fun{a:t@ype}
g0float_mul
  (x: g0float (a), y: g0float (a)):<> g0float (a)
overload * with g0float_mul

fun{a:t@ype}
g0float_div
  (x: g0float (a), y: g0float (a)):<> g0float (a)
overload / with g0float_div

(* ****** ****** *)

fun{a:t@ype}
g0float_lt
  (x: g0float (a), y: g0float (a)):<> bool
overload < with g0float_lt

fun{a:t@ype}
g0float_lte
  (x: g0float (a), y: g0float (a)):<> bool
overload <= with g0float_lte

fun{a:t@ype}
g0float_gt
  (x: g0float (a), y: g0float (a)):<> bool
overload > with g0float_gt

fun{a:t@ype}
g0float_gte
  (x: g0float (a), y: g0float (a)):<> bool
overload >= with g0float_gte

fun{a:t@ype}
g0float_compare
  (x: g0float (a), y: g0float (a)):<> int
overload compare with g0float_compare

(* ****** ****** *)

fun{a:t@ype}
g0float_max
  (x: g0float (a), y: g0float (a)):<> g0float (a)
overload max with g0float_max

fun{a:t@ype}
g0float_min
  (x: g0float (a), y: g0float (a)):<> g0float (a)
overload min with g0float_min

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [float.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [float.sats] *)
