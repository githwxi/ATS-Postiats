(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: January, 2016 *)

(* ****** ****** *)
//
//
#include
"share\
/atspre_define.hats"
#include
"share\
/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./atexting.sats"

(* ****** ****** *)

macdef ENDL = char2int0('\n')

(* ****** ****** *)

fun
BLANK_test
(
  i: int
) : bool = let
//
val c = int2char0 (i)
//
in
  case+ 0 of
  | _ when c = ' ' => true
  | _ when c = '\t' => true
  | _ (*rest-of-chars*) => false
end // end of [BLANK_test]

(* ****** ****** *)

fun
IDENTFST_test
(
  i: int
) : bool = let
//
val c = int2char0(i)
//
in
//
if
isalpha(c)
then true
else (
  if c = '_' then true else false
) (* end of [else] *)
// end of [if]
//
end (* end of [IDENTFST_test] *)

(* ****** ****** *)

fun
IDENTRST_test
(
  i: int
) : bool = let
//
val c = int2char0(i)
//
in
//
case+ 0 of
| _ when
    isalnum(c) => true
  // end of [isalnum]
//
| _ when c = '_' => true
//
| _ (*rest-of-char*) => false
//
end (* end of [IDENTRST_test] *)

(* ****** ****** *)

(* end of [atexting_lexing.dats] *)
