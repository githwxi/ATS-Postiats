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

staload "libats/SATS/ML_basis.sats"

(* ****** ****** *)

%{#
#include "libats/ML/CATS/string0.cats"
%} // end of [%{#]

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)
//
// HX-2013-02:
// a string0-value is represented an array of character;
// in principle, this array should be treated as read-only.
//
(* ****** ****** *)

abstype string0_type = ptr
typedef string0 = string0_type

(* ****** ****** *)

castfn array2string0 (cs: array0 (char)):<> string0
castfn string2array0 (cs: string0):<> array0 (char)

(* ****** ****** *)

fun{}
string0_get_ref (str: string0):<> Ptr1
fun{}
string0_get_size (str: string0):<> size_t

fun{}
string0_get_refsize
  (A: string0):<> [n:nat] (arrayref (char, n), size_t (n))
// end of [string0_get_refsize]

(* ****** ****** *)

symintr string0
fun string0_make_string (str: string):<!wrt> string0
overload string0 with string0_make_string

(* ****** ****** *)

fun string0_imake_string (str: string0):<!wrt> string

(* ****** ****** *)

symintr string0_get_at

fun{tk:tk}
string0_get_at_gint (str: string0, i: g0int(tk)):<!exn> char
overload string0_get_at with string0_get_at_gint of 0
fun{tk:tk}
string0_get_at_guint (str: string0, i: g0uint(tk)):<!exn> char
overload string0_get_at with string0_get_at_guint of 0

(* ****** ****** *)

fun lt_string0_string0
  (str1: string0, str2: string0):<> bool
overload < with lt_string0_string0
fun lte_string0_string0
  (str1: string0, str2: string0):<> bool
overload <= with lte_string0_string0

fun gt_string0_string0
  (str1: string0, str2: string0):<> bool
overload > with gt_string0_string0
fun gte_string0_string0
  (str1: string0, str2: string0):<> bool
overload >= with gte_string0_string0

fun eq_string0_string0
  (str1: string0, str2: string0):<> bool
overload = with eq_string0_string0
fun neq_string0_string0
  (str1: string0, str2: string0):<> bool
overload != with neq_string0_string0
overload <> with neq_string0_string0

(* ****** ****** *)

fun string0_compare
  (str1: string0, str2: string0):<> int
overload compare with string0_compare

(* ****** ****** *)

fun string0_contains (str: string0, c: char):<> bool

(* ****** ****** *)

fun string0_copy (str: string0):<!wrt> string0

(* ****** ****** *)

fun string0_append (str1: string0, str2: string0):<!wrt> string0
overload + with string0_append

(* ****** ****** *)

fun string0_foreach (str: string0, f: cfun (char, void)): void
fun string0_rforeach (str: string0, f: cfun (char, void)): void

(* ****** ****** *)

(* end of [string0.sats] *)
