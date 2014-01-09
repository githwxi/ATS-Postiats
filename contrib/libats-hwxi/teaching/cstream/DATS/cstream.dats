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
** stream of characters
*)

(* ****** ****** *)

staload "./../SATS/cstream.sats"

(* ****** ****** *)

typedef
cstruct = @{
  getc= (ptr) -> int
, free= (ptr) -> void
, data= @[ulint][0] // well-aligned
} (* end of [cstruct] *)

(* ****** ****** *)

datavtype
cstream = CS of cstruct
assume cstream_vtype(tk) = cstream

(* ****** ****** *)

implement
cstream_free
  (cs0) = () where
{
//
  val+@CS (cstruct) = cs0
  val () = cstruct.free (addr@(cstruct.data))
  val ((*void*)) = free@cs0
//
} // end of [cstream_free]

(* ****** ****** *)

implement
cstream_get_char
  (cs0) = ret where
{
//
  val+@CS (cstruct) = cs0
  val ret = cstruct.getc (addr@(cstruct.data))
  prval ((*void*)) = fold@cs0
//
} // end of [cstream_get_char]

(* ****** ****** *)

(* end of [cstream.dats] *)
