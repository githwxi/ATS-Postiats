(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: July, 2012 *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
macdef
prelude_string_sing = string_sing
//
macdef
prelude_string_is_empty = string_is_empty
macdef
prelude_string_isnot_empty = string_isnot_empty
//
macdef
prelude_string0_copy = string0_copy
//
macdef
prelude_string_make_list = string_make_list
macdef
prelude_string_make_rlist = string_make_rlist
//
macdef
prelude_string_make_substring = string_make_substring
//
macdef
prelude_string0_length = string0_length
macdef
prelude_string1_length = string1_length
//
macdef
prelude_string0_append = string0_append
//
macdef
prelude_stringlst_concat = stringlst_concat
//
macdef
prelude_string_explode = string_explode
//
macdef
prelude_string_tabulate = string_tabulate
//
macdef
prelude_string_foreach = string_foreach
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/string.sats"

(* ****** ****** *)

macdef
castvwtp_trans = $UN.castvwtp0 // former name

(* ****** ****** *)

implement{
} itoa (int) =
  $effmask_wrt(strptr2string(g0int2string_int(int)))
// end of [iota]

(* ****** ****** *)
//
implement{
} string_sing (c) =
  strnptr2string ($effmask_wrt(prelude_string_sing (c)))
//
(* ****** ****** *)
//
implement{
} string_is_empty (str) =
  prelude_string_is_empty (g1ofg0(str))
implement{
} string_isnot_empty (str) =
  prelude_string_isnot_empty (g1ofg0(str))
//
(* ****** ****** *)

implement{
} string_copy (str) =
  strptr2string ($effmask_wrt(prelude_string0_copy (str)))
// end of [string_copy]

(* ****** ****** *)
//
implement{
} string_make_list (cs) = let
  val cs = $UN.cast{list0(charNZ)}(cs)
  val str = $effmask_wrt(prelude_string_make_list (g1ofg0_list(cs)))
in
  strnptr2string (str)
end // end of [string_make_list]
//
implement{
} string_make_rlist (cs) = let
  val cs = $UN.cast{list0(charNZ)}(cs)
  val str = $effmask_wrt(prelude_string_make_rlist (g1ofg0_list(cs)))
in
  strnptr2string (str)
end // end of [string_make_rlist]
//
(* ****** ****** *)

implement{
} string_make_substring
  (x, st, ln) = let
//
val x = g1ofg0_string(x)
val st = g1ofg0_uint(st) and ln = g1ofg0_uint(ln)
val lnx = prelude_string1_length (x)
//
val st = min (st, lnx)
//
val substr =
$effmask_wrt(prelude_string_make_substring (x, st, min (ln, lnx-st)))
//
in
  $UN.castvwtp0{string}(substr)
end // end of [string_make_substring]

(* ****** ****** *)

implement{
} string_append
  (str1, str2) = let
  val res = $effmask_wrt (prelude_string0_append (str1, str2))
in
  strptr2string (res)
end // end of [string_append]

(* ****** ****** *)

implement{
} stringlst_concat (xs) = let
  val res = $effmask_wrt (prelude_stringlst_concat (g1ofg0_list(xs)))
in
  strptr2string (res)
end // end of [stringlst_concat]

(* ****** ****** *)

implement{
} string_explode (str) = let
  val str = g1ofg0_string (str)
  val res = $effmask_wrt (prelude_string_explode (str))
in
  list0_of_list_vt (res)
end // end of [string_explode]

(* ****** ****** *)

implement{
} string_implode (cs) = string_make_list (cs)

(* ****** ****** *)

implement
string_tabulate
  (n, f) = let
//
val n = g1ofg0_uint(n)
//
implement
string_tabulate$fopr<> (i) = f (i)
//
in
  strnptr2string(prelude_string_tabulate (n))
end // end of [string_tabulate]

(* ****** ****** *)

implement
string_foreach (str, f) = let
//
val str = g1ofg0_string(str)
//
implement{env}
string_foreach$cont (c, env) = true
implement{env}
string_foreach$fwork (c, env) = f (c)
val _(*n*) = prelude_string_foreach (str)
//
in
  // nothing
end // end of [string_foreach]

(* ****** ****** *)

(* end of [string.dats] *)
