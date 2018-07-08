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
//
// HX-2013-09:
// A collection of hash functions
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/hashfun.sats"

(* ****** ****** *)

(*
fun{}
inthash_jenkins (uint32): uint32
*)
(*
** HX-2013-08:
** This one by Robert Jenkins
** is a full-avalanche hash function
*)
/*
uint32_t
atslib_inthash_jenkins
  (uint32_t a)
{
  a = (a+0x7ed55d16) + (a<<12);
  a = (a^0xc761c23c) ^ (a>>19);
  a = (a+0x165667b1) + (a<< 5);
  a = (a+0xd3a2646c) ^ (a<< 9);
  a = (a+0xfd7046c5) + (a<< 3);
  a = (a^0xb55a4f09) ^ (a>>16);
  return a;
}
*/
implement
{}(*tmp*)
inthash_jenkins (a) =
  $extfcall (uint32, "atslib_inthash_jenkins", a)
//
(* ****** ****** *)

(*
fun{}
string_hash_multiplier
(
  K: ulint, H0: ulint, str: string
) :<> ulint // endfun
*)
implement
{}(*tmp*)
string_hash_multiplier
  (K, H0, str) = let
//
fun loop
(
  p: ptr, res: ulint
) : ulint = let
  val c = $UN.ptr0_get<char> (p)
in
//
if isneqz(c)
  then loop (ptr_succ<char> (p), K*res + $UN.cast{ulint}(c))
  else (res)
//
end // end of [loop]
//
in
  $effmask_all(loop (string2ptr(str), H0))
end // end of [string_hash_multiplier]

(* ****** ****** *)

(* end of [hashfun.dats] *)
