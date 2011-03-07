(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

staload "pats_lexing.sats"

(* ****** ****** *)

staload "pats_lexbuf.sats"

(* ****** ****** *)

#define i2c char_of_int
#define c2i int_of_char

(* ****** ****** *)

fun WHITESPACE_test (c: char): bool = char_isspace (c)

(* ****** ****** *)

fun IDENTFST_test
  (c: char): bool = case+ 0 of
  | _ when ('a' <= c andalso c <= 'z') => true
  | _ when ('A' <= c andalso c <= 'Z') => true
  | _ when c = '_' => true
  | _ => false
// end of [IDENTFST_test]

fun IDENTRST_test
  (c: char): bool = case+ 0 of
  | _ when ('a' <= c andalso c <= 'z') => true
  | _ when ('A' <= c andalso c <= 'Z') => true
  | _ when ('0' <= c andalso c <= '9') => true
  | _ when c = '_' => true
  | _ when c = '\'' => true
  | _ => false
// end of [IDENTRST_test]

(* ****** ****** *)

implement
lexing_WHITESPACE0
  (buf) = n where {
  fun loop (
    buf: &lexbuf, n: int
  ) : int = let
    val i = lexbuf_get_next_char (buf)
  in
    if WHITESPACE_test ((i2c)i) then loop (buf, n+1) else n
  end // end of [loop]
  val n = loop (buf, 0)
  val n = uint_of_int (n)
} // end of [lexing_WHITESPACE0]

(* ****** ****** *)

implement
lexing_ANYWORD1
  (buf) = n where {
  fun loop (
    buf: &lexbuf, n: int
  ) : int = let
    val i = lexbuf_get_next_char (buf)  
  in
    if WHITESPACE_test ((i2c)i) then n else loop (buf, n+1)
  end // end of [loop]
  val n = loop (buf, 1)
  val n = uint_of_int (n)
} // end of [lexing_ANYWORD1]

(* ****** ****** *)

implement
lexing_IDENTIFIER1_alp
  (buf) = n where {
  fun loop (
    buf: &lexbuf, n: int
  ) : int = let
    val i = lexbuf_get_next_char (buf)
  in
    if IDENTRST_test ((i2c)i) then loop (buf, n+1) else n
  end // end of [loop]
  val n = loop (buf, 1)
  val n = uint_of_int (n)
} // end of [lexing_IDENTIFER_alp]

(* ****** ****** *)

implement
lexing_get_next_token
  (buf) = let
//
  val n = lexing_WHITESPACE0 (buf)
  val () = lexbuf_advance_reset (buf, n)
  val i0 = lexbuf_get_next_char (buf)
//
in
//
if i0 >= 0 then let
  val c = (i2c)i0
in
  case+ 0 of
  | _ when IDENTFST_test (c) => let
      val n = lexing_IDENTIFIER1_alp (buf)
//
      val str = lexbuf_strptrout_reset (buf, n)
      val () = println! ("IDENTIFIER_alp = ", str)
      val () = strptr_free (str)
//
    in
      lexing_get_next_token (buf)
    end // end of [when ...]
  | _ => let
      val n = lexing_ANYWORD1 (buf)
      val str = lexbuf_strptrout_reset (buf, n)
      val () = println! ("ANYWORD = ", str)
      val () = strptr_free (str)
    in
      lexing_get_next_token (buf)
    end // end of [when ...]
end else
  TOKEN_eof ()
// end of [if]
//
end // end of [lexing_get_next_token]

(* ****** ****** *)

(* end of [pats_lexing.dats] *)
