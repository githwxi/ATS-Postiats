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
** cstream-based tokener
*)

(* ****** ****** *)

staload "./../SATS/cstream.sats"
staload "./../SATS/cstream_tokener.sats"

(* ****** ****** *)

datavtype
tokener =
TOKENER of
  (cstream, int, $SBF.stringbuf)
// end of [tokener]

(* ****** ****** *)

assume tokener_vtype = tokener

(* ****** ****** *)

#define BUFSZ 1024

(* ****** ****** *)

implement{
} tokener_make_cstream (cs0) = let
//
val c0 = cstream_get_char (cs0)
val buf =
  $SBF.stringbuf_make_nil (i2sz(BUFSZ)) in TOKENER (cs0, c0, buf)
// end of [val]
end // end of [tokener_make_cstream]

(* ****** ****** *)

implement{
} tokener_free
  (buf) = () where
{
  val+~TOKENER(cs0, _, sbf) = buf
  val ((*void*)) = cstream_free (cs0)
  val ((*void*)) = $SBF.stringbuf_free (sbf)
} (* end of [tokener_getfree_cstream] *)

(* ****** ****** *)

implement{token}
tokener_get_token
  (buf) = tok where
{
  val+@TOKENER(cs0, c0, sbf) = buf
  val tok = tokener_get_token$main<token> (cs0, c0, sbf)
  prval ((*void*)) = fold@ (buf)
} (* end of [lexinguf_get_token] *)

(* ****** ****** *)

(* end of [cstream_tokener.dats] *)
