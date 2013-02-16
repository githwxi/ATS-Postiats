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
// HX-2013-02:
// A package for multiple-precision integers
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.atshwxi.intinf"

(* ****** ****** *)
//
absvtype intinf_vtype (i:int)
//
stadef intinf = intinf_vtype
vtypedef intinf = [i:int] intinf_vtype (i)
vtypedef Intinf = [i:int] intinf_vtype (i)
//
(* ****** ****** *)

fun intinf_free (x: Intinf): void

(* ****** ****** *)

fun intinf_make_int {i:int} (x: int (i)): intinf (i)
fun intinf_make_lint {i:int} (x: lint (i)): intinf (i)
fun intinf_make_llint {i:int} (x: llint (i)): intinf (i)

(* ****** ****** *)

fun intinf_make_uint {i:int} (x: uint (i)): intinf (i)
fun intinf_make_ulint {i:int} (x: ulint (i)): intinf (i)
fun intinf_make_ullint {i:int} (x: ullint (i)): intinf (i)

(* ****** ****** *)

fun print_intinf (x: !Intinf): void
fun prerr_intinf (x: !Intinf): void
fun fprint_intinf (out: FILEref, x: !Intinf): void
overload print with print_intinf
overload prerr with prerr_intinf
overload fprint with fprint_intinf

(* ****** ****** *)

fun neg_intinf {i:int} (x: !intinf i): intinf (i)
overload ~ with neg_intinf

(* ****** ****** *)

fun succ_intinf {i:int} (x: !intinf i): intinf (i+1)
overload succ with succ_intinf
fun pred_intinf {i:int} (x: !intinf i): intinf (i-1)
overload pred with pred_intinf

(* ****** ****** *)

fun add_intinf_int
  {i,j:int} (x: !intinf i, y: int j): intinf (i+j)
fun add_int_intinf
  {i,j:int} (x: int i, y: !intinf j): intinf (i+j)
fun add_intinf_intinf
  {i,j:int} (x: !intinf i, y: !intinf j): intinf (i+j)
overload + with add_intinf_int
overload + with add_int_intinf
overload + with add_intinf_intinf

(* ****** ****** *)

fun sub_intinf_int
  {i,j:int} (x: !intinf i, y: int j): intinf (i-j)
fun sub_int_intinf
  {i,j:int} (x: int i, y: !intinf j): intinf (i-j)
fun sub_intinf_intinf
  {i,j:int} (x: !intinf i, y: !intinf j): intinf (i-j)
overload - with sub_intinf_int
overload - with sub_int_intinf
overload - with sub_intinf_intinf

(* ****** ****** *)

fun mul_intinf_int
  {i,j:int} (x: !intinf i, y: int j): intinf (i*j)
fun mul_int_intinf
  {i,j:int} (x: int i, y: !intinf j): intinf (i*j)
fun mul_intinf_intinf
  {i,j:int} (x: !intinf i, y: !intinf j): intinf (i*j)
overload * with mul_intinf_int
overload * with mul_int_intinf
overload * with mul_intinf_int

(* ****** ****** *)

(* end of [intinf.sats] *)
