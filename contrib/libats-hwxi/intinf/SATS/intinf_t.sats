(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: hwxi AT gmail DOT com
// Start Time: February, 2013
//
(* ****** ****** *)
//
// HX-2013-02:
// A package for multiple-precision integers
//
(* ****** ****** *)

#define
ATS_PACKNAME "ATSCNTRB.libats-hwxi.intinf_t"

(* ****** ****** *)

staload "./intinf.sats"

(* ****** ****** *)
//
stadef intinf = intinf_type
//
typedef Intinf = [i:int] intinf (i)
//
typedef
intinfLt (i0:int) = [i:int | i < i0] intinf (i)
typedef
intinfLte (i0:int) = [i:int | i <= i0] intinf (i)
typedef
intinfGt (i0:int) = [i:int | i > i0] intinf (i)
typedef
intinfGte (i0:int) = [i:int | i >= i0] intinf (i)
typedef
intinfBtw (i1:int, i2:int) = [i:int | i1 <= i; i < i2] intinf (i)
typedef
intinfBtwe (i1:int, i2:int) = [i:int | i1 <= i; i <= i2] intinf (i)
//
(* ****** ****** *)

typedef
intinf_base = intBtwe (2, 36) // taken from GMP

(* ****** ****** *)
//
fun{}
intinf_make_int {i:int} (x: int (i)): intinf (i)
macdef int2intinf (x) = intinf_make_int (,(x))
//
(* ****** ****** *)

fun{}
intinf_make_lint {i:int} (x: lint (i)): intinf (i)
fun{}
intinf_make_llint {i:int} (x: llint (i)): intinf (i)

(* ****** ****** *)

fun{}
intinf_make_uint {i:int} (x: uint (i)): intinf (i)
fun{}
intinf_make_ulint {i:int} (x: ulint (i)): intinf (i)
fun{}
intinf_make_ullint {i:int} (x: ullint (i)): intinf (i)

(* ****** ****** *)
//
fun{}
intinf_get_int (x: Intinf): int
fun{}
intinf_get_lint (x: Intinf): lint
//
(* ****** ****** *)

fun{}
intinf_get_string
  (x: Intinf, base: intinf_base): string
// end of [intinf_get_string]

(* ****** ****** *)

//
fun{}
print_intinf (x: Intinf): void
fun{}
prerr_intinf (x: Intinf): void
fun{}
fprint_intinf (out: FILEref, x: Intinf): void
//
overload print with print_intinf
overload prerr with prerr_intinf
overload fprint with fprint_intinf
//
fun{}
fprint_intinf_base
  (out: FILEref, x: Intinf, base: intinf_base): void
//
(* ****** ****** *)

fun{}
neg_intinf {i:int} (x: intinf i): intinf (~i)
overload ~ with neg_intinf

(* ****** ****** *)

fun{}
abs_intinf {i:int} (x: intinf i): intinf (abs(i))
overload abs with abs_intinf

(* ****** ****** *)

fun{}
succ_intinf {i:int} (x: intinf i): intinf (i+1)
overload succ with succ_intinf

(* ****** ****** *)

fun{}
pred_intinf {i:int} (x: intinf i): intinf (i-1)
overload pred with pred_intinf

(* ****** ****** *)

fun{}
add_intinf_int
  {i,j:int} (x: intinf i, y: int j): intinf (i+j)
overload + with add_intinf_int

(* ****** ****** *)

fun{}
add_int_intinf
  {i,j:int} (x: int i, y: intinf j): intinf (i+j)
overload + with add_int_intinf

(* ****** ****** *)

fun{}
add_intinf_intinf
  {i,j:int} (x: intinf i, y: intinf j): intinf (i+j)
overload + with add_intinf_intinf

(* ****** ****** *)

fun{}
sub_intinf_int
  {i,j:int} (x: intinf i, y: int j): intinf (i-j)
overload - with sub_intinf_int

(* ****** ****** *)

fun{}
sub_int_intinf
  {i,j:int} (x: int i, y: intinf j): intinf (i-j)
overload - with sub_int_intinf

(* ****** ****** *)

fun{}
sub_intinf_intinf
  {i,j:int} (x: intinf i, y: intinf j): intinf (i-j)
overload - with sub_intinf_intinf

(* ****** ****** *)

fun{}
mul_intinf_int
  {i,j:int} (x: intinf i, y: int j): intinf (i*j)
overload * with mul_intinf_int

(* ****** ****** *)

fun{}
mul_int_intinf
  {i,j:int} (x: int i, y: intinf j): intinf (i*j)
overload * with mul_int_intinf

(* ****** ****** *)

fun{}
mul_intinf_intinf
  {i,j:int} (x: intinf i, y: intinf j): intinf (i*j)
overload * with mul_intinf_intinf

(* ****** ****** *)

fun{}
div_intinf_int
  {i,j:int | j != 0} (x: intinf i, y: int j): Intinf(*none*)
overload / with div_intinf_int

fun{}
div_intinf_intinf
  {i,j:int | j != 0} (x: intinf i, y: intinf j): Intinf(*none*)
overload / with div_intinf_intinf

(* ****** ****** *)

fun{}
nmod_intinf_int
  {i,j:int | i >= 0; j > 0} (x: intinf i, y: int j): natLt (j)
overload nmod with nmod_intinf_int

(* ****** ****** *)

fun{}
compare_int_intinf
  {i,j:int} (x: int i, y: intinf j):<> int (sgn(i-j))
overload compare with compare_int_intinf

fun{}
compare_intinf_int
  {i,j:int} (x: intinf i, y: int j):<> int (sgn(i-j))
overload compare with compare_intinf_int

fun{}
compare_intinf_intinf
  {i,j:int} (x: intinf i, y: intinf j):<> int (sgn(i-j))
overload compare with compare_intinf_intinf

(* ****** ****** *)

fun{}
pow_intinf_int
  {i:nat} (base: Intinf, exp: int i): Intinf
// end of [pow_intinf_int]

(* ****** ****** *)

(* end of [intinf_t.sats] *)
