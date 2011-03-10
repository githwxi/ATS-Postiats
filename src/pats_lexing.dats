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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "pats_lexbuf.sats"
staload "pats_lexing.sats"

(* ****** ****** *)

staload LOC = "pats_location.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

#define i2c char_of_int
#define c2i int_of_char
#define i2u uint_of_int
#define u2i int_of_uint
#define l2u uint_of_lint
#define sz2i int1_of_size1

(* ****** ****** *)

datatype
lexstate =
//
  | LS_ABST
  | LS_ABSVIEWT
  | LS_CASE
  | LS_FN
  | LS_FOR
  | LS_FOLD
  | LS_FREE
  | LS_PROP
  | LS_P0ROP
  | LS_T
  | LS_TYPE
  | LS_T0YPE
  | LS_VAL
  | LS_VIEW
  | LS_VIEWT
  | LS_VIEWTYPE
  | LS_VIEWT0YPE
  | LS_WHILE
//
  | LS_DOT of () // "."
  | LS_PERCENT of () // "%"
//
  | LS_LTBANG of () // "<!"
  | LS_LTDOLLAR of () // "<$"
  | LS_QMARKGT of () // "?>"
//
  | LS_SLASH2 of () // "//"
  | LS_SLASHSTAR of () // "/*"
  | LS_SLASH4 of () // "////"
//
  | LS_IDENTIFIER_alp of ()
  | LS_IDENTIFIER_sym of ()
//
  | LS_NONE of ()
//
(* end of [lexstate] *)

(* ****** ****** *)

fun IDENTIFIER_sym_get_state
  (x: string): lexstate = let
//
  fun slash2_test
    {n:int} {i:nat | i <= n} 
    (x: string n, i: int i): bool = let
//
    staload STRING = "libc/SATS/string.sats"
//
    extern fun substrncmp
      (x1: string, i1: int, x2: string, i2: int): int = "mac#atslib_substrcmp"
    // end of [substrncmp]
  in
    substrncmp (x, i, "//", 0) = 0
  end // end of [slash2_test]
//
  val x = string1_of_string (x)
//
in
  if string_isnot_at_end (x, 0) then let
    val x0 = x[0]
  in
    case+ x0 of
    | '<' =>
        if string_isnot_at_end (x, 1) then let
          val x1 = x[1]
        in
          case+ x1 of
          | '!' => LS_LTBANG ()
          | '$' => LS_LTDOLLAR ()
          | _ => LS_NONE ()
        end else LS_NONE ()
    | '?' =>
        if string_isnot_at_end (x, 1) then let
          val x1 = x[1]
        in
          case+ x1 of
          | '>' => LS_QMARKGT ()
          | _ => LS_NONE ()
        end else LS_NONE ()
    | '/' =>
        if string_isnot_at_end (x, 1) then let
          val x1 = x[1]
        in
          case+ x1 of
          | '*' => LS_SLASHSTAR ()
          | '/' => if slash2_test (x, 2) then LS_SLASH4 () else LS_SLASH2 ()
          | _ => LS_NONE ()
        end else LS_NONE ()
    | '.' => (
        if string_is_at_end (x, 1) then LS_DOT () else LS_NONE ()
      ) // end of ['.']
    | '%' => (
        if string_is_at_end (x, 1) then LS_PERCENT () else LS_NONE ()
      ) // end of ['%']
    | _ => LS_NONE ()
  end else LS_NONE () // end of [if]
end // end of [IDENTIFIER_sym_get_state]

(* ****** ****** *)

fun BLANK_test (c: char): bool = char_isspace (c)

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

fun SYMBOLIC_test
  (c: char): bool = let
  val symbolic = "%&+-./:=@~`^|*!$#?<>"
in
  string_contains (symbolic, c)
end // end of [SYMBOLIC_test]

(* ****** ****** *)

fun xX_test
  (c: char): bool =
  if c = 'x' then true else c = 'X'
// end of [xX_test]

fun DIGIT_test
  (c: char): bool = char_isdigit (c)

fun XDIGIT_test
  (c: char): bool = char_isxdigit (c)

(* ****** ****** *)

fun INTSP_test
  (c: char): bool = string_contains ("LlUu", c)

fun FLOATSP_test
  (c: char): bool = string_contains ("dDfFlL", c)

(* ****** ****** *)

fun eE_test
  (c: char): bool =
  if c = 'e' then true else c = 'E'
// end of [eE_test]

fun pP_test
  (c: char): bool =
  if c = 'p' then true else c = 'P'
// end of [pP_test]

fun SIGN_test
  (c: char): bool =
  if c = '+' then true else c = '-'
// end of [SIGN_test]

(* ****** ****** *)
//
// HX: f('\n') must be false!
//
extern
fun ftesting_opt (
  buf: &lexbuf, pos: &position, f: char -> bool
) : uint // end of [ftesting_seq0]
implement
ftesting_opt
  (buf, pos, f) = let
  val i = lexbufpos_get_char (buf, pos)
in
  if i >= 0 then (
    if f ((i2c)i) then let
      val () = $LOC.position_incby_count (pos, 1u)
    in
      1u
    end else 0u // end of [if]
  ) else 0u // end of [if]
end // end of [ftesting_opt]

(* ****** ****** *)
//
// HX: f('\n') must be false!
//
extern
fun ftesting_seq0 (
  buf: &lexbuf, pos: &position, f: char -> bool
) : uint // end of [ftesting_seq0]
implement
ftesting_seq0
  (buf, pos, f) = diff where {
  fun loop (
    buf: &lexbuf, nchr: uint, f: char -> bool
  ) : uint = let
    val i = lexbuf_get_char (buf, nchr)
  in
    if i >= 0 then
      if f ((i2c)i) then loop (buf, succ(nchr), f) else nchr
    else nchr // end of [if]
  end // end of [loop]
  val nchr0 = lexbufpos_diff (buf, pos)
  val nchr1 = loop (buf, nchr0, f)
  val diff = nchr1 - nchr0
  val () = if diff > 0u 
    then $LOC.position_incby_count (pos, diff) else ()
  // end of [val]
} // end of [ftesting_seq0]

(* ****** ****** *)
//
// HX: f('\n') must be false!
//
extern
fun ftesting_seq1 (
  buf: &lexbuf, pos: &position, f: char -> bool
) : int // end of [ftesting_seq1]
implement
ftesting_seq1
  (buf, pos, f) = let
  val i = lexbufpos_get_char (buf, pos)
in
  if i >= 0 then (
    if f ((i2c)i) then let
      val () =
        $LOC.position_incby_count (pos, 1u)
      // end of [val]
      val nchr = ftesting_seq0 (buf, pos, f) in (u2i)nchr + 1
    end else ~1 // end of [if]
  ) else ~1 // end of [if]
end // end of [ftesting_seq1]

(* ****** ****** *)
//
// HX: this function should not be based on
// [ftesting_seq0]
//
fun
testing_blankseq0 (
  buf: &lexbuf, pos: &position
) : uint = diff where {
  fun loop (
    buf: &lexbuf, pos: &position, nchr: uint
  ) : uint = let
    val i = lexbuf_get_char (buf, nchr)
  in
    if i >= 0 then (
      if BLANK_test ((i2c)i) then let
        val () = $LOC.position_incby_char (pos, i)
      in
        loop (buf, pos, succ(nchr))
      end else nchr // end of [if]
    ) else nchr // end of [if]
  end // end of [loop]
  val nchr0 = lexbufpos_diff (buf, pos)
  val nchr1 = loop (buf, pos, nchr0)
  val diff = nchr1 - nchr0
} // end of testing_blankseq0]

(* ****** ****** *)

extern
fun testing_char (
  buf: &lexbuf, pos: &position, lit: char
) : int // end of [testing_char]
implement testing_char
  (buf, pos, lit) = res where {
  val i = lexbufpos_get_char (buf, pos)
  val res = (
    if i >= 0 then
      if (i2c)i = lit then 1 else ~1
    else ~1
  ) : int // end of [val]
  val () = if res >= 0 then
    $LOC.position_incby_char (pos, i)
  // end of [val]
} // end of [testing_char]

(* ****** ****** *)
//
// HX: [lit] contains no '\n'!
//
extern
fun testing_literal (
  buf: &lexbuf, pos: &position, lit: string
) : int // end of [testing_literal]
implement testing_literal
  (buf, pos, lit) = res where {
  val [n:int] lit = string1_of_string (lit)
  fun loop
    {k:nat | k <= n} (
    buf: &lexbuf, nchr: uint, lit: string n, k: size_t k
  ) : int =
    if string_isnot_at_end (lit, k) then let
      val i = lexbuf_get_char (buf, nchr)
    in
      if i >= 0 then
        if ((i2c)i = lit[k])
          then loop (buf, succ(nchr), lit, k+1) else ~1
        // end of [if]
      else ~1 // end of [if]
    end else (sz2i)k // end of [if]
  val nchr0 = lexbufpos_diff (buf, pos)
  val res = loop (buf, nchr0, lit, 0)
  val () = if res >= 0
    then $LOC.position_incby_count (pos, (i2u)res) else ()
  // end of [val]
} // end of [testing_literal]

(* ****** ****** *)

fun testing_identrstseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, IDENTRST_test)
// end of [testing_identrstseq0]

fun testing_symbolicseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, SYMBOLIC_test)
// end of [testing_symbolicseq0]

(* ****** ****** *)

fun testing_digitseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, DIGIT_test)
// end of [testing_digitseq0]

fun testing_digitseq1
  (buf: &lexbuf, pos: &position): int
  = ftesting_seq1 (buf, pos, DIGIT_test)
// end of [testing_digitseq1]

(* ****** ****** *)

fun testing_xdigitseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, XDIGIT_test)
// end of [testing_xdigitseq0]

(* ****** ****** *)

fun testing_intspseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, INTSP_test)
// end of [testing_intspseq0]

fun testing_intspseq1
  (buf: &lexbuf, pos: &position): int
  = ftesting_seq1 (buf, pos, INTSP_test)
// end of [testing_intspseq1]

(* ****** ****** *)

fun testing_floatspseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, FLOATSP_test)
// end of [testing_floatspseq0]

(* ****** ****** *)

fun testing_fexponent (
  buf: &lexbuf, pos: &position
) : int = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i
in
  if eE_test (c) then let
    val () = $LOC.position_incby_count (pos, 1u)
    val k1 = ftesting_opt (buf, pos, SIGN_test)
    val k2 = testing_digitseq0 (buf, pos) // err: k2 = 0
  in
    u2i (k1+k2+1u)
  end else ~1 // end [if]
end else ~1 // end of [if]
//
end // end of [testing_fexponent]

fun testing_deciexp (
  buf: &lexbuf, pos: &position
) : int = let  
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i in
  if c = '.' then let
    val () = $LOC.position_incby_count (pos, 1u)
    val k1 = testing_digitseq0 (buf, pos)
    val k2 = testing_fexponent (buf, pos)
  in
    if k2 >= 0 then (u2i)k1 + k2 + 1 else (u2i)k1 + 1
  end else ~1 // end of [if]
end else ~1 // end of [if]
//
end // end of [testing_deciexp]

(* ****** ****** *)

fun testing_fexponent_bin (
  buf: &lexbuf, pos: &position
) : int = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i
in
  if pP_test (c) then let
    val () = $LOC.position_incby_count (pos, 1u)
    val k1 = ftesting_opt (buf, pos, SIGN_test)
    val k2 = testing_digitseq0 (buf, pos) // err: k2 = 0
  in
    u2i (k1+k2+1u)
  end else ~1 // end [if]
end else ~1 // end of [if]
//
end // end of [testing_fexponent]

fun testing_hexiexp (
  buf: &lexbuf, pos: &position
) : int = let  
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i in
  if c = '.' then let
    val () = $LOC.position_incby_count (pos, 1u)
    val k1 = testing_xdigitseq0 (buf, pos)
    val k2 = testing_fexponent_bin (buf, pos)
  in
    if k2 >= 0 then (u2i)k1 + k2 + 1 else (u2i)k1 + 1
  end else ~1 // end of [if]
end else ~1 // end of [if]
//
end // end of [testing_hexiexp]

(* ****** ****** *)

implement
token_make
  (loc, node) = '{
  token_loc= loc, token_node= node
} // end of [token_make]

(* ****** ****** *)

fun
lexbufpos_token_reset (
  buf: &lexbuf
, pos: &position
, node: token_node
) : token = let
  val loc =
    lexbufpos_get_location (buf, pos)
  val () = lexbuf_reset_position (buf, pos)
in
  token_make (loc, node)
end // end of [lexbufpos_token_reset]

(* ****** ****** *)

extern
fun lexing_COMMENT_line
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_COMMENT_block_c
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_COMMENT_block_ml {l:pos}
  (buf: &lexbuf, pos: &position, xs: list_vt (position, l)): token
extern
fun lexing_COMMENT_rest
  (buf: &lexbuf, pos: &position): token

(* ****** ****** *)

implement
lexing_COMMENT_line
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)  
in
  if i >= 0 then (
    case+ (i2c)i of
    | '\n' => (
        lexbufpos_token_reset (buf, pos, COMMENT_line)
      ) // end of ['\n']
    | _ => let
        val () = $LOC.position_incby_count (pos, 1u)
      in
        lexing_COMMENT_line (buf, pos)
      end // end of [_]
  ) else (
    lexbufpos_token_reset (buf, pos, COMMENT_line)
  ) // end of [if]
end // end of [lexing_COMMENT_line]

(* ****** ****** *)

implement
lexing_COMMENT_block_c
  (buf, pos) = let
//
  fun feof (
    buf: &lexbuf, pos: &position
  ) : token = let
    val loc =
      lexbufpos_get_location (buf, pos)
    // end of [loc]
    val () = lexbuf_reset_position (buf, pos)
  in
    token_make (loc, TOKEN_err ())
  end // end of [feof]
//
  val i = lexbufpos_get_char (buf, pos)
//
in
  if i >= 0 then (
    case+ (i2c)i of
    | '*' => let
        val ans = testing_literal (buf, pos, "*/")
      in
        if ans >= 0 then (
          lexbufpos_token_reset (buf, pos, COMMENT_block)
        ) else let
          val () = $LOC.position_incby_count (pos, 1u)
        in
          lexing_COMMENT_block_c (buf, pos)
        end // end of [if]
      end // end of ['*']
    | _ => let
        val () = $LOC.position_incby_char (pos, i)
      in
        lexing_COMMENT_block_c (buf, pos)
      end // end of [_]
  ) else feof (buf, pos) // end of [if]
end // end of [lexing_COMMENT_block_c]

implement
lexing_COMMENT_block_ml
  (buf, pos, xs) = let
//
  fun feof {l:pos} (
    buf: &lexbuf
  , pos: &position
  , xs: list_vt (position, l)
  ) : token = let
    val list_vt_cons (!p_x, _) = xs
    val loc = $LOC.location_make_pos_pos (!p_x, pos)
    prval () = fold@ (xs)
    val () = list_vt_free (xs)
    val () = lexbuf_reset_position (buf, pos)
  in
    token_make (loc, TOKEN_err ())
  end // end of [feof]
//
  val i = lexbufpos_get_char (buf, pos)
//
in
  if i >= 0 then (
    case+ (i2c)i of
    | '*' => let
        val ans = testing_literal (buf, pos, "*)")
      in
        if ans >= 0 then let
          val ~list_vt_cons (_, xs) = xs
        in
          case+ xs of
          | list_vt_cons _ => let
              prval () = fold@ (xs) in
              lexing_COMMENT_block_ml (buf, pos, xs)
            end // end of [list_vt_cons]
          | ~list_vt_nil () =>
              lexbufpos_token_reset (buf, pos, COMMENT_block)
            // end of [list_vt_nil]
        end else let
          val () = $LOC.position_incby_count (pos, 1u)
        in
          lexing_COMMENT_block_ml (buf, pos, xs)
        end // end of [if]
      end // end of ['*']
    | '\(' => let
        var x: position
        val () = $LOC.position_copy (x, pos)
        val ans = testing_literal (buf, pos, "(*")
      in
        if ans >= 0 then
          lexing_COMMENT_block_ml (buf, pos, list_vt_cons (x, xs))
        else let
          val () = $LOC.position_incby_count (pos, 1u)
        in
          lexing_COMMENT_block_ml (buf, pos, xs)
        end // end of [if]
      end // end of ['\(']
    | _ => let
        val () = $LOC.position_incby_char (pos, i)
      in
        lexing_COMMENT_block_ml (buf, pos, xs)
      end // end of [_]
  ) else feof (buf, pos, xs) // end of [if]
end // end of [lexing_COMMENT_block_ml]

(* ****** ****** *)

implement
lexing_COMMENT_rest
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)  
in
  if i >= 0 then let
    val () = $LOC.position_incby_char (pos, i)
  in
    lexing_COMMENT_rest (buf, pos)
  end else (
    lexbufpos_token_reset (buf, pos, COMMENT_rest)
  ) // end of [if]
end // end of [lexing_COMMENT_rest]

(* ****** ****** *)

extern
fun lexing_EXTCODE_knd
  (buf: &lexbuf, pos: &position, knd: int): token
implement
lexing_EXTCODE_knd
  (buf, pos, knd) = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i in
  case+ c of
  | '%' => let
      val res = testing_literal (buf, pos, "%}")
    in
      if res >= 0 then let
        val loc = lexbufpos_get_location (buf, pos)
        val nchr = (if knd = 1 then 2u else 3u): uint
        val () = lexbuf_incby_count (buf, nchr)
        val diff = lexbufpos_diff (buf, pos) - 2u // %}: 2u
        val str = lexbuf_get_strptr (buf, diff)
        val () = lexbuf_reset_position (buf, pos)
        val () = assertloc (strptr_isnot_null (str))
        val str = string_of_strptr (str)
      in
        token_make (loc, EXTCODE (knd, str))
      end else let
        val () = $LOC.position_incby_count (pos, 1u)
      in
        lexing_EXTCODE_knd (buf, pos, knd)
      end // end of [if]
    end // end of ['%']
  | _ => let
      val () = $LOC.position_incby_char (pos, i)
    in
      lexing_EXTCODE_knd (buf, pos, knd)
    end // end of [_]
end else
  lexbufpos_token_reset (buf, pos, TOKEN_err)
// end of [if]
end // end of [lexing_EXTCODE]


extern
fun lexing_EXTCODE
  (buf: &lexbuf, pos: &position): token
implement
lexing_EXTCODE
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i
  val knd = (case+ c of
    | '^' =>  0 | '$' =>  2 | '#' => ~1 | _ => 1
  ) : int // end of [val]
  val () = if knd <> 1 then $LOC.position_incby_count (pos, 1u)
in
  lexing_EXTCODE_knd (buf, pos, knd)
end else
  lexbufpos_token_reset (buf, pos, TOKEN_err)
// end of [if]
end // end of [lexing_EXTCODE]

(* ****** ****** *)

extern
fun lexing_LPAREN
  (buf: &lexbuf, pos: &position): token
implement
lexing_LPAREN
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
  | '*' => let
      val () = $LOC.position_incby_count (pos, 1u)
      val poslst = list_vt_cons {position} (?, list_vt_nil)
      val list_vt_cons (!p_x, _) = poslst
      val () = lexbuf_get_position (buf, !p_x)
      prval () = fold@ (poslst)
    in
      lexing_COMMENT_block_ml (buf, pos, poslst)
    end // end of ['*']
  | _ => lexbufpos_token_reset (buf, pos, LPAREN)
end // en dof [lexing_LPAREN]

(* ****** ****** *)

extern
fun lexing_COMMA
  (buf: &lexbuf, pos: &position): token
implement
lexing_COMMA (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
  | '\(' => let
      val () =
        $LOC.position_incby_count (pos, 1u)
      // end of [val]
    in
      lexbufpos_token_reset (buf, pos, COMMALPAREN)
    end // end of ['(']
  | _ => lexbufpos_token_reset (buf, pos, COMMA)
end // end of [lexing_COMMA]

(* ****** ****** *)

extern
fun lexing_FLOAT_deciexp
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_FLOAT_hexiexp
  (buf: &lexbuf, pos: &position): token

extern
fun lexing_INTEGER_dec
  (buf: &lexbuf, pos: &position, k1: uint): token
extern
fun lexing_INTEGER_oct
  (buf: &lexbuf, pos: &position, k1: uint): token
extern
fun lexing_INTEGER_hex
  (buf: &lexbuf, pos: &position, k1: uint): token

extern
fun lexing_IDENTIFIER_alp {l:agz}
  (buf: &lexbuf, pos: &position, str: strptr l): token

extern
fun lexing_IDENTIFIER_sym {l:agz}
  (buf: &lexbuf, pos: &position, str: strptr l): token

(* ****** ****** *)

macdef DOT = IDENTIFIER_sym (".")

extern
fun lexing_DOT
  (buf: &lexbuf, pos: &position): token
implement
lexing_DOT
  (buf, pos) = let
  val nspace = lexbuf_get_nspace (buf)
in
  case+ 0 of
  | _ when nspace > 0 => let
      val () = $LOC.position_decby_count (pos, 1u)
    in
      if testing_deciexp (buf, pos) >= 0 then
        lexing_FLOAT_deciexp (buf, pos)
      else
        lexbufpos_token_reset (buf, pos, TOKEN_err)
      // end of [if]
    end // end of [nspace > 0]
  | _ => lexbufpos_token_reset (buf, pos, DOT)
end // end of [lexing_DOT]
  
(* ****** ****** *)

macdef PERCENT = IDENTIFIER_sym ("%")

extern
fun lexing_PERCENT
  (buf: &lexbuf, pos: &position): token
implement
lexing_PERCENT
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i in
  case+ c of 
  | '\{' => let
      val () =
        $LOC.position_incby_count (pos, 1u)
      // end of [val]
    in
      lexing_EXTCODE (buf, pos)
    end // end of ['\{']
  | _ => (
      lexbufpos_token_reset (buf, pos, PERCENT)
    ) // end of [_]
end else
  lexbufpos_token_reset (buf, pos, PERCENT)
// end of [if]
end // end of [lexing_PERCENT]

(* ****** ****** *)

implement
lexing_IDENTIFIER_alp
  {l} (buf, pos, str) = let
  viewtypedef vt = strptr l
  val str = string_of_strptr (str)
in
  lexbufpos_token_reset (buf, pos, IDENTIFIER_alp (str))
end // end of [lexing_IDENTIFIER_alp]

(* ****** ****** *)

macdef LT = IDENTIFIER_sym ("<")
macdef QMARK = IDENTIFIER_sym ("?")

implement
lexing_IDENTIFIER_sym
  {l} (buf, pos, str) = let
  viewtypedef vt = strptr l
  val state = IDENTIFIER_sym_get_state ($UN.castvwtp1{string}{vt}(str))
in
  case+ state of
//
  | LS_DOT () => let
      val () = strptr_free (str) in lexing_DOT (buf, pos)
    end // end of [LS_DOT]
  | LS_PERCENT () => let
      val () = strptr_free (str) in lexing_PERCENT (buf, pos)
    end // end of [LS_PERCENT]
//
  | LS_LTBANG () => let
      val () = strptr_free (str)
      val () = $LOC.position_decby_count (pos, 1u)
    in
      lexbufpos_token_reset (buf, pos, LT)
    end // end of [LS_LTBANG]
  | LS_LTDOLLAR () => let
      val () = strptr_free (str)
      val () = $LOC.position_decby_count (pos, 1u)
    in
      lexbufpos_token_reset (buf, pos, LT)
    end // end of [LS_LTDOLLOR]
  | LS_QMARKGT () => let
      val () = strptr_free (str)
      val () = $LOC.position_decby_count (pos, 1u)
    in
      lexbufpos_token_reset (buf, pos, QMARK)
    end // end of [LS_QMARKGT]
//
  | LS_SLASH2 () => let
      val () = strptr_free (str) in lexing_COMMENT_line (buf, pos)
    end // end of [LS_SLASH2]
  | LS_SLASHSTAR () => let
      val () = strptr_free (str) in lexing_COMMENT_block_c (buf, pos)
    end // end of [LS_SLASHSTAR]
  | LS_SLASH4 () => let
      val () = strptr_free (str) in lexing_COMMENT_rest (buf, pos)
    end // end of [LS_SLASH2]
//
  | _ => let
      val str = string_of_strptr (str)
    in
      lexbufpos_token_reset (buf, pos, IDENTIFIER_sym (str))
    end // end of [_]
end // end of [lexing_IDENTIFIER_sym]

(* ****** ****** *)

implement
lexing_FLOAT_deciexp
  (buf, pos) = let
  val k = testing_floatspseq0 (buf, pos)
  val str = lexbufpos_get_strptr (buf, pos)
  val () = assertloc (strptr_isnot_null (str))
  val str = string_of_strptr (str)
in
  lexbufpos_token_reset (buf, pos, FLOAT_deciexp (str))
end // end of [lexing_FLOAT_deciexp]

implement
lexing_FLOAT_hexiexp
  (buf, pos) = let
  val k = testing_floatspseq0 (buf, pos)
  val str = lexbufpos_get_strptr (buf, pos)
  val () = assertloc (strptr_isnot_null (str))
  val str = string_of_strptr (str)
in
  lexbufpos_token_reset (buf, pos, FLOAT_hexiexp (str))
end // end of [lexing_FLOAT_deciexp]

(* ****** ****** *)

implement
lexing_INTEGER_dec
  (buf, pos, k1) =
  case+ 0 of
  | _ when
      testing_deciexp (buf, pos) >= 0 => let
    in
      lexing_FLOAT_deciexp (buf, pos)
    end // end of [_ when ...]
  | _ when
      testing_fexponent (buf, pos) >= 0 => let
    in
      lexing_FLOAT_deciexp (buf, pos)
    end // end of [_ when ...]
  | _ => let
      val k2 = testing_intspseq1 (buf, pos)
      val str = lexbufpos_get_strptr (buf, pos)
      val () = assertloc (strptr_isnot_null (str))
      val str = string_of_strptr (str)
    in
      lexbufpos_token_reset (buf, pos, INTEGER_dec (str))      
    end // end of [_ when ...]
// end of [lexing_INTEGER_dec]

(* ****** ****** *)

implement
lexing_INTEGER_oct
  (buf, pos, k1) =
if k1 >= 2u then let
  val k2 = testing_intspseq0 (buf, pos)
  val str = lexbuf_get_strptr (buf, k1+k2+1u) // 0: 1u
  val () = assertloc (strptr_isnot_null (str))
  val str = string_of_strptr (str)
in
  lexbufpos_token_reset (buf, pos, INTEGER_oct (str))
end else
  lexing_INTEGER_dec (buf, pos, k1)
// end of [lexing_INTEGER_oct]

(* ****** ****** *)

implement
lexing_INTEGER_hex
  (buf, pos, k1) =
  case+ 0 of
  | _ when
      testing_hexiexp (buf, pos) >= 0 => let
    in
      lexing_FLOAT_hexiexp (buf, pos)
    end // end of [_ when ...]
  | _ when
      testing_fexponent_bin (buf, pos) >= 0 => let
    in
      lexing_FLOAT_deciexp (buf, pos)
    end // end of [_ when ...]
  | _ => let
      val k2 = testing_intspseq0 (buf, pos)
      val str = lexbufpos_get_strptr (buf, pos)
      val () = assertloc (strptr_isnot_null (str))
      val str = string_of_strptr (str)
    in
      lexbufpos_token_reset (buf, pos, INTEGER_hex (str))
    end // end of [_ when ...]
// end of [lexing_INTEGER_hex]

(* ****** ****** *)

macdef ZERO = INTEGER_dec ("0")

extern
fun lexing_ZERO
  (buf: &lexbuf, pos: position): token
implement
lexing_ZERO
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
  if i >= 0 then let
    val c = (i2c)i in
    case+ 0 of
    | _ when xX_test (c) => let
        val () =
          $LOC.position_incby_count (pos, 1u)
        // end of [val]
        val k1 = testing_xdigitseq0 (buf, pos)
      in
        lexing_INTEGER_hex (buf, pos, k1)
      end // end of [_ when ...]
    | _ => let
        val k1 = testing_digitseq0 (buf, pos)
      in
        lexing_INTEGER_oct (buf, pos, k1)
      end // end of [_ when ...]
    // end of [case]
  end else
    lexbufpos_token_reset (buf, pos, ZERO)
  // end of [if]
end // end of [lexing_ZERO]

(* ****** ****** *)

implement
lexing_next_token
  (buf) = let
  var pos: position
  val () = lexbuf_get_position (buf, pos)
  val k = testing_blankseq0 (buf, pos)
  val () = lexbuf_set_nspace (buf, (u2i)k)
  val () = lexbuf_reset_position (buf, pos)
  val i0 = lexbuf_get_char (buf, 0u)
//
in
//
if i0 >= 0 then let
  val c = (i2c)i0 // the first character
  val () = $LOC.position_incby_char (pos, i0)
in
  case+ 0 of
//
  | _ when c = '\(' =>
      lexing_LPAREN (buf, pos)
  | _ when c = ')' =>
      lexbufpos_token_reset (buf, pos, RPAREN)
  | _ when c = '\[' =>
      lexbufpos_token_reset (buf, pos, LBRACKET)
  | _ when c = ']' =>
      lexbufpos_token_reset (buf, pos, RBRACKET)
  | _ when c = '\{' =>
      lexbufpos_token_reset (buf, pos, LBRACE)
  | _ when c = '}' =>
      lexbufpos_token_reset (buf, pos, RBRACE)
//
  | _ when c = ',' =>
      lexing_COMMA (buf, pos)
  | _ when c = ';' =>
      lexbufpos_token_reset (buf, pos, SEMICOLON)
//
  | _ when IDENTFST_test (c) => let
      val k = testing_identrstseq0 (buf, pos)
      val str = lexbuf_get_strptr (buf, succ(k))
      val () = assertloc (strptr_isnot_null (str))
    in
      lexing_IDENTIFIER_alp (buf, pos, str)
    end // end of [_ when ...]
  | _ when SYMBOLIC_test (c) => let
      val k = testing_symbolicseq0 (buf, pos)
      val str = lexbuf_get_strptr (buf, succ(k))
      val () = assertloc (strptr_isnot_null (str))
    in
      lexing_IDENTIFIER_sym (buf, pos, str)
    end // end of [_ when ...]
//
  | _ when c = '0' => lexing_ZERO (buf, pos)
//
  | _ when DIGIT_test (c) => let
      val k1 = testing_digitseq0 (buf, pos)
    in
      lexing_INTEGER_dec (buf, pos, k1)
    end // end of [_ when ...]
//
  | _ => let
      val () = lexbuf_reset_position (buf, pos)
    in
      lexing_next_token (buf)
    end // end of [_]
end else
  token_make (lexbufpos_get_location (buf, pos), TOKEN_eof)
// end of [if]
//
end // end of [lexing_get_next_token]

(* ****** ****** *)

(* end of [pats_lexing.dats] *)
