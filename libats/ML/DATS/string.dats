(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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
prelude_string0_copy = string0_copy
//
macdef
prelude_string0_append = string0_append
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

macdef castvwtp_trans = $UN.castvwtp0 // former name

(* ****** ****** *)

implement
string_copy (str) = let
  val res = $effmask_wrt (prelude_string0_copy (str))
in
  strptr2string (res)
end // end of [string_copy]

(* ****** ****** *)
//
implement
string_make_list (cs) = let
  val cs = $UN.cast{list0(charNZ)}(cs)
  val str = prelude_string_make_list (g1ofg0_list (cs))
in
  strnptr2string (str)
end // end of [string_make_list]
//
implement
string_make_rlist (cs) = let
  val cs = $UN.cast{list0(charNZ)}(cs)
  val str = prelude_string_make_rlist (g1ofg0_list (cs))
in
  strnptr2string (str)
end // end of [string_make_rlist]
//
(* ****** ****** *)

implement
string_make_substring
  (str, st, ln) = let
//
val str = g1ofg0_string(str)
val st = g1ofg0_uint(st) and ln = g1ofg0_uint(ln)
val lnx = string_length (str)
//
val st = min (st, lnx)
//
in
  $UN.castvwtp0{string}(prelude_string_make_substring (str, st, min (ln, lnx-st)))
end // end of [string_make_substring]

(* ****** ****** *)

implement
string_append (s1, s2) = let
  val res = $effmask_wrt (prelude_string0_append (s1, s2))
in
  strptr2string (res)
end // end of [string_append]

(* ****** ****** *)

(*
implement
stringlst_concat (xs) = let
  val xs = list_of_list0 (xs)
  val res = $effmask_wrt (prelude_stringlst_concat (xs))
in
  strptr2string (res)
end // end of [stringlst_concat]
*)

(* ****** ****** *)

(*
implement
string_explode (str) = let
  val str = g1ofg0_string (str)
  val res = $effmask_wrt (prelude_string_explode (str))
in
  list0_of_list_vt (res)
end // end of [string_explode]
*)

(* ****** ****** *)

(*
/*
//
#define NUL '\000'
//
implement
string_implode (cs) = let
//
val [n:int]
  cs = list_of_list0 (cs)
//
val n = list_length<char> (cs)
val n1 = g1i2u (n + 1)
val (pf, pfgc | p) = $effmask_wrt (malloc_gc (n1))
//
fun loop
  {n:nat} .<n>.
(
  p: ptr, cs: list (char, n)
) :<!wrt> void = let
in
//
case+ cs of
| list_cons
    (c, cs) => let
    val () = $UN.ptr0_set<char> (p, c)
  in
    loop (ptr0_succ<char> (p), cs)
  end // end of [list_cons]
| list_nil () => $UN.ptr0_set<char> (p, NUL)
//
end // end of [loop]
//
val () = $effmask_wrt (loop (p, cs))
//
in
  castvwtp_trans {string} @(pf, pfgc | p)
end // end of [string_implode]
*/
*)

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
