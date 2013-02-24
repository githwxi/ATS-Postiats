(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: February, 2013 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/array0.sats"
staload "libats/ML/SATS/string0.sats"

(* ****** ****** *)

implement
string0_get_ref (str) =
  array0_get_ref (string2array0 (str))
// end of [string0_get_ref]

implement
string0_get_size (str) =
  array0_get_size (string2array0 (str))
// end of [string0_get_size]

implement
string0_get_refsize (str) =
  array0_get_refsize (string2array0 (str))
// end of [string0_get_refsize]

(* ****** ****** *)

implement
string0_make_string
  (str) = let
//
val [n:int] str =
  string1_of_string0 (str)
val n = string1_length (str)
val (
  pfarr, pfgc | p
) = array_ptr_alloc<char> (n)
val () = let
  extern fun memcpy
    : (ptr(*dst*), ptr, size_t) -<0,!wrt> void = "mac#atslib_memcpy"
  // end of [extern]
in
  memcpy (p, string2ptr (str), n)
end // end of [val]
//
typedef A = arrayref (char, n)
//
val A = $UN.castvwtp0 {A} @(pfarr, pfgc | p)
//
in
  array2string0 (array0_make_arrayref (A, n))
end // end of [string0_make_string]

(* ****** ****** *)

implement
string0_imake_string
  (str) = let
//
val p = string0_get_ref (str)
val sz = g1ofg0_uint (string0_get_size (str))
val (pfgc, pfarr | p2) = malloc_gc (succ (sz))
//
val _(*ptr*) = let
  extern fun memcpy
    : (ptr, ptr, size_t) -<0,!wrt> ptr = "mac#atslib_memcpy"
  // end of [extern]
in
  memcpy (p2, p, sz)
end // end of [val]
//
val () = $UN.ptr0_set<char> (ptr_add<char> (p2, sz), '\000')
//
in
  $UN.castvwtp0 {string} @(pfgc, pfarr | p2)
end // end of [string0_imake_string]

(* ****** ****** *)

implement{tk}
string0_get_at_gint
  (str, i) = let
  val str = string2array0 (str) in
  $effmask_ref (array0_get_at_gint<char> (str, i))
end // end of [string0_get_at_gint]

implement{tk}
string0_get_at_guint
  (str, i) = let
  val str = string2array0 (str) in
  $effmask_ref (array0_get_at_guint<char> (str, i))
end // end of [string0_get_at_guint]

(* ****** ****** *)

implement
lt_string0_string0
  (str1, str2) = (string0_compare (str1, str2) < 0)
implement
lte_string0_string0
  (str1, str2) = (string0_compare (str1, str2) <= 0)

implement
gt_string0_string0
  (str1, str2) = (string0_compare (str1, str2) > 0)
implement
gte_string0_string0
  (str1, str2) = (string0_compare (str1, str2) >= 0)

implement
eq_string0_string0
  (str1, str2) = (string0_compare (str1, str2) = 0)
implement
neq_string0_string0
  (str1, str2) = (string0_compare (str1, str2) != 0)

(* ****** ****** *)

implement
string0_compare
  (str1, str2) = let
//
val (A1, n1) = string0_get_refsize (str1)
and (A2, n2) = string0_get_refsize (str2)
//
extern
fun strncmp
  : (ptr, ptr, size_t) -<fun> int = "mac#atslib_strncmp"
//
val n = g0uint_min_size (n1, n2)
val sgn = strncmp ($UN.cast2ptr(A1), $UN.cast2ptr(A2), n)
//
in
//
if sgn = 0 then
  (if n1 < n2 then ~1 else if n1 > n2 then 1 else 0)
else sgn // end of [if]
//
end // end of [string0_compare]

(* ****** ****** *)

implement
string0_contains
  (str, c0) = $effmask_all let
//
val (A, asz) = string0_get_refsize (str)
//
extern
fun memchr
  : (ptr, int, size_t) -<fun> ptr = "mac#atslib_memchr"
//
val p = memchr ($UN.cast2ptr (A), char2int0 (c0), asz)
//
in
  (p > the_null_ptr)
end // end of [string0_contains]

(* ****** ****** *)

implement
string0_copy
  (str) = let
  val str = string2array0 (str)
  val str2 = $effmask_ref (array0_copy<char> (str))
in
  array2string0 (str2)
end // end of [string0_copy]

(* ****** ****** *)

implement
string0_append
  (str1, str2) = let
  val str1 = string2array0 (str1)
  val str2 = string2array0 (str2)
  val str12 = $effmask_ref (array0_append<char> (str1, str2))
in
  array2string0 (str12)
end // end of [string0_append]

(* ****** ****** *)

implement
string0_foreach
  (str, f) = let
//
fun loop (
  p: ptr, n: size_t, f: cfun (char, void)
) : void = let
in
//
if n > 0 then let
  val () = f ($UN.ptr0_get<char> (p))
in
  loop (ptr0_succ<char> (p), pred (n), f)
end else () // end of [if]
//
end // end of [loop]
//
val p0 = string0_get_ref (str)
val n0 = string0_get_size (str)
//
in
  loop (p0, n0, f)
end // end of [string0_foreach]

(* ****** ****** *)

implement
string0_rforeach
  (str, f) = let
//
fun loop (
  p: ptr, n: size_t, f: cfun (char, void)
) : void = let
in
//
if n > 0 then let
  val p1 = ptr0_pred<char> (p)
  val () = f ($UN.ptr0_get<char> (p1)) in loop (p1, pred (n), f)
end else () // end of [if]
//
end // end of [loop]
//
val p0 = string0_get_ref (str)
val n0 = string0_get_size (str)
//
in
  loop (ptr0_add_guint<char> (p0, n0), n0, f)
end // end of [string0_rforeach]

(* ****** ****** *)

(* end of [string0.dats] *)
