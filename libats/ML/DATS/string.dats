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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

macdef
prelude_string_explode = string_explode

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/string.sats"

(* ****** ****** *)

implement
string_append (s1, s2) = let
  val res = string_append_ref (s1, s2) in $UN.cast{string}(res)
end // end of [string_append]

(* ****** ****** *)

implement
stringlst_concat (xs) = let
  val res = stringlst_concat_ref (xs) in $UN.cast{string}(res)
end // end of [stringlst_concat]

(* ****** ****** *)

(*
implement
string_explode (str) = let
  val str = string1_of_string0 (str)
  val cs = prelude_string_explode (str) in list0_of_list_vt (cs)
end // end of [string_explode]
*)

implement
string_implode
  (cs) = let
//
#define NUL '\000'
//
val [n:int] cs = list_of_list0 (cs)
val n = list_length (cs)
val n1 = g1int2uint (n + 1)
val (pf, pfgc | p) = malloc_gc (n1)
//
fun loop
  {n:nat} .<n>. (
  p: ptr, cs: list (char, n)
) :<!wrt> void = let
in
//
case+ cs of
| list_cons (c, cs) => let
    val () =
      $UN.ptr0_set<char> (p, c)
    // end of [val]
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
  $UN.castvwtp_trans{string} @(pf, pfgc | p)
end // end of [string_implode]

(* ****** ****** *)

(* end of [string.dats] *)
