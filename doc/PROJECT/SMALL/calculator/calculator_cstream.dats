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

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/strarr.sats"

(* ****** ****** *)

staload "./calculator.sats"

(* ****** ****** *)

typedef size = size_t

(* ****** ****** *)

datatype
cstream =
  CSTREAM of (strarr, ref(size))
// end of [cstream]

(* ****** ****** *)

assume cstream_type = cstream

(* ****** ****** *)

implement
cstream_is_atend
  (cs) = let
  val+CSTREAM (A, iref) = cs
in
  if !(iref) >= length(A) then true else false
end // end of [cstream_is_atend]

(* ****** ****** *)

implement
cstream_inc
  (cs) = let
  val+CSTREAM (A, iref) = cs
in
  !iref := succ (!iref)
end // end of [cstream_inc]

(* ****** ****** *)

implement
cstream_get
  (cs) = let
  val+CSTREAM (A, iref) = cs
  val i = !iref
in
  if i < length(A) then char2int_unsigned(A[i]) else ~1
end // end of [cstream_get]

(* ****** ****** *)

(* end of [calculator_cstream.dats] *)
