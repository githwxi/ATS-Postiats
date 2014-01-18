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
** location for lexing
*)

(* ****** ****** *)

staload "./../SATS/filename.sats"
staload "./../SATS/location.sats"

(* ****** ****** *)

#define i2c int2char0
#define c2i char2int0

(* ****** ****** *)

macdef EOL = char2int0('\n')

(* ****** ****** *)

assume
position_type =
$extype_struct
"atscntrb_lexingbuf_position" of
{
  ntot= lint, nrow= int, ncol= int
} (* end of [postion_type] *)

(* ****** ****** *)

implement
position_incby_char
  (pos, c) = () where
{
  val () = pos.ntot := succ(pos.ntot)
  val () = if c = EOL then pos.nrow := succ (pos.nrow)
} (* end of [position_incby_char] *)

(* ****** ****** *)

assume
location_type = $rec
{
  fname= fname_t // file name
, beg_ntot= lint // beginning char position
, beg_nrow= int
, beg_ncol= int
, end_ntot= lint // finishing char position
, end_nrow= int
, end_ncol= int
} (* end of [location] *)

(* ****** ****** *)

(* end of [location.dats] *)
