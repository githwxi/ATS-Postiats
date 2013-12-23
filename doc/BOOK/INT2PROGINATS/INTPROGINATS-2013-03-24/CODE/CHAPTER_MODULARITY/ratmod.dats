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
** A package for rational numbers
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

staload "ratmod.sats"

(* ****** ****** *)

assume rat = (int, int)

(* ****** ****** *)

implement
rat_make_int_int (p, q) = let
  fun make (
    p: int, q: int
  ) : rat = let
    val r = gcd (p, q) in (p / r, q / r)
  end // end of [make]
//
  val () = if q = 0 then $raise Denominator
//
in
  if q > 0 then make (p, q) else make (~p, ~q)
end // end of [rat_make_int_int]

(* ****** ****** *)

implement
fprint_rat (out, x) = {
  val () = fprint_int (out, x.0)
  val () = if x.1 > 1 then {
    val () = fprint_string (out, "/")
    val () = fprint_int (out, x.1)
  } // end of [val]
} // end of [fprint_rat]

(* ****** ****** *)

implement rat_numer (x) = x.0
implement rat_denom (x) = x.1

(* ****** ****** *)

implement ratneg (x) = (~x.0, x.1)

implement
ratadd (x, y) =
  rat_make_int_int (x.0 * y.1 + x.1 * y.0, x.1 * y.1)
// end of [ratadd]

implement
ratsub (x, y) =
  rat_make_int_int (x.0 * y.1 - x.1 * y.0, x.1 * y.1)
// end of [ratsub]

implement
ratmul (x, y) = rat_make_int_int (x.0 * y.0, x.1 * y.1)

implement
ratdiv (x, y) =
  if y.0 > 0 then rat_make_int_int (x.0 * y.1, x.1 * y.0)
  else $raise DivisionByZero
// end of [ratdiv]

(* ****** ****** *)

(* end of [ratmod.dats] *)
