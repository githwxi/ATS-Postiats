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

%{#
#include "libats/CATS/hashfun.cats"
%} // end of [%{#]

(* ****** ****** *)

fun{}
inthash_jenkins (uint32):<> uint32

(* ****** ****** *)
/*
** HX:
** res(0) = H0
** res(i+1) = K*res(i) + str[i]
*/
fun{}
string_hash_multiplier
  (K: ulint, H0: ulint, str: string):<> ulint
// end of [string_hash_multiplier]

(* ****** ****** *)

(* end of [hashfun.sats] *)
