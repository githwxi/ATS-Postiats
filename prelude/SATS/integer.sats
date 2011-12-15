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
#print "Loading [integer.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)
//
// HX: for unsigned unindexed integer types
//
(* ****** ****** *)

fun{a:t@ype}
g0int_add
  (x: g0int (a), y: g0int (a)): g0int (a)
overload + with g0int_add

fun{a:t@ype}
g0int_sub
  (x: g0int (a), y: g0int (a)): g0int (a)
overload - with g0int_sub

fun{a:t@ype}
g0int_mul
  (x: g0int (a), y: g0int (a)): g0int (a)
overload * with g0int_mul

fun{a:t@ype}
g0int_div
  (x: g0int (a), y: g0int (a)): g0int (a)
overload / with g0int_div

(* ****** ****** *)

fun{a:t@ype}
g0int_lt (x: g0int (a), y: g0int (a)): bool
overload < with g0int_lt

fun{a:t@ype}
g0int_lte (x: g0int (a), y: g0int (a)): bool
overload <= with g0int_lte

fun{a:t@ype}
g0int_gt (x: g0int (a), y: g0int (a)): bool
overload > with g0int_gt

fun{a:t@ype}
g0int_gte (x: g0int (a), y: g0int (a)): bool
overload >= with g0int_gte

(* ****** ****** *)
//
// HX: for unsigned indexed integer types
//
castfn
g1ofg0_int
  {a:t@ype} (x: g0int a): g1int (a)
(*
macdef g1ofg0_int (x) = g1ofg0_int ,(x)
*)

(* ****** ****** *)

fun{a:t@ype}
g1int_add {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)): g1int (a, i+j)
overload + with g1int_add

fun{a:t@ype}
g1int_sub {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)): g1int (a, i-j)
overload - with g1int_sub

(* ****** ****** *)
//
// HX: for unsigned unindexed integer types
//
(* ****** ****** *)

fun{a:t@ype}
g0uint_add
  (x: g0uint (a), y: g0uint (a)): g0uint (a)
overload + with g0uint_add

fun{a:t@ype}
g0uint_sub
  (x: g0uint (a), y: g0uint (a)): g0uint (a)
overload - with g0uint_sub

(* ****** ****** *)
//
// HX: for unsigned indexed integer types
//
praxi
g1uint_param_lemma
  {a:t@ype} {i:int} (x: g1uint (a, i)): [i >= 0] void
// end of [g1uint_param_lemma]

castfn
g1ofg0_uint
  {a:t@ype} (x: g0uint a): g1uint (a)
(*
macdef g1ofg0_uint (x) = g1ofg0_uint ,(x)
*)

(* ****** ****** *)

fun{a:t@ype}
g1uint_add {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)): g1uint (a, i+j)
overload + with g1uint_add

fun{a:t@ype}
g1uint_sub {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)): g1uint (a, i-j)
overload - with g1uint_sub

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [integer.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [integer.sats] *)
