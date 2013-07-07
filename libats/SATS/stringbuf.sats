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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

absvtype stringbuf_vtype = ptr
vtypedef stringbuf = stringbuf_vtype

(* ****** ****** *)

fun{}
stringbuf_make_nil (cap: sizeGte(1)): stringbuf

(* ****** ****** *)

fun{}
stringbuf_getfree_strnptr
  (sb: stringbuf, n: &size_t? >> size_t n):<!wrt> #[n:nat] strnptr(n)
// end of [stringbuf_getfree_strnptr]

(* ****** ****** *)

fun{}
stringbuf_insert_at_char (sb: !stringbuf, x: charNZ): int
fun{}
stringbuf_insert_at_string (sb: !stringbuf, x: string): int

(* ****** ****** *)

fun{}
stringbuf_insert_atend_char (sb: !stringbuf, x: charNZ): int
fun{}
stringbuf_insert_atend_string (sb: !stringbuf, x: string): int

(* ****** ****** *)

(* end of [stringbuf.sats] *)
