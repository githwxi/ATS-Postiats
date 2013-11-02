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

#define ATS_PACKNAME "ATSLIB.libats.stringbuf"
#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

absvtype stringbuf_vtype = ptr
vtypedef stringbuf = stringbuf_vtype

(* ****** ****** *)

abst@ype
stringbuf_tsize = $extype"atslib_stringbuf_struct"

(* ****** ****** *)

fun{}
stringbuf_make_cap (cap: sizeGte(1)): stringbuf

(* ****** ****** *)

fun
stringbuf_make_ngc
  {l:addr}{m:int}
(
  stringbuf_tsize? @ l
| ptr(l), bufp: arrayptr(char?, m+1), cap: size_t(m)
) :<!wrt> (mfree_ngc_v (l) | stringbuf) = "mac#%"

(* ****** ****** *)

fun{}
stringbuf_get_size (sbf: !stringbuf): size_t = "mac#%"
fun{}
stringbuf_get_capacity (sbf: !stringbuf): size_t = "mac#%"

(* ****** ****** *)

fun{}
stringbuf_getfree_strnptr
  (sbf: stringbuf, n: &size_t? >> size_t(n)):<!wrt> #[n:nat] strnptr(n)
// end of [stringbuf_getfree_strnptr]

(* ****** ****** *)

fun{}
stringbuf_insert_char (sbf: !stringbuf, x: charNZ): int
fun{}
stringbuf_insert_string (sbf: !stringbuf, x: string): int

(* ****** ****** *)

fun{}
stringbuf_insert_int (sbf: !stringbuf, x: int): int
fun{}
stringbuf_insert_bool (sbf: !stringbuf, x: bool): int
fun{}
stringbuf_insert_double (sbf: !stringbuf, x: double): int

(* ****** ****** *)

fun{}
stringbuf_reset_capacity
  (sbf: !stringbuf, m2: sizeGte(1)): bool(*done/ignored*)
// end of [stringbuf_reset_capacity]

(* ****** ****** *)

(* end of [stringbuf.sats] *)
