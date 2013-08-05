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

absvtype strbuf_vtype = ptr
vtypedef strbuf = strbuf_vtype

(* ****** ****** *)

fun{}
strbuf_make_nil (cap: sizeGte(1)): strbuf

(* ****** ****** *)

fun{}
strbuf_getfree_strnptr
(
  sb: strbuf, n: &size_t? >> size_t (n)
) :<!wrt> #[n:nat] strnptr(n)

(* ****** ****** *)

fun{}
strbuf_insert_char (sb: !strbuf, x: charNZ): int
fun{}
strbuf_insert_string (sb: !strbuf, x: string): int

(* ****** ****** *)

fun{}
strbuf_insert_int (sb: !strbuf, x: int): int
fun{}
strbuf_insert_bool (sb: !strbuf, x: bool): int
fun{}
strbuf_insert_double (sb: !strbuf, x: double): int

(* ****** ****** *)

(* end of [strbuf.sats] *)
