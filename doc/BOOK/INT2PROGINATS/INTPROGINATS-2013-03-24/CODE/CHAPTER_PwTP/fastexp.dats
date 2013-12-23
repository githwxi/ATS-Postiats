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
** Time: August, 2011
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

staload "fastexp.sats"

(* ****** ****** *)

implement{a}
fastpow_elt_int (x, n) = let
//
// lemma: (x*x)^n = x^(2n)
//
(*
extern prfun
lemma {x:elt} {xx:elt} {n:nat} {y:elt}
  (pfxx: MUL (x, x, xx), pfpow: POW (xx, n, y)): POW (x, 2*n, y)
*)
prfun lemma
  {x:elt} {xx:elt} {n:nat} {y:elt} .<n>.
  (pfxx: MUL (x, x, xx), pfpow: POW (xx, n, y)): POW (x, 2*n, y) =
  sif n > 0 then let
    prval POWind {xx} {n1} {y1,y} (pf1pow, pf2mul) = pfpow
    prval pf1pow_res = lemma (pfxx, pf1pow) // pf1pow_res: x^(2n-2) = y1
    prval [xy1:elt] pfxy1 = mul_istot {x,y1} ()
    prval [xxy1:elt] pfxxy1 = mul_istot {x,xy1} ()
    prval () = mul_assoc (pfxx, pf2mul, pfxy1, pfxxy1)
  in
    POWind (POWind (pf1pow_res, pfxy1), pfxxy1)
  end else let
    prval POWbas () = pfpow in POWbas ()
  end (* end of [sif] *)
// end of [lemma]
//
in
  if n > 0 then let
    val n2 = n / 2; val i = n - (n2+n2)
    val (pfxx | xx) = mul_elt_elt (x, x) // xx = x*x
    val (pfpow2 | res) = fastpow_elt_int<a> (xx, n2) // xx^n2 = res
    prval pfpow = lemma (pfxx, pfpow2) // pfpow: x^(2*n2) = res
  in
    if i > 0 then let
      val (pfmul | xres) = mul_elt_elt<a> (x, res) // xres = x*res
    in
      (POWind (pfpow, pfmul) | xres)
    end else (pfpow | res)
  end else let
    val res = mulunit<a> () in (POWbas () | res) // res = 1
  end (* end of [if] *)
end // end of [fastpow_elt_int]

(* ****** ****** *)

(* end of [fastexp.dats] *)
