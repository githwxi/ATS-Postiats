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
(* Start time: July, 2012 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)
//
// HX:
// no need for
// dynloading at run-time
//
#define
ATS_DYNLOADFLAG 0
//
// HX:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "atslib_ML_"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
extern
fun
memcpy
( d0: ptr
, s0: ptr
, n0: size_t
) :<!wrt> ptr = "mac#atspre_string_memcpy"
// end of [memcpy]
//
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
prelude_string_implode = string_implode
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
macdef
prelude_streamize_string_char = streamize_string_char
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
string_is_suffix
(
  str1, str2
) = let
//
val n1 = length(str1)
val n2 = length(str2)
//
in (* in-of-let *)
//
if
(n1 >= n2)
then let
  val p1 = string2ptr(str1)
in
//
$UN.cast{string}
  (ptr_add<char>(p1, n1-n2)) = str2
//
end // end of [then]
else false // end of [else]
//
end // end of [string_is_suffix]

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
implement
{}(*tmp*)
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
//
implement
{}(*tmp*)
string_make_prefix
  (x, ln) = let
  val st = i2sz(0)
in
  string_make_substring<>(x, st, ln)
end // end of [string_make_prefix]
//
implement
{}(*tmp*)
string_make_substring
  (x, st, ln) = let
//
val x = g1ofg0_string(x)
val st = g1ofg0_uint(st)
and ln = g1ofg0_uint(ln)
val lnx = prelude_string1_length(x)
//
val st = min(st, lnx)
//
val
substr =
$effmask_wrt
(
  prelude_string_make_substring(x, st, min(ln, lnx-st))
) (* end of [val] *)
//
in
  $UN.castvwtp0{string}(substr)
end // end of [string_make_substring]
//
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

implement
{}(*tmp*)
mul_int_string
(
  n, x0
) = let
//
val n = g1ofg0(n)
val x0 = g1ofg0(x0)
//
in
//
if
(n > 0)
then let
//
val
nx0 = length(x0)
val
(
  pf, pfgc | p0
) =
$effmask_wrt
(
malloc_gc(n*nx0)
)
//
val () =
loop(p0, n) where
{
//
val x0 =
  string2ptr(x0)
//
fun
loop
{n:nat} .<n>.
(
p0: ptr, n: int(n)
) :<> void =
(
if
(n > 0)
then let
  val _(*p0*) =
  $effmask_all(memcpy(p0, x0, nx0))
in
  loop(ptr_add<char>(p0, nx0), pred(n))
end // end of [then]
) (* end of [loop] *)
//
} (* end of [val] *)
//
in
  $UN.castvwtp0{string}((pf, pfgc | p0))
end // end of [then]
else "" // end of [else]
//
end (* end of [mul_int_string] *)

(* ****** ****** *)

implement
{}(*tmp*)
stringlst_concat
  (xs) = let
//
val res =
$effmask_wrt
(
  prelude_stringlst_concat(g1ofg0_list(xs))
) (* $effmask_wrt *)
in
  strptr2string (res)
end // end of [stringlst_concat]

(* ****** ****** *)
//
implement
{}(*tmp*)
string_implode
  (cs) = string_make_list<>(cs)
//
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
string_tabulate
  {n}(n0, fopr) = let
//
val n0 = g1ofg0_uint(n0)
//
implement
string_tabulate$fopr<>
  (i) = fopr($UN.cast{sizeLt(n)}(i))
//
in
  strnptr2string(prelude_string_tabulate(n0))
end // end of [string_tabulate]

(* ****** ****** *)

implement
{}(*tmp*)
string_exists
  (str, pred) = let
//
val
str = g1ofg0_string(str)
//
implement
string_forall$pred<> (c) = not(pred(c))
//
in
  not(prelude_string_forall(str))
end // end of [string_exists]

implement
{}(*tmp*)
string_iexists
  (str, pred) = let
//
val
str = g1ofg0_string(str)
//
implement
string_iforall$pred<>(i, c) = not(pred(i, c))
//
in
  not(prelude_string_iforall(str))
end // end of [string_iexists]

(* ****** ****** *)
//
implement{}
string_exists_method
  (cs) = lam(pred) => string_exists(cs, pred)
implement{}
string_iexists_method
  (cs) = lam(pred) => string_iexists(cs, pred)
//
(* ****** ****** *)

implement
{}(*tmp*)
string_forall
  (str, pred) = let
//
val
str = g1ofg0_string(str)
//
implement
string_forall$pred<>(c) = pred(c)
//
in
  prelude_string_forall(str)
end // end of [string_forall]

implement
{}(*tmp*)
string_iforall
  (str, pred) = let
//
val
str = g1ofg0_string(str)
//
implement
string_iforall$pred<>(i, c) = pred(i, c)
//
in
  prelude_string_iforall(str)
end // end of [string_iforall]

(* ****** ****** *)
//
implement{}
string_forall_method
  (cs) = lam(pred) => string_forall(cs, pred)
implement{}
string_iforall_method
  (cs) = lam(pred) => string_iforall(cs, pred)
//
(* ****** ****** *)

implement
{}(*tmp*)
string_foreach
  (cs, f) = let
//
fun
loop
(
p0: ptr
) : void = let
  val c = $UN.ptr0_get<char>(p0)
in
//
if isneqz(c)
  then (f(c); loop(ptr_succ<char>(p0))) else ()
//
end // end of [loop]
//
in
  loop(string2ptr(cs))
end // end of [string_foreach]

(* ****** ****** *)

implement
{}(*tmp*)
string_iforeach
  (cs, f) = let
//
fun
loop
(
  i: intGte(0), p0: ptr
) : void = let
  val c = $UN.ptr0_get<char>(p0)
in
//
if isneqz(c)
  then (f(i, c); loop(i+1, ptr_succ<char>(p0))) else ()
//
end // end of [loop]
//
in
  loop(0, string2ptr(cs))
end // end of [string_iforeach]

(* ****** ****** *)
//
implement{}
string_foreach_method
  (cs) = lam(f) => string_foreach(cs, f)
implement{}
string_iforeach_method
  (cs) = lam(f) => string_iforeach(cs, f)
//
(* ****** ****** *)

implement
{res}(*tmp*)
string_foldleft
  (cs, ini, fopr) = let
//
fun
loop
(
p0: ptr, res: res
) : res = let
  val c = $UN.ptr0_get<char>(p0)
in
//
if isneqz(c)
  then loop(ptr_succ<char>(p0), fopr(res, c)) else res
//
end // end of [loop]
//
in
  loop(string2ptr(cs), ini)
end // end of [string_foldleft]
//
implement
{res}(*tmp*)
string_foldleft_method
  (cs, _) =
  lam(ini,fopr) => string_foldleft<res>(cs, ini, fopr)
//
(* ****** ****** *)
//
implement{}
streamize_string_char
  (cs) = prelude_streamize_string_char(cs)
//
(* ****** ****** *)

(* end of [string.dats] *)
