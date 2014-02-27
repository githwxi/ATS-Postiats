(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2014-02-06
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
extern
fun{a:vt0p}
array_insertsort$cmp
  (x1: &RD(a), x2: &RD(a)):<> int
extern
fun{a:vt0p}
array_insertsort
  {n:int}
(
  A: &(@[INV(a)][n]) >> @[a][n], n: size_t n
) :<!wrt> void // end of [array_insertsort]
//
implement
{a}(*tmp*)
array_insertsort$cmp
  (x1, x2) = gcompare_ref<a> (x1, x2)
//
implement
{a}(*tmp*)
array_insertsort
  {n}(A, n) = let
//
val p0 = addr@A
//
fun insord
  (p: ptr): void = let
in
//
if p > p0 then let
  val p1 = ptr_pred<a> (p)
  val (pf, fpf | p) = $UN.ptr0_vtake{a}(p)
  val (pf1, fpf1 | p1) = $UN.ptr0_vtake{a}(p1)
  val sgn = array_insertsort$cmp<a> (!p, !p1)
in
  if sgn < 0
    then let
      val () =
      ptr_exch<a> (pf | p, !p1)
      prval () = fpf (pf)
      prval () = fpf1 (pf1)
    in
      insord (p1)
    end // end of [then]
    else let
      prval () = fpf (pf)
      prval () = fpf1 (pf1)
    in
      // nothing
    end // end of [else]
  // end of [if]
end (* end of [if] *)
//
end // end of [insord]
//
fun
loop{n:nat} .<n>.
  (p: ptr, n: size_t (n)): void =
  if n > 0 then (insord (p); loop (ptr_succ<a> p, pred(n))) else ()
//
in
  if n >= 2 then $effmask_all (loop (ptr_succ<a> (p0), pred(n))) else ()
end // end of [array_insertsort]
//
(* ****** ****** *)

(* end of [insertsort.dats] *)
