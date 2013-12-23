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
** Quicksort
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)

typedef cmp (a:t@ype) = (&a, &a) -> int

(* ****** ****** *)

extern
fun{a:t@ype}
compare (x: &a, y: &a, cmp: cmp (a)): int

(* ****** ****** *)

staload "libats/SATS/biarray.sats"

(* ****** ****** *)

dataview array_v
  (a:t@ype, int(*size*), addr(*beg*)) =
  | {n:nat} {l:addr}
    array_v_cons (a, n+1, l) of (a @ l, array_v (a, n, l+sizeof(a)))
  | {l:addr} array_v_nil (a, 0, l)
// end of [array_v]

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

extern
prfun array_v_extend
  {a:t@ype} {n:nat} {l:addr} {ofs:int} (
  pfmul: MUL (n, sizeof(a), ofs)
, pfarr: array_v (a, n, l), pfat: a @ l+ofs
) : array_v (a, n+1, l)

(* ****** ****** *)

fun{a:t@ype}
swap2 (x: &a, y: &a): void = () where {
  val tmp = x; val () = x := y; val () = y := tmp
} // end of [swap2]

(* ****** ****** *)

(*
extern
fun{a:t@ype}
array_ptr_exch {n:nat} {l:addr} (
  pf: !array_v (a, n, l) | p: ptr l, i: natLt n, j: natLt n
) : void // end of [array_ptr_exch]
*)

local

staload _(*anon*) = "prelude/DATS/array.dats"

in // in of [local]

fn{a:t@ype}
array_ptr_exch {n:nat} {l:addr} (
  pfarr: !array_v (a, n, l) | p: ptr l, i: natLt n, j: natLt n
) : void = let
  prval pfarr1 = __assert (pfarr) where {
    extern prfun __assert {n:nat} {l:addr} (pf: array_v (a, n, l)): @[a][n] @ l
  } // end of [prval]
  val i = size1_of_int1 (i) and j = size1_of_int1 (j)
  val () = array_ptr_exch<a> (!p, i, j)
  prval () = pfarr := __assert (pfarr1) where {
    extern prfun __assert {n:nat} {l:addr} (pf: @[a][n] @ l): array_v (a, n, l)
  }
in
  // nothing
end // end of [array_ptr_exch]

end // end of [local]

(* ****** ****** *)

extern
fun{a:t@ype}
quicksort {n:nat} {l:addr} (
  pf: !array_v (a, n, l) | p: ptr l, n: int (n), cmp: cmp (a)
) : void // end of [quicksort]

(* ****** ****** *)

fun{a:t@ype}
npivot {n:pos} {l:addr} (
  pf: !array_v (a, n, l) | p: ptr l, n: int (n), cmp: cmp (a)
) : natLt (n) = n/2

(* ****** ****** *)

extern
fun{a:t@ype}
split {n:nat} {l:addr} (
  pf: array_v (a, n, l) | p: ptr l, n: int n, cmp: cmp a, piv: &a
) : [n1,n2:nat | n1+n2==n] [ofs:int] (
  MUL (n1, sizeof(a), ofs), array_v (a, n1, l), array_v (a, n2, l+ofs) | int n1
) // end of [split]

(* ****** ****** *)

fun{a:t@ype}
qsort {n:nat} {l:addr} .<n>. (
  pfarr: !array_v (a, n, l) | p: ptr l, n: int (n), cmp: cmp (a)
) : void =
  if n > 0 then let
    val tsz = int1_of_size1 (sizeof<a>)
    val npiv = npivot (pfarr | p, n, cmp)
    val () = array_ptr_exch (pfarr | p, 0, npiv) // move the pivot to the front
    val p1 = p+tsz
    prval array_v_cons (pfat, pf1arr) = pfarr
    val (pfmul, pf1arr_lte, pf1arr_gt | n1) = split (pf1arr | p1, n-1, cmp, !p)
    prval pf1arr_lte = array_v_cons (pfat, pf1arr_lte)
    val () = array_ptr_exch (pf1arr_lte | p, 0, n1)
//
    prval (pf1arr_lte, pflast) = array_v_split {a} (pfmul, pf1arr_lte)
    val () = qsort (pf1arr_lte | p, n1, cmp)
    prval pf1arr_lte = array_v_unsplit {a} (pfmul, pf1arr_lte, pflast)
//
    val (pfmul_alt | ofs) = n1 imul2 tsz
    prval () = mul_isfun (pfmul, pfmul_alt)
    val () = qsort (pf1arr_gt | p1+ofs, n-n1-1, cmp)
//
    prval () = pfarr := array_v_unsplit {a} (MULind (pfmul), pf1arr_lte, pf1arr_gt)
  in
    // nothing
  end else () // empty array
// end of [qsort]

(* ****** ****** *)

extern
prfun array_v_of_biarray_v
  {a:t@ype} {n:int} {l1,l2:addr}
  (pf: biarray_v (a, n, l1, l2)): array_v (a, n, l1)
// end of [array_v_of_biarray_v]

extern
prfun biarray_v_of_array_v
  {a:t@ype} {n:int} {l:addr} {ofs:int} (
  pfmul: MUL (n, sizeof(a), ofs), pfarr: array_v (a, n, l)
) : biarray_v (a, n, l, l+ofs)

(* ****** ****** *)

(*
//
// HX-2011-09-18:
// this one makes use of two pointers: the front one goes
// forward while the rear one goes backward.
//
implement{a}
split (pf | p, n, cmp, piv) = let
//
  fn* loop
    {n0,n:nat} {la,lz:addr} .<n>. (
    pf: biarray_v (a, n, la, lz)
  | pa: ptr la, pz: ptr lz, n0: int n0, n: int n, cmp: cmp(a), piv: &a
  ) : [n1,n2:nat; ofs: int | n1+n2==n] (
    MUL (n1, sizeof(a), ofs)
  , biarray_v (a, n1, la, la+ofs), biarray_v (a, n2, la+ofs, lz) | int (n0+n1)
  ) =
    if n > 0 then let
      prval (pfat, pf) = biarray_v_uncons {a} (pf)
      val sgn = compare<a> (!pa, piv, cmp)
    in
      if sgn <= 0 then let
        val (pfmul, pf1, pf2 | n0n1) = loop (pf | pa+sizeof<a>, pz, n0+1, n-1, cmp, piv)
      in
        (MULind (pfmul), biarray_v_cons (pfat, pf1), pf2 | n0n1)
      end else
        loop2 (pfat, pf | pa, pz, n0, n-1, cmp, piv)
      // end of [if]
    end else let
      prval () = biarray_v_unnil {a} (pf)
    in
      (MULbas (), biarray_v_nil (), biarray_v_nil () | n0)
    end // end of [if]
  and loop2
    {n0,n:nat} {la,lz:addr} .<n>. (
    pfat: a @ la, pf: biarray_v (a, n, la+sizeof(a), lz)
  | pa: ptr la, pz: ptr lz, n0: int n0, n: int n, cmp: cmp a, piv: &a
  ) : [n1,n2:nat; ofs: int | n1+n2==n+1] (
    MUL (n1, sizeof(a), ofs)
  , biarray_v (a, n1, la, la+ofs), biarray_v (a, n2, la+ofs, lz) | int (n0+n1)
  ) =
    if n > 0 then let
      prval (pf, pfat2) = biarray_v_unsnoc {a} (pf)
      val pz1 = pz - sizeof<a>
      val sgn = compare<a> (!pz1, piv, cmp)
    in
      if sgn > 0 then let
        val (pfmul, pf1, pf2 | n1) = loop2 (pfat, pf | pa, pz1, n0, n-1, cmp, piv)
      in
        (pfmul, pf1, biarray_v_snoc (pf2, pfat2) | n1)
      end else let
        val () = swap2 (!pa, !pz1)
        val (pfmul, pf1, pf2 | n0n1) = loop (pf | pa+sizeof<a>, pz1, n0+1, n-1, cmp, piv)
      in
        (MULind (pfmul), biarray_v_cons (pfat, pf1), biarray_v_snoc (pf2, pfat2) | n0n1)
      end // end of [if]
    end else let
      prval () = biarray_v_unnil (pf)
    in
      (MULbas (), biarray_v_nil (), biarray_v_sing (pfat) | n0)
    end // end of[ if]
//
  val tsz = int1_of_size1 (sizeof<a>)
  val pa = p
  val (pfmul | ofs) = n imul2 tsz
  val pz = pa + ofs
  prval pf = biarray_v_of_array_v {a} (pfmul, pf)
  val (pfmul, pf1, pf2 | n1) = loop (pf | pa, pz, 0, n, cmp, piv)
  prval pf1 = array_v_of_biarray_v {a} (pf1)
  prval pf2 = array_v_of_biarray_v {a} (pf2)
in
  (pfmul, pf1, pf2 | n1)
end // end of [split]
*)

(* ****** ****** *)

extern
prfun array_v_takeout
  {a:t@ype} {n,i:nat | i < n} {l:addr} {ofs:int} (
  pfmul: MUL (i, sizeof(a), ofs), pfarr: array_v (a, n, l)
) : (a @ l+ofs, a @ l+ofs -<lin,prf> array_v (a, n, l))

extern
fun{a:t@ype}
array_ptr_takeout
  {n,k:nat | k < n} {l:addr} (
  pf: array_v (a, n, l) | p: ptr l, k: int k
) : [lk:addr] (
  a @ lk, a @ lk -<lin,prf> array_v (a, n, l) | ptr lk
) // end of [array_ptr_takeout]

implement{a}
array_ptr_takeout
  (pf | p, k) = let
  val tsz = int1_of_size1 (sizeof<a>)
  val (pfmul | ofs) = k imul2 tsz
  prval (pfat, fpf) = array_v_takeout {a} (pfmul, pf)
in
  (pfat, fpf | p+ofs)
end // end of [array_ptr_takeout]

(* ****** ****** *)

implement{a}
split {n} (
  pfarr | p, n, cmp, piv
) = let
  fun loop
    {n1:nat}
    {k:nat | n1+k <= n}
    {l:addr} {ofs:int} .<n-n1-k>. (
    pfmul: MUL (n1, sizeof(a), ofs)
  , pf1arr: array_v (a, n1, l)
  , pf2arr: array_v (a, n-n1, l+ofs)
  | p: ptr (l+ofs), n: int n, n1: int n1, k: int k, cmp: cmp(a), piv: &a
  ) : [n1,n2:nat | n1+n2==n] [ofs:int] (
    MUL (n1, sizeof(a), ofs), array_v (a, n1, l), array_v (a, n2, l+ofs)
  | int (n1)
  ) =
    if n1+k < n then let
      val (pfat, fpf2 | pk) = array_ptr_takeout (pf2arr | p, k)
      val sgn = compare (!pk, piv, cmp)
      prval () = pf2arr := fpf2 (pfat)
    in
      if sgn > 0 then
        loop (pfmul, pf1arr, pf2arr | p, n, n1, k+1, cmp, piv)
      else let
        val () = array_ptr_exch (pf2arr | p, 0, k)
        prval array_v_cons (pfat, pf2arr) = pf2arr
        prval () = pf1arr := array_v_extend {a} (pfmul, pf1arr, pfat)
      in
        loop (MULind (pfmul), pf1arr, pf2arr | p+sizeof<a>, n, n1+1, k, cmp, piv)
      end (* end of [if] *)
    end else (
      pfmul, pf1arr, pf2arr | n1
    ) // end of [if]
in
  loop (MULbas (), array_v_nil (), pfarr | p, n, 0, 0, cmp, piv)
end // end of [split]

(* ****** ****** *)

implement{a}
quicksort (pf | p, n, cmp) = qsort<a> (pf | p, n, cmp)

(* ****** ****** *)

implement
compare<int> (x, y, _) = compare_int_int (x, y)

implement
main () = let
  typedef T = int
  val asz = 10
  var !parr with pfarr = @[T](3, 2, 5, 4, 8, 7, 6, 9, 1, 0)
  fn cmp (x: &int, y: &int): int = compare_int_int (x, y)
  prval pfarr1 = __assert (pfarr) where {
    extern prfun __assert {n:nat} {l:addr} (pf: @[T][n] @ l): array_v (T, n, l)
  } // end of [prval]
  val () = quicksort (pfarr1 | parr, asz, cmp)
  prval () = pfarr := __assert (pfarr1) where {
    extern prfun __assert {n:nat} {l:addr} (pf: array_v (T, n, l)): @[T][n] @ l
  }
  val () = array_ptr_foreach_fun<int> (!parr, lam (x) =<1> print x, size1_of_int1 asz)
  val () = print_newline ()
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [quicksort.dats] *)
