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
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
staload
STDIO =
"libats/libc/SATS/stdio.sats"
//
(* ****** ****** *)

staload "./../SATS/cstream.sats"

(* ****** ****** *)

#define NUL '\000'

(* ****** ****** *)

typedef
cstruct = @{
  getc= (ptr) -> int
, free= (ptr) -> void
, data= FILEref
} (* end of [cstruct] *)

(* ****** ****** *)

datavtype cstream = CS of cstruct

(* ****** ****** *)

fun
cstream_getc
  (p: ptr): int = ret where
{
//
typedef data = FILEref
//
val (pf, fpf | p) = $UN.ptr0_vtake{data}(p)
//
val ret = $STDIO.fgetc0 (!p)
//
prval () = fpf (pf)
//
} (* end of [cstream_getc] *)

(* ****** ****** *)

fun cstream_free(p: ptr): void = ()

(* ****** ****** *)

implement
cstream_make_fileref
  (inp) = let
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
val () = cstruct.data := inp
//
in
  $UN.castvwtp0{cstream(TKfileref)}((view@cstruct | cs0))
end // end of [cstream_make_fileref]

(* ****** ****** *)

implement
cstream_getv_char<TKfileref>
  {n} (cs0, A, n) = let
//
val cs0 =
$UN.castvwtp1{cstream}(cs0)
//
val+CS(cstruct) = cs0
//
val n2 = $STDIO.fread0 (A, i2sz(1), i2sz(n), cstruct.data)
//
prval () = $UN.cast2void (cs0)
//
in
  sz2i(n2)
end // end of [cstream_getv_char]

(* ****** ****** *)

(* end of [cstream_fileref.dats] *)
