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
// Author: Hongwei Xi
// Start Time: January, 2014
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSCNTRB.HX.cstream"
//
(* ****** ****** *)
//
(*
** cstream:
** stream of characters
*)
//
(* ****** ****** *)

staload "./cstream.sats"

(* ****** ****** *)
//
staload
SBF =
"libats/SATS/stringbuf.sats"
//
vtypedef stringbuf = $SBF.stringbuf
//
(* ****** ****** *)
//
absvtype
tokener_vtype(a: type) = ptr
vtypedef
tokener(a: type) = tokener_vtype(a)
//
(* ****** ****** *)
//
fun{a:type}
tokener_free(tknr: tokener(a)): void
//
(* ****** ****** *)
//
fun{a:type}
tokener_make_cstream(cs0: cstream): tokener(a)
//
(* ****** ****** *)
//
fun{a:type}
tokener_get_token (lxbf: !tokener(a)): (a)
//
fun{
token:type
} tokener_get_token$main
(
  cs0: !cstream, i0: &int >> _, sbf: !stringbuf
) : token // end of [tokener_get_token$main]
//
(* ****** ****** *)

absvtype tokener2_vtype(a:type) = ptr
vtypedef tokener2(a:type) = tokener2_vtype(a)

(* ****** ****** *)

fun{a:type}
tokener2_free(t2nkr: tokener2(a)): void
fun{a:type}
tokener2_make_tokener(tokener(a)): tokener2(a)

(* ****** ****** *)
//
absview token_v
//
fun{a:type}
tokener2_get (!tokener2(a)): (token_v | a)
fun{a:type}
tokener2_unget (token_v | !tokener2(a)): void
fun{a:type}
tokener2_getaft (token_v | !tokener2(a)): void
//
fun{a:type} tokener2_getout (!tokener2(a)): (a)
//
(* ****** ****** *)

(* end of [cstream_tokener.sats] *)
