/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2008 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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
*) */

/* ****** ****** */

/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATS_LIBC_GMP_CATS
#define ATS_LIBC_GMP_CATS

/* ****** ****** */

#include <stdio.h>
#include <gmp.h>

/* ****** ****** */

#include "ats_types.h"

/* ****** ****** */

#include "prelude/CATS/basics.cats"

/* ****** ****** */

typedef unsigned long int ulint ;

/* ****** ****** */

// [mpz_t] is one-element array of [__mpz_struct]
typedef __mpz_struct ats_mpz_viewt0ype ;

// [mpq_t] is one-element array of [__mpq_struct]
typedef __mpq_struct ats_mpq_viewt0ype ;

// [mpf_t] is one-element array of [__mpf_struct]
typedef __mpf_struct ats_mpf_viewt0ype ;

// [mpz_ptr] is defined in [gmp.h]

// call-by-reference
typedef ats_ref_type ats_mpz_ptr_type ;
typedef ats_ref_type ats_mpq_ptr_type ;
typedef ats_ref_type ats_mpf_ptr_type ;

/* ****** ****** */

//
// [gmp_randstate_t] is
// one-element array of [__gmp_randstate_struct]
//
typedef __gmp_randstate_struct ats_gmp_randstate_viewt0ype ;

/* ****** ****** */

//
// init/clear/realloc
//

#define atslib_mpz_init mpz_init
#define atslib_mpz_init2 mpz_init2
#define atslib_mpz_clear mpz_clear
#define atslib_mpz_realloc2 mpz_realloc2

/* ****** ****** */
//
// HX: integral number operations
//
/* ****** ****** */

//
// get functions
//

#define atslib_mpz_get_int mpz_get_si
#define atslib_mpz_get_uint mpz_get_ui
#define atslib_mpz_get_lint mpz_get_si
#define atslib_mpz_get_ulint mpz_get_ui
#define atslib_mpz_get_double mpz_get_d

ATSinline()
ats_ptr_type
atslib_mpz_get_str (
  ats_int_type base, ats_mpz_ptr_type x
) {
  return mpz_get_str((char*)0, base, (mpz_ptr)x) ;
} // end of [atslib_mpz_get_str]

//
// set functions
//

#define atslib_mpz_set_mpz mpz_set
#define atslib_mpz_set_int mpz_set_si
#define atslib_mpz_set_uint mpz_set_ui
#define atslib_mpz_set_lint mpz_set_si
#define atslib_mpz_set_ulint mpz_set_ui
#define atslib_mpz_set_double mpz_set_d
#define atslib_mpz_set_mpq mpz_set_q
#define atslib_mpz_set_mpf mpz_set_f
#define atslib_mpz_set_str mpz_set_str

ATSinline()
ats_void_type
atslib_mpz_set_str_exn (
  ats_mpz_ptr_type x, ats_ptr_type s, ats_int_type base
) {
  int n ;
  n = mpz_set_str((mpz_ptr)x, (char*)s, base) ;
  if (n < 0) {
    atspre_exit_prerrf(1, "exit(ATS): [mpz_set_str(%s)]: failed\n", s) ;
  } // end of [if]
  return ;
} // end of [atslib_mpz_set_str_exn]

//
// init and set functions
//

#define atslib_mpz_init_set_mpz mpz_init_set
#define atslib_mpz_init_set_int mpz_init_set_si
#define atslib_mpz_init_set_uint mpz_init_set_ui
#define atslib_mpz_init_set_lint mpz_init_set_si
#define atslib_mpz_init_set_ulint mpz_init_set_ui
#define atslib_mpz_init_set_double mpz_init_set_d

ATSinline()
ats_void_type
atslib_mpz_init_set_mpq
  (ats_mpz_ptr_type x, ats_mpq_ptr_type y) {
  mpz_init((mpz_ptr)x) ; mpz_set_q((mpz_ptr)x, (mpq_ptr)y); return ;
} // end of [atslib_mpz_init_set_mpq]

ATSinline()
ats_void_type
atslib_mpz_init_set_mpf
  (ats_mpz_ptr_type x, ats_mpf_ptr_type y) {
  mpz_init((mpz_ptr)x) ; mpz_set_f((mpz_ptr)x, (mpf_ptr)y); return ;
} // end of [atslib_mpz_init_set_mpf]

#define atslib_mpz_init_set_str mpz_init_set_str

ATSinline()
ats_void_type
atslib_mpz_init_set_str_exn (
  ats_mpz_ptr_type x, ats_ptr_type s, ats_int_type base
) {
  int err ;
  err = mpz_init_set_str((mpz_ptr)x, (char*)s, base) ;
  if (err < 0) {
    atspre_exit_prerrf(1, "exit(ATS): [mpz_init_set_str(%s)] failed\n", s) ;
  } // end of [if]
  return ;
} // end of [atslib_mpz_init_set_str_exn]

/* ****** ****** */

#define atslib_mpz_swap mpz_swap

/* ****** ****** */

ATSinline()
ats_bool_type
atslib_mpz_odd_p (ats_ref_type x) {
  return mpz_odd_p((mpz_ptr)x) ? ats_true_bool : ats_false_bool ;
} // end of [atslib_mpz_odd_p]

ATSinline()
ats_bool_type
atslib_mpz_even_p (ats_ref_type x) {
  return mpz_even_p((mpz_ptr)x) ? ats_true_bool : ats_false_bool ;
} // end of [atslib_mpz_even_p]

#define atslib_mpz_fits_int_p mpz_fits_int_p
#define atslib_mpz_fits_uint_p mpz_fits_uint_p
#define atslib_mpz_fits_lint_p mpz_fits_long_p
#define atslib_mpz_fits_ulint_p mpz_fits_ulong_p
#define atslib_mpz_fits_sint_p mpz_fits_sshort_p
#define atslib_mpz_fits_usint_p mpz_fits_ushort_p

#define atslib_mpz_size mpz_size
#define atslib_mpz_sizeinbase mpz_sizeinbase

/* ****** ****** */

//
// negation
//

#define atslib_mpz_neg2 mpz_neg

ATSinline()
ats_void_type
atslib_mpz_neg1
  (ats_mpz_ptr_type x) {
  mpz_neg((mpz_ptr)x, (mpz_ptr)x) ; return ;
} // end of [atslib_mpz_neg1]

//
// absolute value
//

#define atslib_mpz_abs2 mpz_abs

ATSinline()
ats_void_type
atslib_mpz_abs1
  (ats_mpz_ptr_type x) {
  mpz_abs((mpz_ptr)x, (mpz_ptr)x) ; return ;
} // end of [atslib_mpz_abs1]

/* ****** ****** */

//
// addition, subtraction and multiplcation
//

/* ****** ****** */

//
// addition
//

#define atslib_mpz_add3_mpz mpz_add

#define atslib_mpz_add3_int(x, y, z) \
  atslib_mpz_add3_lint(x, y, (ats_lint_type)z)

#define atslib_mpz_add3_uint mpz_add_ui

ATSinline()
ats_void_type
atslib_mpz_add3_lint
  (ats_mpz_ptr_type x, ats_mpz_ptr_type y, ats_lint_type z) {
  if (z >= 0) {
    mpz_add_ui ((mpz_ptr)x, (mpz_ptr)y, (ulint)z) ;
  } else {
    mpz_sub_ui ((mpz_ptr)x, (mpz_ptr)y, (ulint)-z) ;
  }
  return ;
} // end of [atslib_mpz_add3_lint]

#define atslib_mpz_add3_ulint mpz_add_ui

//

ATSinline()
ats_void_type
atslib_mpz_add2_mpz (
  ats_mpz_ptr_type x, ats_mpz_ptr_type y
) {
  mpz_add ((mpz_ptr)x, (mpz_ptr)x, (mpz_ptr)y) ; return ;
} // end of [atslib_mpz_add2_mpz]

ATSinline()
ats_void_type
atslib_mpz_add2_lint (
  ats_mpz_ptr_type x, ats_lint_type y
) {
  if (y >= 0) {
    mpz_add_ui ((mpz_ptr)x, (mpz_ptr)x, (ulint)y) ;
  } else {
    mpz_sub_ui ((mpz_ptr)x, (mpz_ptr)x, (ulint)-y) ;
  } // end of [if]
  return ;
} // end of [atslib_mpz_add2_lint]

ATSinline()
ats_void_type
atslib_mpz_add2_ulint (
  ats_mpz_ptr_type x, ats_ulint_type y
) {
  mpz_add_ui ((mpz_ptr)x, (mpz_ptr)x, y) ; return ;
} // end of [atslib_mpz_add2_ulint]

#define atslib_mpz_add2_int(x, y) atslib_mpz_add2_lint(x, (ats_lint_type)y)
#define atslib_mpz_add2_uint(x, y) atslib_mpz_add2_lint(x, (ats_ulint_type)y)

//
// subtraction
//

#define atslib_mpz_sub3_mpz mpz_sub

#define atslib_mpz_sub3_int(x, y, z) \
  atslib_mpz_sub3_lint(x, y, (ats_lint_type)z)
#define atslib_mpz_sub3_uint mpz_sub_ui

ATSinline()
ats_void_type
atslib_mpz_sub3_lint (
  ats_mpz_ptr_type x, ats_mpz_ptr_type y, ats_lint_type z
) {
  if (z >= 0) {
    mpz_sub_ui ((mpz_ptr)x, (mpz_ptr)y, (ulint)z) ;
  } else {
    mpz_add_ui ((mpz_ptr)x, (mpz_ptr)y, (ulint)-z) ;
  }
  return ;
} // end of [atslib_mpz_sub3_lint]

#define atslib_mpz_sub3_ulint mpz_sub_ui

#define atslib_mpz_ui_sub3 mpz_ui_sub


ATSinline()
ats_void_type
atslib_mpz_sub2_mpz (
  ats_mpz_ptr_type x, ats_mpz_ptr_type y
) {
  mpz_sub ((mpz_ptr)x, (mpz_ptr)x, (mpz_ptr)y) ; return ;
} // end of [atslib_mpz_sub2_mpz]

ATSinline()
ats_void_type
atslib_mpz_sub2_lint (
  ats_mpz_ptr_type x, ats_lint_type y
) {
  if (y >= 0) {
    mpz_sub_ui ((mpz_ptr)x, (mpz_ptr)x, y) ;
  } else {
    mpz_add_ui ((mpz_ptr)x, (mpz_ptr)x, -y) ;
  }
  return ;
} // end of [atslib_mpz_sub2_lint]

ATSinline()
ats_void_type
atslib_mpz_sub2_ulint (
  ats_mpz_ptr_type x, ats_ulint_type y
) {
  mpz_sub_ui ((mpz_ptr)x, (mpz_ptr)x, y) ; return ;
} // end of [atslib_mpz_sub2_ulint]

#define atslib_mpz_sub2_int(x, y) atslib_mpz_sub2_lint(x, (ats_lint_type)y)
#define atslib_mpz_sub2_uint(x, y) atslib_mpz_sub2_ulint(x, (ats_ulint_type)y)

//
// multiplication
//

#define atslib_mpz_mul3_mpz mpz_mul
#define atslib_mpz_mul3_int mpz_mul_si
#define atslib_mpz_mul3_uint mpz_mul_ui
#define atslib_mpz_mul3_lint mpz_mul_si
#define atslib_mpz_mul3_ulint mpz_mul_ui

ATSinline()
ats_void_type
atslib_mpz_mul2_mpz (
  ats_mpz_ptr_type x, ats_mpz_ptr_type y
) {
  mpz_mul ((mpz_ptr)x, (mpz_ptr)x, (mpz_ptr)y) ; return ;
} // end of [atslib_mpz_mul2_mpz]

ATSinline()
ats_void_type
atslib_mpz_mul2_lint (
  ats_mpz_ptr_type x, ats_lint_type y
) {
  mpz_mul_si ((mpz_ptr)x, (mpz_ptr)x, y) ; return ;
} // end of [atslib_mpz_mul2_lint]

ATSinline()
ats_void_type
atslib_mpz_mul2_ulint (
  ats_mpz_ptr_type x, ats_ulint_type y
) {
  mpz_mul_ui ((mpz_ptr)x, (mpz_ptr)x, y) ; return ;
} // end of [atslib_mpz_mul2_ulint]

#define atslib_mpz_mul2_int(x, y) atslib_mpz_mul2_lint (x, (ats_lint_type)y)
#define atslib_mpz_mul2_uint(x, y) atslib_mpz_mul2_ulint (x, (ats_ulint_type)y)

ATSinline()
ats_void_type
atslib_mpz_mul1_mpz
  (ats_mpz_ptr_type x) {
  mpz_mul ((mpz_ptr)x, (mpz_ptr)x, (mpz_ptr)x) ; return ;
} // end of [atslib_mpz_mul1_mpz]

ATSinline()
ats_void_type
atslib_mpz_mul_2exp ( // x = y * 2^n
  ats_mpz_ptr_type x, ats_mpz_ptr_type y, ats_ulint_type n
) {
  mpz_mul_2exp((mpz_ptr)x, (mpz_ptr)y, n) ; return ;
} // end of [atslib_mpz_mul_2exp]

/* ****** ****** */

//
// truncate division
//

#define atslib_mpz_tdiv4_qr_mpz mpz_tdiv_qr
#define atslib_mpz_tdiv4_qr_ulint mpz_tdiv_qr_ui

#define atslib_mpz_tdiv3_q_mpz mpz_tdiv_q
#define atslib_mpz_tdiv3_q_ulint mpz_tdiv_q_ui

ATSinline()
ats_void_type
atslib_mpz_tdiv2_q_mpz (
  ats_mpz_ptr_type x, ats_mpz_ptr_type d
) {
  mpz_tdiv_q ((mpz_ptr)x, (mpz_ptr)x, (mpz_ptr)d) ; return ;
} // end of [atslib_mpz_tdiv2_q_mpz]

ATSinline()
ats_ulint_type
atslib_mpz_tdiv2_q_ulint (
  ats_mpz_ptr_type x, ats_ulint_type d
) {
  return mpz_tdiv_q_ui ((mpz_ptr)x, (mpz_ptr)x, d) ;
} // end of [atslib_mpz_tdiv2_q_ulint]

/* ****** ****** */

//
// floor division
//

#define atslib_mpz_fdiv4_qr_mpz mpz_fdiv_qr
#define atslib_mpz_fdiv4_qr_ulint mpz_fdiv_qr_ui

#define atslib_mpz_fdiv3_q_mpz mpz_fdiv_q
#define atslib_mpz_fdiv3_q_ulint mpz_fdiv_q_ui

ATSinline()
ats_void_type
atslib_mpz_fdiv2_q_mpz (
  ats_mpz_ptr_type x, ats_mpz_ptr_type d
) {
  mpz_fdiv_q ((mpz_ptr)x, (mpz_ptr)x, (mpz_ptr)d) ; return ;
} // end of [atslib_mpz_fdiv2_q_mpz]

ATSinline()
ats_ulint_type
atslib_mpz_fdiv2_q_ulint (
  ats_mpz_ptr_type x, ats_ulint_type d
) {
  return mpz_fdiv_q_ui ((mpz_ptr)x, (mpz_ptr)x, d) ;
} // end of [atslib_mpz_fdiv2_q_ulint]

#define atslib_mpz_fdiv3_r_mpz mpz_fdiv_r
#define atslib_mpz_fdiv3_r_ulint mpz_fdiv_r_ui

ATSinline()
ats_void_type
atslib_mpz_fdiv2_r_mpz (
  ats_mpz_ptr_type x, ats_mpz_ptr_type d
) {
  mpz_fdiv_r ((mpz_ptr)x, (mpz_ptr)x, (mpz_ptr)d) ; return ;
} // end of [atslib_mpz_fdiv2_r_mpz]

ATSinline()
ats_ulint_type
atslib_mpz_fdiv2_r_ulint (
  ats_mpz_ptr_type x, ats_ulint_type d
) {
  return mpz_fdiv_r_ui ((mpz_ptr)x, (mpz_ptr)x, d) ;
} // end of [atslib_mpz_fdiv2_r_ulint]

/* ****** ****** */

#define atslib_mpz_divisible_p mpz_divisible_p
#define atslib_mpz_divisible_ui_p mpz_divisible_ui_p

#define atslib_mpz_congruent_p mpz_congruent_p
#define atslib_mpz_congruent_ui_p mpz_congruent_ui_p

/* ****** ****** */

#define atslib_mpz_mod3_mpz mpz_mod
#define atslib_mpz_mod2_mpz(n, d) mpz_mod((mpz_ptr)n, (mpz_ptr)n, (mpz_ptr)d)
#define atslib_mpz_mod3_ulint mpz_mod_ui
#define atslib_mpz_mod2_ulint(n, d) mpz_mod_ui((mpz_ptr)n, (mpz_ptr)n, d)

#define atslib_mpz_divexact3 mpz_divexact
#define atslib_mpz_divexact2(n, d) mpz_divexact((mpz_ptr)n, (mpz_ptr)n, (mpz_ptr)d)

#define atslib_tdiv3_q_2exp tdiv_q_2exp
#define atslib_tdiv3_r_2exp tdiv_r_2exp
#define atslib_fdiv3_q_2exp fdiv_q_2exp
#define atslib_fdiv3_r_2exp fdiv_r_2exp

#define atslib_mpz_divisible_ui_2exp_p mpz_divisible_ui_2exp_p
#define atslib_mpz_congruent_ui_2exp_p mpz_congruent_ui_2exp_p

/* ****** ****** */

#define atslib_mpz_sqrt2 mpz_sqrt

ATSinline()
ats_void_type
atslib_mpz_sqrt1
  (ats_ref_type dst) {
  mpz_sqrt ((mpz_ptr)dst, (mpz_ptr)dst) ; return ;
} // end of [atslib_mpz_sqrt1]

#define atslib_mpz_sqrtrem3 mpz_sqrtrem

#define atslib_mpz_perfect_square_p mpz_perfect_square_p

/* ****** ****** */

#define atslib_mpz_powm4_mpz mpz_powm
#define atslib_mpz_powm4_ui mpz_powm_ui

/* ****** ****** */

#define atslib_mpz_pow3_ui mpz_pow_ui

ATSinline()
ats_void_type
atslib_mpz_pow2_ui (
  ats_ref_type dst, ats_ulint_type src2
) {
  mpz_pow_ui ((mpz_ptr)dst, (mpz_ptr)dst, src2) ; return ;
} // end of [atslib_mpz_pow2_ui]

/* ****** ****** */

// addmul and submul compibination

#define atslib_mpz_addmul3_mpz  mpz_addmul
#define atslib_mpz_addmul3_uint mpz_addmul_ui
#define atslib_mpz_addmul3_ulint mpz_addmul_ui
#define atslib_mpz_submul3_mpz mpz_submul
#define atslib_mpz_submul3_uint mpz_submul_ui
#define atslib_mpz_submul3_ulint mpz_submul_ui

/* ****** ****** */

// comparison functions

#define atslib_mpz_cmp_mpz mpz_cmp

#define atslib_mpz_cmp_lint(x, y) mpz_cmp_si((mpz_ptr)x, y)
#define atslib_mpz_cmp_ulint(x, y) mpz_cmp_ui((mpz_ptr)x, y)

#define atslib_mpz_cmp_int atslib_mpz_cmp_lint
#define atslib_mpz_cmp_uint atslib_mpz_cmp_ulint

ATSinline()
ats_int_type
atslib_mpz_cmp_double (
  ats_ref_type x, ats_double_type y
) {
  return mpz_cmp_d((mpz_ptr)x, y) ;
} // end of [atslib_mpz_cmp_double]

#define atslib_mpz_cmpabs_mpz mpz_cmpabs
#define atslib_mpz_cmpabs_uint mpz_cmpabs_ui
#define atslib_mpz_cmpabs_ulint mpz_cmpabs_ui
#define atslib_mpz_cmpabs_double mpz_cmpabs_d

#define atslib_mpz_sgn mpz_sgn

/* ****** ****** */

#define atslib_mpz_gcd3_mpz mpz_gcd
#define atslib_mpz_gcd2_mpz(dst, src2) \
  mpz_gcd((mpz_ptr)dst, (mpz_ptr)dst, (mpz_ptr)src2)
#define atslib_mpz_gcd3_ui mpz_gcd_ui
#define atslib_mpz_gcd2_ui(dst, src2) mpz_gcd_ui((mpz_ptr)dst, (mpz_ptr)dst, src2)

#define atslib_mpz_gcdext mpz_gcdext

#define atslib_mpz_lcm3_mpz mpz_lcm
#define atslib_mpz_lcm2_mpz(dst, src2) \
  mpz_lcm((mpz_ptr)dst, (mpz_ptr)dst, (mpz_ptr)src2)
#define atslib_mpz_lcm3_ui mpz_lcm_ui
#define atslib_mpz_lcm2_ui(dst, src2) mpz_lcm_ui((mpz_ptr)dst, (mpz_ptr)dst, src2)

#define atslib_mpz_invert3 mpz_invert

/* ****** ****** */
//
// various number-theoretic functions
//

ATSinline()
ats_void_type
atslib_mpz_nextprime1
  (ats_ref_type dst) {
  mpz_nextprime((mpz_ptr)dst, (mpz_ptr)dst); return ;
} // end of [atslib_mpz_nextprime1]
#define atslib_mpz_nextprime2 mpz_nextprime

#define atslib_mpz_jacobi mpz_jacobi
#define atslib_mpz_legendre mpz_legendre

#define atslib_mpz_kronecker_mpz mpz_kronecker
#define atslib_mpz_kronecker_si mpz_kronecker_si
#define atslib_mpz_kronecker_ui mpz_kronecker_ui
#define atslib_mpz_si_kronecker mpz_si_kronecker
#define atslib_mpz_ui_kronecker mpz_ui_kronecker

#define atslib_mpz_fac_ui mpz_fac_ui

#define atslib_mpz_bin3_ui mpz_bin_ui
#define atslib_mpz_bin2_ui(n, k) \
  mpz_bin_ui ((mpz_ptr)n, (mpz_ptr)n, (mpz_ptr)k)
#define atslib_mpz_bin_uiui mpz_bin_uiui

#define atslib_mpz_fib_ui mpz_fib_ui
#define atslib_mpz_fib2_ui mpz_fib2_ui

#define atslib_mpz_remove3 mpz_remove

ATSinline()
ats_void_type
atslib_mpz_remove2 (
  ats_ptr_type dst, ats_ptr_type src2
) {
  mpz_remove ((mpz_ptr)dst, (mpz_ptr)dst, (mpz_ptr)src2); return ;
} // end of [atslib_mpz_remove2]

/* ****** ****** */

//
// some MPZ input/output/print functions
//

#define atslib_mpz_inp_str mpz_inp_str
#define atslib_mpz_out_str mpz_out_str

extern
ats_void_type
atslib_mpz_out_str_exn (
  ats_ptr_type, ats_int_type, ats_mpf_ptr_type
) ; // end of [extern]

ATSinline()
ats_void_type
atslib_fprint_mpz (
  ats_ptr_type file, const ats_mpz_ptr_type x
) {
  atslib_mpz_out_str_exn (file, 10/*base*/, x) ; return ;
} // end of [atslib_fprint_mpz]

#define atslib_mpz_inp_raw mpz_inp_raw
#define atslib_mpz_out_raw mpz_out_raw

/* ****** ****** */
//
//
// HX: rational number operations
//
//
/* ****** ****** */

#define atslib_mpq_canonicalize mpq_canonicalize

#define atslib_mpq_init mpq_init
#define atslib_mpq_clear mpq_clear

#define atslib_mpq_get_d mpq_get_d

ATSinline()
ats_ptr_type
atslib_mpq_get_str (
  ats_int_type base, ats_mpq_ptr_type x
) {
  return mpq_get_str((char*)0, base, (mpq_ptr)x) ;
} // end of [atslib_mpq_get_str]

#define atslib_mpq_get_num mpq_get_num
#define atslib_mpq_get_den mpq_get_den

ATSinline()
ats_ptr_type
atslib_mpq_numref
  (ats_ptr_type x) { return mpq_numref ((mpq_ptr)x) ; }
// end of [atslib_mpq_numref]
ATSinline()
ats_ptr_type
atslib_mpq_denref
  (ats_ptr_type x) { return mpq_denref ((mpq_ptr)x) ; }
// end of [atslib_mpq_denref]

#define atslib_mpq_set_mpq mpq_set
#define atslib_mpq_set_mpz mpq_set_z
#define atslib_mpq_set_si mpq_set_si
#define atslib_mpq_set_ui mpq_set_ui
#define atslib_mpq_set_d mpq_set_d
#define atslib_mpq_set_mpf mpq_set_f
#define atslib_mpq_set_num mpq_set_num
#define atslib_mpq_set_den mpq_set_den

/* ****** ****** */

#define atslib_mpq_neg2 mpq_neg

ATSinline()
ats_void_type
atslib_mpq_neg1
  (ats_mpq_ptr_type x) {
  mpq_neg((mpq_ptr)x, (mpq_ptr)x) ; return ;
} // end of [atslib_mpq_neg1]

/* ****** ****** */

#define atslib_mpq_inv2 mpq_inv

ATSinline()
ats_void_type
atslib_mpq_inv1
  (ats_mpq_ptr_type x) {
  mpq_inv((mpq_ptr)x, (mpq_ptr)x) ; return ;
} // end of [atslib_mpq_inv1]

/* ****** ****** */

#define atslib_mpq_add3_mpq mpq_add

ATSinline()
ats_void_type
atslib_mpq_add2_mpq (
  ats_ref_type dst, ats_ref_type src2
) {
  mpq_add ((mpq_ptr)dst, (mpq_ptr) dst, (mpq_ptr)src2); return ;
} // end of [atslib_mpq_add2_mpq]

#define atslib_mpq_sub3_mpq mpq_sub

ATSinline()
ats_void_type
atslib_mpq_sub2_mpq (
  ats_ref_type dst, ats_ref_type src2
) {
  mpq_sub ((mpq_ptr)dst, (mpq_ptr) dst, (mpq_ptr)src2); return ;
} // end of [atslib_mpq_sub2_mpq]

#define atslib_mpq_mul3_mpq mpq_mul

ATSinline()
ats_void_type
atslib_mpq_mul2_mpq (
  ats_ref_type dst, ats_ref_type src2
) {
  mpq_mul ((mpq_ptr)dst, (mpq_ptr) dst, (mpq_ptr)src2); return ;
} // end of [atslib_mpq_mul2_mpq]

#define atslib_mpq_div3_mpq mpq_div

ATSinline()
ats_void_type
atslib_mpq_div2_mpq (
  ats_ref_type dst, ats_ref_type src2
) {
  mpq_div ((mpq_ptr)dst, (mpq_ptr) dst, (mpq_ptr)src2); return ;
} // end of [atslib_mpq_div2_mpq]

/* ****** ****** */

#define atslib_mpq_equal mpq_equal

#define atslib_mpq_cmp_mpq mpq_cmp
#define atslib_mpq_cmp_ui mpq_cmp_ui

#define atslib_mpq_sgn mpq_sgn

/* ****** ****** */

//
// some MPQ input/output/print functions
//

#define atslib_mpq_inp_str mpq_inp_str
#define atslib_mpq_out_str mpq_out_str

extern
ats_void_type
atslib_mpq_out_str_exn (
  ats_ptr_type, ats_int_type, ats_mpf_ptr_type
) ; // end of [extern]

ATSinline()
ats_void_type
atslib_fprint_mpq (
  ats_ptr_type file, const ats_mpq_ptr_type x
) {
  atslib_mpq_out_str_exn (file, 10/*base*/, x) ; return ;
} // end of [atslib_fprint_mpq]

/* ****** ****** */
//
//
// HX: floating number operations
//
//
/* ****** ****** */

#define atslib_mpf_get_default_prec mpf_get_default_prec
#define atslib_mpf_set_default_prec mpf_set_default_prec

/* ****** ****** */

#define atslib_mpf_init mpf_init
#define atslib_mpf_init2 mpf_init2
#define atslib_mpf_clear mpf_clear

#define atslib_mpf_get_prec mpf_get_prec
#define atslib_mpf_set_prec mpf_set_prec
#define atslib_mpf_set_prec_raw mpf_set_prec_raw

#define atslib_mpf_get_d mpf_get_d
#define atslib_mpf_get_d_2exp mpf_get_d_2exp
#define atslib_mpf_get_si mpf_get_si
#define atslib_mpf_get_ui mpf_get_ui

ATSinline()
ats_ptr_type
atslib_mpf_get_str (
  ats_ptr_type exp
, ats_int_type base, ats_size_type ndigit
, ats_mpf_ptr_type x
) {
  return mpf_get_str((char*)0, (mp_exp_t*)exp, base, ndigit, (mpf_ptr)x) ;
} // end of [atslib_mpf_get_str]

/* ****** ****** */

#define atslib_mpf_set_mpf mpf_set
#define atslib_mpf_set_si mpf_set_si
#define atslib_mpf_set_ui mpf_set_ui
#define atslib_mpf_set_mpz mpf_set_z
#define atslib_mpf_set_mpq mpf_set_q
#define atslib_mpf_set_d mpf_set_d
#define atslib_mpf_set_str mpf_set_str

ATSinline()
ats_void_type
atslib_mpf_set_str_exn (
  ats_mpf_ptr_type x, ats_ptr_type s, ats_int_type base
) {
  int n ;
  n = mpf_set_str((mpf_ptr)x, (char*)s, base) ;
  if (n < 0) {
    atspre_exit_prerrf(1, "exit(ATS): [mpf_set_str(%s)]: failed\n", s) ;
  } // end of [if]
  return ;
} // end of [atslib_mpf_set_str_exn]

/* ****** ****** */

#define atslib_mpf_init_set_mpf mpf_init_set
#define atslib_mpf_init_set_d mpf_init_set_d
#define atslib_mpf_init_set_si mpf_init_set_si
#define atslib_mpf_init_set_ui mpf_init_set_ui
#define atslib_mpf_init_set_str mpf_init_set_str

#define atslib_mpf_swap mpf_swap

/* ****** ****** */

#define atslib_mpf_ceil mpf_ceil
#define atslib_mpf_floor mpf_floor
#define atslib_mpf_trunc mpf_trunc

#define atslib_mpf_integer_p mpf_integer_p
#define atslib_mpf_int_p mpf_int_p
#define atslib_mpf_uint_p mpf_uint_p
#define atslib_mpf_lint_p mpf_slong_p
#define atslib_mpf_ulint_p mpf_ulong_p
#define atslib_mpf_sint_p mpf_sshort_p
#define atslib_mpf_usint_p mpf_ushort_p

#define atslib_mpf_fits_int_p mpf_fits_int_p
#define atslib_mpf_fits_uint_p mpf_fits_uint_p
#define atslib_mpf_fits_lint_p mpf_fits_long_p
#define atslib_mpf_fits_ulint_p mpf_fits_ulong_p
#define atslib_mpf_fits_sint_p mpf_fits_sshort_p
#define atslib_mpf_fits_usint_p mpf_fits_ushort_p

/* ****** ****** */

#define abslib_mpf_neg2 mpf_neg2

ATSinline()
ats_void_type
atslib_mpf_neg1 (ats_ref_type x) {
  mpf_neg ((mpf_ptr)x, (mpf_ptr)x) ; return ;
} // end of [atslib_mpf_neg1]

#define abslib_mpf_abs2 mpf_abs2

ATSinline()
ats_void_type
atslib_mpf_abs1 (ats_ref_type x) {
  mpf_abs ((mpf_ptr) x, (mpf_ptr) x) ; return ;
} // end of [atslib_mpf_abs1]

/* ****** ****** */

#define atslib_mpf_add3_mpf mpf_add
#define atslib_mpf_add3_mpf_ui mpf_add_ui

ATSinline()
ats_void_type
atslib_mpf_add2_mpf (
  ats_ref_type dst, ats_ref_type src2
) {
  mpf_add ((mpf_ptr)dst, (mpf_ptr) dst, (mpf_ptr)src2); return ;
} // end of [atslib_mpf_add2_mpf]

ATSinline()
ats_void_type
atslib_mpf_add2_ui (
  ats_ref_type dst, ats_ulint_type src2
) {
  mpf_add_ui ((mpf_ptr)dst, (mpf_ptr)dst, src2) ; return ;
} // end of [atslib_mpf_add2_ui]

/* ****** ****** */

#define atslib_mpf_sub3_mpf mpf_sub
#define atslib_mpf_sub3_ui mpf_sub_ui
#define atslib_mpf_ui_sub3 mpf_ui_sub

ATSinline()
ats_void_type
atslib_mpf_sub2_mpf (
  ats_ref_type dst, ats_ref_type src2
) {
  mpf_sub ((mpf_ptr) dst, (mpf_ptr) dst, (mpf_ptr) src2) ; return ;
} // end of [atslib_mpf_sub2_mpf]


ATSinline()
ats_void_type
atslib_mpf_sub2_ui (
  ats_ref_type dst, ats_ulint_type src2
) {
  mpf_sub_ui ((mpf_ptr)dst, (mpf_ptr)dst, src2) ; return ;
} // end of [atslib_mpf_sub2_ui]

ATSinline()
ats_void_type
atslib_mpf_ui_sub2 (
  ats_ref_type dst, ats_ulint_type src1
) {
  mpf_ui_sub ((mpf_ptr)dst, src1, (mpf_ptr)dst) ; return ;
} // end of [atslib_mpf_ui_sub2]

/* ****** ****** */

#define atslib_mpf_mul3_mpf mpf_mul
#define atslib_mpf_mul3_ui mpf_mul_ui

ATSinline()
ats_void_type
atslib_mpf_mul2_mpf (
  ats_ref_type dst, ats_ref_type src2
) {
  mpf_mul ((mpf_ptr)dst, (mpf_ptr)dst, (mpf_ptr)src2) ; return ;
} // end of [atslib_mpf_mul2_mpf]

ATSinline()
ats_void_type
atslib_mpf_mul2_ui (
  ats_ref_type dst, ats_ulint_type src2
) {
  mpf_mul_ui ((mpf_ptr)dst, (mpf_ptr)dst, src2) ; return ;
} // end of [atslib_mpf_mul2_ui]

/* ****** ****** */

#define atslib_mpf_div3_mpf mpf_div
#define atslib_mpf_div3_ui mpf_div_ui
#define atslib_mpf_ui_div3 mpf_ui_div

ATSinline()
ats_void_type
atslib_mpf_div2_mpf
(ats_ref_type dst, ats_ref_type src2) {
  mpf_div ((mpf_ptr)dst, (mpf_ptr)dst, (mpf_ptr)src2) ; return ;
} // end of [atslib_mpf_div2_mpf]

ATSinline()
ats_void_type
atslib_mpf_div2_ui (
  ats_ref_type dst, ats_ulint_type src2
) {
  mpf_div_ui ((mpf_ptr)dst, (mpf_ptr)dst, src2) ; return ;
} // end of [atslib_mpf_div2_ui]

ATSinline()
ats_void_type
atslib_mpf_ui_div2 (
  ats_ref_type dst, ats_ulint_type src1
) {
  mpf_ui_div ((mpf_ptr)dst, src1, (mpf_ptr)dst) ; return ;
} // end of [atslib_mpf_ui_div2]

/* ****** ****** */

#define atslib_mpf_sqrt2_mpf mpf_sqrt
#define atslib_mpf_sqrt2_ui mpf_sqrt_ui

ATSinline()
ats_void_type
atslib_mpf_sqrt1_mpf
  (ats_ref_type dst) {
  mpf_sqrt ((mpf_ptr)dst, (mpf_ptr)dst) ; return ;
} // end of [atslib_mpf_sqrt1]

/* ****** ****** */

#define atslib_mpf_pow3_ui mpf_pow_ui

ATSinline()
ats_void_type
atslib_mpf_pow2_ui (
  ats_ref_type dst, ats_ulint_type src2
) {
  mpf_pow_ui ((mpf_ptr)dst, (mpf_ptr)dst, src2) ; return ;
} // end of [atslib_mpf_pow2_ui]

/* ****** ****** */

#define atslib_mpf_mul3_2exp mpf_mul_2exp

ATSinline()
ats_void_type
atslib_mpf_mul2_2exp (
  ats_ref_type dst, ats_ulint_type src2
) {
  mpf_mul_2exp ((mpf_ptr)dst, (mpf_ptr)dst, src2) ; return ;
} // end of [atslib_mpf_mul2_2exp]

/* ****** ****** */

#define atslib_mpf_div3_2exp mpf_div_2exp

ATSinline()
ats_void_type
atslib_mpf_div2_2exp (
  ats_ref_type dst, ats_ulint_type src2
) {
  mpf_div_2exp ((mpf_ptr)dst, (mpf_ptr)dst, src2) ; return ;
} // end of [atslib_mpf_div2_2exp]

/* ****** ****** */

#define atslib_mpf_eq mpf_eq

#define atslib_mpf_cmp_mpf mpf_cmp
#define atslib_mpf_cmp_si mpf_cmp_si
#define atslib_mpf_cmp_ui mpf_cmp_ui
#define atslib_mpf_cmp_d mpf_cmp_d

#define atslib_mpf_sgn mpf_sgn

/* ****** ****** */

#define atslib_mpf_reldiff mpf_reldiff

/* ****** ****** */
//
// HX: input/output/print functions
//
#define atslib_mpf_out_str mpf_out_str
#define atslib_mpf_inp_str mpf_inp_str

extern ats_void_type atslib_mpf_out_str_exn (
  ats_ptr_type, ats_int_type, ats_size_type, ats_mpf_ptr_type
) ; // end of [extern]

ATSinline()
ats_void_type
atslib_fprint_mpf (
  ats_ptr_type file, ats_mpf_ptr_type x, ats_size_type ndigit
) {
  atslib_mpf_out_str_exn (file, 10/*base*/, ndigit, x) ; return ;
} // end of [atslib_fprint_mpf]

ATSinline()
ats_void_type
atslib_print_mpf (
  const ats_mpf_ptr_type x, ats_size_type ndigit
) {
  atslib_mpf_out_str_exn (stdout, 10/*base*/, ndigit, x) ; return ;
} // end of [atslib_print_mpf]

ATSinline()
ats_void_type
atslib_prerr_mpf (
  const ats_mpf_ptr_type x, ats_size_type ndigit
) {
  atslib_mpf_out_str_exn (stderr, 10/*base*/, ndigit, x) ; return ;
} // end of [atslib_prerr_mpf]

/* ****** ****** */

//
// random number generators for MPZ, MPQ and MPF
//
#define atslib_gmp_randclear gmp_randclear
#define atslib_gmp_randinit_default gmp_randinit_default
#define atslib_gmp_randinit_lc_2exp gmp_randinit_lc_2exp
#define atslib_gmp_randinit_lc_2exp_size gmp_randinit_lc_2exp_size
//
#define atslib_gmp_randseed_mpz gmp_randseed
#define atslib_gmp_randseed_ui gmp_randseed_ui
//
#define atslib_mpz_urandomb mpz_urandomb
#define atslib_mpz_urandomm mpz_urandomm
#define atslib_mpz_rrandomb mpz_rrandomb
#define atslib_mpz_random mpz_random
#define atslib_mpz_random2 mpz_random2
//
#define atslib_mpf_random2 mpf_random2
#define atslib_mpf_urandomb mpf_urandomb

/* ****** ****** */

#endif /* ATS_LIBC_GMP_CATS */

/* end of [gmp.cats] */
