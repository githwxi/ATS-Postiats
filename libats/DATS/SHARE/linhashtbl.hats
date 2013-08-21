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
(* Start time: August, 2013 *)

(* ****** ****** *)
//
// HX: shared by linhashtbl_chain
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

extern
fun{}
string_hash_33 (str: string):<> ulint

(* ****** ****** *)

implement{}
string_hash_33 (str) = let
//
#define CNUL '\000'
//
fun loop
(
  p: ptr, res: ulint
) : ulint = let
  val c = $UN.ptr0_get<char> (p)
in
//
if c > CNUL then let
  val res = (res << 5) + res
in
  loop (ptr_succ<char> (p), res + $UN.cast{ulint}(c))
end else res // end of [if]
//
end // end of [loop]
//
in
  $effmask_all(loop (string2ptr(str), 314159265359UL))
end // end of [string_hash_33]

(* ****** ****** *)

implement
hash_key<string> = string_hash_33<>

(* ****** ****** *)

implement{key} equal_key_key = gequal_val<key>

(* ****** ****** *)

(* end of [linhashtbl.hats] *)
