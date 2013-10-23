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
** A record-based functorial
** package for rational numbers
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

staload "ratfun_rec.sats"

(* ****** ****** *)

assume rat (a:t@ype) = (a, a)

(* ****** ****** *)

fun{a:t@ype}
intgcd (
  int: intmod a, x: a, y: a
) : a = let
//
  macdef intneg (x) = int.neg (,(x))  
  macdef intmod (x, y) = int.mod (,(x), ,(y))
  macdef intgtz (x) = int.cmp (,(x), int.ofint(0)) > 0
  macdef intgtez (x) = int.cmp (,(x), int.ofint(0)) >= 0
//
  fun gcd (x: a, y: a):<cloref1> a =
    if intgtz (y) then gcd (y, x \intmod y) else x
  // end of [gcd]
in
  if intgtez (x) then
    if intgtez (y) then gcd (x, y) else gcd (x, intneg y)
  else
    if intgtez (y) then gcd (intneg x, y) else gcd (intneg x, intneg y)
  // end of [if]
end // end of [intgcd]

implement{a}
ratmod_make_intmod (int) = let
  typedef rat = rat (a)
//
  macdef intneg (x) = int.neg (,(x))
  macdef intadd (x, y) = int.add (,(x), ,(y))
  macdef intsub (x, y) = int.sub (,(x), ,(y))
  macdef intmul (x, y) = int.mul (,(x), ,(y))
  macdef intdiv (x, y) = int.div (,(x), ,(y))
//
  macdef intcmp (x, y) = int.cmp (,(x), ,(y))
  macdef intgtz (x) = intcmp (,(x), int.ofint(0)) > 0
//
  fun make0 (p: a, q: a):<cloref1> rat a = let
    val r = intgcd (int, p, q) in (p \intdiv r, q \intdiv r)
  end // end of [make]
  fun make (p: a, q: a):<cloref1> rat a =
    if intgtz (q)
      then make0 (p, q) else make0 (intneg p, intneg q)
    // end of [if]
  (* end if [make] *)
//
in '{
  make= make
, fprint= lam (out, x) => {
    val () = int.fprint (out, x.0)
    val () = fprint_string (out, "/")
    val () = int.fprint (out, x.1)
  } // end of [val]
, numer= lam (x) => x.0
, denom= lam (x) => x.1
, neg= lam (x) => (intneg (x.0), x.1)
, add= lam (x, y) => let
    val p = intadd (x.0 \intmul y.1, x.1 \intmul y.0)
    val q = intmul (x.1, y.1)
  in
    make (p, q)
  end // end of [ratadd]
, sub= lam (x, y) => let
    val p = intsub (x.0 \intmul y.1, x.1 \intmul y.0)
    val q = intmul (x.1, y.1)
  in
    make (p, q)
  end // end of [ratsub]
, mul= lam (x, y) => let
    val p = intmul (x.0, y.0)
    val q = intmul (x.1, y.1)
  in
    make (p, q)
  end // end of [ratmul]
, div= lam (x, y) => let
    val p = intmul (x.0, y.1)
    val q = intmul (x.1, y.0)
  in
    make (p, q)
  end // end of [ratdiv]
, cmp= lam (x, y) => intcmp (x.0 \intmul y.1, x.1 \intmul y.0)
} end // end of [ratmod_make_intmod]

(* ****** ****** *)

(* end of [ratfun_rec.dats] *)
