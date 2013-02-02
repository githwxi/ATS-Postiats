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
val A = $UN.castvwtp0 {A} @(pfarr, pfgc | p)
//
in
  array2string0 (array0_make_arrayref (A, n))
end // end of [string0_make_string]

(* ****** ****** *)

implement
string0_append
  (str1, str2) = let
  val str1 = string2array0 (str1)
  val str2 = string2array0 (str2)
in
  array2string0 (array0_append<char> (str1, str2))
end // end of [string0_append]

(* ****** ****** *)

implement
string0_foreach
  (str, f) = let
//
fun loop (
  p: ptr, n: size_t, i: size_t, f: cfun (char, void)
) : void = let
in
//
if i < n then let
  val () = f ($UN.ptr0_get<char> (p)) in loop (ptr0_succ<char> (p), n, succ(i), f)
end else () // end of [if]
//
end // end of [loop]
//
val p = string0_get_ref (str)
val n = string0_get_size (str)
//
in
  loop (p, n, g0int2uint(0), f)
end // end of [string0_foreach]

(* ****** ****** *)

(* end of [string0.dats] *)
