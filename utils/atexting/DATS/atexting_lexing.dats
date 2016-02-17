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
//
staload
"./../SATS/atexting.sats"
//
(* ****** ****** *)

macdef EOL = char2int0('\n')

(* ****** ****** *)
//
fun
EOF_test(i: int) =
  if i >= 0 then false else true
fun
EOL_test(i: int) =
  if i = EOL then true else false
//
(* ****** ****** *)

fun
SPACE_test
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
end // end of [SPACE_test]

(* ****** ****** *)

fun
SHARP_test
(
  i: int
) : bool =
(
//
if int2char0(i) = '#' then true else false
//
) (* SHARP_test *)

(* ****** ****** *)
//
fun
BSLASH_test
(
  i: int
) : bool =
(
//
if int2char0(i) = '\\' then true else false
//
) (* BSLASH_test *)
//
(* ****** ****** *)
//
fun
SQUOTE_test
(
  i: int
) : bool =
(
if int2char0(i) = '\'' then true else false
)
//
fun
DQUOTE_test
(
  i: int
) : bool =
(
  if int2char0(i) = '"' then true else false
)
//
(* ****** ****** *)
//
fun
PERCENT_test
(
  i: int
) : bool =
(
  if int2char0(i) = '%' then true else false
)
//
(* ****** ****** *)
//
fun
DIGIT_test
(
  i: int
) : bool = if isdigit(i) then true else false
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
(*
//
fun SIGN_test
  (c: int): bool = let
//
val c = int2char0(c) in (c = '+' || c = '-')
//
end // end of [SIGN_test]
//
*)
(* ****** ****** *)
(*
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
*)
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
testing_spaceseq0
  (buf: &lexbuf): intGte(0) =
  ftesting_seq0 (buf, SPACE_test)
//
(* ****** ****** *)
//
fun
testing_sharpseq0
  (buf: &lexbuf): intGte(0) =
  ftesting_seq0 (buf, SHARP_test)
//
(* ****** ****** *)
//
fun
testing_dquoteseq0
  (buf: &lexbuf): intGte(0) =
  ftesting_seq0 (buf, DQUOTE_test)
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
extern
fun
lexing_SPACE
  (buf: &lexbuf >> _): token
//
implement
lexing_SPACE
  (buf) = let
//
val nchr =
  testing_spaceseq0(buf)
//
val nchr1 = nchr + 1
//
val () = lexbuf_set_nspace(buf, nchr1)
//
val space =
  lexbuf_takeout(buf, nchr1)
val space = strptr2string(space)
//
val loc = lexbuf_getincby_location(buf, nchr1)
//
in
  token_make(loc, TOKspace(space))
end // end of [lexing_SPACE]
//
(* ****** ****** *)
//
extern
fun
lexing_SHARP
  (buf: &lexbuf >> _): token
//
implement
lexing_SHARP
  (buf) = let
//
val nchr =
  testing_sharpseq0(buf)
//
val nchr1 = nchr + 1
//
val sharp =
  lexbuf_takeout(buf, nchr1)
val sharp = strptr2string(sharp)
//
val loc = lexbuf_getincby_location(buf, nchr1)
//
in
  token_make(loc, TOKsharp(sharp))
end // end of [lexing_SHARP]
//
(* ****** ****** *)
//
extern
fun
lexing_BSLASH
  (buf: &lexbuf >> _): token
//
implement
lexing_BSLASH
  (buf) = let
//
val i = lexbuf_get_char(buf)
//
val _ = lexbuf_remove(buf, 2)
//
var pos: position
val () =
lexbuf_get_position(buf, pos)
//
val () = position_incby_1(pos)
val () =
(
  if EOL_test(i)
    then position_byrow(pos)
    else position_incby_1(pos)
) (* end of [if] *)
//
val loc =
lexbufpos_get_location (buf, pos)
//
val () = lexbuf_set_position(buf, pos)
//
in
  token_make(loc, TOKbslash(i))
end // end of [lexing_BSLASH]
//
(* ****** ****** *)
//
extern
fun
lexing_SQUOTE
  (buf: &lexbuf >> _): token
//
implement
lexing_SQUOTE
  (buf) = let
//
val _ = lexbuf_remove(buf, 1)
val loc = lexbuf_getincby_location(buf, 1)
//
in
  token_make(loc, TOKsquote())
end // end of [lexing_SQUOTE]
//
(* ****** ****** *)
//
extern
fun
lexing_DQUOTE
  (buf: &lexbuf >> _): token
//
implement
lexing_DQUOTE
  (buf) = let
//
val nchr =
  testing_dquoteseq0(buf)
//
val nchr1 = nchr + 1
//
val dquote =
  lexbuf_takeout(buf, nchr1)
val dquote = strptr2string(dquote)
//
val loc = lexbuf_getincby_location(buf, nchr1)
//
in
  token_make(loc, TOKdquote(dquote))
end // end of [lexing_DQUOTE]
//
(* ****** ****** *)
//
extern
fun
lexing_PERCENT
  (buf: &lexbuf >> _): token
//
implement
lexing_PERCENT
  (buf) = let
//
val i =
lexbuf_get_char(buf)
//
val c = int2char0(i)
//
in
//
case+ c of
//
| '}' => let
    val cend =
      lexbuf_takeout(buf, 2)
    val cend = strptr2string(cend)
    val loc0 =
      lexbuf_getincby_location(buf, 2)
    // end of [val]
  in
    token_make(loc0, TOKcode_end(cend))
  end // end of [%{]
//
| '\{' => let
    val cbeg =
      lexbuf_takeout(buf, 2)
    val cbeg = strptr2string(cbeg)
    val loc0 =
      lexbuf_getincby_location(buf, 2)
    // end of [val]
  in
    token_make(loc0, TOKcode_beg(cbeg))
  end // end of [%{]
//
| _(*rest*) => let
    val () = lexbuf_remove(buf, 1)
    val loc0 =
      lexbuf_getincby_location(buf, 1)
    // end of [val]
  in
    token_make(loc0, TOKspchr(char2int0('%')))
  end // end of [make]
//
end // end of [lexing_PERCENT]
//
(* ****** ****** *)
//
implement
lexing_INTEGER
  (buf) = let
//
val nchr =
  testing_digitseq0(buf)
//
val nchr1 = succ(nchr)
//
val int =
  lexbuf_takeout(buf, nchr1)
val int = strptr2string(int)
//
val loc = lexbuf_getincby_location(buf, nchr1)
//
in
  token_make(loc, TOKint(int))
end // end of [lexing_INTEGER]
//
(* ****** ****** *)
//
implement
lexing_IDENT_alp
  (buf) = let
//
val nchr =
  testing_identrstseq0(buf)
//
val nchr1 = succ(nchr)
//
val ide =
  lexbuf_takeout(buf, nchr1)
//
val ide = strptr2string(ide)
//
val loc = lexbuf_getincby_location(buf, nchr1)
//
in
  token_make(loc, TOKide(ide))
end // end of [lexing_IDENT_alp]
//
(* ****** ****** *)

local
//
fun
get_token
(
  buf: &lexbuf >> _
) : token = let
//
val i0 = lexbuf_get_char(buf)
//
in
//
case+ 0 of
//
| _ when
    SPACE_test(i0) => lexing_SPACE(buf)
//
| _ when
    BSLASH_test(i0) => lexing_BSLASH(buf)
//
| _ when
    SHARP_test(i0) => lexing_SHARP(buf)
//
| _ when
    SQUOTE_test(i0) => lexing_SQUOTE(buf)
| _ when
    DQUOTE_test(i0) => lexing_DQUOTE(buf)
//
| _ when
    PERCENT_test(i0) => lexing_PERCENT(buf)
//
| _ when
    DIGIT_test(i0) => lexing_INTEGER(buf)
//
| _ when
    IDENTFST_test(i0) => lexing_IDENT_alp(buf)
//
| _ when
    EOL_test(i0) => let
    val _ = lexbuf_remove(buf, 1)
    val loc = lexbuf_getbyrow_location(buf) in token_make(loc, TOKeol())
  end // end of [EOF]
| _ when
    EOF_test(i0) => let
    val _ = lexbuf_remove(buf, 1)
    val loc = lexbuf_getincby_location(buf, 1) in token_make(loc, TOKeof())
  end // end of [EOF]
//
| _ (*rest*) => let
    val _ = lexbuf_remove(buf, 1)
    val loc = lexbuf_getincby_location(buf, 1) in token_make(loc, TOKspchr(i0))
  end // end of [rest]
//
end // end of [get_token_any]

in (* in-of-local *)

implement
lexbuf_get_token
  (buf) = let
//
val tok = get_token (buf)
//
in
//
case+
tok.token_node of
//
| TOKspace _ => tok
| _ (*non-SPACE*) => let
    val () = lexbuf_set_nspace (buf, 0) in tok
  end // end of [non-SPACE]
//
end // end of [lexbuf_get_token_any]

end // end of [local]

(* ****** ****** *)

(* end of [atexting_lexing.dats] *)
