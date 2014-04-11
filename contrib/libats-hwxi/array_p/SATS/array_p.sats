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
//
absprop
array_p (a:viewt@ype+, l:addr, n:int)
//
(* ****** ****** *)
  
propdef
bytes_p (l:addr, n:int) = array_p (byte, l, n)
  
(* ****** ****** *)
//
praxi
array_p_assert
  {a:vt0p}{l:addr}{n:int}
  (p: ptr(l), n: size_t(n)): array_p(a, l, n)
//
(* ****** ****** *)

praxi
array_p_ofview
  {a:vt0p}{l:addr}{n:int}
  (pf: !array_v (a, l, n)): array_p (a, l, n)
// end of [array_p_ofview]

(* ****** ****** *)

fun{a:vt0p}
array_p_subcheck
  {l,l2:addr}{n,n2:int}
(
  array_p(a, l, n)
| p: ptr(l), n: size_t(n), p2: ptr(l2), n2: size_t(n2)
) : (array_p(a, l2, n2) | void)

(* ****** ****** *)

(* end of [array_p.sats] *)
