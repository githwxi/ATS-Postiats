(* ****** ****** *)
//
// Linear Algebra vector operations
//
(* ****** ****** *)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)
//
// Linear Algebra vector operations
//
(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

staload "libats/SATS/gvector.sats"

(* ****** ****** *)
//
absvtype
LAgvec_vtype
  (a:t@ype, l: addr, n: int) = ptr(l)
//
stadef LAgvec = LAgvec_vtype
vtypedef LAgvec
  (a:t@ype, n: int) = [l:addr] LAgvec(a, l, n)
//
(* ****** ****** *)

praxi
lemma_LAgvec_param
  {a:t0p}{n:int}
  (V: !LAgvec(a, n)): [n >= 0] void
// end of [lemma_LAgvec_param]

(* ****** ****** *)
//
// HX: only if you know what you are doing
//
praxi
LAgvec_initize
  {a:t0p}{n:int}
  (V: !LAgvec(a?, n) >> LAgvec(a, n)): void
// end of [LAgvec_initize]
praxi
LAgvec_uninitize
  {a:t0p}{n:int}
  (V: !LAgvec(a, n) >> LAgvec(a?, n)): void
// end of [LAgvec_uninitize]

(* ****** ****** *)

fun{}
LAgvec_size
  {a:t0p}{n:int}(!LAgvec(a, n)): int(n)
// end of [LAgvec_size]

(* ****** ****** *)

fun{}
LAgvec_vtakeout_vector
  {a:t0p}{n:int}
(
  !LAgvec(a, n), &int? >> int(d)
) : #[l:addr;d:int]
(
  gvector_v (a, l, n, d)
, gvector_v (a, l, n, d) -<lin,prf> void
| ptr (l)
) // end of [LAgvec_vtakeout_vector]

(* ****** ****** *)
//
fun{}
LAgvec_incref // refcnt++
  {a:t0p}{l:addr}{n:int}
  (!LAgvec(a, l, n)): LAgvec(a, l, n)
//
fun{}
LAgvec_decref // refcnt--
  {a:t0p}{l:addr}{n:int}(LAgvec(a, l, n)): void
//
macdef
LAgvec_decref2
  (V1, V2) =
{
  val () = LAgvec_decref ,(V1)
  val () = LAgvec_decref ,(V2)
}
//
(* ****** ****** *)

fun{}
LAgvec_make_arrayptr
  {a:t0p}{n:int}
  (arrayptr (INV(a), n), int n): LAgvec(a, n)
// end of [LAgvec_make_arrayptr]

(* ****** ****** *)

fun{a:t0p}
LAgvec_make_uninitized {n:nat}(int n): LAgvec(a?, n)

(* ****** ****** *)
//
fun{a:t0p}
LAgvec_get_at{n:int}
  (V: !LAgvec(a, n), i: natLt(n)): (a)
fun{a:t0p}
LAgvec_set_at{n:int}
  (V: !LAgvec(a, n), i: natLt(n), x: a): void
//
fun{a:t0p}
LAgvec_getref_at{n:int}
  (V: !LAgvec(a, n), i: natLt(n)) : cPtr1(a)
//
(* ****** ****** *)
//
fun{}
fprint_LAgvec$sep (FILEref): void
fun{a:t0p}
fprint_LAgvec{n:int}
  (out: FILEref, V: !LAgvec(a, n)): void
fun{a:t0p}
fprint_LAgvec_sep{n:int}
  (out: FILEref, V: !LAgvec(a, n), sep: string): void
//
(* ****** ****** *)

fun{a:t0p}
LAgvec_split
  {n:int}{i:nat | i <= n}
  (LAgvec(a, n), int(i)): (LAgvec(a, i), LAgvec(a, n-i))
// end of [LAgvec_split]

(* ****** ****** *)

fun{a:t0p}
LAgvec_tabulate$fopr (i: int): a
fun{a:t0p}
LAgvec_tabulate {n:nat} (n: int n): LAgvec(a, n)

(* ****** ****** *)

fun{a:t0p}
LAgvec_inner{n:int}
  (A: !LAgvec(a, n), B: !LAgvec(a, n)): a(*innerprod*)
// end of [LAgvec_inner]

(* ****** ****** *)
//
// X <- alpha*X
//
fun{a:t0p}
LAgvec_scal{n:int}
  (alpha: a, X: !LAgvec(a, n) >> _) : void
// end of [LAgvec_scal]

fun{a:t0p}
scal_LAgvec{n:int}
  (alpha: a, X: !LAgvec(a, n)): LAgvec(a, n)
// end of [scal_LAgvec]

(* ****** ****** *)
//
// Y <- X
//
fun{a:t0p}
LAgvec_copy{n:int}
(
  X: !LAgvec(a, n)
, Y: !LAgvec(a?, n) >> LAgvec(a, n)
) : void // endfun

fun{a:t0p}
copy_LAgvec
  {n:int}(X: !LAgvec(a, n)): LAgvec(a, n)
// end of [copy_LAgvec]

(* ****** ****** *)
//
// Y <-> X
//
fun{a:t0p}
LAgvec_swap{n:int}
(
  X: !LAgvec(a, n) >> _
, Y: !LAgvec(a, n) >> _
) : void // endfun

(* ****** ****** *)
//
// Y <- X + Y
//
fun{a:t0p}
LAgvec_1x1y{n:int}
(
  X: !LAgvec(a, n), Y: !LAgvec(a, n) >> _
) : void // [LAgvec_1x1y]
//
// Y <- alpha*X + Y
//
fun{a:t0p}
LAgvec_ax1y{n:int}
(
  alpha: a, X: !LAgvec(a, n), Y: !LAgvec(a, n) >> _
) : void // [LAgvec_ax1y]
//
// Y <- alpha*X + beta*Y
//
fun{a:t0p}
LAgvec_axby{n:int}
(
  alpha: a, X: !LAgvec(a, n), beta: a, Y: !LAgvec(a, n) >> _
) : void // [LAgvec_axby]

(* ****** ****** *)
//
fun{a:t0p}
add11_LAgvec_LAgvec{n:int}
  (A: !LAgvec(a, n), B: !LAgvec(a, n)): LAgvec(a, n)
//
(* ****** ****** *)
//
// Overloading for certain symbols
//
(* ****** ****** *)
//
overload + with add11_LAgvec_LAgvec
//
(* ****** ****** *)

overload [] with LAgvec_get_at
overload [] with LAgvec_set_at

(* ****** ****** *)

overload .size with LAgvec_size

(* ****** ****** *)
//
overload fprint with fprint_LAgvec
//
(* ****** ****** *)

(* end of [lavector.sats] *)
