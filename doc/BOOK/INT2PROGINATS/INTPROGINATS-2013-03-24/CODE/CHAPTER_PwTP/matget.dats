(*
** Copyright (C) 2011 Hongwei Xi, Boston University
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

(* ****** ****** *)

(*
**
** Some code used in the book INTPROGINATS
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: August, 2011
**
*)

(* ****** ****** *)

extern fun{a:t@ype}
matget {m,n:nat} {i,j:nat | i < m; j < n}
  (A: array (a, m*n), col: int n, i: int i, j: int j): a
// end of [matget]

(* ****** ****** *)

(*
implement{a} matget (A, n, i, j) = A[i*n+j] // it fails to typecheck!!!
*)

(* ****** ****** *)

(*
extern
fun imul2 {i,j:int}
  (i: int i, j: int j): [ij:int] (MUL (i, j, ij) | int ij)

extern
prfun mul_istot {i,j:int} (): [ij:int] MUL (i, j, ij)

extern;
prfun mul_isfun {i,j:int} {ij1, ij2: int}
  (pf1: MUL (i, j, ij1), pf2: MUL (i, j, ij2)): [ij1==ij2] void

extern
prfun mul_elim
  {i,j:int} {ij:int} (pf: MUL (i, j, ij)): [i*j==ij] void

extern
prfun mul_nat_nat_nat
  {i,j:nat} {ij:int} (pf: MUL (i, j, ij)): [ij >= 0] void

extern
prfun mul_distribute2
  {i1,i2:int} {j:int} {i1j,i2j:int}
  (pf1: MUL (i1, j, i1j), pf2: MUL (i2, j, i2j)): MUL (i1+i2, j, i1j+i2j)
*)

implement{a}
matget {m,n} {i,j} (A, n, i, j) = let
//
  val (pf_in | _in) = i imul2 n // pf_in: MUL (i, n, _in)
  prval () = mul_nat_nat_nat (pf_in) // _in >= 0
//
  prval pf_mn = mul_istot {m,n} () // pf1_mn: MUL (m, n, _mn)
  prval () = mul_elim (pf_mn) // _mn = m*n
  prval MULind (pf_m1n) = pf_mn // _m1n = (m-1)*n = m*n-n
//
  stadef i1 = m-1-i
  prval pf_i1n = mul_istot {i1,n} () // pf_i1n: MUL (i1, n, _i1n)
  prval () = mul_nat_nat_nat (pf_i1n) // _i1n >= 0
//
  prval pf2_m1n = mul_distribute2 (pf_in, pf_i1n) // _m1n = _in + _i1n
  prval () = mul_isfun (pf_m1n, pf2_m1n) // _mn - n = _in + _i1n 
//
in
  A[_in+j]
end // end of [matget]

(* ****** ****** *)

implement main () = ()

(* ****** ****** *)

(* end of [matget.dats] *)
