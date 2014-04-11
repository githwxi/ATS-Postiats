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
array_p (a:t@ype+, l:addr, n:int)
//
(* ****** ****** *)
  
propdef
bytes_p (l:addr, n:int) = array_p (byte, l, n)
  
(* ****** ****** *)
//
praxi
array_p_tail
  {a:t0p}
  {l:addr}
  {n:int | n > 0}
(
  pf: array_p (INV(a), l, n)
) : array_p (a, l+sizeof(a), n-1)
//
overload .tail with array_p_tail
//
(* ****** ****** *)
//
praxi
array_p_assert
  {a:t0p}{l:addr}{n:int}
  (p: ptr(l), n: size_t(n)): array_p(a, l, n)
//
(* ****** ****** *)

praxi
array_p_ofview
  {a:t0p}{l:addr}{n:int}
  (pf: !array_v (INV(a), l, n)): array_p (a, l, n)
// end of [array_p_ofview]

(* ****** ****** *)

fun{
a:t0p
} array_p_subcheck
  {l,l2:addr}{n,n2:int}
(
  array_p(INV(a), l, n)
| p: ptr(l), n: size_t(n), p2: ptr(l2), n2: size_t(n2)
) :<!exn> (array_p(a, l2, n2) | void)

(* ****** ****** *)
//
fun{
a:t0p
} array_p_get0
  {l:addr}{n:pos}
  (pf: array_p(INV(a), l, n) | p: ptr(l)):<!wrt> (a)
fun{
a:t0p
} array_p_set0
  {l:addr}{n:pos}
  (pf: array_p(INV(a), l, n) | p: ptr(l), x: a):<!wrt> void
//
(* ****** ****** *)
//
fun{
a:t0p
} array_p_get_at
  {l:addr}{n:int}
  (pf: array_p(INV(a), l, n) | ptr(l), sizeLt(n)):<!wrt> (a)
fun{
a:t0p
} array_p_set_at
  {l:addr}{n:int}
  (pf: array_p(INV(a), l, n) | ptr(l), sizeLt(n), a):<!wrt> void
//
(* ****** ****** *)

fun{
} array_p_memcpy
  {l1,l2:addr}
  {n,n1,n2:int | n <= n1; n <= n2}
(
  pf1: bytes_p (l1, n1), pf2: bytes_p (l2, n2) | ptr(l1), ptr(l2), size_t(n)
) :<!wrt> ptr(l1) // end of [array_p_memcpy]

(* ****** ****** *)

fun{
} array_p_memmove
  {l1,l2:addr}
  {n,n1,n2:int | n <= n1; n <= n2}
(
  pf1: bytes_p (l1, n1), pf2: bytes_p (l2, n2) | ptr(l1), ptr(l2), size_t(n)
) :<!wrt> ptr(l1) // end of [array_p_memmove]

(* ****** ****** *)

(* end of [array_p.sats] *)
