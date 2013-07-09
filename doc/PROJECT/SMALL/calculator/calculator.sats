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
fun aexp_parse_string (inp: string): aexp
//
(* ****** ****** *)
//
// abstract type
// for streams character
//
abstype cstream_type
typedef cstream = cstream_type
//
(* ****** ****** *)

fun cstream_make_string (str: string): cstream

(* ****** ****** *)

fun cstream_is_atend (cs: cstream): bool

(* ****** ****** *)

fun cstream_inc (cs: cstream): void
fun cstream_get (cs: cstream): int
fun cstream_getinc (cs: cstream): int // get and inc

(* ****** ****** *)

fun cstream_get_at (cs: cstream, i: int): char
fun cstream_getinc_at (cs: cstream, i: int): char

(* ****** ****** *)

fun cstream_get_range (cs: cstream, i: int, j: int): string

(* ****** ****** *)

datatype token =
  | TOKint of int | TOKopr of string | TOKeof of ()
// end of [token]

(* ****** ****** *)

fun print_token (tok: token): void
overload print with print_token
fun fprint_token (out: FILEref, tok: token): void
overload fprint with fprint_token

(* ****** ****** *)
//
// abstract type
// for streams of tokens
//
abstype tstream_type
typedef tstream = tstream_type
//
(* ****** ****** *)

(* end of [calculator.sats] *)
