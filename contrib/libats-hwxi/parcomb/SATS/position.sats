(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2012-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
** 
*)

(* ****** ****** *)
(*
** For recording
** location information on concrete syntax
*)
//
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu
// Start Time: October 2013
//
(* ****** ****** *)
//
// HX: a position is a point in a given file
//
(* ****** ****** *)

abstype position_type = ptr
typedef position = position_type

(* ****** ****** *)

fun position_get_line (p: position):<> int
fun position_get_lofs (p: position):<> int
fun position_get_tofs (p: position):<> lint

(* ****** ****** *)

symintr .line .loff .toff
overload .line with position_get_line
overload .line with position_get_lofs
overload .line with position_get_tofs

(* ****** ****** *)

fun print_position (position): void
fun prerr_position (position): void
overload print with print_position
overload prerr with prerr_position
fun fprint_position (out: FILEref, x: position): void
overload fprint with fprint_position

(* ****** ****** *)

(* end of [position.sats] *)
