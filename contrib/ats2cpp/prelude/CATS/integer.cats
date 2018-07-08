/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2015 Hongwei Xi, ATS Trustful Software, Inc.
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

/*
(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2013 *)
*/

/* ****** ****** */
/*
** Source:
** $PATSHOME/prelude/CATS/CODEGEN/integer.atxt
** Time of generation: Sun Aug 21 20:48:34 2016
*/

/* ****** ****** */

#ifndef ATS2CPP_PRELUDE_CATS_INTEGER
#define ATS2CPP_PRELUDE_CATS_INTEGER

/* ****** ****** */
//
#define \
atspre_g0int2int_int_int(x) ((atstype_int)(x))
#define \
atspre_g1int2int_int_int(x) atspre_g0int2int_int_int(x)
//
/* ****** ****** */
//
#define \
atspre_g0int2uint_int_uint(x) ((atstype_uint)(x))
#define \
atspre_g1int2uint_int_uint(x) atspre_g0int2uint_int_uint(x)
//
/* ****** ****** */
//
#define atspre_g0uint2int_uint_int(x) ((atstype_int)(x))
//
/* ****** ****** */
//
#define \
atspre_g0uint2uint_uint_uint(x) (x)
#define \
atspre_g1uint2uint_uint_uint(x) atspre_g0uint2uint_uint_uint(x)
//
/* ****** ****** */
//
#define atspre_g0uint2uint_ulint_uint(x) ((atstype_uint)(x))
#define atspre_g0uint2uint_ulint_ulint(x) (x)
#define atspre_g0uint2uint_ulint_ullint(x) ((atstype_ullint)(x))
#define atspre_g1uint2uint_ulint_uint atspre_g0uint2uint_ulint_uint
#define atspre_g1uint2uint_ulint_ulint atspre_g0uint2uint_ulint_ulint
#define atspre_g1uint2uint_ulint_ullint atspre_g0uint2uint_ulint_ullint
//
/* ****** ****** */
//
#define atspre_g0uint2uint_usint_uint(x) ((atstype_uint)(x))
//
/* ****** ****** */
//
extern "C"
{
int atoi(const char *inp) throw ();
long int atol(const char *inp) throw ();
long long int atoll(const char *inp) throw ();
} // extern "C"
//
ATSinline()
atstype_int
atspre_g0string2int_int
  (atstype_string inp) { return atoi((char*)inp) ; }
ATSinline()
atstype_lint
atspre_g0string2int_lint
  (atstype_string inp) { return atol((char*)inp) ; }
ATSinline()
atstype_llint
atspre_g0string2int_llint
  (atstype_string inp) { return atoll((char*)inp) ; }
//
/* ****** ****** */
//
extern "C"
{
unsigned long int
strtoul(const char *nptr, char **endptr, int base) throw ();
unsigned long long int
strtoull(const char *nptr, char **endptr, int base) throw ();
} // extern "C"
//
ATSinline()
atstype_uint
atspre_g0string2uint_uint
  (atstype_string inp) { return strtoul((char*)inp, NULL, 10) ; }
ATSinline()
atstype_ulint
atspre_g0string2uint_ulint
  (atstype_string inp) { return strtoul((char*)inp, NULL, 10) ; }
ATSinline()
atstype_ullint
atspre_g0string2uint_ullint
  (atstype_string inp) { return strtoull((char*)inp, NULL, 10) ; }
//
/* ****** ****** */
//
ATSinline()
atstype_int
atspre_g0int_neg_int
  (atstype_int x) { return (-x) ; }
// end of [atspre_g0int_neg_int]
ATSinline()
atstype_int
atspre_g0int_abs_int
  (atstype_int x) { return (x >= 0 ? x : -x) ; }
// end of [atspre_g0int_abs_int]
ATSinline()
atstype_int
atspre_g0int_succ_int
  (atstype_int x) { return (x + 1) ; }
// end of [atspre_g0int_succ_int]
ATSinline()
atstype_int
atspre_g0int_pred_int
  (atstype_int x) { return (x - 1) ; }
// end of [atspre_g0int_pred_int]
ATSinline()
atstype_int
atspre_g0int_half_int
  (atstype_int x) { return (x / 2) ; }
// end of [atspre_g0int_half_int]
ATSinline()
atstype_int
atspre_g0int_add_int
  (atstype_int x1, atstype_int x2) { return (x1 + x2) ; }
// end of [atspre_g0int_add_int]
ATSinline()
atstype_int
atspre_g0int_sub_int
  (atstype_int x1, atstype_int x2) { return (x1 - x2) ; }
// end of [atspre_g0int_sub_int]
ATSinline()
atstype_int
atspre_g0int_mul_int
  (atstype_int x1, atstype_int x2) { return (x1 * x2) ; }
// end of [atspre_g0int_mul_int]
ATSinline()
atstype_int
atspre_g0int_div_int
  (atstype_int x1, atstype_int x2) { return (x1 / x2) ; }
// end of [atspre_g0int_div_int]
ATSinline()
atstype_int
atspre_g0int_mod_int
  (atstype_int x1, atstype_int x2) { return (x1 % x2) ; }
// end of [atspre_g0int_mod_int]
ATSinline()
atstype_int
atspre_g0int_nmod_int
  (atstype_int x1, atstype_int x2) { return (x1 % x2) ; }
// end of [atspre_g0int_nmod_int]
ATSinline()
atstype_int
atspre_g0int_asl_int
  (atstype_int x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0int_asl_int]
ATSinline()
atstype_int
atspre_g0int_asr_int
  (atstype_int x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0int_asr_int]
ATSinline()
atstype_bool
atspre_g0int_lt_int
(
  atstype_int x1, atstype_int x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lt_int]
ATSinline()
atstype_bool
atspre_g0int_lte_int
(
  atstype_int x1, atstype_int x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lte_int]
ATSinline()
atstype_bool
atspre_g0int_gt_int
(
  atstype_int x1, atstype_int x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gt_int]
ATSinline()
atstype_bool
atspre_g0int_gte_int
(
  atstype_int x1, atstype_int x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gte_int]
ATSinline()
atstype_bool
atspre_g0int_eq_int
(
  atstype_int x1, atstype_int x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_eq_int]
ATSinline()
atstype_bool
atspre_g0int_neq_int
(
  atstype_int x1, atstype_int x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_neq_int]
ATSinline()
atstype_int
atspre_g0int_compare_int
(
  atstype_int x1, atstype_int x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0int_compare_int]
ATSinline()
atstype_int
atspre_g0int_max_int
  (atstype_int x1, atstype_int x2) { return (x1 >= x2 ? x1 : x2) ; }
// end of [atspre_g0int_max_int]
ATSinline()
atstype_int
atspre_g0int_min_int
  (atstype_int x1, atstype_int x2) { return (x1 <= x2 ? x1 : x2) ; }
// end of [atspre_g0int_min_int]
ATSinline()
atstype_bool
atspre_g0int_isltz_int (atstype_int x)
{
  return (x < 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltz_int]
ATSinline()
atstype_bool
atspre_g0int_isltez_int (atstype_int x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltez_int]
ATSinline()
atstype_bool
atspre_g0int_isgtz_int (atstype_int x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtz_int]
ATSinline()
atstype_bool
atspre_g0int_isgtez_int (atstype_int x)
{
  return (x >= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtez_int]
ATSinline()
atstype_bool
atspre_g0int_iseqz_int (atstype_int x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_iseqz_int]
ATSinline()
atstype_bool
atspre_g0int_isneqz_int (atstype_int x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isneqz_int]
//
ATSinline()
atstype_lint
atspre_g0int_neg_lint
  (atstype_lint x) { return (-x) ; }
// end of [atspre_g0int_neg_lint]
ATSinline()
atstype_lint
atspre_g0int_abs_lint
  (atstype_lint x) { return (x >= 0 ? x : -x) ; }
// end of [atspre_g0int_abs_lint]
ATSinline()
atstype_lint
atspre_g0int_succ_lint
  (atstype_lint x) { return (x + 1) ; }
// end of [atspre_g0int_succ_lint]
ATSinline()
atstype_lint
atspre_g0int_pred_lint
  (atstype_lint x) { return (x - 1) ; }
// end of [atspre_g0int_pred_lint]
ATSinline()
atstype_lint
atspre_g0int_half_lint
  (atstype_lint x) { return (x / 2) ; }
// end of [atspre_g0int_half_lint]
ATSinline()
atstype_lint
atspre_g0int_add_lint
  (atstype_lint x1, atstype_lint x2) { return (x1 + x2) ; }
// end of [atspre_g0int_add_lint]
ATSinline()
atstype_lint
atspre_g0int_sub_lint
  (atstype_lint x1, atstype_lint x2) { return (x1 - x2) ; }
// end of [atspre_g0int_sub_lint]
ATSinline()
atstype_lint
atspre_g0int_mul_lint
  (atstype_lint x1, atstype_lint x2) { return (x1 * x2) ; }
// end of [atspre_g0int_mul_lint]
ATSinline()
atstype_lint
atspre_g0int_div_lint
  (atstype_lint x1, atstype_lint x2) { return (x1 / x2) ; }
// end of [atspre_g0int_div_lint]
ATSinline()
atstype_lint
atspre_g0int_mod_lint
  (atstype_lint x1, atstype_lint x2) { return (x1 % x2) ; }
// end of [atspre_g0int_mod_lint]
ATSinline()
atstype_lint
atspre_g0int_nmod_lint
  (atstype_lint x1, atstype_lint x2) { return (x1 % x2) ; }
// end of [atspre_g0int_nmod_lint]
ATSinline()
atstype_lint
atspre_g0int_asl_lint
  (atstype_lint x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0int_asl_lint]
ATSinline()
atstype_lint
atspre_g0int_asr_lint
  (atstype_lint x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0int_asr_lint]
ATSinline()
atstype_bool
atspre_g0int_lt_lint
(
  atstype_lint x1, atstype_lint x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lt_lint]
ATSinline()
atstype_bool
atspre_g0int_lte_lint
(
  atstype_lint x1, atstype_lint x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lte_lint]
ATSinline()
atstype_bool
atspre_g0int_gt_lint
(
  atstype_lint x1, atstype_lint x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gt_lint]
ATSinline()
atstype_bool
atspre_g0int_gte_lint
(
  atstype_lint x1, atstype_lint x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gte_lint]
ATSinline()
atstype_bool
atspre_g0int_eq_lint
(
  atstype_lint x1, atstype_lint x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_eq_lint]
ATSinline()
atstype_bool
atspre_g0int_neq_lint
(
  atstype_lint x1, atstype_lint x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_neq_lint]
ATSinline()
atstype_int
atspre_g0int_compare_lint
(
  atstype_lint x1, atstype_lint x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0int_compare_lint]
ATSinline()
atstype_lint
atspre_g0int_max_lint
  (atstype_lint x1, atstype_lint x2) { return (x1 >= x2 ? x1 : x2) ; }
// end of [atspre_g0int_max_lint]
ATSinline()
atstype_lint
atspre_g0int_min_lint
  (atstype_lint x1, atstype_lint x2) { return (x1 <= x2 ? x1 : x2) ; }
// end of [atspre_g0int_min_lint]
ATSinline()
atstype_bool
atspre_g0int_isltz_lint (atstype_lint x)
{
  return (x < 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltz_lint]
ATSinline()
atstype_bool
atspre_g0int_isltez_lint (atstype_lint x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltez_lint]
ATSinline()
atstype_bool
atspre_g0int_isgtz_lint (atstype_lint x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtz_lint]
ATSinline()
atstype_bool
atspre_g0int_isgtez_lint (atstype_lint x)
{
  return (x >= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtez_lint]
ATSinline()
atstype_bool
atspre_g0int_iseqz_lint (atstype_lint x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_iseqz_lint]
ATSinline()
atstype_bool
atspre_g0int_isneqz_lint (atstype_lint x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isneqz_lint]
//
ATSinline()
atstype_llint
atspre_g0int_neg_llint
  (atstype_llint x) { return (-x) ; }
// end of [atspre_g0int_neg_llint]
ATSinline()
atstype_llint
atspre_g0int_abs_llint
  (atstype_llint x) { return (x >= 0 ? x : -x) ; }
// end of [atspre_g0int_abs_llint]
ATSinline()
atstype_llint
atspre_g0int_succ_llint
  (atstype_llint x) { return (x + 1) ; }
// end of [atspre_g0int_succ_llint]
ATSinline()
atstype_llint
atspre_g0int_pred_llint
  (atstype_llint x) { return (x - 1) ; }
// end of [atspre_g0int_pred_llint]
ATSinline()
atstype_llint
atspre_g0int_half_llint
  (atstype_llint x) { return (x / 2) ; }
// end of [atspre_g0int_half_llint]
ATSinline()
atstype_llint
atspre_g0int_add_llint
  (atstype_llint x1, atstype_llint x2) { return (x1 + x2) ; }
// end of [atspre_g0int_add_llint]
ATSinline()
atstype_llint
atspre_g0int_sub_llint
  (atstype_llint x1, atstype_llint x2) { return (x1 - x2) ; }
// end of [atspre_g0int_sub_llint]
ATSinline()
atstype_llint
atspre_g0int_mul_llint
  (atstype_llint x1, atstype_llint x2) { return (x1 * x2) ; }
// end of [atspre_g0int_mul_llint]
ATSinline()
atstype_llint
atspre_g0int_div_llint
  (atstype_llint x1, atstype_llint x2) { return (x1 / x2) ; }
// end of [atspre_g0int_div_llint]
ATSinline()
atstype_llint
atspre_g0int_mod_llint
  (atstype_llint x1, atstype_llint x2) { return (x1 % x2) ; }
// end of [atspre_g0int_mod_llint]
ATSinline()
atstype_llint
atspre_g0int_nmod_llint
  (atstype_llint x1, atstype_llint x2) { return (x1 % x2) ; }
// end of [atspre_g0int_nmod_llint]
ATSinline()
atstype_llint
atspre_g0int_asl_llint
  (atstype_llint x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0int_asl_llint]
ATSinline()
atstype_llint
atspre_g0int_asr_llint
  (atstype_llint x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0int_asr_llint]
ATSinline()
atstype_bool
atspre_g0int_lt_llint
(
  atstype_llint x1, atstype_llint x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lt_llint]
ATSinline()
atstype_bool
atspre_g0int_lte_llint
(
  atstype_llint x1, atstype_llint x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lte_llint]
ATSinline()
atstype_bool
atspre_g0int_gt_llint
(
  atstype_llint x1, atstype_llint x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gt_llint]
ATSinline()
atstype_bool
atspre_g0int_gte_llint
(
  atstype_llint x1, atstype_llint x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gte_llint]
ATSinline()
atstype_bool
atspre_g0int_eq_llint
(
  atstype_llint x1, atstype_llint x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_eq_llint]
ATSinline()
atstype_bool
atspre_g0int_neq_llint
(
  atstype_llint x1, atstype_llint x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_neq_llint]
ATSinline()
atstype_int
atspre_g0int_compare_llint
(
  atstype_llint x1, atstype_llint x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0int_compare_llint]
ATSinline()
atstype_llint
atspre_g0int_max_llint
  (atstype_llint x1, atstype_llint x2) { return (x1 >= x2 ? x1 : x2) ; }
// end of [atspre_g0int_max_llint]
ATSinline()
atstype_llint
atspre_g0int_min_llint
  (atstype_llint x1, atstype_llint x2) { return (x1 <= x2 ? x1 : x2) ; }
// end of [atspre_g0int_min_llint]
ATSinline()
atstype_bool
atspre_g0int_isltz_llint (atstype_llint x)
{
  return (x < 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltz_llint]
ATSinline()
atstype_bool
atspre_g0int_isltez_llint (atstype_llint x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltez_llint]
ATSinline()
atstype_bool
atspre_g0int_isgtz_llint (atstype_llint x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtz_llint]
ATSinline()
atstype_bool
atspre_g0int_isgtez_llint (atstype_llint x)
{
  return (x >= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtez_llint]
ATSinline()
atstype_bool
atspre_g0int_iseqz_llint (atstype_llint x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_iseqz_llint]
ATSinline()
atstype_bool
atspre_g0int_isneqz_llint (atstype_llint x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isneqz_llint]
//
/* ****** ****** */

#define atspre_g1int_neg_int atspre_g0int_neg_int
#define atspre_g1int_abs_int atspre_g0int_abs_int
#define atspre_g1int_succ_int atspre_g0int_succ_int
#define atspre_g1int_pred_int atspre_g0int_pred_int
#define atspre_g1int_half_int atspre_g0int_half_int
#define atspre_g1int_add_int atspre_g0int_add_int
#define atspre_g1int_sub_int atspre_g0int_sub_int
#define atspre_g1int_mul_int atspre_g0int_mul_int
#define atspre_g1int_div_int atspre_g0int_div_int
#define atspre_g1int_nmod_int atspre_g0int_nmod_int
#define atspre_g1int_isltz_int atspre_g0int_isltz_int
#define atspre_g1int_isltez_int atspre_g0int_isltez_int
#define atspre_g1int_isgtz_int atspre_g0int_isgtz_int
#define atspre_g1int_isgtez_int atspre_g0int_isgtez_int
#define atspre_g1int_iseqz_int atspre_g0int_iseqz_int
#define atspre_g1int_isneqz_int atspre_g0int_isneqz_int
#define atspre_g1int_lt_int atspre_g0int_lt_int
#define atspre_g1int_lte_int atspre_g0int_lte_int
#define atspre_g1int_gt_int atspre_g0int_gt_int
#define atspre_g1int_gte_int atspre_g0int_gte_int
#define atspre_g1int_eq_int atspre_g0int_eq_int
#define atspre_g1int_neq_int atspre_g0int_neq_int
#define atspre_g1int_compare_int atspre_g0int_compare_int
#define atspre_g1int_max_int atspre_g0int_max_int
#define atspre_g1int_min_int atspre_g0int_min_int

/* ****** ****** */

#define atspre_g1int_neg_lint atspre_g0int_neg_lint
#define atspre_g1int_succ_lint atspre_g0int_succ_lint
#define atspre_g1int_pred_lint atspre_g0int_pred_lint
#define atspre_g1int_half_lint atspre_g0int_half_lint
#define atspre_g1int_add_lint atspre_g0int_add_lint
#define atspre_g1int_sub_lint atspre_g0int_sub_lint
#define atspre_g1int_mul_lint atspre_g0int_mul_lint
#define atspre_g1int_div_lint atspre_g0int_div_lint
#define atspre_g1int_nmod_lint atspre_g0int_nmod_lint
#define atspre_g1int_isltz_lint atspre_g0int_isltz_lint
#define atspre_g1int_isltez_lint atspre_g0int_isltez_lint
#define atspre_g1int_isgtz_lint atspre_g0int_isgtz_lint
#define atspre_g1int_isgtez_lint atspre_g0int_isgtez_lint
#define atspre_g1int_iseqz_lint atspre_g0int_iseqz_lint
#define atspre_g1int_isneqz_lint atspre_g0int_isneqz_lint
#define atspre_g1int_lt_lint atspre_g0int_lt_lint
#define atspre_g1int_lte_lint atspre_g0int_lte_lint
#define atspre_g1int_gt_lint atspre_g0int_gt_lint
#define atspre_g1int_gte_lint atspre_g0int_gte_lint
#define atspre_g1int_eq_lint atspre_g0int_eq_lint
#define atspre_g1int_neq_lint atspre_g0int_neq_lint
#define atspre_g1int_compare_lint atspre_g0int_compare_lint
#define atspre_g1int_max_lint atspre_g0int_max_lint
#define atspre_g1int_min_lint atspre_g0int_min_lint

/* ****** ****** */

#define atspre_g1int_neg_llint atspre_g0int_neg_llint
#define atspre_g1int_succ_llint atspre_g0int_succ_llint
#define atspre_g1int_pred_llint atspre_g0int_pred_llint
#define atspre_g1int_half_llint atspre_g0int_half_llint
#define atspre_g1int_add_llint atspre_g0int_add_llint
#define atspre_g1int_sub_llint atspre_g0int_sub_llint
#define atspre_g1int_mul_llint atspre_g0int_mul_llint
#define atspre_g1int_div_llint atspre_g0int_div_llint
#define atspre_g1int_nmod_llint atspre_g0int_nmod_llint
#define atspre_g1int_isltz_llint atspre_g0int_isltz_llint
#define atspre_g1int_isltez_llint atspre_g0int_isltez_llint
#define atspre_g1int_isgtz_llint atspre_g0int_isgtz_llint
#define atspre_g1int_isgtez_llint atspre_g0int_isgtez_llint
#define atspre_g1int_iseqz_llint atspre_g0int_iseqz_llint
#define atspre_g1int_isneqz_llint atspre_g0int_isneqz_llint
#define atspre_g1int_lt_llint atspre_g0int_lt_llint
#define atspre_g1int_lte_llint atspre_g0int_lte_llint
#define atspre_g1int_gt_llint atspre_g0int_gt_llint
#define atspre_g1int_gte_llint atspre_g0int_gte_llint
#define atspre_g1int_eq_llint atspre_g0int_eq_llint
#define atspre_g1int_neq_llint atspre_g0int_neq_llint
#define atspre_g1int_compare_llint atspre_g0int_compare_llint
#define atspre_g1int_max_llint atspre_g0int_max_llint
#define atspre_g1int_min_llint atspre_g0int_min_llint

/* ****** ****** */
//
ATSinline()
atstype_uint
atspre_g0uint_succ_uint
  (atstype_uint x) { return (x + 1) ; }
// end of [atspre_g0uint_succ_uint]
ATSinline()
atstype_uint
atspre_g0uint_pred_uint
  (atstype_uint x) { return (x - 1) ; }
// end of [atspre_g0uint_pred_uint]
ATSinline()
atstype_uint
atspre_g0uint_half_uint
  (atstype_uint x) { return (x >> 1) ; }
// end of [atspre_g0uint_half_uint]
ATSinline()
atstype_uint
atspre_g0uint_add_uint
  (atstype_uint x1, atstype_uint x2) { return (x1 + x2) ; }
// end of [atspre_g0uint_add_uint]
ATSinline()
atstype_uint
atspre_g0uint_sub_uint
  (atstype_uint x1, atstype_uint x2) { return (x1 - x2) ; }
// end of [atspre_g0uint_sub_uint]
ATSinline()
atstype_uint
atspre_g0uint_mul_uint
  (atstype_uint x1, atstype_uint x2) { return (x1 * x2) ; }
// end of [atspre_g0uint_mul_uint]
ATSinline()
atstype_uint
atspre_g0uint_div_uint
  (atstype_uint x1, atstype_uint x2) { return (x1 / x2) ; }
// end of [atspre_g0uint_div_uint]
ATSinline()
atstype_uint
atspre_g0uint_mod_uint
  (atstype_uint x1, atstype_uint x2) { return (x1 % x2) ; }
// end of [atspre_g0uint_mod_uint]
ATSinline()
atstype_uint
atspre_g0uint_lsl_uint
  (atstype_uint x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0uint_lsl_uint]
ATSinline()
atstype_uint
atspre_g0uint_lsr_uint
  (atstype_uint x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0uint_lsr_uint]
ATSinline()
atstype_uint
atspre_g0uint_lnot_uint
  (atstype_uint x) { return ~(x) ; }
// end of [atspre_g0uint_lnot_uint]
ATSinline()
atstype_uint
atspre_g0uint_lor_uint
  (atstype_uint x, atstype_uint y) { return (x | y) ; }
// end of [atspre_g0uint_uint_uint]
ATSinline()
atstype_uint
atspre_g0uint_land_uint
  (atstype_uint x, atstype_uint y) { return (x & y) ; }
// end of [atspre_g0uint_uint_uint]
ATSinline()
atstype_uint
atspre_g0uint_lxor_uint
  (atstype_uint x, atstype_uint y) { return (x ^ y) ; }
// end of [atspre_g0uint_uint_uint]
ATSinline()
atstype_bool
atspre_g0uint_lt_uint
(
  atstype_uint x1, atstype_uint x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lt_uint]
ATSinline()
atstype_bool
atspre_g0uint_lte_uint
(
  atstype_uint x1, atstype_uint x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lte_uint]
ATSinline()
atstype_bool
atspre_g0uint_gt_uint
(
  atstype_uint x1, atstype_uint x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gt_uint]
ATSinline()
atstype_bool
atspre_g0uint_gte_uint
(
  atstype_uint x1, atstype_uint x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gte_uint]
ATSinline()
atstype_bool
atspre_g0uint_eq_uint
(
  atstype_uint x1, atstype_uint x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_eq_uint]
ATSinline()
atstype_bool
atspre_g0uint_neq_uint
(
  atstype_uint x1, atstype_uint x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_neq_uint]
ATSinline()
atstype_int
atspre_g0uint_compare_uint
(
  atstype_uint x1, atstype_uint x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0uint_compare_uint]
ATSinline()
atstype_uint
atspre_g0uint_max_uint
  (atstype_uint x1, atstype_uint x2) { return (x1 >= x2 ? x1 : x2) ; }
// end of [atspre_g0uint_max_uint]
ATSinline()
atstype_uint
atspre_g0uint_min_uint
  (atstype_uint x1, atstype_uint x2) { return (x1 <= x2 ? x1 : x2) ; }
// end of [atspre_g0uint_min_uint]
ATSinline()
atstype_bool
atspre_g0uint_isltez_uint (atstype_uint x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isltez_uint]
ATSinline()
atstype_bool
atspre_g0uint_isgtz_uint (atstype_uint x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isgtz_uint]
ATSinline()
atstype_bool
atspre_g0uint_iseqz_uint (atstype_uint x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_iseqz_uint]
ATSinline()
atstype_bool
atspre_g0uint_isneqz_uint (atstype_uint x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isneqz_uint]
//
ATSinline()
atstype_ulint
atspre_g0uint_succ_ulint
  (atstype_ulint x) { return (x + 1) ; }
// end of [atspre_g0uint_succ_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_pred_ulint
  (atstype_ulint x) { return (x - 1) ; }
// end of [atspre_g0uint_pred_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_half_ulint
  (atstype_ulint x) { return (x >> 1) ; }
// end of [atspre_g0uint_half_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_add_ulint
  (atstype_ulint x1, atstype_ulint x2) { return (x1 + x2) ; }
// end of [atspre_g0uint_add_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_sub_ulint
  (atstype_ulint x1, atstype_ulint x2) { return (x1 - x2) ; }
// end of [atspre_g0uint_sub_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_mul_ulint
  (atstype_ulint x1, atstype_ulint x2) { return (x1 * x2) ; }
// end of [atspre_g0uint_mul_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_div_ulint
  (atstype_ulint x1, atstype_ulint x2) { return (x1 / x2) ; }
// end of [atspre_g0uint_div_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_mod_ulint
  (atstype_ulint x1, atstype_ulint x2) { return (x1 % x2) ; }
// end of [atspre_g0uint_mod_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_lsl_ulint
  (atstype_ulint x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0uint_lsl_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_lsr_ulint
  (atstype_ulint x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0uint_lsr_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_lnot_ulint
  (atstype_ulint x) { return ~(x) ; }
// end of [atspre_g0uint_lnot_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_lor_ulint
  (atstype_ulint x, atstype_ulint y) { return (x | y) ; }
// end of [atspre_g0uint_ulint_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_land_ulint
  (atstype_ulint x, atstype_ulint y) { return (x & y) ; }
// end of [atspre_g0uint_ulint_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_lxor_ulint
  (atstype_ulint x, atstype_ulint y) { return (x ^ y) ; }
// end of [atspre_g0uint_ulint_ulint]
ATSinline()
atstype_bool
atspre_g0uint_lt_ulint
(
  atstype_ulint x1, atstype_ulint x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lt_ulint]
ATSinline()
atstype_bool
atspre_g0uint_lte_ulint
(
  atstype_ulint x1, atstype_ulint x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lte_ulint]
ATSinline()
atstype_bool
atspre_g0uint_gt_ulint
(
  atstype_ulint x1, atstype_ulint x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gt_ulint]
ATSinline()
atstype_bool
atspre_g0uint_gte_ulint
(
  atstype_ulint x1, atstype_ulint x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gte_ulint]
ATSinline()
atstype_bool
atspre_g0uint_eq_ulint
(
  atstype_ulint x1, atstype_ulint x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_eq_ulint]
ATSinline()
atstype_bool
atspre_g0uint_neq_ulint
(
  atstype_ulint x1, atstype_ulint x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_neq_ulint]
ATSinline()
atstype_int
atspre_g0uint_compare_ulint
(
  atstype_ulint x1, atstype_ulint x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0uint_compare_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_max_ulint
  (atstype_ulint x1, atstype_ulint x2) { return (x1 >= x2 ? x1 : x2) ; }
// end of [atspre_g0uint_max_ulint]
ATSinline()
atstype_ulint
atspre_g0uint_min_ulint
  (atstype_ulint x1, atstype_ulint x2) { return (x1 <= x2 ? x1 : x2) ; }
// end of [atspre_g0uint_min_ulint]
ATSinline()
atstype_bool
atspre_g0uint_isltez_ulint (atstype_ulint x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isltez_ulint]
ATSinline()
atstype_bool
atspre_g0uint_isgtz_ulint (atstype_ulint x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isgtz_ulint]
ATSinline()
atstype_bool
atspre_g0uint_iseqz_ulint (atstype_ulint x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_iseqz_ulint]
ATSinline()
atstype_bool
atspre_g0uint_isneqz_ulint (atstype_ulint x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isneqz_ulint]
//
ATSinline()
atstype_ullint
atspre_g0uint_succ_ullint
  (atstype_ullint x) { return (x + 1) ; }
// end of [atspre_g0uint_succ_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_pred_ullint
  (atstype_ullint x) { return (x - 1) ; }
// end of [atspre_g0uint_pred_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_half_ullint
  (atstype_ullint x) { return (x >> 1) ; }
// end of [atspre_g0uint_half_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_add_ullint
  (atstype_ullint x1, atstype_ullint x2) { return (x1 + x2) ; }
// end of [atspre_g0uint_add_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_sub_ullint
  (atstype_ullint x1, atstype_ullint x2) { return (x1 - x2) ; }
// end of [atspre_g0uint_sub_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_mul_ullint
  (atstype_ullint x1, atstype_ullint x2) { return (x1 * x2) ; }
// end of [atspre_g0uint_mul_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_div_ullint
  (atstype_ullint x1, atstype_ullint x2) { return (x1 / x2) ; }
// end of [atspre_g0uint_div_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_mod_ullint
  (atstype_ullint x1, atstype_ullint x2) { return (x1 % x2) ; }
// end of [atspre_g0uint_mod_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_lsl_ullint
  (atstype_ullint x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0uint_lsl_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_lsr_ullint
  (atstype_ullint x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0uint_lsr_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_lnot_ullint
  (atstype_ullint x) { return ~(x) ; }
// end of [atspre_g0uint_lnot_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_lor_ullint
  (atstype_ullint x, atstype_ullint y) { return (x | y) ; }
// end of [atspre_g0uint_ullint_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_land_ullint
  (atstype_ullint x, atstype_ullint y) { return (x & y) ; }
// end of [atspre_g0uint_ullint_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_lxor_ullint
  (atstype_ullint x, atstype_ullint y) { return (x ^ y) ; }
// end of [atspre_g0uint_ullint_ullint]
ATSinline()
atstype_bool
atspre_g0uint_lt_ullint
(
  atstype_ullint x1, atstype_ullint x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lt_ullint]
ATSinline()
atstype_bool
atspre_g0uint_lte_ullint
(
  atstype_ullint x1, atstype_ullint x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lte_ullint]
ATSinline()
atstype_bool
atspre_g0uint_gt_ullint
(
  atstype_ullint x1, atstype_ullint x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gt_ullint]
ATSinline()
atstype_bool
atspre_g0uint_gte_ullint
(
  atstype_ullint x1, atstype_ullint x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gte_ullint]
ATSinline()
atstype_bool
atspre_g0uint_eq_ullint
(
  atstype_ullint x1, atstype_ullint x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_eq_ullint]
ATSinline()
atstype_bool
atspre_g0uint_neq_ullint
(
  atstype_ullint x1, atstype_ullint x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_neq_ullint]
ATSinline()
atstype_int
atspre_g0uint_compare_ullint
(
  atstype_ullint x1, atstype_ullint x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0uint_compare_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_max_ullint
  (atstype_ullint x1, atstype_ullint x2) { return (x1 >= x2 ? x1 : x2) ; }
// end of [atspre_g0uint_max_ullint]
ATSinline()
atstype_ullint
atspre_g0uint_min_ullint
  (atstype_ullint x1, atstype_ullint x2) { return (x1 <= x2 ? x1 : x2) ; }
// end of [atspre_g0uint_min_ullint]
ATSinline()
atstype_bool
atspre_g0uint_isltez_ullint (atstype_ullint x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isltez_ullint]
ATSinline()
atstype_bool
atspre_g0uint_isgtz_ullint (atstype_ullint x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isgtz_ullint]
ATSinline()
atstype_bool
atspre_g0uint_iseqz_ullint (atstype_ullint x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_iseqz_ullint]
ATSinline()
atstype_bool
atspre_g0uint_isneqz_ullint (atstype_ullint x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isneqz_ullint]
//
/* ****** ****** */

#define atspre_g1uint_succ_uint atspre_g0uint_succ_uint
#define atspre_g1uint_pred_uint atspre_g0uint_pred_uint
#define atspre_g1uint_half_uint atspre_g0uint_half_uint
#define atspre_g1uint_add_uint atspre_g0uint_add_uint
#define atspre_g1uint_sub_uint atspre_g0uint_sub_uint
#define atspre_g1uint_mul_uint atspre_g0uint_mul_uint
#define atspre_g1uint_div_uint atspre_g0uint_div_uint
#define atspre_g1uint_mod_uint atspre_g0uint_mod_uint
#define atspre_g1uint_isgtz_uint atspre_g0uint_isgtz_uint
#define atspre_g1uint_iseqz_uint atspre_g0uint_iseqz_uint
#define atspre_g1uint_isneqz_uint atspre_g0uint_isneqz_uint
#define atspre_g1uint_lt_uint atspre_g0uint_lt_uint
#define atspre_g1uint_lte_uint atspre_g0uint_lte_uint
#define atspre_g1uint_gt_uint atspre_g0uint_gt_uint
#define atspre_g1uint_gte_uint atspre_g0uint_gte_uint
#define atspre_g1uint_eq_uint atspre_g0uint_eq_uint
#define atspre_g1uint_neq_uint atspre_g0uint_neq_uint
#define atspre_g1uint_compare_uint atspre_g0uint_compare_uint
#define atspre_g1uint_max_uint atspre_g0uint_max_uint
#define atspre_g1uint_min_uint atspre_g0uint_min_uint

/* ****** ****** */

#define atspre_g1uint_succ_ulint atspre_g0uint_succ_ulint
#define atspre_g1uint_pred_ulint atspre_g0uint_pred_ulint
#define atspre_g1uint_half_ulint atspre_g0uint_half_ulint
#define atspre_g1uint_add_ulint atspre_g0uint_add_ulint
#define atspre_g1uint_sub_ulint atspre_g0uint_sub_ulint
#define atspre_g1uint_mul_ulint atspre_g0uint_mul_ulint
#define atspre_g1uint_div_ulint atspre_g0uint_div_ulint
#define atspre_g1uint_mod_ulint atspre_g0uint_mod_ulint
#define atspre_g1uint_isgtz_ulint atspre_g0uint_isgtz_ulint
#define atspre_g1uint_iseqz_ulint atspre_g0uint_iseqz_ulint
#define atspre_g1uint_isneqz_ulint atspre_g0uint_isneqz_ulint
#define atspre_g1uint_lt_ulint atspre_g0uint_lt_ulint
#define atspre_g1uint_lte_ulint atspre_g0uint_lte_ulint
#define atspre_g1uint_gt_ulint atspre_g0uint_gt_ulint
#define atspre_g1uint_gte_ulint atspre_g0uint_gte_ulint
#define atspre_g1uint_eq_ulint atspre_g0uint_eq_ulint
#define atspre_g1uint_neq_ulint atspre_g0uint_neq_ulint
#define atspre_g1uint_compare_ulint atspre_g0uint_compare_ulint
#define atspre_g1uint_max_ulint atspre_g0uint_max_ulint
#define atspre_g1uint_min_ulint atspre_g0uint_min_ulint

/* ****** ****** */

#define atspre_g1uint_succ_ullint atspre_g0uint_succ_ullint
#define atspre_g1uint_pred_ullint atspre_g0uint_pred_ullint
#define atspre_g1uint_half_ullint atspre_g0uint_half_ullint
#define atspre_g1uint_add_ullint atspre_g0uint_add_ullint
#define atspre_g1uint_sub_ullint atspre_g0uint_sub_ullint
#define atspre_g1uint_mul_ullint atspre_g0uint_mul_ullint
#define atspre_g1uint_div_ullint atspre_g0uint_div_ullint
#define atspre_g1uint_mod_ullint atspre_g0uint_mod_ullint
#define atspre_g1uint_isgtz_ullint atspre_g0uint_isgtz_ullint
#define atspre_g1uint_iseqz_ullint atspre_g0uint_iseqz_ullint
#define atspre_g1uint_isneqz_ullint atspre_g0uint_isneqz_ullint
#define atspre_g1uint_lt_ullint atspre_g0uint_lt_ullint
#define atspre_g1uint_lte_ullint atspre_g0uint_lte_ullint
#define atspre_g1uint_gt_ullint atspre_g0uint_gt_ullint
#define atspre_g1uint_gte_ullint atspre_g0uint_gte_ullint
#define atspre_g1uint_eq_ullint atspre_g0uint_eq_ullint
#define atspre_g1uint_neq_ullint atspre_g0uint_neq_ullint
#define atspre_g1uint_compare_ullint atspre_g0uint_compare_ullint
#define atspre_g1uint_max_ullint atspre_g0uint_max_ullint
#define atspre_g1uint_min_ullint atspre_g0uint_min_ullint

/* ****** ****** */

#endif // ifndef(ATS2CPP_PRELUDE_CATS_INTEGER)

/* ****** ****** */

/* end of [integer.cats] */
