(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: February, 2013 *)

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.ML"
#define // prefix for external
ATS_EXTERN_PREFIX "atslib_ML_" // names
//
(* ****** ****** *)
//
#staload "libats/ML/SATS/basis.sats"
//
(* ****** ****** *)

%{#
//
#include "libats/ML/CATS/strarr.cats"
//
%} // end of [%{#]

(* ****** ****** *)
(*
typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose
*)
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
#endif // #if(0)

(* ****** ****** *)
//
castfn
array2strarr
  (cs: array0(char)):<> strarr
castfn
strarr2array
  (cs: strarr):<> array0(char)
//
(* ****** ****** *)
//
fun{}
strarr_get_ref (str: strarr):<> Ptr1
fun{}
strarr_get_size (str: strarr):<> size_t
//
(* ****** ****** *)
//
fun{}
strarr_get_refsize
(
A0: strarr
) :<> [n:nat] (arrayref (char, n), size_t (n))
// end of [strarr_get_refsize]
//
(* ****** ****** *)
//
fun
strarr_make_string
  (str: string):<!wrt> strarr
//
fun
strarr_make_substring
  (str: string, st: size_t, ln: size_t):<!wrt> strarr
//
symintr strarr_make
//
overload strarr_make with strarr_make_string
overload strarr_make with strarr_make_substring
//
(* ****** ****** *)
//
// HX-2013:
// naming convention:
// xxx_imake_yyy -> yyy_make_xxx
//
fun
strarr_imake_string(str: strarr):<!wrt> string
//
(* ****** ****** *)
//
fun{}
strarr_is_empty(strarr):<> bool
fun{}
strarr_isnot_empty(strarr):<> bool
//
overload iseqz with strarr_is_empty
overload isneqz with strarr_isnot_empty
//
(* ****** ****** *)
//
fun{tk:tk}
strarr_get_at_gint
  (str: strarr, i: g0int(tk)):<!exn> char
fun{tk:tk}
strarr_get_at_guint
  (str: strarr, i: g0uint(tk)):<!exn> char
//
symintr strarr_get_at
//
overload [] with strarr_get_at_gint of 0
overload [] with strarr_get_at_guint of 0
//
overload
strarr_get_at with strarr_get_at_gint of 0
overload
strarr_get_at with strarr_get_at_guint of 0
//
(* ****** ****** *)
//
fun
strarr_get_range
(
  strarr, i0: size_t, i1: size_t
) : string // end-of-strarr_get_range
//
(* ****** ****** *)
//
fun
lt_strarr_strarr
  (x1: strarr, x2: strarr):<> bool
fun
lte_strarr_strarr
  (x1: strarr, x2: strarr):<> bool
//
(* ****** ****** *)
//
fun
gt_strarr_strarr
  (x1: strarr, x2: strarr):<> bool
fun
gte_strarr_strarr
  (x1: strarr, x2: strarr):<> bool
//
(* ****** ****** *)
//
fun
eq_strarr_strarr
  (x1: strarr, x2: strarr):<> bool
fun
neq_strarr_strarr
  (x1: strarr, x2: strarr):<> bool
//
(* ****** ****** *)
//
fun
strarr_compare
  (x1: strarr, x2: strarr):<> int
//
(* ****** ****** *)
//
fun
strarr_length(strarr):<> size_t
//
(* ****** ****** *)
//
fun
print_strarr(str: strarr): void
fun
prerr_strarr(str: strarr): void
//
fun
fprint_strarr
(
  out: FILEref, str: strarr
) : void // end-of-fprint_strarr
//
(* ****** ****** *)
//
fun
strarr_contains
  (str: strarr, c: char):<> bool
//
(* ****** ****** *)
//
fun
strarr_copy(str: strarr):<!wrt> strarr
//
(* ****** ****** *)
//
fun
strarr_append
  (x1: strarr, x2: strarr):<!wrt> strarr
//
(* ****** ****** *)
//
fun
strarr_tabulate
  {n:int}
(
  n: size_t(n), f: cfun(sizeLt(n), char)
) : strarr // end of [strarr_tabulate]
//
(* ****** ****** *)
//
fun
strarr_foreach
  (str: strarr, fwork: cfun(char, void)): void
//
fun
strarr_iforeach
  (str: strarr, fwork: cfun2(size_t, char, void)): void
//
fun
strarr_rforeach
  (str: strarr, fwork: cfun(char, void)): void
//
(* ****** ****** *)
//
// Some common overloading
//
(* ****** ****** *)
//
overload + with strarr_append
//
overload < with lt_strarr_strarr
overload <= with lte_strarr_strarr
overload > with gt_strarr_strarr
overload >= with gte_strarr_strarr
overload = with eq_strarr_strarr
overload != with neq_strarr_strarr
overload <> with neq_strarr_strarr
//
(* ****** ****** *)
//
overload print with print_strarr
overload prerr with prerr_strarr
//
overload fprint with fprint_strarr
//
(* ****** ****** *)
//
overload length with strarr_length
//
overload compare with strarr_compare
//
(* ****** ****** *)

(* end of [strarr.sats] *)
