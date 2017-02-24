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
, data= ((*void*)) -<cloref1> int
} (* end of [cstruct] *)

(* ****** ****** *)

datavtype cstream = CS of cstruct

(* ****** ****** *)

fun cstream_getc
  (p: ptr): int = ret where
{
//
typedef
data = ((*void*)) -<cloref> int
//
val (pf, fpf | p) = $UN.ptr0_vtake{data}(p)
//
val ret = !p()
//
prval () = fpf (pf)
//
} (* end of [cstream_getc] *)

(* ****** ****** *)

fun cstream_free (p: ptr): void = ()

(* ****** ****** *)

implement
cstream_make_cloref
  (getc) = let
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
val () = cstruct.data := getc
//
in
  $UN.castvwtp0{cstream(TKcloref)}((view@cstruct | cs0))
end // end of [cstream_make_cloref]

(* ****** ****** *)

(* end of [cstream_cloref.dats] *)
