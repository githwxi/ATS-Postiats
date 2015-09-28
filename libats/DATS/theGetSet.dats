(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2015 Hongwei Xi, ATS Trustful Software, Inc.
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
// Various Common
// generic get-set-templates
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/theGetSet.sats"

(* ****** ****** *)

implement
{a}(*tmp*)
the_getall_list_exn
  ((*void*)) =
(
  list_vt_reverse(the_getall_rlist_exn<a>())
) (* end of [the_getall_list_exn] *)

(* ****** ****** *)

implement
{a}(*tmp*)
the_getall_rlist_exn
  ((*void*)) = let
//
vtypedef
res_vt = List0_vt(a)
//
fun
loop
(
  p: ptr
) : void = loop(p) where
{
  val x =
    the_get_elt_exn()
  val xs =
    $UN.ptr0_get<res_vt>(p)
  val () =
    $UN.ptr0_set<res_vt>(p, cons_vt{a}(x, xs))
} (* end of [loop] *)
//
var
res: ptr =
  list_vt_nil()
//
val ((*void*)) =
(
  try loop(addr@res) with ~Exception_the_get_elt_exn() => ()
) : void // end of [val]
//
in
  res
end // end of [the_getall_rlist_exn]

(* ****** ****** *)

(* end of [theGetSet.dats] *)
