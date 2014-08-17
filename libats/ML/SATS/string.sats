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
(* Start time: July, 2012 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)

fun{
} itoa (x: int):<> string

(* ****** ****** *)

fun{
} string_copy (x: NSH(string)):<> string

(* ****** ****** *)

fun{
} string_make_list (cs: list0 (char)):<> string
fun{
} string_make_rlist (cs: list0 (char)):<> string

(* ****** ****** *)

fun{
} string_make_substring
  (x: NSH(string), st: size_t, ln: size_t):<> string
// end of [string_make_substring]

(* ****** ****** *)

fun{
} string_append
  (x1: NSH(string), x2: NSH(string)):<> string
overload + with string_append of 0

(* ****** ****** *)

fun{
} stringlst_concat (xs: list0 (string)):<> string

(* ****** ****** *)

fun{
} string_explode (x: string):<> list0 (char)
fun{
} string_implode (cs: list0 (char)):<> string

(* ****** ****** *)

fun string_tabulate
  (n: size_t, f: (size_t) -<cloref1> charNZ): string

(* ****** ****** *)

fun string_foreach (x: string, f: cfun (char, void)): void

(* ****** ****** *)

(* end of [string.sats] *)
