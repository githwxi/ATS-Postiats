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
** cstream-based tokenizer
*)

(* ****** ****** *)

staload "./cstream.sats"

(* ****** ****** *)
//
staload
SBF = "libats/SATS/stringbuf.sats"
//
(* ****** ****** *)

absvtype tokener_vtype = ptr
vtypedef tokener = tokener_vtype

(* ****** ****** *)
//
fun tokener_make_cstream (cs0: cstream): tokener
//
(* ****** ****** *)
//
fun tokener_free (tknr: tokener): void
fun tokener_getfree_cstream (tknr: tokener): cstream
//
(* ****** ****** *)
//
fun{
token:type
} tokener_get_token (lxbf: !tokener): token
//
fun{token:type}
tokener_get_token$main (
  cs0: !cstream, c0: &int >> _, sbf: !($SBF.stringbuf)
) : token // end of [tokener_get_token$main]
//
(* ****** ****** *)

(* end of [cstream_tokener.sats] *)
