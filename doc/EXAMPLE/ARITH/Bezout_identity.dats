(*
** Copyright (C) 2013 Hongwei Xi, Boston University
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
// Author: Hongwei Xi
// Authoremail:
// gmhwxiATgmailDOTcom
// Start time: 2013-11
//
(* ****** ****** *)

absprop GCD (int, int, int)

(* ****** ****** *)
//
// Euclid's gcd algorithm
//
dataprop
EGCD (int(*m*), int(*n*), int(*g*)) = 
| {m:nat}
  EGCD0 (m, 0, m)
| {m:nat;n:pos}{r:int}{g:int}
  EGCD1 (m, n, g) of (MOD (m, n, r), EGCD (n, r, g))
// end of [EGCD]

(* ****** ****** *)
//
extern
praxi
GCD2EGCD
  {m,n:nat}{g:int} (pf: GCD (m, n, g)): EGCD (m, n, g)
// end of [GCD2EGCD]
//
extern
praxi
EGCD2GCD
  {m,n:nat}{g:int} (pf: EGCD (m, n, g)): GCD (m, n, g)
// end of [EGCD2GCD]
//
(* ****** ****** *)
//
// HX-2013-11-20:
// I became interested in this after seeing a related
// implementation by Allan Wirth.
//
//
(* ****** ****** *)
//
extern
prfun
lemma_bezout
  {m,n:nat}{g:int}
  (pf: GCD (m, n, g)): [x,y:int | m*x + n*y == g] void
//
(* ****** ****** *)

primplmnt
lemma_bezout (pf) = let
//
prfun aux
  {m,n:nat}
  {g:int} .<n>.
(
  pf: EGCD (m, n, g)
) : [x,y:int] EQINT (m*x + n*y, g) =
(
  case+ pf of
  | EGCD0 () => #[1,0 | EQINT ()]
  | EGCD1{m,n}{r}{g}
      ([q:int] pf_mod, pf_egcd) => let
      prval pf_mul = divmod_elim (pf_mod)
      prval ((*void*)) = mul_elim {q,n} (pf_mul)
      prval [x1:int,y1:int] EQINT () = aux (pf_egcd) // n*x1+r*y1 = g
      prval ((*void*)) = mul_isfun (mul_make{m,y1}(), mul_make{q*n+r,y1}())
    in
      #[y1, x1-q*y1 | EQINT ()] // m*y1 + n*(x1-q*y1) = q
    end // end of [EGCD1]
) (* end of [aux] *)
//
prval [x:int,y:int] EQINT () = aux (GCD2EGCD(pf))
//
in
  #[x, y | ()]
end // end of [lemma_bezout]

(* ****** ****** *)

(* end of [Bezout_identity.dats] *)
