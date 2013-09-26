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

staload "./basics.sats"

(* ****** ****** *)
//
// HX: the defintion of fib function:
// fib(0) = 0; fib(1) = 1; fib(n+2)=fib(n)+fib(n+1)
//
dataprop
FIB (int, int) =
  | FIBbas1 (0, 0) of ()
  | FIBbas2 (1, 1) of ()
  | {n:nat}{r0,r1:int}
    FIBind (n+2, r0+r1) of (FIB (n, r0), FIB (n+1, r1))
// end of [FIB]

(* ****** ****** *)
//
// HX: [FIB] is a total functional relation
//
prfun fib_istot {n:nat} (): [r:nat] FIB (n, r)

prfun fib_isfun
  {n:nat}{r1,r2:int}
  (pf1: FIB (n, r1), pf2: FIB (n, r2)): [r1==r2] void
// end of [fib_isfun]
prfun fib_isfun2
  {n:nat}{r1,r2:int}
  (pf1: FIB (n, r1), pf2: FIB (n, r2)): EQINT (r1, r2)
// end of [fib_isfun2]

(* ****** ****** *)
//
// HX-2012-03:
// fib(m+n+1)=fib(m)*fib(n)+fib(m+1)*fib(n+1)
//
prfun fibeq1
  {m,n:nat}
  {r1,r2,r3,r4:int} (
  pf1: FIB (m, r1) // r1 = fib(m)
, pf2: FIB (n, r2) // r2 = fib(n)
, pf3: FIB (m+1, r3) // r3 = fib(m+1)
, pf4: FIB (n+1, r4) // r4 = fib(n+1)
) : FIB (m+n+1, r1*r2+r3*r4)

(* ****** ****** *)
//
// Cassini's formula states:
//
// fib(n)*fib(n+2) + (-1)^n = (fib(n+1))^2
//
(* ****** ****** *)

prfun
fibeq2
  {n:nat}{i:int}
  {f0,f1,f2:int} (
  pf0: FIB (n, f0)
, pf1: FIB (n+1, f1)
, pf2: FIB (n+2, f2)
, pf3: SGN (n, i)
) : [f0*f2 + i == f1*f1] void

(* ****** ****** *)

(* end of [fibonacci.sats] *)
