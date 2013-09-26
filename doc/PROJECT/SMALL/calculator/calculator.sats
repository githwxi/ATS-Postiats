(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX: for arithmetic expressions
//
datatype aexp =
  | AEint of (int) // intconst
  | AEneg of (aexp) // negative
  | AEadd of (aexp, aexp) // addition
  | AEsub of (aexp, aexp) // subtraction
  | AEmul of (aexp, aexp) // multiplication
  | AEdiv of (aexp, aexp) // division
// end of [aexp]

(* ****** ****** *)
//
// Some printing functions
// mostly for the purpose of debugging
//
fun print_aexp (ae: aexp): void
overload print with print_aexp
fun fprint_aexp (out: FILEref, ae: aexp): void
overload fprint with fprint_aexp
//
(* ****** ****** *)
//
// It is for evaluating arithemetic expressions.
//
fun aexp_eval (ae: aexp): double
//
(* ****** ****** *)
//
// A parsing function for turning string into aexp.
// In case of parsing error, a run-time exception is
// raised.
//
fun aexp_parse_string (inp: string): Option_vt (aexp)
//
(* ****** ****** *)

typedef size = size_t

(* ****** ****** *)
//
// abstract type
// for streams character
//
abstype cstream_type = ptr
typedef cstream = cstream_type
//
(* ****** ****** *)

fun cstream_make_string (string): cstream

(* ****** ****** *)

fun cstream_is_atend (cs: cstream): bool

(* ****** ****** *)

fun cstream_inc (cs: cstream): void
fun cstream_get (cs: cstream): int
fun cstream_getinc (cs: cstream): int // get and inc

(* ****** ****** *)

fun cstream_get_pos (cs: cstream): size

(* ****** ****** *)

fun cstream_get_at (cs: cstream, i: size): char

(* ****** ****** *)

fun cstream_get_range (cs: cstream, i: size, j: size): string

(* ****** ****** *)

fun cstream_skip (cs: cstream, f: int -> bool): void
fun cstream_skip_WS (cs: cstream): void // skipping white space

(* ****** ****** *)

fun cstream_get_int (cs: cstream): int
fun cstream_get_ident (cs: cstream): string
fun cstream_get_symbol (cs: cstream): string

(* ****** ****** *)

datatype token =
  | TOKint of int
  | TOKopr of string
  | TOKlpar of () | TOKrpar of ()
  | TOKunknown of char
  | TOKeof of ()
// end of [token]

(* ****** ****** *)

fun token_is_add (token): bool
fun token_is_sub (token): bool
fun token_is_mul (token): bool
fun token_is_div (token): bool

(* ****** ****** *)

fun print_token (token): void
overload print with print_token
fun fprint_token (FILEref, token): void
overload fprint with fprint_token

(* ****** ****** *)

fun cstream_get_token (cs: cstream): token

(* ****** ****** *)
//
// abstract type
// for streams of tokens
//
abstype tstream_type = ptr
typedef tstream = tstream_type
//
(* ****** ****** *)

fun tstream_make_string (string): tstream

fun tstream_get (tstream): token
fun tstream_inc (ts: tstream): void
fun tstream_getinc (ts: tstream): token

(* ****** ****** *)

(* end of [calculator.sats] *)
