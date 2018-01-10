/* ****** ****** */
//
// API in ATS for libgmp
//
/* ****** ****** */

/*
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
*/

/* ****** ****** */

/*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
*/

/* ****** ****** */

#ifndef ATSCNTRB_LIBGMP_GMP_CATS
#define ATSCNTRB_LIBGMP_GMP_CATS

/* ****** ****** */

#include <gmp.h>

/* ****** ****** */

typedef
__mpz_struct atscntrb_gmp_mpz ;
typedef atscntrb_gmp_mpz *ptrmpz;

/* ****** ****** */
//
// init/clear/realloc
//
#define atscntrb_gmp_mpz_init mpz_init
#define atscntrb_gmp_mpz_init2 mpz_init2
#define atscntrb_gmp_mpz_clear mpz_clear
#define atscntrb_gmp_mpz_realloc2 mpz_realloc2
//
/* ****** ****** */
//
// get-functions
//
#define atscntrb_gmp_mpz_get_int mpz_get_si
#define atscntrb_gmp_mpz_get_uint mpz_get_ui
#define atscntrb_gmp_mpz_get_lint mpz_get_si
#define atscntrb_gmp_mpz_get_ulint mpz_get_ui
#define atscntrb_gmp_mpz_get_double mpz_get_d
#define atscntrb_gmp_mpz_get_str mpz_get_str
#define atscntrb_gmp_mpz_get_str_null(base, mpz) mpz_get_str((char*)0, base, mpz)
//
/* ****** ****** */
//
// set-functions
//
#define atscntrb_gmp_mpz_set_int mpz_set_si
#define atscntrb_gmp_mpz_set_uint mpz_set_ui
#define atscntrb_gmp_mpz_set_lint mpz_set_si
#define atscntrb_gmp_mpz_set_ulint mpz_set_ui
#define atscntrb_gmp_mpz_set_mpz mpz_set
//
/* ****** ****** */
//
// init-set functions
//
#define atscntrb_gmp_mpz_init_set_mpz mpz_init_set
#define atscntrb_gmp_mpz_init_set_int mpz_init_set_si
#define atscntrb_gmp_mpz_init_set_uint mpz_init_set_ui
#define atscntrb_gmp_mpz_init_set_lint mpz_init_set_si
#define atscntrb_gmp_mpz_init_set_ulint mpz_init_set_ui
//
/* ****** ****** */

#define atscntrb_gmp_mpz_size mpz_size

/* ****** ****** */
//
// input-output-functions
//
#define atscntrb_gmp_mpz_inp_str mpz_inp_str
#define atscntrb_gmp_mpz_out_str mpz_out_str
//
/* ****** ****** */

ATSinline()
atsvoid_t0ype
atscntrb_gmp_fprint_mpz_base
(
  atstype_ref out, atstype_ptr x, atstype_int base
) {
  size_t ndigit ;
  ndigit = mpz_out_str ((FILE*)out, base, (ptrmpz)x) ;
  return ;
} // end of [atscntrb_gmp_fprint_mpz_base]

#define atscntrb_gmp_fprint_mpz(out, x) \
  atscntrb_gmp_fprint_mpz_base(out, x, 10)

/* ****** ****** */
//
#define atscntrb_gmp_mpz_inp_raw mpz_inp_raw
#define atscntrb_gmp_mpz_out_raw mpz_out_raw
//
/* ****** ****** */

#define atscntrb_gmp_mpz_odd_p(x) mpz_odd_p((ptrmpz)x)
#define atscntrb_gmp_mpz_even_p(x) mpz_even_p((ptrmpz)x)

/* ****** ****** */

#define atscntrb_gmp_mpz_neg1(x) mpz_neg(x, x)
#define atscntrb_gmp_mpz_neg2(x, y) mpz_neg(x, y)

/* ****** ****** */

#define atscntrb_gmp_mpz_abs1(x) mpz_abs(x, x)
#define atscntrb_gmp_mpz_abs2(x, y) mpz_abs(x, y)

/* ****** ****** */
//
// addition-functions
//
ATSinline()
atsvoid_t0ype
mpz_add_si
(
  mpz_t rop
, mpz_t op1, atstype_lint op2
)
{
  if (op2 >= 0)
    mpz_add_ui (rop, op1,  op2) ;
  else
    mpz_add_ui (rop, op1, -op2) ;
  // end of [if]
} /* end of [mpz_add_si] */
//
// x := x+y // y+z
//
#define atscntrb_gmp_mpz_add2_mpz(x, y) mpz_add(x, x, y)
#define atscntrb_gmp_mpz_add2_int(x, y) mpz_add_si(x, x, y)
#define atscntrb_gmp_mpz_add2_uint(x, y) mpz_add_ui(x, x, y)
#define atscntrb_gmp_mpz_add2_lint(x, y) mpz_add_si(x, x, y)
#define atscntrb_gmp_mpz_add2_ulint(x, y) mpz_add_ui(x, x, y)
#define atscntrb_gmp_mpz_add3_mpz(x, y, z) mpz_add(x, y, z)
#define atscntrb_gmp_mpz_add3_int(x, y, z) mpz_add_si(x, y, z)
#define atscntrb_gmp_mpz_add3_uint(x, y, z) mpz_add_ui(x, y, z)
#define atscntrb_gmp_mpz_add3_lint(x, y, z) mpz_add_si(x, y, z)
#define atscntrb_gmp_mpz_add3_ulint(x, y, z) mpz_add_ui(x, y, z)
//
/* ****** ****** */
//
// subtraction-functions
//
ATSinline()
atsvoid_t0ype
mpz_sub_si
(
  mpz_t rop
, mpz_t op1, atstype_lint op2
)
{
  if (op2 >= 0)
    mpz_sub_ui (rop, op1,  op2) ;
  else
    mpz_sub_ui (rop, op1, -op2) ;
  // end of [if]
} /* end of [mpz_sub_si] */
//
#define atscntrb_gmp_mpz_sub2_mpz(x, y) mpz_sub(x, x, y)
#define atscntrb_gmp_mpz_sub2_int(x, y) mpz_sub_si(x, x, y)
#define atscntrb_gmp_mpz_sub2_uint(x, y) mpz_sub_ui(x, x, y)
#define atscntrb_gmp_mpz_sub2_lint(x, y) mpz_sub_si(x, x, y)
#define atscntrb_gmp_mpz_sub2_ulint(x, y) mpz_sub_ui(x, x, y)
#define atscntrb_gmp_mpz_sub3_mpz(x, y, z) mpz_sub(x, y, z)
#define atscntrb_gmp_mpz_sub3_int(x, y, z) mpz_sub_si(x, y, z)
#define atscntrb_gmp_mpz_sub3_uint(x, y, z) mpz_sub_ui(x, y, z)
#define atscntrb_gmp_mpz_sub3_lint(x, y, z) mpz_sub_si(x, y, z)
#define atscntrb_gmp_mpz_sub3_ulint(x, y, z) mpz_sub_ui(x, y, z)
//
/* ****** ****** */
//
// multiplication-functions
//
// x := x * y // y * z
//
#define atscntrb_gmp_mpz_mul2_mpz(x, y) mpz_mul(x, x, y)
#define atscntrb_gmp_mpz_mul2_int(x, y) mpz_mul_si(x, x, y)
#define atscntrb_gmp_mpz_mul2_uint(x, y) mpz_mul_ui(x, x, y)
#define atscntrb_gmp_mpz_mul2_lint(x, y) mpz_mul_si(x, x, y)
#define atscntrb_gmp_mpz_mul2_ulint(x, y) mpz_mul_ui(x, x, y)
#define atscntrb_gmp_mpz_mul3_mpz(x, y, z) mpz_mul(x, y, z)
#define atscntrb_gmp_mpz_mul3_int(x, y, z) mpz_mul_si(x, y, z)
#define atscntrb_gmp_mpz_mul3_uint(x, y, z) mpz_mul_ui(x, y, z)
#define atscntrb_gmp_mpz_mul3_lint(x, y, z) mpz_mul_si(x, y, z)
#define atscntrb_gmp_mpz_mul3_ulint(x, y, z) mpz_mul_ui(x, y, z)
//
#define atscntrb_gmp_mpz_mul3_2exp(x, y, z) mpz_mul_2exp(x, y, z)
//
/* ****** ****** */
//
// trunc-division-functions
//
#define atscntrb_gmp_mpz_tdiv2_q_mpz(x, y) mpz_tdiv_q(x, x, y)
#define atscntrb_gmp_mpz_tdiv2_q_uint(x, y) mpz_tdiv_q_ui(x, x, y)
#define atscntrb_gmp_mpz_tdiv2_q_ulint(x, y) mpz_tdiv_q_ui(x, x, y)
#define atscntrb_gmp_mpz_tdiv3_q_mpz(x, y, z) mpz_tdiv_q(x, y, z)
#define atscntrb_gmp_mpz_tdiv3_q_uint(x, y, z) mpz_tdiv_q_ui(x, y, z)
#define atscntrb_gmp_mpz_tdiv3_q_ulint(x, y, z) mpz_tdiv_q_ui(x, y, z)
//
#define atscntrb_gmp_mpz_tdiv2_r_mpz(x, y) mpz_tdiv_r(x, x, y)
#define atscntrb_gmp_mpz_tdiv2_r_uint(x, y) mpz_tdiv_r_ui(x, x, y)
#define atscntrb_gmp_mpz_tdiv2_r_ulint(x, y) mpz_tdiv_r_ui(x, x, y)
#define atscntrb_gmp_mpz_tdiv3_r_mpz(x, y, z) mpz_tdiv_r(x, y, z)
#define atscntrb_gmp_mpz_tdiv3_r_uint(x, y, z) mpz_tdiv_r_ui(x, y, z)
#define atscntrb_gmp_mpz_tdiv3_r_ulint(x, y, z) mpz_tdiv_r_ui(x, y, z)
//
#define atscntrb_gmp_mpz_tdiv3_qr_mpz(xq, xr, y) mpz_tdiv_qr(xq, xr, xq, y)
#define atscntrb_gmp_mpz_tdiv3_qr_uint(xq, xr, y) mpz_tdiv_qr_ui(xq, xr, xq, y)
#define atscntrb_gmp_mpz_tdiv3_qr_ulint(xq, xr, y) mpz_tdiv_qr_ui(xq, xr, xq, y)
#define atscntrb_gmp_mpz_tdiv4_qr_mpz(xq, xr, y, z) mpz_tdiv_qr(xq, xr, y, z)
#define atscntrb_gmp_mpz_tdiv4_qr_uint(xq, xr, y, z) mpz_tdiv_qr_ui(xq, xr, y, z)
#define atscntrb_gmp_mpz_tdiv4_qr_ulint(xq, xr, y, z) mpz_tdiv_qr_ui(xq, xr, y, z)
//
/* ****** ****** */
//
// floor-division-functions
//
#define atscntrb_gmp_mpz_fdiv_uint(x, y) mpz_fdiv_ui(x, y)
#define atscntrb_gmp_mpz_fdiv_ulint(x, y) mpz_fdiv_ui(x, y)
//
#define atscntrb_gmp_mpz_fdiv2_q_mpz(x, y) mpz_fdiv_q(x, x, y)
#define atscntrb_gmp_mpz_fdiv2_q_uint(x, y) mpz_fdiv_q_ui(x, x, y)
#define atscntrb_gmp_mpz_fdiv2_q_ulint(x, y) mpz_fdiv_q_ui(x, x, y)
#define atscntrb_gmp_mpz_fdiv3_q_mpz(x, y, z) mpz_fdiv_q(x, y, z)
#define atscntrb_gmp_mpz_fdiv3_q_uint(x, y, z) mpz_fdiv_q_ui(x, y, z)
#define atscntrb_gmp_mpz_fdiv3_q_ulint(x, y, z) mpz_fdiv_q_ui(x, y, z)
//
#define atscntrb_gmp_mpz_fdiv4_qr_mpz(q, r, dd, dr) mpz_fdiv_qr(q, r, dd, dr)
#define atscntrb_gmp_mpz_fdiv4_qr_ulint(q, r, dd, dr) mpz_fdiv_qr_ui(q, r, dd, dr)
//
/* ****** ****** */
//
// ceiling-division-functions
//
#define atscntrb_gmp_mpz_cdiv_uint(x, y) mpz_cdiv_ui(x, y)
#define atscntrb_gmp_mpz_cdiv_ulint(x, y) mpz_cdiv_ui(x, y)
//
#define atscntrb_gmp_mpz_cdiv2_q_mpz(x, y) mpz_cdiv_q(x, x, y)
#define atscntrb_gmp_mpz_cdiv2_q_uint(x, y) mpz_cdiv_q_ui(x, x, y)
#define atscntrb_gmp_mpz_cdiv2_q_ulint(x, y) mpz_cdiv_q_ui(x, x, y)
#define atscntrb_gmp_mpz_cdiv3_q_mpz(x, y, z) mpz_cdiv_q(x, y, z)
#define atscntrb_gmp_mpz_cdiv3_q_uint(x, y, z) mpz_cdiv_q_ui(x, y, z)
#define atscntrb_gmp_mpz_cdiv3_q_ulint(x, y, z) mpz_cdiv_q_ui(x, y, z)
//
/* ****** ****** */
//
// modulo-functions
//
// x := x mod y // y mod z
//
#define atscntrb_gmp_mpz_mod2_mpz(x, y) mpz_mod(x, x, y)
#define atscntrb_gmp_mpz_mod2_uint(x, y) mpz_mod_ui(x, x, y)
#define atscntrb_gmp_mpz_mod2_ulint(x, y) mpz_mod_ui(x, x, y)
#define atscntrb_gmp_mpz_mod3_mpz(x, y, z) mpz_mod(x, y, z)
#define atscntrb_gmp_mpz_mod3_uint(x, y, z) mpz_mod_ui(x, y, z)
#define atscntrb_gmp_mpz_mod3_ulint(x, y, z) mpz_mod_ui(x, y, z)
//
/* ****** ****** */
//
#define atscntrb_gmp_mpz_addmul3_mpz(x, y, z) mpz_addmul(x, y, z)
#define atscntrb_gmp_mpz_addmul3_uint(x, y, z) mpz_addmul_ui(x, y, z)
#define atscntrb_gmp_mpz_addmul3_ulint(x, y, z) mpz_addmul_ui(x, y, z)
//
#define atscntrb_gmp_mpz_submul3_mpz(x, y, z) mpz_submul(x, y, z)
#define atscntrb_gmp_mpz_submul3_uint(x, y, z) mpz_submul_ui(x, y, z)
#define atscntrb_gmp_mpz_submul3_ulint(x, y, z) mpz_submul_ui(x, y, z)
//
/* ****** ****** */
//
// comparison-functions
//
#define atscntrb_gmp_mpz_cmp_mpz(x, y) mpz_cmp((ptrmpz)x, y)
#define atscntrb_gmp_mpz_cmp_int(x, y) mpz_cmp_si((ptrmpz)x, y)
#define atscntrb_gmp_mpz_cmp_uint(x, y) mpz_cmp_ui((ptrmpz)x, y)
#define atscntrb_gmp_mpz_cmp_lint(x, y) mpz_cmp_si((ptrmpz)x, y)
#define atscntrb_gmp_mpz_cmp_ulint(x, y) mpz_cmp_ui((ptrmpz)x, y)
//
/* ****** ****** */
//
// power-functions
//
#define atscntrb_gmp_mpz_pow_uint(pow, base, exp) mpz_pow_ui(pow, base, exp)
#define atscntrb_gmp_mpz_pow_ulint(pow, base, exp) mpz_pow_ui(pow, base, exp)
//
#define atscntrb_gmp_mpz_ui_pow_ui(pow, base, exp) mpz_ui_pow_ui(pow, base, exp)
//
/* ****** ****** */

#define atscntrb_gmp_mpz_fac_uint(res, n) mpz_fac_ui(res, n)

/* ****** ****** */  
//
#define atscntrb_gmp_mpz_fib_uint(res, n) mpz_fib_ui(res, n)
#define atscntrb_gmp_mpz_fib2_uint(res1, res2, n) mpz_fib2_ui(res1, res2, n)
//
/* ****** ****** */

#endif // ifndef ATSCNTRB_LIBGMP_GMP_CATS

/* ****** ****** */

/* end of [gmp.cats] */
