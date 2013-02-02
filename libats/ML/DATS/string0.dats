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

(*
fun malloc_gc
  {n:int} (n: size_t n)
  :<> [l:agz] (b0ytes n @ l, free_gc_v (l) | ptr l)
  = "ext#ats_malloc_gc"
// end of [malloc_gc]

fun
arrszref_make{a:vt0p}{n:int}
  (A: arrayref (a, n), n: size_t n):<> arrszref (a)
// end of [arrszref_make]

*)
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
    : (ptr, ptr, size_t) -<0,!wrt> void = "ext#atslib_memcpy"
  // end of [extern]
in
  memcpy (p, string2ptr (str), n)
end // end of [val]
//
val A = $UN.castvwtp0 {arrayref(char,n)} @(pfarr, pfgc | p)
//
in
  array2string0 (array0_make_arrayref (A, n))
end // end of [string0_make_string]

(* ****** ****** *)

(* end of [string0.dats] *)
