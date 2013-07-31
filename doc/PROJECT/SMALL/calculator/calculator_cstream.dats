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
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/strarr.sats"
staload _ = "libats/ML/DATS/array0.dats"
staload _ = "libats/ML/DATS/strarr.dats"

(* ****** ****** *)

staload "./calculator.sats"

(* ****** ****** *)

datatype
cstream =
  CSTREAM of (strarr, ref(size))
// end of [cstream]

(* ****** ****** *)

assume cstream_type = cstream

(* ****** ****** *)

implement
cstream_make_string
  (str) = let
//
val A = strarr_make_string (str)
val iref = ref_make_elt<size> (i2sz(0))
//
in
  CSTREAM (A, iref)
end // end of [cstream_make_string]

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
  if i < length(A) then char2u2int0(A[i]) else ~1
end // end of [cstream_get]

(* ****** ****** *)

implement
cstream_getinc
  (cs) = let
  val+CSTREAM (A, iref) = cs
  val i = !iref
  val () = !iref := succ (!iref)
in
  if i < length(A) then char2u2int0(A[i]) else ~1
end // end of [cstream_getinc]

(* ****** ****** *)

implement
cstream_get_pos (cs) =
  let val+CSTREAM (A, iref) = cs in !iref end
// end of [cstream_get_pos]

(* ****** ****** *)

implement
cstream_skip
  (cs, f) = let
  val c = cstream_get (cs) in
  if f (c) then (cstream_inc (cs); cstream_skip (cs, f))
end // end of [ctsream_skip]
      
implement
cstream_skip_WS (cs) = cstream_skip (cs, lam (c) => isspace (c))

(* ****** ****** *)

(* end of [calculator_cstream.dats] *)
