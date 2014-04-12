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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
STRING = "libc/SATS/string.sats"

(* ****** ****** *)

staload "./../SATS/array_p.sats"

(* ****** ****** *)

implement
{a}(*tmp*)
array_p_subcheck
  (pf | p, n, p2, n2) = let
//
val () = assert_errmsg (p <= p2, "array_p_subcheck:left-bound")
val () = assert_errmsg ($UN.cast2size(p2-p)/sizeof<a> = 0, "array_p_subcheck:alignment")
val () = assert_errmsg (n <= n2, "array_p_subcheck:right-bound")
//
prval pf2 = array_p_assert (p2, n2)
//
in
  (pf2 | ())
end // end of [array_p_subcheck]

(* ****** ****** *)
//
implement
{a}(*tmp*)
array_p_get0 (pf | p) = $UN.ptr0_get<a> (p)
implement
{a}(*tmp*)
array_p_set0 (pf | p, x) = $UN.ptr0_set<a> (p, x)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
array_p_get_at
  (pf | p, i) = $UN.ptr0_get<a> (ptr_add<a> (p, i))
implement
{a}(*tmp*)
array_p_set_at
  (pf | p, i, x) = $UN.ptr0_set<a> (ptr_add<a> (p, i), x)
//
(* ****** ****** *)

implement{
} array_p_memcpy
  (pf1, pf2 | p1, p2, n) = $STRING.memcpy_unsafe (p1, p2, n)

(* ****** ****** *)

implement{
} array_p_memmove
  (pf1, pf2 | p1, p2, n) = $STRING.memmove_unsafe (p1, p2, n)

(* ****** ****** *)

(* end of [array_p.dats] *)
