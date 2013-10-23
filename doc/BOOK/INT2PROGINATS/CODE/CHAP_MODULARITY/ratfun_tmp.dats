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
** A template-based functorial
** package for rational numbers
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

(* ****** ****** *)

staload "ratfun_tmp.sats"

(* ****** ****** *)

extern fun{a:t@ype} intgtz: a -> bool
implement{a} intgtz (x) = intgt (x, ofint0)

extern fun{a:t@ype} intgtez: a -> bool
implement{a} intgtez (x) = intgte (x, ofint0)

(* ****** ****** *)

implement{a} intlt (x, y) = intcmp (x, y) < 0
implement{a} intlte (x, y) = intcmp (x, y) <= 0

implement{a} intgt (x, y) = intcmp (x, y) > 0
implement{a} intgte (x, y) = intcmp (x, y) >= 0

implement{a} inteq (x, y) = intcmp (x, y) = 0
implement{a} intneq (x, y) = intcmp (x, y) <> 0

(* ****** ****** *)

implement{a}
intgcd (x, y) = let
  fun gcd (x: a, y: a): a =
    if intgtz (y) then gcd (y, x \intmod y) else x
  // end of [gcd]
in
  if intgtez (x) then
    if intgtez (y) then gcd (x, y) else gcd (x, intneg y)
  else
    if intgtez (y) then gcd (intneg x, y) else gcd (intneg x, intneg y)
  // end of [if]
end // end of [intgcd]

(* ****** ****** *)

assume rat (a:t@ype) = (a, a)

(* ****** ****** *)

implement{a}
rat_make_int_int (p, q) =
  rat_make_numer_denom (ofint (p), ofint (q))
// end of [rat_make_numer_denom]

implement{a}
rat_make_numer_denom (p, q) = let
//
(*
  val () = print ("rat_make_numer_denom: p = ")
  val () = fprint_int (stdout_ref, p)
  val () = print_newline ()
  val () = print ("rat_make_numer_denom: q = ")
  val () = fprint_int (stdout_ref, q)
  val () = print_newline ()
*)
//
  fun make (p: a, q: a): rat a = let
    val r = intgcd (p, q) in (p \intdiv r, q \intdiv r)
  end // end of [make]
in
  if intgtz (q)
    then make (p, q) else make (intneg p, intneg q)
  // end of [if]
end // end of [rat_make_numer_denom]

(* ****** ****** *)

implement{a}
fprint_rat (out, x) = {
  val () = fprint_int (out, x.0)
  val isint = intgt (x.1, ofint1)
  val () = if isint then {
    val () = fprint_string (out, "/")
    val () = fprint_int (out, x.1)
  } // end of [val]
} // end of [fprint_rat]

(* ****** ****** *)

implement{a} rat_numer (x) = x.0
implement{a} rat_denom (x) = x.1

(* ****** ****** *)

implement{a} ratneg (x) = (intneg (x.0), x.1)

(* ****** ****** *)

implement{a} ratneg (x) = (intneg (x.0), x.1)

implement{a}
ratadd (x, y) = let
  val p = intadd (x.0 \intmul y.1, x.1 \intmul y.0)
  val q = intmul (x.1, y.1)
in
  rat_make_numer_denom (p, q)
end // end of [ratadd]

implement{a}
ratsub (x, y) = let
  val p = intsub (x.0 \intmul y.1, x.1 \intmul y.0)
  val q = intmul (x.1, y.1)
in
  rat_make_numer_denom (p, q)
end // end of [ratadd]

implement{a}
ratmul (x, y) = let
  val p = intmul (x.0, y.0) and q = intmul (x.1, y.1)
in
  rat_make_numer_denom (p, q)
end // end of [ratadd]

implement{a}
ratdiv (x, y) = let
  val p = intmul (x.0, y.1)
  and q = intmul (x.1, y.0)
  val () = (if intgtz (q) then () else $raise DivisionByZero): void
in
  rat_make_numer_denom (p, q)
end // end of [ratadd]

(* ****** ****** *)

implement{a} ratlt (x, y) = ratcmp (x, y) < 0
implement{a} ratlte (x, y) = ratcmp (x, y) <= 0

implement{a} ratgt (x, y) = ratcmp (x, y) > 0
implement{a} ratgte (x, y) = ratcmp (x, y) >= 0

implement{a} rateq (x, y) = ratcmp (x, y) = 0
implement{a} ratneq (x, y) = ratcmp (x, y) <> 0

(* ****** ****** *)

implement{a}
ratcmp (x, y) = intcmp (x.0 \intmul y.1, x.1 \intmul y.0)

(* ****** ****** *)

(* end of [ratpoly_tmp.dats] *)
