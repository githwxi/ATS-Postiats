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
** Example: Estimating the Constant Pi
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail hwxiATcsDOTbuDOTedu
** Time: January, 2011
*)

(* ****** ****** *)

(*
** Ported to ATS2 by HX-2013-09
*)

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

staload MATH = "libc/SATS/math.sats"
staload _(*MATH*) = "libc/DATS/math.dats"

(* ****** ****** *)

staload TIME = "libc/SATS/time.sats"
staload STDLIB = "libc/SATS/stdlib.sats"

(* ****** ****** *)

#define N 1000

(* ****** ****** *)

typedef
point = @{
  x= float, y= float
} // end of [point]

typedef pnt = point
typedef pntlst = list0 (pnt)

(* ****** ****** *)

fun pntdist
(
  p1: pnt, p2: pnt
) : float = let
  val df_x = p1.x - p2.x
  and df_y = p1.y - p2.y
in
  $MATH.sqrt (df_x * df_x + df_y * df_y)
end // end of [pntdist]

(* ****** ****** *)

fun nhit
(
  p0: pnt, ps: pntlst, cnt: int
) : int =
  case+ ps of
  | list0_cons (p, ps) =>
      if pntdist (p0, p) <= 1.0f
        then nhit (p0, ps, cnt+1) else nhit (p0, ps, cnt)
      // end of [if]
  | list0_nil () => cnt
// end of [nhit]

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

val theGrid =
  mtrxszref_make_elt<pntlst> (i2sz(N), i2sz(N), list0_nil)
// end of [val]

(* ****** ****** *)

fun do_one (): int = let
//
// make sure that x and y are in the interval [0, 1)
//
  #define ALPHA 0.999999
  val x = $UN.cast{float}(ALPHA * $STDLIB.drand48 ())
  val y = $UN.cast{float}(ALPHA * $STDLIB.drand48 ())
//
  val p0_x = N*x and p0_y = N*y
  val p0 = @{x= p0_x, y= p0_y} : pnt
  val i0 = g0float2int_float_int (p0_x)
  and j0 = g0float2int_float_int (p0_y)
//
  fnx loop1 (
    i: int, cnt: int
  ) :<cloref1> int =
    if i >= 0 then
      if i <= i0+1 andalso i < N
        then loop2 (i, j0-1, cnt) else cnt
      // end of [if]
    else loop1 (i+1, cnt)
//
  and loop2 (
    i: int, j: int, cnt: int
  ) :<cloref1> int =
    if j >= 0 then
      if j <= j0+1 andalso j < N then let
        val cnt = nhit (p0, theGrid[i,j], cnt)
      in
        loop2 (i, j+1, cnt)
      end else
        loop1 (i+1, cnt)
      // end of [if]
    else
      loop2 (i, j+1, cnt)
    // end of [if]
//
  val cnt = loop1 (i0-1, 0)
  val () = theGrid[i0,j0] := list0_cons{pnt}(p0, theGrid[i0,j0])
//
in
  cnt  
end // end of [do_one]

(* ****** ****** *)

fun
do_many (
  K: int, i: int, cnt: int
) : int =
  if i < K then do_many (K, i+1, cnt + do_one ()) else cnt
// end of [do_many]

(* ****** ****** *)

implement
main0 () =
{
//
val seed =
$UN.cast2lint($TIME.time_get())
val () = $STDLIB.srand48 (seed)
//
val N2 = N * N
val cnt = do_many (N2, 0, 0)
val Pi = 2.0 * cnt / (N2 - 1)
val () = (print "Pi = "; print Pi; print_newline ())
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [montecarlo.dats] *)
