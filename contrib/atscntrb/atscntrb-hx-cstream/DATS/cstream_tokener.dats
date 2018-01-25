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
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "./../SATS/cstream.sats"
staload "./../SATS/cstream_tokener.sats"

(* ****** ****** *)

#define BUFSZ 1024

(* ****** ****** *)

datavtype
tokener(a:type) =
TOKENER of
(cstream, int, $SBF.stringbuf)
// end of [tokener]

(* ****** ****** *)

assume tokener_vtype = tokener

(* ****** ****** *)

implement{a}
tokener_make_cstream (cs0) = let
//
val c0 = cstream_get_char (cs0)
val buf =
  $SBF.stringbuf_make_nil (i2sz(BUFSZ)) in TOKENER{a}(cs0, c0, buf)
// end of [val]
end // end of [tokener_make_cstream]

(* ****** ****** *)

implement{a}
tokener_free
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

datavtype
tokener2(token:type) =
  TOKENER2 of (tokener(token), token)
// end of [tokener2]

(* ****** ****** *)

assume token_v = unit_v
assume tokener2_vtype(a:type) = tokener2(a)

(* ****** ****** *)

implement
{a}(*tmp*)
tokener2_get (t2knr) = let
//
val+TOKENER2(_, tok) = t2knr
//
in
  (unit_v() | tok)
end // end of [tokener2_get]

(* ****** ****** *)

implement
{token}
tokener2_unget (pf | t2knr) =
  let prval unit_v () = pf in () end
// end of [tokener2_unget]

implement
{token}
tokener2_getaft (pf | t2knr) =
{
//
prval unit_v () = pf
//
val+@TOKENER2(tknr, tok) = t2knr
val () = tok := tokener_get_token<token> (tknr)
prval ((*void*)) = fold@ (t2knr)
//
} (* end of [tokener2_getaft] *)

(* ****** ****** *)

implement
{token}
tokener2_getout
  (t2knr) = tok_ where
{
//
val+@TOKENER2(tknr, tok) = t2knr
val tok_ = tok
val ((*void*)) = tok := tokener_get_token<token> (tknr)
//
prval ((*void*)) = fold@ (t2knr)
//
} (* end of [tokener2_getout] *)

(* ****** ****** *)

implement
{a}(*tmp*)
tokener2_free (t2knr) = let
//
val+~TOKENER2(tknr, tok) = t2knr in tokener_free (tknr)
//
end // end of [tokener2_free]

(* ****** ****** *)

implement
{a}(*tmp*)
tokener2_make_tokener
  (tknr) = let
//
val tok = tokener_get_token<a> (tknr) in TOKENER2 (tknr, tok)
//
end // end of [tokener2_make]

(* ****** ****** *)

(* end of [cstream_tokener.dats] *)
