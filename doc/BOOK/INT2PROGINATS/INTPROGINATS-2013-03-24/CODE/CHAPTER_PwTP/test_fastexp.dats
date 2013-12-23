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
** Example: Verified Fast Exponentiation
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: November, 2011
*)

(* ****** ****** *)

typedef
mat2x2_def = (int, int, int, int)
abst@ype mat2x2 = mat2x2_def

extern
fun make_mat2x2
  (x11: int, x12: int, x21: int, x22: int): mat2x2
// end of [make_mat2x2]

extern fun mat2x2_get11 (M: mat2x2): int
extern fun mat2x2_get12 (M: mat2x2): int
extern fun mat2x2_get21 (M: mat2x2): int
extern fun mat2x2_get22 (M: mat2x2): int

extern
fun mulunit_mat2x2 (): mat2x2
extern
fun mul_mat2x2_mat2x2 (M1: mat2x2, M2: mat2x2): mat2x2

extern
fun fastpow_mat2x2_int {n:nat} (M: mat2x2, n: int n): mat2x2

(* ****** ****** *)

local

assume mat2x2 = mat2x2_def // row-major

in (* in of [local] *)

implement
make_mat2x2
  (x11, x12, x21, x22) = (x11, x12, x21, x22) 
// end of [make_mat2x2]

implement mat2x2_get11 (M) = M.0
implement mat2x2_get12 (M) = M.1
implement mat2x2_get21 (M) = M.2
implement mat2x2_get22 (M) = M.3

implement
mulunit_mat2x2 () = (1, 0, 0, 1)

implement
mul_mat2x2_mat2x2 (x, y) = (
  x.0 * y.0 + x.1 * y.2, x.0 * y.1 + x.1 * y.3 
, x.2 * y.0 + x.3 * y.2, x.2 * y.1 + x.3 * y.3
) // end of [mul_mat2x2_mat2x2]

end // end of [local]

(* ****** ****** *)

fun fprint_mat2x2
  (out: FILEref, M: mat2x2): void = {
  val () = fprint_string (out, "(")
  val () = fprint_int (out, mat2x2_get11 (M))
  val () = fprint_string (out, ", ")
  val () = fprint_int (out, mat2x2_get12 (M))
  val () = fprint_string (out, ", ")
  val () = fprint_int (out, mat2x2_get21 (M))
  val () = fprint_string (out, ", ")
  val () = fprint_int (out, mat2x2_get22 (M))
  val () = fprint_string (out, ")")
}

(* ****** ****** *)

staload "fastexp.sats"
staload _(*anon*) = "fastexp.dats"

local

assume E (a:t@ype, x: elt) = a
assume MUL (x:elt, y: elt, xy: elt) = unit

in (* in of [local] *)

implement
mulunit<mat2x2> () = mulunit_mat2x2 ()

implement
mul_elt_elt<mat2x2> (x, y) =
  (unit () | mul_mat2x2_mat2x2 (x, y))
// end of [mul_elt_elt]

implement
fastpow_mat2x2_int (M, n) = let
  val (pf | res) = fastpow_elt_int<mat2x2> (M, n) in res
end // end of [fastpow_mat2x2_int]

end // end of [local]

(* ****** ****** *)

(*

Fibonacci numbers are defined as follows:

fib(0)   = 0
fib(1)   = 1
fib(n+2) = fib(n) + fib(n+1) for n >= 0

Here is a fast way to compute Fibonacci numbers.

Let vfib(n) = (fib(n), fib(n+1)) and vfibT(n) be the transpose of
vfib(n). Then we have

vfibT(n+1) = M vfibT(n), where M is the following 2-by-2 matrix:

0 1
1 1

Therefore, vfibT(n) = M^n vfibT(0), where M^n is the nth power of M.
Given that vfib(0) = (0, 1), we know that fib(n) is the number at the
upper right corner of M^n.

*)

fun fib {n:nat}
  (n: int n): int = let
  val M = make_mat2x2 (0, 1, 1, 1)
  val Mn = fastpow_mat2x2_int (M, n)
//
(*
  val out = stdout_ref
  val () = fprintf (out, "fib: M%i = ", @(n))
  val () = fprint_mat2x2 (out, Mn)
  val () = fprint_newline (out)
*)
//
in
  mat2x2_get12 (Mn)
end // end of [fib]

(* ****** ****** *)

implement
main () = {
  val () = println! ("fib(0) = ", fib(0))
  val () = println! ("fib(1) = ", fib(1))
  val () = println! ("fib(2) = ", fib(2))
  val () = println! ("fib(10) = ", fib(10))
  val () = println! ("fib(20) = ", fib(20))
  val () = println! ("fib(30) = ", fib(30))
  val () = println! ("fib(40) = ", fib(40))
} // end of [main]

(* ****** ****** *)

(* end of [test_fastexp.dats] *)
