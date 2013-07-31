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

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

%{#
#include "libats/ML/CATS/strarr.cats"
%} // end of [%{#]

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)
//
// HX-2013-02:
// a strarr-value is represented an array of character;
// in principle, this array should be treated as read-only.
//
(* ****** ****** *)

#if(0)
//
// HX: in [basis.sats]
//
abstype strarr_type = ptr
typedef strarr = strarr_type
//
#endif

(* ****** ****** *)

castfn array2strarr (cs: array0 (char)):<> strarr
castfn strarr2array (cs: strarr):<> array0 (char)

(* ****** ****** *)

fun{}
strarr_get_ref (str: strarr):<> Ptr1
fun{}
strarr_get_size (str: strarr):<> size_t

fun{}
strarr_get_refsize
  (A: strarr):<> [n:nat] (arrayref (char, n), size_t (n))
// end of [strarr_get_refsize]

(* ****** ****** *)

symintr strarr
fun strarr_make_string (str: string):<!wrt> strarr
overload strarr with strarr_make_string

(* ****** ****** *)

fun strarr_make_substring
  (string, st: size_t, ln: size_t):<!wrt> strarr
// end of [strarr_make_substring]

(* ****** ****** *)
//
// HX-2013:
// naming convention: xxx_imake_yyy -> yyy_make_xxx
//
fun strarr_imake_string (str: strarr):<!wrt> string
//
(* ****** ****** *)

fun{}
strarr_is_empty (strarr):<> bool
overload iseqz with strarr_is_empty

fun{}
strarr_isnot_empty (strarr):<> bool
overload isneqz with strarr_isnot_empty

(* ****** ****** *)
//
symintr strarr_get_at
//
fun{tk:tk}
strarr_get_at_gint
  (str: strarr, i: g0int(tk)):<!exn> char
fun{tk:tk}
strarr_get_at_guint
  (str: strarr, i: g0uint(tk)):<!exn> char
//
overload [] with strarr_get_at_gint of 0
overload strarr_get_at with strarr_get_at_gint of 0
overload [] with strarr_get_at_guint of 0
overload strarr_get_at with strarr_get_at_guint of 0
//
(* ****** ****** *)

fun strarr_get_range
  (strarr, i0: size_t, i1: size_t): string
// end of [strarr_get_range]

(* ****** ****** *)

fun lt_strarr_strarr
  (str1: strarr, str2: strarr):<> bool
overload < with lt_strarr_strarr
fun lte_strarr_strarr
  (str1: strarr, str2: strarr):<> bool
overload <= with lte_strarr_strarr

fun gt_strarr_strarr
  (str1: strarr, str2: strarr):<> bool
overload > with gt_strarr_strarr
fun gte_strarr_strarr
  (str1: strarr, str2: strarr):<> bool
overload >= with gte_strarr_strarr

fun eq_strarr_strarr
  (str1: strarr, str2: strarr):<> bool
overload = with eq_strarr_strarr
fun neq_strarr_strarr
  (str1: strarr, str2: strarr):<> bool
overload != with neq_strarr_strarr
overload <> with neq_strarr_strarr

(* ****** ****** *)

fun strarr_compare
  (str1: strarr, str2: strarr):<> int
overload compare with strarr_compare

(* ****** ****** *)

fun{}
strarr_length (str: strarr):<> size_t
overload length with strarr_length

(* ****** ****** *)
//
fun print_strarr (str: strarr): void
fun prerr_strarr (str: strarr): void
fun fprint_strarr (out: FILEref, str: strarr): void
//
overload print with print_strarr
overload prerr with prerr_strarr
overload fprint with fprint_strarr
//
(* ****** ****** *)

fun strarr_contains (str: strarr, c: char):<> bool

(* ****** ****** *)

fun strarr_copy (str: strarr):<!wrt> strarr

(* ****** ****** *)

fun strarr_append
  (str1: strarr, str2: strarr):<!wrt> strarr
overload + with strarr_append

(* ****** ****** *)
//
fun strarr_tabulate
  (n: size_t, f: cfun (size_t, char)): strarr
//
(* ****** ****** *)
//
fun strarr_foreach (str: strarr, f: cfun (char, void)): void
fun strarr_iforeach (str: strarr, f: cfun2 (size_t, char, void)): void
fun strarr_rforeach (str: strarr, f: cfun (char, void)): void
//
(* ****** ****** *)

(* end of [strarr.sats] *)
