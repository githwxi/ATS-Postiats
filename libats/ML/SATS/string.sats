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
(* Start time: July, 2012 *)
(* Authoremail: gmmhwxiATgmailDOTcom *)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.ML"
//
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "atslib_ML_"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)
//
fun{}
itoa(x: int):<> string
//
(* ****** ****** *)
//
fun{}
string_sing(c: charNZ):<> string
//
(* ****** ****** *)
//
fun{}
string_is_empty(NSH(string)):<> bool
fun{}
string_isnot_empty(NSH(string)):<> bool
//
overload iseqz with string_is_empty
overload isneqz with string_isnot_empty
//
(* ****** ****** *)
//
// HX-2016-11-08:
// str1 is a prefix of str2
//
fun{}
string_is_prefix
(
  str1: NSH(string), str2: NSH(string)
) :<> bool // string_is_prefix
//
(* ****** ****** *)
//
// HX-2016-11-12:
// str1 is a suffix of str2
//
fun{}
string_is_suffix
(
  str1: NSH(string), str2: NSH(string)
) :<> bool // string_is_suffix
//
(* ****** ****** *)
//
fun{}
string_copy(str: NSH(string)):<> string
//
(* ****** ****** *)
//
fun{}
string_make_list(cs: List(char)):<> string
fun{}
string_make_rlist(cs: List(char)):<> string
//
fun{}
string_make_list0(cs: list0(char)):<> string
fun{}
string_make_rlist0(cs: list0(char)):<> string
//
(* ****** ****** *)
//
fun{}
string_make_list_vt(List_vt(char)):<!wrt> string
fun{}
string_make_rlist_vt(List_vt(char)):<!wrt> string
//
(* ****** ****** *)

fun{}
string_make_prefix
(
  x0: NSH(string), len: size_t
) :<> string // end-of-function
fun{}
string_make_substring
(
  x0: NSH(string), start: size_t, len: size_t
) :<> string // end-of-function

(* ****** ****** *)
//
fun{}
string_append
(
  x1: NSH(string), x2: NSH(string)
) :<> string // end of [string_append]
//
overload + with string_append of 0
//
(* ****** ****** *)
//
fun{}
string_append3
(
  x1: NSH(string)
, x2: NSH(string), x3: NSH(string)
) :<> string // end of [string_append3]
//
(* ****** ****** *)
//
fun{}
string_append4
(
  x1: NSH(string), x2: NSH(string)
, x3: NSH(string), x4: NSH(string)
) :<> string // end of [string_append4]
fun{}
string_append5
(
  x1: NSH(string)
, x2: NSH(string), x3: NSH(string)
, x4: NSH(string), x5: NSH(string)
) :<> string // end of [string_append5]
fun{}
string_append6
(
  x1: NSH(string), x2: NSH(string)
, x3: NSH(string), x4: NSH(string)
, x5: NSH(string), x6: NSH(string)
) :<> string // end of [string_append6]
//
(* ****** ****** *)
//
fun{}
mul_int_string
(
  ntime: int, x0: NSH(string)
) :<> string // end-of-function
//
overload * with mul_int_string of 0
//
(* ****** ****** *)
//
fun{}
stringlst_concat
  (xs: list0(string)):<> string
//
(* ****** ****** *)

fun{}
string_explode(string):<> list0(char)
fun{}
string_implode(list0(char)):<> string

(* ****** ****** *)

fun{}
string_copywith
(
  cs: string
, fopr: (charNZ) -<cloref1> charNZ
) : string // end of [string_copywith]

(* ****** ****** *)
//
fun{}
string_tabulate
  {n:int}
(
  n0: size_t(n)
, fopr: (sizeLt(n)) -<cloref1> charNZ
) : string // end of [string_tabulate]
//
(* ****** ****** *)
//
fun{}
string_exists
(cs: string, pred: cfun(char, bool)): bool
fun{}
string_iexists
(cs: string, pred: cfun2(int, char, bool)): bool
//
fun{}
string_exists_method
(cs: string)(pred: cfun(char, bool)): bool
fun{}
string_iexists_method
(cs: string)(pred: cfun2(int, char, bool)): bool
//
overload .exists with string_exists_method
overload .iexists with string_iexists_method
//
(* ****** ****** *)
//
fun{}
string_forall
(cs: string, pred: cfun(char, bool)): bool
fun{}
string_iforall
(cs: string, pred: cfun2(int, char, bool)): bool
//
fun{}
string_forall_method
(cs: string)(pred: cfun(char, bool)): bool
fun{}
string_iforall_method
(cs: string)(pred: cfun2(int, char, bool)): bool
//
overload .forall with string_forall_method
overload .iforall with string_iforall_method
//
(* ****** ****** *)
//
fun{}
string_foreach
(cs: string, fwork: cfun(char, void)): void
fun{}
string_iforeach
(cs: string, fwork: cfun2(int, char, void)): void
//
fun{}
string_foreach_method
(cs: string)(fwork: cfun(char, void)): void
fun{}
string_iforeach_method
(cs: string)(fwork: cfun2(int, char, void)): void
//
overload .foreach with string_foreach_method
overload .iforeach with string_iforeach_method
//
(* ****** ****** *)
//
fun
{res:vt0p}
string_foldleft
(cs: string, ini: res, cfun(res, char, res)): res
fun
{res:vt0p}
string_foldleft_method
(string, TYPE(res))(res, cfun(res, char, res)): res
//
overload .foldleft with string_foldleft_method
//
(* ****** ****** *)
//
fun
{a:t0p}
string_list0_map
(cs: string, fopr: cfun(charNZ, a)): list0(a)
fun
{a:t0p}
string_list0_map_method
(string, TYPE(a))(fopr: cfun(charNZ, a)): list0(a)
//
overload .list0_map with string_list0_map_method
//
(* ****** ****** *)
//
fun{}
streamize_string_char(string): stream_vt(charNZ)
fun{}
un_streamize_string_char(stream_vt(charNZ)): string
//
(* ****** ****** *)

(* end of [string.sats] *)
