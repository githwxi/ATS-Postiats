(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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

(*
** Author: Hongwei Xi // MPZ and MPQ
** Authoremail: hwxi AT cs DOT bu DOT edu
*)
(*
** Author: Shivkumar Chandrasekaran // MPF
** Authoremail: shiv AT ece DOT ucsb DOT edu)
*)

(* ****** ****** *)

%{#
//
#include "libgmp/CATS/gmp.cats"
//
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libgmp"
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
fun mpz_get_int (x: &RD(mpz)): int = "mac#%"
fun mpz_get_lint (x: &RD(mpz)): lint = "mac#%"
//
fun mpz_get_uint (x: &RD(mpz)): uint = "mac#%"
fun mpz_get_ulint (x: &RD(mpz)): ulint = "mac#%"
//
fun mpz_get_double (x: &RD(mpz)): double = "mac#%"
//
(* ****** ****** *)
//
// HX-2013-04:
// [res] should hold enough memory for output
//
fun mpz_get_str
(
  res: ptr
, base: mp_base, x: &RD(mpz)
) : Strptr1 = "mac#%"
fun mpz_get_str_null
   (base: mp_base, x: &RD(mpz)) : Strptr1 = "mac#%"
//
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
  (x: &mpz >> _, y: &RD(mpz)): void = "mac#%"
fun mpz_set_mpq
  (x: &mpz >> _, y: &RD(mpq)): void = "mac#%"
fun mpz_set_mpf
  (x: &mpz >> _, y: &RD(mpf)): void = "mac#%"
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
//
symintr mpz_init_set // x := y
//
fun mpz_init_set_int
  (x: &mpz? >> mpz, y: int): void = "mac#%"
fun mpz_init_set_uint
  (x: &mpz? >> mpz, y: uint): void = "mac#%"
fun mpz_init_set_lint
  (x: &mpz? >> mpz, y: lint): void = "mac#%"
fun mpz_init_set_ulint
  (x: &mpz? >> mpz, y: ulint): void = "mac#%"
overload mpz_init_set with mpz_init_set_ulint
fun mpz_init_set_mpz
  (x: &mpz? >> mpz, y: &mpz): void = "mac#%"
//
overload mpz_init_set with mpz_init_set_int
overload mpz_init_set with mpz_init_set_uint
overload mpz_init_set with mpz_init_set_lint
overload mpz_init_set with mpz_init_set_mpz
//
(* ****** ****** *)

fun mpz_size (x: &RD(mpz)): size_t = "mac#%"

(* ****** ****** *)

fun mpz_out_str
  (out: FILEref, base: mp_base, x: &RD(mpz)): size_t = "mac#%"
// end of [mpz_out_str]

fun mpz_inp_str
  (x: &mpz >> _, inp: FILEref, base: mp_base): size_t = "mac#%"
// end of [mpz_inp_str]

(* ****** ****** *)
//
fun fprint_mpz (out: FILEref, x: &RD(mpz)): void = "mac#%"
fun fprint_mpz_base (out: FILEref, x: &RD(mpz), base: mp_base): void = "mac#%"
//
overload fprint with fprint_mpz
overload fprint with fprint_mpz_base
//
(* ****** ****** *)

fun mpz_out_raw (out: FILEref, x: &RD(mpz)): size_t = "mac#%"
fun mpz_inp_raw (x: &mpz >> _, out: FILEref): size_t = "mac#%"

(* ****** ****** *)

fun mpz_odd_p (x: &RD(mpz)):<> bool = "mac#%"
fun mpz_even_p (x: &RD(mpz)):<> bool = "mac#%"

(* ****** ****** *)
//
// HX: negation
//
symintr mpz_neg
//
// x := -x // -y
//
fun mpz_neg1
  (x: &mpz >> _): void = "mac#%"
fun mpz_neg2
  (x: &mpz >> _, y: &mpz): void = "mac#%"
overload mpz_neg with mpz_neg1
overload mpz_neg with mpz_neg2
//
(* ****** ****** *)
//
// absolute value
//
symintr mpz_abs
//
// x := |x| // |y|
//
fun mpz_abs1
  (x: &mpz >> _): void = "mac#%"
fun mpz_abs2
  (x: &mpz >> _, y: &mpz): void = "mac#%"
overload mpz_abs with mpz_abs1
overload mpz_abs with mpz_abs2
//
(* ****** ****** *)
//
// addition
//
symintr mpz_add
//
fun mpz_add2_mpz
  (x: &mpz >> _, y: &mpz): void = "mac#%"
fun mpz_add2_int
  (x: &mpz >> _, y: int): void = "mac#%"
fun mpz_add2_lint
  (x: &mpz >> _, y: lint): void = "mac#%"
fun mpz_add2_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
fun mpz_add2_ulint
  (x: &mpz >> _, y: ulint): void = "mac#%"
fun mpz_add3_mpz
  (x: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
fun mpz_add3_int
  (x: &mpz >> _, y: &mpz, z: int): void = "mac#%"
fun mpz_add3_lint
  (x: &mpz >> _, y: &mpz, z: lint): void = "mac#%"
fun mpz_add3_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
fun mpz_add3_ulint
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
//
overload mpz_add with mpz_add2_mpz
overload mpz_add with mpz_add2_int
overload mpz_add with mpz_add2_lint
overload mpz_add with mpz_add2_uint
overload mpz_add with mpz_add2_ulint
overload mpz_add with mpz_add3_mpz
overload mpz_add with mpz_add3_int
overload mpz_add with mpz_add3_lint
overload mpz_add with mpz_add3_uint
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
fun mpz_sub2_int
  (x: &mpz >> _, y: int): void = "mac#%"
fun mpz_sub2_lint
  (x: &mpz >> _, y: lint): void = "mac#%"
fun mpz_sub2_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
fun mpz_sub2_ulint
  (x: &mpz >> _, y: ulint): void = "mac#%"
fun mpz_sub3_mpz
  (x: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
fun mpz_sub3_int
  (x: &mpz >> _, y: &mpz, z: int): void = "mac#%"
fun mpz_sub3_lint
  (x: &mpz >> _, y: &mpz, z: lint): void = "mac#%"
fun mpz_sub3_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
fun mpz_sub3_ulint
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
//
overload mpz_sub with mpz_sub2_mpz
overload mpz_sub with mpz_sub2_int
overload mpz_sub with mpz_sub2_lint
overload mpz_sub with mpz_sub2_uint
overload mpz_sub with mpz_sub2_ulint
overload mpz_sub with mpz_sub3_mpz
overload mpz_sub with mpz_sub3_int
overload mpz_sub with mpz_sub3_lint
overload mpz_sub with mpz_sub3_uint
overload mpz_sub with mpz_sub3_ulint
//
(* ****** ****** *)
//
// multiplication
//
symintr mpz_mul
//
fun mpz_mul2_mpz
  (x: &mpz >> _, y: &mpz): void = "mac#%"
fun mpz_mul2_int
  (x: &mpz >> _, y: int): void = "mac#%"
fun mpz_mul2_lint
  (x: &mpz >> _, y: lint): void = "mac#%"
fun mpz_mul2_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
fun mpz_mul2_ulint
  (x: &mpz >> _, y: ulint): void = "mac#%"
fun mpz_mul3_mpz
  (x: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
fun mpz_mul3_int
  (x: &mpz >> _, y: &mpz, z: int): void = "mac#%"
fun mpz_mul3_lint
  (x: &mpz >> _, y: &mpz, z: lint): void = "mac#%"
fun mpz_mul3_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
fun mpz_mul3_ulint
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
//
overload mpz_mul with mpz_mul2_mpz
overload mpz_mul with mpz_mul2_int
overload mpz_mul with mpz_mul2_lint
overload mpz_mul with mpz_mul2_uint
overload mpz_mul with mpz_mul2_ulint
overload mpz_mul with mpz_mul3_mpz
overload mpz_mul with mpz_mul3_int
overload mpz_mul with mpz_mul3_lint
overload mpz_mul with mpz_mul3_uint
overload mpz_mul with mpz_mul3_ulint
//
(* ****** ****** *)

(*
**
** Author: Zhiqiang Ren
** Authoremail: arenATcsDOTbuDOTedu
**
** Description:
** Set res to arg * (2 ^ exp)
** The same object can be passed for both res and arg1.
** It's up to an application to call functions like mpz_mul_2exp when appropriate.
** General purpose functions like mpz_mul make no attempt to identify powers of two
** or other special forms.
**
*)
//
symintr mpz_mul_2exp
//
fun mpz_mul3_2exp
  (res: &mpz, arg: &mpz, exp: ulint): void = "mac#%"
//
overload mpz_mul_2exp with mpz_mul3_2exp 
//
(* ****** ****** *)
//
// trunc-division-functions
//
symintr mpz_tdiv_q
//
// x := trunc(x/y) // trunc(y/z)
//
fun mpz_tdiv2_q_mpz
  (x: &mpz >> _, y: &mpz): void = "mac#%"
fun mpz_tdiv2_q_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
fun mpz_tdiv2_q_ulint
  (x: &mpz >> _, y: ulint): void = "mac#%"
fun mpz_tdiv3_q_mpz
  (x: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
fun mpz_tdiv3_q_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
fun mpz_tdiv3_q_ulint
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
//
overload mpz_tdiv_q with mpz_tdiv2_q_mpz
overload mpz_tdiv_q with mpz_tdiv2_q_uint
overload mpz_tdiv_q with mpz_tdiv2_q_ulint
overload mpz_tdiv_q with mpz_tdiv3_q_mpz
overload mpz_tdiv_q with mpz_tdiv3_q_uint
overload mpz_tdiv_q with mpz_tdiv3_q_ulint
//
symintr mpz_tdiv_r
//
// x := x-trunc(x/y)*y // y-trunc(y/z)*z
//
fun mpz_tdiv2_r_mpz
  (x: &mpz >> _, y: &mpz): void = "mac#%"
fun mpz_tdiv2_r_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
fun mpz_tdiv2_r_ulint
  (x: &mpz >> _, y: ulint): void = "mac#%"
fun mpz_tdiv3_r_mpz
  (x: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
fun mpz_tdiv3_r_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
fun mpz_tdiv3_r_ulint
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
//
overload mpz_tdiv_r with mpz_tdiv2_r_mpz
overload mpz_tdiv_r with mpz_tdiv2_r_uint
overload mpz_tdiv_r with mpz_tdiv2_r_ulint
overload mpz_tdiv_r with mpz_tdiv3_r_mpz
overload mpz_tdiv_r with mpz_tdiv3_r_uint
overload mpz_tdiv_r with mpz_tdiv3_r_ulint
//
symintr mpz_tdiv_qr
//
fun mpz_tdiv3_qr_mpz
  (xq: &mpz >> _, xr: &mpz >> _, y: &mpz): void = "mac#%"
fun mpz_tdiv3_qr_uint
  (xq: &mpz >> _, xr: &mpz >> _, y: uint): void = "mac#%"
fun mpz_tdiv3_qr_ulint
  (xq: &mpz >> _, xr: &mpz >> _, y: ulint): void = "mac#%"
fun mpz_tdiv4_qr_mpz
  (xq: &mpz >> _, xr: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
fun mpz_tdiv4_qr_uint
  (xq: &mpz >> _, xr: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
fun mpz_tdiv4_qr_ulint
  (xq: &mpz >> _, xr: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
//
overload mpz_tdiv_qr with mpz_tdiv3_qr_mpz
overload mpz_tdiv_qr with mpz_tdiv3_qr_uint
overload mpz_tdiv_qr with mpz_tdiv3_qr_ulint
overload mpz_tdiv_qr with mpz_tdiv4_qr_mpz
overload mpz_tdiv_qr with mpz_tdiv4_qr_uint
overload mpz_tdiv_qr with mpz_tdiv4_qr_ulint
//
(* ****** ****** *)
//
// floor-division-functions
//
symintr mpz_fdiv
//
fun mpz_fdiv_uint
  (x: &mpz, d: uint): uint = "mac#%"
fun mpz_fdiv_ulint
  (x: &mpz, d: ulint): ulint = "mac#%"
overload mpz_fdiv with mpz_fdiv_uint
overload mpz_fdiv with mpz_fdiv_ulint
//
symintr mpz_fdiv_q
//
// x := floor(x/y) // floor(y/z)
//
fun mpz_fdiv2_q_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
fun mpz_fdiv2_q_ulint
  (x: &mpz >> _, y: ulint): void = "mac#%"
fun mpz_fdiv3_q_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
fun mpz_fdiv3_q_ulint // x := floor(y / z)
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
//
overload mpz_fdiv_q with mpz_fdiv2_q_uint
overload mpz_fdiv_q with mpz_fdiv2_q_ulint
overload mpz_fdiv_q with mpz_fdiv3_q_uint
overload mpz_fdiv_q with mpz_fdiv3_q_ulint
//
(* ****** ****** *)
(*
**
**
** Author: Zhiqiang Ren
** Authoremail: arenATcsDOTbuDOTedu
**
** Description:
** Set quot and rem so that dividend = quot * divisor + rem
** Rounds quot down towards negative infinity, and rem will
** have the same sign as divisor, and 0 <= |rem| < |divisor|.
** The same object cannot be passed for both quot and rem, or the result will be
** unpredictable. No other constraints on the passing arguments.
*)
//
symintr mpz_fdiv_qr
//
fun
mpz_fdiv4_qr_mpz
(
  quot: &mpz, rem: &mpz, dividend: &mpz, divisor: &mpz
) :<> void = "mac#%"
fun
mpz_fdiv4_qr_ulint
(
  quot: &mpz, rem: &mpz, dividend: &mpz, divisor: ulint
) :<> ulint = "mac#%"
//
overload mpz_fdiv_qr with mpz_fdiv4_qr_mpz
overload mpz_fdiv_qr with mpz_fdiv4_qr_ulint
//
(* ****** ****** *)
//
// ceiling-division-functions
//
symintr mpz_cdiv
//
fun mpz_cdiv_uint
  (x: &mpz, d: uint): uint = "mac#%"
fun mpz_cdiv_ulint
  (x: &mpz, d: ulint): ulint = "mac#%"
//
overload mpz_cdiv with mpz_cdiv_uint
overload mpz_cdiv with mpz_cdiv_ulint
//
symintr mpz_cdiv_q
//
// x := ceiling(x/y) // ceiling(y/z)
fun mpz_cdiv2_q_uint
  (x: &mpz >> _, y: uint): void = "mac#%"
fun mpz_cdiv2_q_ulint
  (x: &mpz >> _, y: uint): void = "mac#%"
fun mpz_cdiv3_q_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
fun mpz_cdiv3_q_ulint // x := ceiling(y / z)
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
//
overload mpz_cdiv_q with mpz_cdiv2_q_uint
overload mpz_cdiv_q with mpz_cdiv2_q_ulint
overload mpz_cdiv_q with mpz_cdiv3_q_uint
overload mpz_cdiv_q with mpz_cdiv3_q_ulint
//
(* ****** ****** *)
//
// modulo-functions
//
symintr mpz_mod
//
fun mpz_mod2_uint
  (r: &mpz >> _, d: uint): uint = "mac#%"
overload mpz_mod with mpz_mod2_uint
//
fun mpz_mod2_ulint
  (r: &mpz >> _, d: ulint): ulint = "mac#%"
overload mpz_mod with mpz_mod2_ulint

fun mpz_mod3_uint
  (r: &mpz >> _, n: &mpz, d: uint): uint = "mac#%"
overload mpz_mod with mpz_mod3_uint
//
fun mpz_mod3_ulint
  (r: &mpz >> _, n: &mpz, d: ulint): ulint = "mac#%"
overload mpz_mod with mpz_mod3_ulint

(* ****** ****** *)
//
// add/mul combination
// addmul (x, y, z): x := x + y * z
//
symintr mpz_addmul
//
fun mpz_addmul3_mpz
  (x: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
fun mpz_addmul3_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
fun mpz_addmul3_ulint
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
//
overload mpz_addmul with mpz_addmul3_mpz
overload mpz_addmul with mpz_addmul3_uint
overload mpz_addmul with mpz_addmul3_ulint
//
// sub/mul combination
// submul (x, y, z): x := x - y * z
//
symintr mpz_submul
//
fun mpz_submul3_mpz
  (x: &mpz >> _, y: &mpz, z: &mpz): void = "mac#%"
fun mpz_submul3_uint
  (x: &mpz >> _, y: &mpz, z: uint): void = "mac#%"
fun mpz_submul3_ulint
  (x: &mpz >> _, y: &mpz, z: ulint): void = "mac#%"
//
overload mpz_submul with mpz_submul3_mpz
overload mpz_submul with mpz_submul3_uint
overload mpz_submul with mpz_submul3_ulint
//
(* ****** ****** *)
//
// comparison-functions
//
symintr mpz_cmp
//
fun mpz_cmp_mpz (x: &mpz, y: &mpz):<> int = "mac#%"
fun mpz_cmp_int (x: &mpz, y: int):<> int = "mac#%"
fun mpz_cmp_uint (x: &mpz, y: uint):<> int = "mac#%"
fun mpz_cmp_lint (x: &mpz, y: lint):<> int = "mac#%"
fun mpz_cmp_ulint (x: &mpz, y: ulint):<> int = "mac#%"
//
overload mpz_cmp with mpz_cmp_mpz
overload mpz_cmp with mpz_cmp_int
overload mpz_cmp with mpz_cmp_uint
overload mpz_cmp with mpz_cmp_lint
overload mpz_cmp with mpz_cmp_ulint
//
(* ****** ****** *)

symintr mpz_pow
//
fun mpz_pow_uint
  (pwr: &mpz >> _, base: &mpz, exp: uint): void = "mac#%"
fun mpz_pow_ulint
  (pwr: &mpz >> _, base: &mpz, exp: ulint): void = "mac#%"
//
overload mpz_pow with mpz_cmp_uint
overload mpz_pow with mpz_cmp_ulint
//
fun mpz_ui_pow_ui
  (pw: &mpz >> _, base: ulint, exp: ulint): void = "mac#%"
//
(* ****** ****** *)

symintr mpz_fib
symintr mpz_fib2
//
fun mpz_fib_uint
  (x: &mpz >> _, n: ulint): void = "mac#%"
fun mpz_fib2_uint
  (x1: &mpz >> _, x2: &mpz >> _, n: ulint): void = "mac#%"
//
overload mpz_fib with mpz_fib_uint
overload mpz_fib2 with mpz_fib2_uint
//
(* ****** ****** *)

(* end of [gmp.sats] *)
