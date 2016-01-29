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
//
fun
DIGIT_test
(
  i: int
) : bool =
(
if isdigit(i)
  then true else false
)
//
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

local
//
#define
SYMBOLIC "%&+-./:=@~`^|*!$#?<>"
//
in (* in-of-local *)
//
fun
SYMBOLIC_test
  (c: int): bool =
  strchr (SYMBOLIC, int2char0(c)) >= 0
//
end // end of [local]

(* ****** ****** *)
//
fun SIGN_test
  (c: int): bool = let
//
val c = int2char0(c) in (c = '+' || c = '-')
//
end // end of [SIGN_test]
//
(* ****** ****** *)
//
extern
fun
ftesting_one
(
  buf: &lexbuf >> _, f: int -> bool
) : intGte(0) // end of [ftesting_one]
//
implement
ftesting_one
  (buf, f) = let
//
val i = lexbuf_get_char(buf)
//
in
//
if (
i > 0
) then (
  if f(i) then 1 else (lexbuf_incby_nback(buf, 1); 0)
) else (0)
//
end // end of [ftesting_one]
//
(* ****** ****** *)
//
extern
fun
ftesting_opt
(
  buf: &lexbuf >> _, f: int -> bool
) : intGte(0) // end of [ftesting_opt]
//
implement
ftesting_opt
  (buf, f) = let
//
val i = lexbuf_get_char (buf)
//
in
//
if (
i > 0
) then (
  if f(i) then 1 else (lexbuf_incby_nback(buf, 1); 0)
) else (0)
//
end // end of [ftesting_opt]
//
(* ****** ****** *)
//
extern
fun
ftesting_seq0
(
  buf: &lexbuf >> _, f: int -> bool
) : intGte(0) // end-of-fun
//
implement
ftesting_seq0
  (buf, f) = let
//
fun loop
(
  buf: &lexbuf >> _, nchr: intGte(0)
) : intGte(0) = let
//
val i = lexbuf_get_char(buf)
//
in
//
if (
i > 0
) then (
//
if f(i)
  then
    loop (buf, succ(nchr))
  // end of [then]
  else let
    val () = lexbuf_incby_nback (buf, 1) in nchr
  end // end of [else]
//
) else (nchr)
//
end // end of [loop]
//
in
  loop (buf, 0)
end // end of [ftesting_seq0]
//
(* ****** ****** *)
//
fun
testing_digitseq0
(
  buf: &lexbuf >> _
) : intGte(0) =
  ftesting_seq0 (buf, DIGIT_test)
//
(* ****** ****** *)
//
fun
testing_identrstseq0
(
  buf: &lexbuf >> _
) : intGte(0) =
  ftesting_seq0 (buf, IDENTRST_test)
//
(* ****** ****** *)
//
implement
lexing_IDENT_alp
  (buf) = let
//
val nchr =
  testing_identrstseq0 (buf)
val nchr1 = succ(nchr)
val name = lexbuf_takeout (buf, nchr1)
val name = strptr2string (name)
//
val loc = lexbuf_getincby_location (buf, nchr1)
//
in
  token_make (loc, TOKide(name))
end // end of [lexing_IDENT_alp]

(* ****** ****** *)

(* end of [atexting_lexing.dats] *)
