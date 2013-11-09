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

extern
fun{
a:t@ype
} matrix_get
  {m,n:int}{i,j:nat | i < m; j < n}
  (A: arrayref (a, m*n), col: int n, i: int i, j: int j): a
// end of [matrix_get]

(* ****** ****** *)

(*
implement{a}
matrix_get (A, n, i, j) = A[i*n+j] // it fails to typecheck!!!
*)

(* ****** ****** *)

extern
prfun mul_istot{i,j:int} (): [ij:int] MUL (i, j, ij)

extern
prfun mul_isfun
  {i,j:int}{ij1,ij2:int}
  (pf1: MUL (i, j, ij1), pf2: MUL (i, j, ij2)): [ij1==ij2] void

extern
prfun mul_elim
  {i,j:int}{ij:int} (pf: MUL (i, j, ij)): [i*j==ij] void

extern
prfun mul_nat_nat_nat
  {i,j:nat}{ij:int} (pf: MUL (i, j, ij)): [ij >= 0] void

extern
prfun mul_distribute2
  {i1,i2:int}{j:int}{i1j,i2j:int}
  (pf1: MUL (i1, j, i1j), pf2: MUL (i2, j, i2j)): MUL (i1+i2, j, i1j+i2j)

(* ****** ****** *)

extern
fun imul2{i,j:int}
  (i: int i, j: int j): [ij:int] (MUL (i, j, ij) | int ij)

(* ****** ****** *)

implement
{a}(*tmp*)
matrix_get
  {m,n}{i,j}
  (A, n, i, j) = let
//
  val (pf_i_n | _i_n) = imul2 (i, n)
  prval () = mul_nat_nat_nat (pf_i_n)
  prval () = mul_gte_gte_gte{m-1-i,n} ()
  prval () = mul_elim (pf_i_n)
//
in
  A[_i_n+j]
end // end of [matrix_get]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [matget.dats] *)
