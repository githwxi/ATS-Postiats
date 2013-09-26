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

staload "./calculator.sats"
staload _ = "prelude/DATS/pointer.dats"
staload _ = "prelude/DATS/reference.dats"

(* ****** ****** *)

datatype
tstream = TSTREAM of (ref(token), cstream)

(* ****** ****** *)

assume tstream_type = tstream

(* ****** ****** *)

implement
tstream_make_string
  (str) = let
  val cs = cstream_make_string (str)
  val tok = cstream_get_token (cs)
  val tref = ref_make_elt<token> (tok)
in
  TSTREAM (tref, cs)
end // end of [tstream_make_string]

(* ****** ****** *)

implement
tstream_get (ts) = let
//
val+TSTREAM (tref, cs) = ts
//
in
  !tref
end // end of [tstream_get_token]

(* ****** ****** *)

implement
tstream_inc (ts) = let
//
val+TSTREAM (tref, cs) = ts
val ((*void*)) = !tref := cstream_get_token (cs)
//
in
  // nothing
end // end of [tstream_inc]

(* ****** ****** *)

implement
tstream_getinc (ts) = let
//
val+TSTREAM (tref, cs) = ts
val tok = !tref
val ((*void*)) = !tref := cstream_get_token (cs)
//
in
  tok
end // end of [tstream_inc]

(* ****** ****** *)

(* end of [calculator_tstream.dats] *)
