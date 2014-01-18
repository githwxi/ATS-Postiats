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

(*
** location for lexing
*)

(* ****** ****** *)
//
abst@ype
position_type =
$extype"atscntrb_lexingbuf_position" 
//
typedef pos_t = position_type
//  
(* ****** ****** *)
//
fun
position_incby_char
  (pos: &pos_t >> _, c: int):<!wrt> void
//
(* ****** ****** *)

abstype
location_type = ptr
typedef loc_t = location_type

(* ****** ****** *)
//
fun location_make
  (_beg: &pos_t, _end: &pos_t): loc_t
//
(* ****** ****** *)
//
fun print_location : (loc_t) -> void
fun prerr_location : (loc_t) -> void
//
fun fprint_location
  (out: FILEref, loc: loc_t): void
//
overload print with print_location
overload prerr with prerr_location
overload fprint with fprint_location
//
(* ****** ****** *)

(* end of [location.sats] *)
