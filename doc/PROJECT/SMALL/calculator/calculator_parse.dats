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

staload "calculator.sats"

(* ****** ****** *)

abstype cstream_type
typedef cstream = cstream_type

(* ****** ****** *)

extern
fun cstream_make_string (str: string): cstream

(* ****** ****** *)

extern
fun cstream_inc (cs: cstream): void
extern
fun cstream_get (cs: cstream): char
extern
fun cstream_getinc (cs: cstream): char

(* ****** ****** *)

extern
fun cstream_is_atend (cs: cstream): bool

(* ****** ****** *)

extern
fun cstream_get_at (cs: cstream, i: int): char
extern
fun cstream_getinc_at (cs: cstream, i: int): char

(* ****** ****** *)

extern
fun cstream_get_range (cs: cstream, i: int, j: int): string

(* ****** ****** *)

(* end of [calculator.dats] *)
