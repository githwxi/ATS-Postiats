(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2012 Hongwei Xi, ATS Trustful Software, Inc.
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
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
** THE SOFTWARE.
** 
*)

(* ****** ****** *)

(*
** Functions
** for left-folding aggregates
*)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/foldleft.sats"

(* ****** ****** *)

implement{res}
foldleft_int (n, ini) = let
//
fun loop
  {n:int}
  {i:nat | i <= n} .<n-i>. (
  n: int n, i: int i, acc: res
) : res =
(
  if i < n then let
    val acc = foldleft_int$fwork<res> (acc, i) in loop (n, succ(i), acc)
  end else acc // end of [if]
) (* end of [loop] *)
//
in
  loop (n, 0, ini)
end // end of [foldleft_int]

(* ****** ****** *)

implement
{x}{res}
foldleft_list
  (xs, ini) = let
//
 prval () = lemma_list_param (xs)
//
fun loop
  {n:nat} .<n>.
(
  xs: list (x, n), acc: res
) : res =
(
  case+ xs of
  | list_cons
      (x, xs) => let
      val acc = foldleft_list$fwork<x><res> (acc, x)
    in
      loop (xs, acc)
    end // end of [list_cons]
  | list_nil () => acc
) (* end of [loop] *)
//
in
  loop (xs, ini)
end // end of [foldleft_list]

(* ****** ****** *)

implement
{x}{res}
foldleft_list_vt
  (xs, ini) = let
//
prval () = lemma_list_vt_param (xs)
//
fun loop
  {n:nat} .<n>. (
  xs: !list_vt (x, n), acc: res
) : res =
(
  case+ xs of
  | @list_vt_cons
      (x, xs1) => let
      val acc = foldleft_list_vt$fwork<x><res> (acc, x)
      val res = loop (xs1, acc)
      prval () = fold@ (xs)
    in
      res
    end // end of [list_cons]
  | list_vt_nil () => acc
) (* end of [loop] *)
//
in
  loop (xs, ini)
end // end of [foldleft_list_vt]

(* ****** ****** *)

implement
{a}{res}
foldleft_array
  (A, n, ini) = let
//
prval () = lemma_array_param (A)
//
fun loop
  {l:addr}
  {n:nat} .<n>.
(
  pf: !array_v (a, l, n)
| p: ptr l, n: size_t n, acc: res
) : res =
(
  if n > 0 then let
    prval (pf1, pf2) = array_v_uncons (pf)
    val acc = foldleft_array$fwork<a><res> (acc, !p)
    val res = loop (pf2 | ptr1_succ<a> (p), pred(n), acc)
    prval () = pf := array_v_cons (pf1, pf2)
  in
    res
  end else acc // end of [if]
) (* end of [loop] *)
//
in
  loop (view@(A) | addr@(A), n, ini)
end // end of [foldleft_array]

(* ****** ****** *)

(* end of [foldleft.dats] *)
