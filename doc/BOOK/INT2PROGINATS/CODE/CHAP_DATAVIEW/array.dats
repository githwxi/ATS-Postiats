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
  (a:t@ype+, addr(*beg*), int(*size*)) =
  | {l:addr}
    array_v_nil (a, l, 0)
  | {l:addr}{n:nat}
    array_v_cons (a, l, n+1) of (a @ l, array_v (a, l+sizeof(a), n))
// end of [array_v]

(* ****** ****** *)

extern
fun{
a:t@ype
} arrget{l:addr}{n,i:nat | i < n}
  (pf: !array_v (a, l, n) | p: ptr l, i: int i): a
// end of [arrget]

extern
fun{
a:t@ype
} arrset{l:addr}{n,i:nat | i < n}
  (pf: !array_v (a, l, n) | p: ptr l, i: int i, x: a): void
// end of [arrset]

(* ****** ****** *)

fun{
a:t@ype
} arrgetfst{l:addr}{n:pos}
(
  pf: !array_v (a, l, n) | p: ptr l
) : a = x where {
  prval array_v_cons (pf1, pf2) = pf
  // pf1: a @ l; pf2: array_v (a, l+sizeof(a), n-1)
  val x = !p
  prval () = pf := array_v_cons (pf1, pf2)
} // end of [arrgetfst]

(* ****** ****** *)

implement{a}
arrget (pf | p, i) =
  if i > 0 then let
    prval array_v_cons (pf1, pf2) = pf
    val x = arrget (pf2 | ptr_succ<a> (p), i-1)
    prval () = pf := array_v_cons (pf1, pf2)
  in
    x
  end else
    arrgetfst (pf | p)
  // end of [if]

(* ****** ****** *)

extern
prfun
array_v_split
  {a:t@ype}
  {l:addr}{n,i:nat | i <= n}
(
  pfarr: array_v (a, l, n)
) : (array_v (a, l, i), array_v (a, l+i*sizeof(a), n-i))

extern
prfun
array_v_unsplit
  {a:t@ype}
  {l:addr}{n1,n2:nat}
(
  pf1arr: array_v (a, l, n1), pf2arr: array_v (a, l+n1*sizeof(a), n2)
) : array_v (a, l, n1+n2)

(* ****** ****** *)

implement{a}
arrget{l}{n,i}
  (pf | p, i) = x where {
  prval (pf1, pf2) = array_v_split{a}{l}{n,i}(pf)
  prval array_v_cons (pf21, pf22) = pf2
  val x = ptr_get1<a> (pf21 | ptr_add<a> (p, i))
  prval pf2 = array_v_cons (pf21, pf22)
  prval () = pf := array_v_unsplit{a}{l}{i,n-i}(pf1, pf2)
} // end of [arrget]

implement{a}
arrset{l}{n,i}
  (pf | p, i, x) = () where {
  prval (pf1, pf2) = array_v_split{a}{l}{n,i}(pf)
  prval array_v_cons (pf21, pf22) = pf2
  val () = ptr_set1<a> (pf21 | ptr_add<a> (p, i), x)
  prval pf2 = array_v_cons (pf21, pf22)
  prval () = pf := array_v_unsplit{a}{l}{i,n-i}(pf1, pf2)
} // end of [arrset]

(* ****** ****** *)

typedef natLt (n:int) = [i:nat | i < n] int (i)

fun{a:t@ype}
array_ptr_tabulate
  {l:addr}{n:nat}
(
  pf: !array_v (a?,l,n) >> array_v (a,l,n)
| p: ptr (l), n: int (n), f: natLt(n) -<cloref1> a
) : void = let
  fun loop{l:addr}
    {i:nat | i <= n} .<n-i>.
  (
    pf: !array_v (a?,l,n-i) >> array_v (a,l,n-i)
  | p: ptr l, n: int n, f: natLt(n) -<cloref1> a, i: int i
  ) : void =
    if i < n then let
      prval array_v_cons (pf1, pf2) = pf
      val () = !p := f (i)
      val () = loop (pf2 | ptr_succ<a> (p), n, f, i+1)
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

primplement
array_v_split
  {a}{l}{n,i}(pfarr) = let
  prfun split
    {l:addr}{n,i:nat | i <= n} .<i>.
  (
    pfarr: array_v (a, l, n)
  ) : (
    array_v (a, l, i)
  , array_v (a, l+i*sizeof(a), n-i)
  ) =
    sif i > 0 then let
      prval array_v_cons (pf1, pf2arr) = pfarr
      prval (pf1res1, pf1res2) = split{..}{n-1,i-1} (pf2arr)
    in
      (array_v_cons (pf1, pf1res1), pf1res2)
    end else let
      prval EQINT () = eqint_make{i,0}((*void*))
    in
      (array_v_nil (), pfarr)
    end // end of [sif]
in
  split (pfarr)
end // end of [array_v_split]

(* ****** ****** *)

primplement
array_v_unsplit
  {a}{l}{n1,n2}
  (pf1arr, pf2arr) = let
  prfun unsplit
    {l:addr}{n1,n2:nat} .<n1>.
  (
    pf1arr: array_v (a, l, n1)
  , pf2arr: array_v (a, l+n1*sizeof(a), n2)
  ) : array_v (a, l, n1+n2) =
    sif n1 > 0 then let
      prval
      array_v_cons (pf1, pf1arr) = pf1arr
      prval pfres = unsplit (pf1arr, pf2arr)
    in
      array_v_cons (pf1, pfres)
    end else let
      prval array_v_nil () = pf1arr in pf2arr
    end // end of [sif]
in
  unsplit (pf1arr, pf2arr)
end // end of [array_v_unsplit]

(* ****** ****** *)

extern
prfun
array_v_takeout
  {a:t@ype}
  {l:addr}{n,i:nat | i < n}
(
  pfarr: array_v (a, l, n)
) : (a @ l+i*sizeof(a), a @ l+i*sizeof(a) -<lin,prf> array_v (a, l, n))

(* ****** ****** *)

implement{a}
arrget{l}{n,i}
  (pf | p, i) = x where {
  prval (pf1, fpf2) =
  array_v_takeout{a}{l}{n,i} (pf)
  val x = ptr_get1<a> (pf1 | ptr_add<a> (p, i))
  prval () = pf := fpf2 (pf1) // putting the cell and the rest together
} // end of [arrget]

(* ****** ****** *)

primplement
array_v_takeout
  {a}{l}{n,i}(pfarr) = let
  prfun takeout
    {l:addr}{n,i:nat | i < n} .<i>.
  (
    pfarr: array_v (a, l, n)
  ) : (
    a @ l+i*sizeof(a)
  , a @ l+i*sizeof(a) -<lin,prf> array_v (a, l, n)
  ) = let
    prval array_v_cons (pf1at, pf1arr) = pfarr
  in
    sif i > 0 then let
      prval (pfres, fpfres) = takeout{..}{n-1,i-1}(pf1arr)
    in
      (pfres, llam (pfres) => array_v_cons (pf1at, fpfres (pfres)))
    end else let
      prval EQINT () = eqint_make{i,0}((*void*))
    in
      (pf1at, llam (pf1at) => array_v_cons (pf1at, pf1arr))
    end // end of [sif]
  end // end of [takeout]
in
  takeout{l}{n,i}(pfarr)
end // end of [array_v_takeout]

(* ****** ****** *)

(* end of [array.dats] *)
