(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) *) // MPZ and MPQ
(* Author: Shivkumar Chandrasekaran (shiv AT ece DOT ucsb DOT edu) *) // MPF

(* ****** ****** *)

%{#
//
#include "libgmp/CATS/gmp.cats"
//
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libevent"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_libgmp_" // prefix for external names

(* ****** ****** *)
//
// integral numbers
//
absvt@ype
mpz_vt0ype = $extype"atscntrb_libgmp_mpz"
//
// rational numbers
//
absvt@ype
mpq_vt0ype = $extype"atscntrb_libgmp_mpq"
//
// floating point numbers
//
absvt@ype
mpf_vt0ype = $extype"atscntrb_libgmp_mpf"
//
(* ****** ****** *)
//
stadef mpz = mpz_vt0ype
stadef mpq = mpq_vt0ype
stadef mpf = mpf_vt0ype
//
(* ****** ****** *)

typedef
mp_base = intBtw (2, 36+1) // for outputing MP numbers

(* ****** ****** *)

(* ****** ****** *)
//
// integral number operations
//
(* ****** ****** *)
//
// [x] is initialized with 0
//
fun mpz_init
  (x: &mpz? >> mpz): void = "mac#%"
//
(* ****** ****** *)
//
// [x] is initialized with 0 while given [n]-bit space
//
fun mpz_init2
  (x: &mpz? >> mpz, n: ulint): void = "mac#%"
//
(* ****** ****** *)
//
// [x] is cleared
//
fun mpz_clear (x: &mpz >> mpz?): void = "mac#%"
//
(* ****** ****** *)
//
// [x] is reallocated
// the original value of [x] is carried over if there
// is enough space, or 0 is assigned to [x] otherwise.
//
fun mpz_realloc2
  (x: &mpz >> mpz, n: ulint): void = "mac#%"
//
(* ****** ****** *)
//
fun mpz_get_int (x: &mpz): int = "mac#%"
fun mpz_get_lint (x: &mpz): lint = "mac#%"
//
fun mpz_get_uint (x: &mpz): uint = "mac#%"
fun mpz_get_ulint (x: &mpz): ulint = "mac#%"
//
fun mpz_get_double (x: &mpz): double = "mac#%"
//
// HX-2013:
// a special case of the namesake in GMP
//
fun mpz_get_str
  (base: mp_base, x: &mpz): Strptr1 = "ext#%"
// end of [mpz_get_str]

(* ****** ****** *)
//
// x := y
//
fun mpz_set_int
  (x: &mpz >> _, y: int): void = "mac#%"
fun mpz_set_lint
  (x: &mpz >> _, y: lint): void = "mac#%"
//
fun mpz_set_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
fun mpz_set_ulint
  (x: &mpz >> _, y: ulint): void = "mac#%"
//
fun mpz_set_double
  (x: &mpz >> _, y: double): void = "mac#%"
//
fun mpz_set_mpz
  (x: &mpz >> _, y: &mpz): void = "mac#%"
fun mpz_set_mpq
  (x: &mpz >> _, y: &mpq): void = "mac#%"
fun mpz_set_mpf
  (x: &mpz >> _, y: &mpf): void = "mac#%"
//
(* ****** ****** *)
//
// HX: the function returns 0/-1 if the string is valid/not
//
fun mpz_set_str
  (x: &mpz >> _, inp: string, base: mp_base): int = "mac#%"
// end of [mpz_set_str]
//
fun mpz_set_str_exn
  (x: &mpz >> _, inp: string, base: mp_base): void = "mac#%"
// end of [mpz_set_str_exn]

(* ****** ****** *)

symintr mpz_init_set // (x, y) => x := y

(* ****** ****** *)

fun mpz_init_set_int
  (x: &mpz? >> mpz, y: int): void = "mac#%"
overload mpz_init_set with mpz_init_set_int

fun mpz_init_set_uint
  (x: &mpz? >> mpz, y: uint): void = "mac#%"
overload mpz_init_set with mpz_init_set_uint

fun mpz_init_set_lint
  (x: &mpz? >> mpz, y: lint): void = "mac#%"
overload mpz_init_set with mpz_init_set_lint

fun mpz_init_set_ulint
  (x: &mpz? >> mpz, y: ulint): void = "mac#%"
overload mpz_init_set with mpz_init_set_ulint

fun mpz_init_set_mpz
  (x: &mpz? >> mpz, y: &mpz): void = "mac#%"
overload mpz_init_set with mpz_init_set_mpz

(* ****** ****** *)

fun mpz_inp_str
  (x: &mpz, inp: FILEref, base: mp_base): size_t = "mac#%"
// end of [mpz_inp_str]

fun mpz_out_str
  (out: FILEref, base: mp_base, x: &mpz): size_t = "mac#%"
// end of [mpz_out_str]

(* ****** ****** *)

fun mpz_inp_raw (x: &mpz, out: FILEref): size_t = "mac#%"
fun mpz_out_raw (out: FILEref, x: &mpz): size_t = "mac#%"

(* ****** ****** *)
//
// HX: negation
//
symintr mpz_neg
//
// x := -x
//
fun mpz_neg1
  (x: &mpz >> _): void = "ext#%"
overload mpz_neg with mpz_neg1
//
// x := -y
//
fun mpz_neg2
  (x: &mpz >> _, y: &mpz): void = "mac#%"
overload mpz_neg with mpz_neg2

(* ****** ****** *)
//
// absolute value
//
symintr mpz_abs
//
// x := |x|
//
fun mpz_abs1
  (x: &mpz >> _): void = "ext#%"
overload mpz_abs with mpz_abs1
//
// x := |y|
//
fun mpz_abs2
  (x: &mpz >> _, y: &mpz): void = "mac#%"
overload mpz_abs with mpz_abs2

(* ****** ****** *)
//
// addition
//
symintr mpz_add
//
fun mpz_add2_mpz
  (x: &mpz >> _, y: &mpz): void = "mac#%"
overload mpz_add with mpz_add2_mpz
//
fun mpz_add2_int
  (x: &mpz >> _, y: int): void = "mac#%"
overload mpz_add with mpz_add2_int
//
fun mpz_add2_lint
  (x: &mpz >> _, y: lint): void = "mac#%"
overload mpz_add with mpz_add2_lint
//
fun mpz_add2_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
overload mpz_add with mpz_add2_uint
//
fun mpz_add2_ulint
  (x: &mpz >> _, y: ulint): void = "mac#%"
overload mpz_add with mpz_add2_ulint
//
fun mpz_add3_mpz
  (x: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
overload mpz_add with mpz_add3_mpz
//
fun mpz_add3_int
  (x: &mpz >> _, y: &mpz, z: int): void = "mac#%"
overload mpz_add with mpz_add3_int
//
fun mpz_add3_lint
  (x: &mpz >> _, y: &mpz, z: lint): void = "mac#%"
overload mpz_add with mpz_add3_lint
//
fun mpz_add3_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
overload mpz_add with mpz_add3_uint
//
fun mpz_add3_ulint
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
overload mpz_add with mpz_add3_ulint
//
(* ****** ****** *)
//
// subtraction
//
symintr mpz_sub
//
fun mpz_sub2_mpz
  (x: &mpz >> _, y: &mpz): void = "mac#%"
overload mpz_sub with mpz_sub2_mpz
//
fun mpz_sub2_int
  (x: &mpz >> _, y: int): void = "mac#%"
overload mpz_sub with mpz_sub2_int
//
fun mpz_sub2_lint
  (x: &mpz >> _, y: lint): void = "mac#%"
overload mpz_sub with mpz_sub2_lint
//
fun mpz_sub2_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
overload mpz_sub with mpz_sub2_uint
//
fun mpz_sub2_ulint
  (x: &mpz >> _, y: ulint): void = "mac#%"
overload mpz_sub with mpz_sub2_ulint

fun mpz_sub3_mpz
  (x: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
overload mpz_sub with mpz_sub3_mpz
//
fun mpz_sub3_int
  (x: &mpz >> _, y: &mpz, z: int): void = "mac#%"
overload mpz_sub with mpz_sub3_int
//
fun mpz_sub3_lint
  (x: &mpz >> _, y: &mpz, z: lint): void = "mac#%"
overload mpz_sub with mpz_sub3_lint
//
fun mpz_sub3_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
overload mpz_sub with mpz_sub3_uint
//
fun mpz_sub3_ulint
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
overload mpz_sub with mpz_sub3_ulint

(* ****** ****** *)
//
// multiplication
//
symintr mpz_mul
//
fun mpz_mul2_mpz
  (x: &mpz >> _, y: &mpz): void = "mac#%"
overload mpz_mul with mpz_mul2_mpz
//
fun mpz_mul2_int
  (x: &mpz >> _, y: int): void = "mac#%"
overload mpz_mul with mpz_mul2_int
//
fun mpz_mul2_lint
  (x: &mpz >> _, y: lint): void = "mac#%"
overload mpz_mul with mpz_mul2_lint
//
fun mpz_mul2_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
overload mpz_mul with mpz_mul2_uint
//
fun mpz_mul2_ulint
  (x: &mpz >> _, y: ulint): void = "mac#%"
overload mpz_mul with mpz_mul2_ulint

fun mpz_mul3_mpz
  (x: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
overload mpz_mul with mpz_mul3_mpz
//
fun mpz_mul3_int
  (x: &mpz >> _, y: &mpz, z: int): void = "mac#%"
overload mpz_mul with mpz_mul3_int
//
fun mpz_mul3_lint
  (x: &mpz >> _, y: &mpz, z: lint): void = "mac#%"
overload mpz_mul with mpz_mul3_lint
//
fun mpz_mul3_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
overload mpz_mul with mpz_mul3_uint
//
fun mpz_mul3_ulint
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
overload mpz_mul with mpz_mul3_ulint

(* ****** ****** *)

(* end of [gmp.sats] *)
