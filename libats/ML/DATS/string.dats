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
macdef
prelude_string0_append3 = string0_append3
macdef
prelude_string0_append4 = string0_append4
macdef
prelude_string0_append5 = string0_append5
macdef
prelude_string0_append6 = string0_append6
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
prelude_string_forall = string_forall
macdef
prelude_string_iforall = string_iforall
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

implement
{}(*tmp*)
itoa(int) =
$effmask_wrt
  (strptr2string(g0int2string_int(int)))
// end of [iota]

(* ****** ****** *)
//
implement
{}(*tmp*)
string_sing(c) =
strnptr2string
  ($effmask_wrt(prelude_string_sing (c)))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
string_is_empty
  (str) =
(
  prelude_string_is_empty(g1ofg0(str))
)
implement
{}(*tmp*)
string_isnot_empty
  (str) =
(
  prelude_string_isnot_empty(g1ofg0(str))
)
//
(* ****** ****** *)

implement
{}(*tmp*)
string_is_prefix
(
  str1, str2
) = let
//
#define NUL '\000'
//
fun
loop
(
  p1: ptr, p2: ptr
) : bool = let
//
val c1 =
  $UN.ptr0_get<char>(p1)
//
in
//
if
(c1 != NUL)
then let
  val c2 = $UN.ptr0_get<char>(p2)
in
//
if
c1 = c2
  then loop(ptr_succ<char>(p1), ptr_succ<char>(p2))
  else false
//
end // end of [then]
else (true) // end of [else]
//
end // end of [loop]
//
in
  $effmask_all(loop(string2ptr(str1), string2ptr(str2)))
end // end of [string_is_prefix]

(* ****** ****** *)

implement
{}(*tmp*)
string_copy
  (str) = (
//
strptr2string
  ($effmask_wrt(prelude_string0_copy(str)))
//
) // end of [string_copy]

(* ****** ****** *)
//
implement{}
string_make_list
  (cs) = let
//
val cs =
$UN.cast{list0(charNZ)}(cs)
//
val str =
$effmask_wrt
  (prelude_string_make_list (g1ofg0_list(cs)))
//
in
  strnptr2string (str)
end // end of [string_make_list]
//
implement
{}(*tmp*)
string_make_rlist
  (cs) = let
//
val cs =
$UN.cast{list0(charNZ)}(cs)
//
val str =
$effmask_wrt
  (prelude_string_make_rlist(g1ofg0_list(cs)))
//
in
  strnptr2string(str)
end // end of [string_make_rlist]
//
(* ****** ****** *)

implement{
} string_make_substring
  (x, st, ln) = let
//
val x = g1ofg0_string(x)
val st = g1ofg0_uint(st)
and ln = g1ofg0_uint(ln)
val lnx = prelude_string1_length (x)
//
val st = min (st, lnx)
//
val
substr =
$effmask_wrt
(
  prelude_string_make_substring (x, st, min (ln, lnx-st))
) (* end of [val] *)
//
in
  $UN.castvwtp0{string}(substr)
end // end of [string_make_substring]

(* ****** ****** *)

implement
{}(*tmp*)
string_append
  (str1, str2) = let
//
val res =
$effmask_wrt
  (prelude_string0_append(str1, str2))
//
in
  strptr2string(res)
end // end of [string_append]

(* ****** ****** *)

implement
{}(*tmp*)
string_append3
(
  str1, str2, str3
) = let
//
val res =
$effmask_wrt
  (prelude_string0_append3(str1, str2, str3))
//
in
  strptr2string(res)
end // end of [string_append3]

(* ****** ****** *)

implement
{}(*tmp*)
string_append4
(
  str1, str2
, str3, str4
) = let
//
val res =
$effmask_wrt
  (prelude_string0_append4(str1, str2, str3, str4))
//
in
  strptr2string(res)
end // end of [string_append4]

(* ****** ****** *)

implement
{}(*tmp*)
string_append5
(
  str1, str2
, str3, str4, str5) = let
//
val res =
$effmask_wrt
(
  prelude_string0_append5(str1, str2, str3, str4, str5)
) (* end of [val] *)
//
in
  strptr2string(res)
end // end of [string_append5]

(* ****** ****** *)

implement
{}(*tmp*)
string_append6
(
  str1, str2, str3
, str4, str5, str6
) = let
//
val res =
$effmask_wrt
(
  prelude_string0_append6(str1, str2, str3, str4, str5, str6)
) (* end of [val] *)
//
in
  strptr2string(res)
end // end of [string_append6]

(* ****** ****** *)

implement{
} stringlst_concat (xs) = let
  val res = $effmask_wrt (prelude_stringlst_concat (g1ofg0_list(xs)))
in
  strptr2string (res)
end // end of [stringlst_concat]

(* ****** ****** *)

implement
{}(*tmp*)
string_explode
  (str) = let
//
val
str =
g1ofg0_string(str)
//
val
res =
$effmask_wrt
  (prelude_string_explode(str))
//
in
  list0_of_list_vt(res)
end // end of [string_explode]

(* ****** ****** *)

implement
{}(*tmp*)
string_implode(cs) = string_make_list(cs)

(* ****** ****** *)

implement
string_tabulate
  (n, f) = let
//
val n = g1ofg0_uint(n)
//
implement
string_tabulate$fopr<> (i) = f(i)
//
in
  strnptr2string(prelude_string_tabulate(n))
end // end of [string_tabulate]

(* ****** ****** *)

implement
string_forall
  (str, f) = let
//
val str = g1ofg0_string(str)
//
implement
string_forall$pred<> (c) = f(c)
//
in
  prelude_string_forall (str)
end // end of [string_forall]

implement
string_iforall
  (str, f) = let
//
val str = g1ofg0_string(str)
//
implement
string_iforall$pred<> (i, c) = f(i, c)
//
in
  prelude_string_iforall (str)
end // end of [string_iforall]

(* ****** ****** *)

implement
string_foreach
  (str, f) = let
//
val str = g1ofg0_string(str)
//
implement(env)
string_foreach$cont<env> (c, env) = true
implement(env)
string_foreach$fwork<env> (c, env) = f(c)
//
val _(*nchar*) = prelude_string_foreach (str)
//
in
  // nothing
end // end of [string_foreach]

(* ****** ****** *)
//
implement{}
string_forall_method(x) = lam(f) => string_forall (x, f)
implement{}
string_iforall_method(x) = lam(f) => string_iforall (x, f)
implement{}
string_foreach_method(x) = lam(f) => string_foreach (x, f)
//
(* ****** ****** *)

(* end of [string.dats] *)
