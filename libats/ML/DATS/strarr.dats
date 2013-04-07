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

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/ML_basis.sats"
staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)

staload "libats/ML/SATS/array0.sats"
staload _(*anon*) = "libats/ML/DATS/array0.dats"

(* ****** ****** *)

staload "libats/ML/SATS/strarr.sats"

(* ****** ****** *)

implement{}
strarr_get_ref (str) =
  array0_get_ref (strarr2array (str))
// end of [strarr_get_ref]

implement{}
strarr_get_size (str) =
  array0_get_size (strarr2array (str))
// end of [strarr_get_size]

implement{}
strarr_get_refsize (str) =
  array0_get_refsize (strarr2array (str))
// end of [strarr_get_refsize]

(* ****** ****** *)

implement
strarr_make_string
  (str) = let
//
val [n:int] str =
  string1_of_string0 (str)
//
val n = string1_length (str)
//
val
(
  pfarr, pfgc | p
) = array_ptr_alloc<char> (n)
//
// [memcpy] declared in [string.h]
//
val _(*ptr*) = $extfcall (ptr, "memcpy", p, string2ptr(str), n)
//
typedef A = arrayref (char, n)
//
val A = $UN.castvwtp0 {A} @(pfarr, pfgc | p)
//
in
  array2strarr (array0_make_arrayref (A, n))
end // end of [strarr_make_string]

(* ****** ****** *)

implement
strarr_imake_string
  (str) = let
//
val p = strarr_get_ref (str)
val sz = g1ofg0_uint (strarr_get_size (str))
val (pfgc, pfarr | p2) = malloc_gc (succ (sz))
//
// [memcpy] declared in [string.h]
//
val _(*ptr*) = $extfcall (ptr, "memcpy", p2, p, sz)
//
val () = $UN.ptr0_set<char> (ptr_add<char> (p2, sz), '\000')
//
in
  $UN.castvwtp0 {string} @(pfgc, pfarr | p2)
end // end of [strarr_imake_string]

(* ****** ****** *)

implement{tk}
strarr_get_at_gint
  (str, i) = let
  val str = strarr2array (str) in
  $effmask_ref (array0_get_at_gint<char> (str, i))
end // end of [strarr_get_at_gint]

implement{tk}
strarr_get_at_guint
  (str, i) = let
  val str = strarr2array (str) in
  $effmask_ref (array0_get_at_guint<char> (str, i))
end // end of [strarr_get_at_guint]

(* ****** ****** *)

implement
lt_strarr_strarr
  (str1, str2) = (strarr_compare (str1, str2) < 0)
implement
lte_strarr_strarr
  (str1, str2) = (strarr_compare (str1, str2) <= 0)

implement
gt_strarr_strarr
  (str1, str2) = (strarr_compare (str1, str2) > 0)
implement
gte_strarr_strarr
  (str1, str2) = (strarr_compare (str1, str2) >= 0)

implement
eq_strarr_strarr
  (str1, str2) = (strarr_compare (str1, str2) = 0)
implement
neq_strarr_strarr
  (str1, str2) = (strarr_compare (str1, str2) != 0)

(* ****** ****** *)

implement
strarr_compare
  (str1, str2) = let
//
val (A1, n1) = strarr_get_refsize (str1)
and (A2, n2) = strarr_get_refsize (str2)
//
extern
fun strncmp
  : (ptr, ptr, size_t) -<fun> int = "strncmp"
//
val n = g0uint_min_size (n1, n2)
//
// [strncmp] declared in [string.h]
//
val sgn = $extfcall (int, "strncmp", $UN.cast2ptr(A1), $UN.cast2ptr(A2), n)
//
in
//
if sgn = 0 then
  (if n1 < n2 then ~1 else if n1 > n2 then 1 else 0)
else sgn // end of [if]
//
end // end of [strarr_compare]

(* ****** ****** *)

implement
strarr_contains
  (str, c0) = $effmask_all let
//
val (A, asz) = strarr_get_refsize (str)
//
// [memcpy] declared in [string.h]
//
val p = $extfcall (ptr, "memchr", $UN.cast2ptr(A), char2int0(c0), asz)
//
in
  (p > the_null_ptr)
end // end of [strarr_contains]

(* ****** ****** *)

implement
strarr_copy
  (str) = let
  val str = strarr2array (str)
  val str2 = $effmask_ref (array0_copy<char> (str))
in
  array2strarr (str2)
end // end of [strarr_copy]

(* ****** ****** *)

implement
strarr_append
  (str1, str2) = let
  val str1 = strarr2array (str1)
  val str2 = strarr2array (str2)
  val str12 = $effmask_ref (array0_append<char> (str1, str2))
in
  array2strarr (str12)
end // end of [strarr_append]

(* ****** ****** *)

(*

implement
strarr_foreach
  (str, f) = let
//
fun loop
(
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
val p0 = strarr_get_ref (str)
val n0 = strarr_get_size (str)
//
in
  loop (p0, n0, f)
end // end of [strarr_foreach]

(* ****** ****** *)

implement
strarr_rforeach
  (str, f) = let
//
fun loop
(
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
val p0 = strarr_get_ref (str)
val n0 = strarr_get_size (str)
//
in
  loop (ptr0_add_guint<char> (p0, n0), n0, f)
end // end of [strarr_rforeach]

*)

(* ****** ****** *)

(* end of [strarr.dats] *)
