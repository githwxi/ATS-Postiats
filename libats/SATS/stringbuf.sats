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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.stringbuf"
//
// HX: prefix for external names
//
#define ATS_EXTERN_PREFIX "atslib_"
//
(* ****** ****** *)

%{#
#include "libats/CATS/stringbuf.cats"
%} // end of [%{#]

(* ****** ****** *)

absvtype stringbuf_vtype = ptr
vtypedef stringbuf = stringbuf_vtype

(* ****** ****** *)
//
// HX: for recapacitizing policy
//
fun{} stringbuf$recapacitize ((*void*)): int
//
(* ****** ****** *)
//
(*
fun{}
stringbuf_make_nil(cap: sizeGte(1)): stringbuf
*)
//
fun{}
stringbuf_make_nil_int(cap: intGte(1)): stringbuf
fun{}
stringbuf_make_nil_size(cap: sizeGte(1)): stringbuf
//
overload stringbuf_make_nil with stringbuf_make_nil_int
overload stringbuf_make_nil with stringbuf_make_nil_size
//
(* ****** ****** *)

fun{}
stringbuf_free(sbf: stringbuf):<!wrt> void

fun{}
stringbuf_getfree_strptr(sbf: stringbuf):<!wrt> Strptr1

fun{}
stringbuf_getfree_strnptr
  (sbf: stringbuf, n: &size_t? >> size_t(n)):<!wrt> #[n:nat] strnptr(n)
// end of [stringbuf_getfree_strnptr]

(* ****** ****** *)

fun{}
stringbuf_get_size(sbf: !stringbuf):<> size_t
fun{}
stringbuf_get_capacity(sbf: !stringbuf):<> size_t

(* ****** ****** *)

fun{}
stringbuf_get_bufptr(sbf: !stringbuf):<> Ptr1
fun{}
stringbuf_get_strptr(sbf: !stringbuf):<!wrt> vStrptr1

(* ****** ****** *)

fun{}
stringbuf_takeout_strbuf
(
  sbf: !stringbuf, n: &size_t? >> size_t(n)
) :<!wrt> #[l:addr;n:nat]
(
  bytes_v (l, n), bytes_v (l, n) -<lin,prf> void | ptr(l)
) (* end of [stringbuf_takeout_strbuf] *)

(* ****** ****** *)

fun{}
stringbuf_reset_capacity
  (sbf: !stringbuf, m2: sizeGte(1)):<!wrt> bool(*done/ignored*)
// end of [stringbuf_reset_capacity]

(* ****** ****** *)
//
// HX: (-1) indicates error of bounds-checking
//
fun{}
stringbuf_get_at(sbf: !stringbuf, i: size_t): int
fun{}
stringbuf_rget_at(sbf: !stringbuf, i: sizeGte(1)): int

(* ****** ****** *)

symintr stringbuf_insert

(* ****** ****** *)

fun{}
stringbuf_insert_char(!stringbuf, x: charNZ): int
fun{}
stringbuf_insert_string(!stringbuf, x: string): int
fun{}
stringbuf_insert_strlen
  {n:int}(buf: !stringbuf, string n, size_t n): int
fun{}
stringbuf_insert_bool(sbf: !stringbuf, x: bool): int

(* ****** ****** *)

overload stringbuf_insert with stringbuf_insert_char
overload stringbuf_insert with stringbuf_insert_string
overload stringbuf_insert with stringbuf_insert_bool

(* ****** ****** *)

fun{}
stringbuf_insert_int(sbf: !stringbuf, x: int): int
fun{}
stringbuf_insert_uint(sbf: !stringbuf, x: uint): int
fun{}
stringbuf_insert_lint(sbf: !stringbuf, x: lint): int
fun{}
stringbuf_insert_ulint(sbf: !stringbuf, x: ulint): int

(* ****** ****** *)

overload stringbuf_insert with stringbuf_insert_int
overload stringbuf_insert with stringbuf_insert_uint
overload stringbuf_insert with stringbuf_insert_lint
overload stringbuf_insert with stringbuf_insert_ulint

(* ****** ****** *)

fun{}
stringbuf_insert_fread
  (sbf: !stringbuf, inp: FILEref, nbyte: int): int
// end of [stringbuf_insert_fread]

(* ****** ****** *)

fun{}
stringbuf_insert_fgets
(
  sbf: !stringbuf, inp: FILEref, last: &char(0) >> char
) : int // end of [stringbuf_insert_fgets]

(* ****** ****** *)
(*
//
fun
stringbuf_insert_snprintf
  (sbf: !stringbuf, recap: int, fmt: string, ...) = "mac#%"
//
*)
(* ****** ****** *)

fun{a:t0p}
stringbuf_insert_val(sbf: !stringbuf, x: a): int

(* ****** ****** *)

fun{a:t0p}
stringbuf_insert_list(sbf: !stringbuf, x: List(a)): int

(* ****** ****** *)
//
// HX-2014-07:
// taking out the first [i] chars, and
// moving the rest of chars to the front
//
fun{}
stringbuf_takeout
  (sbf: !stringbuf, i: size_t):<!wrt> Strptr1
//
fun{}
stringbuf_takeout_all(sbf: !stringbuf):<!wrt> Strptr1
//
(* ****** ****** *)
//
fun{}
stringbuf_remove
  (sbf: !stringbuf, i: size_t):<!wrt> void
//
fun{}
stringbuf_remove_all(sbf: !stringbuf):<!wrt> void
//
(* ****** ****** *)

fun{}
stringbuf_truncate
  (sbf: !stringbuf, n2: size_t):<!wrt> bool(*done/ignored*)
// end of [stringbuf_truncate]

(* ****** ****** *)
//
// HX-2014:
// taking out the truncated porting
//
fun{}
stringbuf_truncout
  (sbf: !stringbuf, n2: size_t):<!wrt> Strptr0
//
// HX-2014:
// it does the same as [stringbuf_takeout_all]
//
fun{}
stringbuf_truncout_all(sbf: !stringbuf):<!wrt> Strptr1
//
(* ****** ****** *)

(* end of [stringbuf.sats] *)
