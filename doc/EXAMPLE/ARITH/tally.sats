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
//
// HX: these examples are primarily used to test the constraint-solver
// of ATS/Postiats (that is, ATS2)
//
(* ****** ****** *)

(*
//
// HX-2012-03-05:
// let q(n) range over all the polynomials that can be represented
// as p(n)-p(n-1) for some polynomial p; it is straigtforward to prove
// that any polynomial (in n) can be represented as a linear sum of q's.
//
stadef S0 (n:int) = n
stadef S1 (n:int) = (n*n+S0(n))/2 // n*(n+1)
stadef S2 (n:int) = (n*n*n+3*S1(n)-S0(n))/3
stadef S3 (n:int) = (n*n*n*n+6*S2(n)-4*S1(n)+S0(n))/4
stadef S4 (n:int) = (n*n*n*n*n+10*S3(n)-10*S2(n)+5*S1(n)-S0(n))/5
stadef S5 (n:int) = (n*n*n*n*n*n+15*S4(n)-20*S3(n)+15*S2(n)-6*S1(n)+S0(n))/6
*)

(* ****** ****** *)

dataprop
SUM1 (int, int) = 
  | SUM1bas (0, 0)
  | {n:pos}{s:int}
    SUM1ind (n, s + n) of SUM1 (n-1, s)
// end of [SUM1]

stadef cff1 = 2
stadef csum1 (n:int) = n*(n+1)
prfun sum1
  {n:nat}{s:int}
  (pf: SUM1 (n, s)) : [cff1*s==csum1(n)] void
// end of [sum1]

(* ****** ****** *)

dataprop
SUM2 (int, int) = 
  | SUM2bas (0, 0)
  | {n:pos}{s:int}
    SUM2ind (n, s + n*n) of SUM2 (n-1, s)
// end of [SUM2]

stadef cff2 = 6
stadef csum2 (n:int) = n*(n+1)*(2*n+1)
prfun sum2
  {n:nat}{s:int}
  (pf: SUM2 (n, s)) : [cff2*s==csum2(n)] void
// end of [sum2]

(* ****** ****** *)

dataprop
SUM3 (int, int) = 
  | SUM3bas (0, 0)
  | {n:pos}{s:int}
    SUM3ind (n, s + n*n*n) of SUM3 (n-1, s)
// end of [SUM3]

stadef cff3 = 4
stadef csum3 (n:int) = n*n*(n+1)*(n+1)
prfun sum3
  {n:nat}{s:int}
  (pf: SUM3 (n, s)) : [4*s==csum3(n)] void
// end of [sum3]

(* ****** ****** *)

dataprop
SUM4 (int, int) = 
  | SUM4bas (0, 0)
  | {n:pos}{s:int}
    SUM4ind (n, s + n*n*n*n) of SUM4 (n-1, s)
// end of [SUM4]

stadef cff4 = 30
stadef csum4
  (n:int) = n*(n+1)*(2*n+1)*(3*n*n+3*n-1)
prfun sum4
  {n:nat}{s:int}
  (pf: SUM4 (n, s)) : [cff4*s==csum4(n)] void
// end of [sum4]

(* ****** ****** *)

dataprop
SUM5 (int, int) = 
  | SUM5bas (0, 0)
  | {n:pos}{s:int}
    SUM5ind (n, s + n*n*n*n*n) of SUM5 (n-1, s)
// end of [SUM5]

stadef cff5 = 12
stadef csum5
  (n:int) = n*n*(n+1)*(n+1)*(2*n*n+2*n-1)
prfun sum5
  {n:nat}{s:int}
  (pf: SUM5 (n, s)) : [cff5*s==csum5(n)] void
// end of [sum5]

(* ****** ****** *)

dataprop
SUM6 (int, int) = 
  | SUM6bas (0, 0)
  | {n:pos}{s:int}
    SUM6ind (n, s + n*n*n*n*n*n) of SUM6 (n-1, s)
// end of [SUM6]

stadef cff6 = 42
stadef csum6
  (n:int) = n*(n+1)*(2*n+1)*(3*n*n*n*n+6*n*n*n-3*n+1)
prfun sum6
  {n:nat}{s:int}
  (pf: SUM6 (n, s)) : [cff6*s==csum6(n)] void
// end of [sum6]

(* ****** ****** *)

dataprop
SUM7 (int, int) = 
  | SUM7bas (0, 0)
  | {n:pos}{s:int}
    SUM7ind (n, s + n*n*n*n*n*n*n) of SUM7 (n-1, s)
// end of [SUM7]

stadef cff7 = 24
stadef csum7
  (n:int) = n*n*(n+1)*(n+1)*(3*n*n*n*n+6*n*n*n-n*n-4*n+2)
prfun sum7
  {n:nat}{s:int}
  (pf: SUM7 (n, s)) : [cff7*s==csum7(n)] void
// end of [sum7]

(* ****** ****** *)

dataprop
SUM8 (int, int) = 
  | SUM8bas (0, 0)
  | {n:pos}{s:int}
    SUM8ind (n, s + n*n*n*n*n*n*n*n) of SUM8 (n-1, s)
// end of [SUM8]

stadef cff8 = 90
stadef csum8
  (n:int) = n*(n+1)*(2*n+1)*((((((5*n+15)*n+5)*n-15)*n-1)*n+9)*n-3)
prfun sum8
  {n:nat}{s:int}
  (pf: SUM8 (n, s)) : [cff8*s==csum8(n)] void
// end of [sum8]

(* ****** ****** *)

dataprop
SUM9 (int, int) = 
  | SUM9bas (0, 0)
  | {n:pos}{s:int}
    SUM9ind (n, s + n*n*n*n*n*n*n*n*n) of SUM9 (n-1, s)
// end of [SUM9]

stadef cff9 = 20
stadef csum9
  (n:int) = n*n*(n+1)*(n+1)*(n*n+n-1)*(2*n*n*n*n+4*n*n*n-n*n-3*n+3)
prfun sum9
  {n:nat}{s:int}
  (pf: SUM9 (n, s)) : [cff9*s==csum9(n)] void
// end of [sum9]

(* ****** ****** *)

dataprop
SUM10 (int, int) = 
  | SUM10bas (0, 0)
  | {n:pos}{s:int}
    SUM10ind (n, s + n*n*n*n*n*n*n*n*n*n) of SUM10 (n-1, s)
// end of [SUM10]

stadef cff10 = 66
stadef csum10
  (n:int) = n*(n+1)*(2*n+1)*(n*n+n-1)*((((((3*n+9)*n+2)*n-11)*n+3)*n+10)*n-5)
prfun sum10
  {n:nat}{s:int}
  (pf: SUM10 (n, s)) : [cff10*s==csum10(n)] void
// end of [sum10]

(* ****** ****** *)

(* end of [tally.sats] *)
