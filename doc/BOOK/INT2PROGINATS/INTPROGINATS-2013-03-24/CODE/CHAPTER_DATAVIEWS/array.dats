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
** Linear Arrays
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)

extern
fun{a:t@ype}
ptr_get1 {l:addr} (pf: !a @ l >> a @ l | p: ptr l): a

extern
fun{a:t@ype}
ptr_set1 {l:addr} (pf: !a? @ l >> a @ l | p: ptr l, x: a): void

(* ****** ****** *)

dataview array_v
  (a:t@ype+, int(*size*), addr(*beg*)) =
  | {n:nat} {l:addr}
    array_v_cons (a, n+1, l) of (a @ l, array_v (a, n, l+sizeof(a)))
  | {l:addr} array_v_nil (a, 0, l)
// end of [array_v]

extern
fun{a:t@ype}
arrget {n,i:nat | i < n} {l:addr}
  (pf: !array_v (a, n, l) | p: ptr l, i: int i): a
// end of [arrget]

extern
fun{a:t@ype}
arrset {n,i:nat | i < n} {l:addr}
  (pf: !array_v (a, n, l) | p: ptr l, i: int i, x: a): void
// end of [arrset]

fun{a:t@ype}
arrgetfst {n:pos} {l:addr} (
  pf: !array_v (a, n, l) | p: ptr l
) : a = x where {
  prval array_v_cons (pf1, pf2) = pf
  // pf1: a @ l; pf2: array_v (a, n-1, l+sizeof(a))
  val x = !p
  prval () = pf := array_v_cons (pf1, pf2)
} // end of [arrgetfst]

implement{a}
arrget (pf | p, i) =
  if i > 0 then let
    prval array_v_cons (pf1, pf2) = pf
    val x = arrget (pf2 | p+sizeof<a>, i-1)
    prval () = pf := array_v_cons (pf1, pf2)
  in
    x
  end else
    arrgetfst (pf | p)
  // end of [if]

(* ****** ****** *)

extern
prfun array_v_split
  {a:t@ype} {n,i:nat | i <= n} {l:addr} {ofs:int} (
  pfmul: MUL (i, sizeof(a), ofs), pfarr: array_v (a, n, l)
) : (array_v (a, i, l), array_v (a, n-i, l+ofs))

extern
prfun array_v_unsplit
  {a:t@ype} {n1,n2:nat} {l:addr} {ofs:int} (
  pfmul: MUL (n1, sizeof(a), ofs)
, pf1arr: array_v (a, n1, l), pf2arr: array_v (a, n2, l+ofs)
) : array_v (a, n1+n2, l)

(* ****** ****** *)

implement{a}
arrget (pf | p, i) = x where {
  val tsz = int1_of_size1 (sizeof<a>)
  val (pfmul | ofs) = i imul2 tsz
  prval (pf1, pf2) = array_v_split {a} (pfmul, pf)
  prval array_v_cons (pf21, pf22) = pf2
  val x = ptr_get1<a> (pf21 | p+ofs)
  prval pf2 = array_v_cons (pf21, pf22)
  prval () = pf := array_v_unsplit {a} (pfmul, pf1, pf2)
} // end of [arrget]

implement{a}
arrset (pf | p, i, x) = () where {
  val tsz = int1_of_size1 (sizeof<a>)
  val (pfmul | ofs) = i imul2 tsz
  prval (pf1, pf2) = array_v_split {a} (pfmul, pf)
  prval array_v_cons (pf21, pf22) = pf2
  val () = ptr_set1<a> (pf21 | p+ofs, x)
  prval pf2 = array_v_cons (pf21, pf22)
  prval () = pf := array_v_unsplit {a} (pfmul, pf1, pf2)
} // end of [arrset]

(* ****** ****** *)

typedef natLt (n:int) = [i:nat | i < n] int (i)

fun{a:t@ype}
array_ptr_tabulate
  {n:nat} {l:addr} (
  pf: !array_v (a?,n,l) >> array_v (a,n,l)
| p: ptr (l), n: int (n), f: natLt(n) -<cloref1> a
) : void = let
  fun loop {i:nat | i <= n} {l:addr} .<n-i>. (
    pf: !array_v (a?,n-i,l) >> array_v (a,n-i,l)
  | p: ptr l, n: int n, f: natLt(n) -<cloref1> a, i: int i
  ) : void =
    if i < n then let
      prval array_v_cons (pf1, pf2) = pf
      val () = !p := f (i)
      val () = loop (pf2 | p+sizeof<a>, n, f, i+1)
    in
      pf := array_v_cons (pf1, pf2)
    end else let
      prval array_v_nil () = pf in pf := array_v_nil {a} ()
    end // end of [if]
  // end of [loop]
in
  loop (pf | p, n, f, 0)
end // end of [array_ptr_tabulate]

(* ****** ****** *)

implement
array_v_split {a} (pfmul, pfarr) = let
  prfun split
    {n,i:nat | i <= n} {l:addr} {ofs:int} .<i>. (
    pfmul: MUL (i, sizeof(a), ofs), pfarr: array_v (a, n, l)
  ) : (array_v (a, i, l), array_v (a, n-i, l+ofs)) =
    sif i > 0 then let
      prval MULind (pf1mul) = pfmul
      prval array_v_cons (pf1at, pf1arr) = pfarr
      prval (pf1res1, pf1res2) = split (pf1mul, pf1arr)
    in
      (array_v_cons (pf1at, pf1res1), pf1res2)
    end else let
      prval MULbas () = pfmul in (array_v_nil (), pfarr)
    end // end of [sif]
in
  split (pfmul, pfarr)
end // end of [array_v_split]

(* ****** ****** *)

implement
array_v_unsplit {a}
  (pfmul, pf1arr, pf2arr) = let
  prfun unsplit
    {n1,n2:nat} {l:addr} {ofs:int} .<n1>. (
    pfmul: MUL (n1, sizeof(a), ofs)
  , pf1arr: array_v (a, n1, l)
  , pf2arr: array_v (a, n2, l+ofs)
  ) : array_v (a, n1+n2, l) =
    sif n1 > 0 then let
      prval MULind (pf1mul) = pfmul
      prval array_v_cons (pf1at, pf1arr) = pf1arr
      prval pfres = unsplit (pf1mul, pf1arr, pf2arr)
    in
      array_v_cons (pf1at, pfres)
    end else let
      prval MULbas () = pfmul
      prval array_v_nil () = pf1arr
    in
      pf2arr
    end // end of [sif]
in
  unsplit (pfmul, pf1arr, pf2arr)
end // end of [array_v_unsplit]

(* ****** ****** *)

extern
prfun array_v_takeout
  {a:t@ype} {n,i:nat | i < n} {l:addr} {ofs:int} (
  pfmul: MUL (i, sizeof(a), ofs), pfarr: array_v (a, n, l)
) : (a @ l+ofs, a @ l+ofs -<lin,prf> array_v (a, n, l))

(* ****** ****** *)

implement
array_v_takeout
  {a} (pfmul, pfarr) = let
  prfun takeout
    {n,i:nat | i < n} {l:addr} {ofs:int} .<i>. (
    pfmul: MUL (i, sizeof(a), ofs), pfarr: array_v (a, n, l)
  ) : (a @ l+ofs, a @ l+ofs -<lin,prf> array_v (a, n, l)) = let
    prval array_v_cons (pf1at, pf1arr) = pfarr
  in
    sif i > 0 then let
      prval MULind (pf1mul) = pfmul
      prval (pfres, fpfres) = takeout (pf1mul, pf1arr)
    in
      (pfres, llam (pfres) => array_v_cons (pf1at, fpfres (pfres)))
    end else let
      prval MULbas () = pfmul
    in
      (pf1at, llam (pf1at) => array_v_cons (pf1at, pf1arr))
    end // end of [sif]
  end // end of [takeout]
in
  takeout (pfmul, pfarr)
end // end of [array_v_takeout]

(* ****** ****** *)

(* end of [array.dats] *)
