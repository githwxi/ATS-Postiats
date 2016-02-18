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

fun{}
itoa (x: int):<> string

(* ****** ****** *)

fun{}
string_sing (c: charNZ):<> string

(* ****** ****** *)

fun{}
string_is_empty (NSH(string)):<> bool
fun{}
string_isnot_empty (NSH(string)):<> bool
  
(* ****** ****** *)

overload iseqz with string_is_empty
overload isneqz with string_isnot_empty

(* ****** ****** *)
//
fun{}
string_is_prefix
(
  str1: string, str2: string
) :<> bool // string_is_prefix
//
(* ****** ****** *)

fun{}
string_copy(x: NSH(string)):<> string

(* ****** ****** *)

fun{}
string_make_list(cs: list0(char)):<> string
fun{}
string_make_rlist(cs: list0(char)):<> string

(* ****** ****** *)

fun{}
string_make_substring
(
  x0: NSH(string), start: size_t, len: size_t
) :<> string // end-of-function

(* ****** ****** *)

fun{}
string_append
  (x1: NSH(string), x2: NSH(string)):<> string
overload + with string_append of 0

(* ****** ****** *)
//
fun{}
string_append3
(
  x1: NSH(string), x2: NSH(string), x3: NSH(string)
) :<> string // end of [string_append3]
fun{}
string_append4
(
  x1: NSH(string), x2: NSH(string), x3: NSH(string), x4: NSH(string)
) :<> string // end of [string_append4]
fun{}
string_append5
(
  x1: NSH(string), x2: NSH(string)
, x3: NSH(string), x4: NSH(string), x5: NSH(string)
) :<> string // end of [string_append5]
fun{}
string_append6
(
  x1: NSH(string), x2: NSH(string), x3: NSH(string)
, x4: NSH(string), x5: NSH(string), x6: NSH(string)
) :<> string // end of [string_append6]
//
(* ****** ****** *)
//
fun{}
stringlst_concat(xs: list0 (string)):<> string
//
(* ****** ****** *)

fun{}
string_explode (x: string):<> list0 (char)
fun{}
string_implode (cs: list0 (char)):<> string

(* ****** ****** *)
//
fun string_tabulate
  (n: size_t, f: (size_t) -<cloref1> charNZ): string
//
(* ****** ****** *)
//
fun
string_forall (x: string, f: cfun (char, bool)): bool
fun
string_iforall (x: string, f: cfun2 (int, char, bool)): bool
//
fun
string_foreach (x: string, f: cfun (char, void)): void
//
fun{}
string_forall_method(string)(cfun (char, bool)): bool
fun{}
string_iforall_method(string)(cfun2 (int, char, bool)): bool
//
fun{}
string_foreach_method(x: string)(f: cfun (char, void)): void
//
overload .forall with string_forall_method
overload .iforall with string_iforall_method
overload .foreach with string_foreach_method
//
(* ****** ****** *)

(* end of [string.sats] *)
