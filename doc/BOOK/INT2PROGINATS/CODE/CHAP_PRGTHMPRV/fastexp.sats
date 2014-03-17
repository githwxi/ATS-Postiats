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

sortdef elt = int

(* ****** ****** *)

abst@ype ELT (a:t@ype, x:elt) = a

(* ****** ****** *)

absprop MUL (x: elt, y: elt, xy: elt) // abstract mul relation

praxi mul_istot {x,y:elt} (): [xy:elt] MUL (x, y, xy)
praxi mul_isfun {x,y:elt} {z1,z2:elt}
  (pf1: MUL (x, y, z1), pf2: MUL (x, y, z2)): [z1==z2] void
praxi mul_assoc {x,y,z:elt} {xy,yz:elt} {xy_z, x_yz:elt} (
  pf1: MUL (x, y, xy), pf2: MUL (xy, z, xy_z), pf3: MUL (y, z, yz), pf4: MUL (x, yz, x_yz)
) : [xy_z==x_yz] void

fun{
a:t@ype
} mulunit (): ELT (a, 1(*stamp*))

fun{
a:t@ype
} mul_elt_elt {x,y:elt}
  (x: ELT (a, x), y: ELT (a, y)): [xy:elt] (MUL (x, y, xy) | ELT (a, xy))
// end of [mul_elt_elt]

dataprop
POW (elt(*base*), int(*exp*), elt(*res*)) =
  | {x:elt} POWbas (x, 0, 1(*unit*))
  | {x:elt} {n:nat} {p,p1:elt}
    POWind (x, n+1, p1) of (POW (x, n, p), MUL (x, p, p1))
// end of [POW]

fun{
a:t@ype
} fastpow_elt_int {x:elt} {n:nat}
  (x: ELT (a, x), n: int n): [p:elt] (POW (x, n, p) | ELT (a, p))
// end of [fastpow_elt_int]

(* ****** ****** *)

(* end of fastexp.sats *)
