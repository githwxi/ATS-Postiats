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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/cstream.sats"

(* ****** ****** *)

typedef
cstruct = @{
  getc= (ptr) -> int
, free= (ptr) -> void
, data= @(string, ptr)
} (* end of [cstruct] *)

(* ****** ****** *)

datavtype cstream = CS of cstruct

(* ****** ****** *)

#define NUL '\000'

(* ****** ****** *)

fun cstream_getc
  (p: ptr): int = i where
{
//
typedef data = @(string, ptr)
//
val (pf, fpf | p) = $UN.ptr0_vtake{data}(p)
//
val p1 = p->1
//
val c = $UN.ptr0_get<char> (p1)
val i = (if c != NUL then char2u2int0(c) else ~1): int
val () = if i >= 0 then p->1 := ptr_succ<char> (p1) 
//
prval () = fpf (pf)
//
} (* end of [cstream_getc] *)

(* ****** ****** *)

fun cstream_free (p: ptr): void = ()

(* ****** ****** *)

implement
cstream_make_string
  (str0) = let
//
val cs0 = CS (_)
val+CS(cstruct) = cs0
//
val () =
cstruct.getc := cstream_getc
//
val () =
cstruct.free := cstream_free
//
val p0 = string2ptr(str0)
val () = cstruct.data := @(str0, p0)
//
in
  $UN.castvwtp0{cstream(TKstring)}((view@cstruct | cs0))
end // end of [cstream_make_string]

(* ****** ****** *)

(* end of [cstream_string.dats] *)
