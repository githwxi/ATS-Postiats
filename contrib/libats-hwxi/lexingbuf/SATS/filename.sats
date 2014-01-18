(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2014-01-17: start
//
(* ****** ****** *)

(*
** filename for lexing
*)

(* ****** ****** *)
//
abstype
filename_type = ptr
//
typedef fname_t = filename_type
//
(* ****** ****** *)

fun
filename_make
(
  given: string, part: string, full: string
) : fname_t // end of [filename_make]

(* ****** ****** *)
//
fun print_filename_full (fname_t): void
fun prerr_filename_full (fname_t): void
fun fprint_filename_full (out: FILEref, fname_t): void
//
overload print with print_filename_full
overload prerr with prerr_filename_full
overload fprint with fprint_filename_full
//
(* ****** ****** *)
//
fun
filename_equal
  (fname_t, fname_t): bool
//
overload = with filename_equal
//
(* ****** ****** *)

(* end of [filename.sats] *)
