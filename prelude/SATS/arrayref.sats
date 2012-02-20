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
// Start Time: February, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [arrayref.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(*
staload "fiterator.sats" // HX: it is preloaded
*)

(* ****** ****** *)
//
// arrszref: a reference to an array with size information attached
//
(* ****** ****** *)

abstype
arrszref_viewt0ype_type (a: viewt@ype)
stadef arrszref = arrszref_viewt0ype_type
stadef array0 = arrszref // backward compatibility

(* ****** ****** *)

fun{a:t@ype}
arrszref_get_at (A: arrszref (a), i: size_t):<!exnref> a
overload [] with arrszref_get_at
fun{a:t@ype}
arrszref_set_at (A: arrszref (a), i: size_t, x: a):<!exnref> void
overload [] with arrszref_set_at

(* ****** ****** *)

fun{
a:viewt@ype
} arrszref_exch_at
  (A: arrszref (a), i: size_t, x: &a >> a):<!exnref> void
// end of [arrszref_exch_at]

(* ****** ****** *)

fun{a:t@ype}
arrszref_make_iter_beg
  (A: arrszref (a)): [n:nat] fiterator (arrszref (a), a, 0, n)
// end of [arrszref_make_iter_beg]

fun{a:t@ype}
arrszref_make_iter_end
  (A: arrszref (a)): [n:nat] fiterator (arrszref (a), a, n, 0)
// end of [arrszref_make_iter_end]

(* ****** ****** *)
//
// arrayref: a reference to an array with no size information attached
//
(* ****** ****** *)

abstype
arrayref_viewt0ype_int_type (a: viewt@ype, n: int)
stadef arrayref = arrayref_viewt0ype_int_type
stadef array = arrayref // backward compatibility

typedef Arrayref (a: viewt@ype) = [n:int] arrayref (a, n)

(* ****** ****** *)

fun{a:t@ype}
arrayref_get_at
  {n:int}{i:nat | i < n} (A: arrayref (a, n), i: size_t i):<0> a
overload [] with arrayref_get_at
fun{a:t@ype}
arrayref_set_at
  {n:int}{i:nat | i < n} (A: arrayref (a, n), i: size_t i, x: a):<0> void
overload [] with arrayref_set_at

(* ****** ****** *)

fun{
a:viewt@ype
} arrayref_exch_at
  {n:int}{i:nat | i < n}
  (A: arrayref (a, n), i: size_t i, x: &a >> a):<0> void
// end of [arrayref_exch_at]

(* ****** ****** *)

fun{a:t@ype}
arrayref_make_iter_beg{n:nat}
  (A: arrayref (a, n)): fiterator (Arrayref (a), a, 0, n)
// end of [arrszref_make_iter_beg]

fun{a:t@ype}
arrayref_make_iter_end{n:nat}
  (A: arrayref (a, n), n: size_t n): fiterator (Arrayref (a), a, n, 0)
// end of [arrszref_make_iter_end]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [arrayref.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [arrayref.sats] *)
