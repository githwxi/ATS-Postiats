(*
** Copyright (C) 2012 Hongwei Xi, Boston University
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
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
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

(* ****** ******)
//
// Author: Hongwei Xi (2012-03)
//
(* ****** ****** *)

staload "doc/EXAMPLE/ARITH/tally.sats"

(* ****** ****** *)

implement
sum1 (pf) = let
//
prfun sum1
  {n:nat}{s:int} .<n>. (
  pf: SUM2 (n, s)
) : [2*s==n*(n+1)] void =
  if n > 0 then let
    val SUM2ind (pf1) = pf
    val () = sum1 (n-1, pf1)
  in
    // nothing
  end else let
    val SUM2bas () = pf in (*nothing*)
  end // end of [if]
//
in
  sum1 (pf)
end // end of [sum1]

(* ****** ****** *)

implement
sum2 (pf) = let
//
prfun sum2
  {n:nat}{s:int} .<n>. (
  pf: SUM2 (n, s)
) : [6*s==n*(n+1)*(2*n+1)] void =
  if n > 0 then let
    val SUM2ind (pf1) = pf
    val () = sum2 (n-1, pf1)
  in
    // nothing
  end else let
    val SUM2bas () = pf in (*nothing*)
  end // end of [if]
//
in
  sum2 (pf)
end // end of [sum2]

(* ****** ****** *)

implement
sum3 (pf) = let
//
prfun sum3
  {n:nat}{s:int} .<n>. (
  pf: SUM3 (n, s)
) : [4*s==n*n*(n+1)*(n+1)] void =
  if n > 0 then let
    val SUM3ind (pf1) = pf
    val () = sum3 (n-1, pf1)
  in
    // nothing
  end else let
    val SUM3bas () = pf in (*nothing*)
  end // end of [if]
//
in
  sum3 (pf)
end // end of [sum3]

(* ****** ****** *)

(* end of [tally.dats] *)
