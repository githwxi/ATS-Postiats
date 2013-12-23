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
** Example: Binary Search
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

fun bsearch_fun (
  f: int -> uint
, x0: uint, lb: int, ub: int
) : int =
  if lb <= ub then let
    val mid = lb + (ub - lb) / 2
    val x = f (mid)
  in
    if x0 < x then
      bsearch_fun (f, x0, lb, mid-1)
    else
      bsearch_fun (f, x0, mid+1, ub)
    // end of [if]
  end else ub // end of [if]
// end of [bsearch_fun]

(* ****** ****** *)

val ISQRT_MAX = (1 << 16) - 1
fun isqrt (x: uint): int =
  bsearch_fun (lam i => square ((uint_of)i), x, 0, ISQRT_MAX)
// end of [isqrt]

(* ****** ****** *)

val () = assertloc (isqrt (100U) = 10)
val () = assertloc (isqrt (1000U) = 31)
val () = assertloc (isqrt (1024U) = 32)

(* ****** ****** *)

implement main () = () where {
  val () = println! ("[bsearch] is tested successfully.")
} // end of [main]

(* ****** ****** *)

(* end of [bsearch.dats] *)
