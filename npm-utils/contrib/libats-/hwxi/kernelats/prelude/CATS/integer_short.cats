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
** $PATSHOME/prelude/CATS/CODEGEN/integer_short.atxt
** Time of generation: Sun Aug 21 20:48:35 2016
*/

/* ****** ****** */

#ifndef ATSLIB_PRELUDE_CATS_INTEGER_SHORT
#define ATSLIB_PRELUDE_CATS_INTEGER_SHORT

/* ****** ****** */
//
#define \
atspre_g0int2int_int_sint(x) ((atstype_sint)(x))
#define \
atspre_g1int2int_int_sint(x) atspre_g0int2int_int_sint(x)
#define \
atspre_g0uint2int_uint_sint(x) ((atstype_sint)(x))
#define \
atspre_g1uint2int_uint_sint(x) atspre_g0uint2int_uint_sint(x)
//
#define \
atspre_g0int2uint_int_usint(x) ((atstype_usint)(x))
#define \
atspre_g1int2uint_int_usint(x) atspre_g0int2uint_int_usint(x)
#define \
atspre_g0uint2uint_uint_usint(x) ((atstype_usint)(x))
#define \
atspre_g1uint2uint_uint_usint(x) atspre_g0uint2uint_uint_usint(x)
//
/* ****** ****** */
//
#define \
atspre_g0int2uint_sint_usint(x) ((atstype_usint)(x))
#define \
atspre_g1int2uint_sint_usint(x) atspre_g0int2uint_sint_usint(x)
#define \
atspre_g0uint2int_usint_sint(x) ((atstype_usint)(x))
#define \
atspre_g1uint2int_usint_sint(x) atspre_g0uint2int_sint_usint(x)
//
/* ****** ****** */
//
#define \
atspre_g0int2int_sint_int(x) ((atstype_int)(x))
#define \
atspre_g1int2int_sint_int(x) atspre_g0int2int_sint_int(x)
//
#define \
atspre_g0uint2uint_usint_uint(x) ((atstype_uint)(x))
#define \
atspre_g1uint2uint_usint_uint(x) atspre_g0uint2uint_usint_uint(x)
//
/* ****** ****** */
//
ATSinline()
atstype_sint
atspre_g0int_neg_sint
  (atstype_sint x) { return (-x) ; }
// end of [atspre_g0int_neg_sint]
ATSinline()
atstype_sint
atspre_g0int_abs_sint
  (atstype_sint x) { return (x >= 0 ? x : -x) ; }
// end of [atspre_g0int_abs_sint]
ATSinline()
atstype_sint
atspre_g0int_succ_sint
  (atstype_sint x) { return (x + 1) ; }
// end of [atspre_g0int_succ_sint]
ATSinline()
atstype_sint
atspre_g0int_pred_sint
  (atstype_sint x) { return (x - 1) ; }
// end of [atspre_g0int_pred_sint]
ATSinline()
atstype_sint
atspre_g0int_half_sint
  (atstype_sint x) { return (x / 2) ; }
// end of [atspre_g0int_half_sint]
ATSinline()
atstype_sint
atspre_g0int_add_sint
  (atstype_sint x1, atstype_sint x2) { return (x1 + x2) ; }
// end of [atspre_g0int_add_sint]
ATSinline()
atstype_sint
atspre_g0int_sub_sint
  (atstype_sint x1, atstype_sint x2) { return (x1 - x2) ; }
// end of [atspre_g0int_sub_sint]
ATSinline()
atstype_sint
atspre_g0int_mul_sint
  (atstype_sint x1, atstype_sint x2) { return (x1 * x2) ; }
// end of [atspre_g0int_mul_sint]
ATSinline()
atstype_sint
atspre_g0int_div_sint
  (atstype_sint x1, atstype_sint x2) { return (x1 / x2) ; }
// end of [atspre_g0int_div_sint]
ATSinline()
atstype_sint
atspre_g0int_mod_sint
  (atstype_sint x1, atstype_sint x2) { return (x1 % x2) ; }
// end of [atspre_g0int_mod_sint]
ATSinline()
atstype_sint
atspre_g0int_nmod_sint
  (atstype_sint x1, atstype_sint x2) { return (x1 % x2) ; }
// end of [atspre_g0int_nmod_sint]
ATSinline()
atstype_sint
atspre_g0int_asl_sint
  (atstype_sint x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0int_asl_sint]
ATSinline()
atstype_sint
atspre_g0int_asr_sint
  (atstype_sint x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0int_asr_sint]
ATSinline()
atstype_bool
atspre_g0int_lt_sint
(
  atstype_sint x1, atstype_sint x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lt_sint]
ATSinline()
atstype_bool
atspre_g0int_lte_sint
(
  atstype_sint x1, atstype_sint x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lte_sint]
ATSinline()
atstype_bool
atspre_g0int_gt_sint
(
  atstype_sint x1, atstype_sint x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gt_sint]
ATSinline()
atstype_bool
atspre_g0int_gte_sint
(
  atstype_sint x1, atstype_sint x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gte_sint]
ATSinline()
atstype_bool
atspre_g0int_eq_sint
(
  atstype_sint x1, atstype_sint x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_eq_sint]
ATSinline()
atstype_bool
atspre_g0int_neq_sint
(
  atstype_sint x1, atstype_sint x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_neq_sint]
ATSinline()
atstype_int
atspre_g0int_compare_sint
(
  atstype_sint x1, atstype_sint x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0int_compare_sint]
ATSinline()
atstype_sint
atspre_g0int_max_sint
  (atstype_sint x1, atstype_sint x2) { return (x1 >= x2 ? x1 : x2) ; }
// end of [atspre_g0int_max_sint]
ATSinline()
atstype_sint
atspre_g0int_min_sint
  (atstype_sint x1, atstype_sint x2) { return (x1 <= x2 ? x1 : x2) ; }
// end of [atspre_g0int_min_sint]
ATSinline()
atstype_bool
atspre_g0int_isltz_sint (atstype_sint x)
{
  return (x < 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltz_sint]
ATSinline()
atstype_bool
atspre_g0int_isltez_sint (atstype_sint x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltez_sint]
ATSinline()
atstype_bool
atspre_g0int_isgtz_sint (atstype_sint x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtz_sint]
ATSinline()
atstype_bool
atspre_g0int_isgtez_sint (atstype_sint x)
{
  return (x >= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtez_sint]
ATSinline()
atstype_bool
atspre_g0int_iseqz_sint (atstype_sint x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_iseqz_sint]
ATSinline()
atstype_bool
atspre_g0int_isneqz_sint (atstype_sint x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isneqz_sint]
//
#define atspre_g1int_abs_sint atspre_g0int_abs_sint
#define atspre_g1int_neg_sint atspre_g0int_neg_sint
#define atspre_g1int_succ_sint atspre_g0int_succ_sint
#define atspre_g1int_pred_sint atspre_g0int_pred_sint
#define atspre_g1int_half_sint atspre_g0int_half_sint
#define atspre_g1int_add_sint atspre_g0int_add_sint
#define atspre_g1int_sub_sint atspre_g0int_sub_sint
#define atspre_g1int_mul_sint atspre_g0int_mul_sint
#define atspre_g1int_div_sint atspre_g0int_div_sint
#define atspre_g1int_nmod_sint atspre_g0int_nmod_sint
#define atspre_g1int_lt_sint atspre_g0int_lt_sint
#define atspre_g1int_lte_sint atspre_g0int_lte_sint
#define atspre_g1int_gt_sint atspre_g0int_gt_sint
#define atspre_g1int_gte_sint atspre_g0int_gte_sint
#define atspre_g1int_eq_sint atspre_g0int_eq_sint
#define atspre_g1int_neq_sint atspre_g0int_neq_sint
#define atspre_g1int_compare_sint atspre_g0int_compare_sint
#define atspre_g1int_max_sint atspre_g0int_max_sint
#define atspre_g1int_min_sint atspre_g0int_min_sint
#define atspre_g1int_isltz_sint atspre_g0int_isltz_sint
#define atspre_g1int_isltez_sint atspre_g0int_isltez_sint
#define atspre_g1int_isgtz_sint atspre_g0int_isgtz_sint
#define atspre_g1int_isgtez_sint atspre_g0int_isgtez_sint
#define atspre_g1int_iseqz_sint atspre_g0int_iseqz_sint
#define atspre_g1int_isneqz_sint atspre_g0int_isneqz_sint
//
/* ****** ****** */
//
ATSinline()
atstype_usint
atspre_g0uint_succ_usint
  (atstype_usint x) { return (x + 1) ; }
// end of [atspre_g0uint_succ_usint]
ATSinline()
atstype_usint
atspre_g0uint_pred_usint
  (atstype_usint x) { return (x - 1) ; }
// end of [atspre_g0uint_pred_usint]
ATSinline()
atstype_usint
atspre_g0uint_half_usint
  (atstype_usint x) { return (x >> 1) ; }
// end of [atspre_g0uint_half_usint]
ATSinline()
atstype_usint
atspre_g0uint_add_usint
  (atstype_usint x1, atstype_usint x2) { return (x1 + x2) ; }
// end of [atspre_g0uint_add_usint]
ATSinline()
atstype_usint
atspre_g0uint_sub_usint
  (atstype_usint x1, atstype_usint x2) { return (x1 - x2) ; }
// end of [atspre_g0uint_sub_usint]
ATSinline()
atstype_usint
atspre_g0uint_mul_usint
  (atstype_usint x1, atstype_usint x2) { return (x1 * x2) ; }
// end of [atspre_g0uint_mul_usint]
ATSinline()
atstype_usint
atspre_g0uint_div_usint
  (atstype_usint x1, atstype_usint x2) { return (x1 / x2) ; }
// end of [atspre_g0uint_div_usint]
ATSinline()
atstype_usint
atspre_g0uint_mod_usint
  (atstype_usint x1, atstype_usint x2) { return (x1 % x2) ; }
// end of [atspre_g0uint_mod_usint]
ATSinline()
atstype_usint
atspre_g0uint_lsl_usint
  (atstype_usint x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0uint_lsl_usint]
ATSinline()
atstype_usint
atspre_g0uint_lsr_usint
  (atstype_usint x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0uint_lsr_usint]
ATSinline()
atstype_usint
atspre_g0uint_lnot_usint
  (atstype_usint x) { return ~(x) ; }
// end of [atspre_g0uint_lnot_usint]
ATSinline()
atstype_usint
atspre_g0uint_lor_usint
  (atstype_usint x, atstype_usint y) { return (x | y) ; }
// end of [atspre_g0uint_usint_usint]
ATSinline()
atstype_usint
atspre_g0uint_land_usint
  (atstype_usint x, atstype_usint y) { return (x & y) ; }
// end of [atspre_g0uint_usint_usint]
ATSinline()
atstype_usint
atspre_g0uint_lxor_usint
  (atstype_usint x, atstype_usint y) { return (x ^ y) ; }
// end of [atspre_g0uint_usint_usint]
ATSinline()
atstype_bool
atspre_g0uint_lt_usint
(
  atstype_usint x1, atstype_usint x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lt_usint]
ATSinline()
atstype_bool
atspre_g0uint_lte_usint
(
  atstype_usint x1, atstype_usint x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lte_usint]
ATSinline()
atstype_bool
atspre_g0uint_gt_usint
(
  atstype_usint x1, atstype_usint x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gt_usint]
ATSinline()
atstype_bool
atspre_g0uint_gte_usint
(
  atstype_usint x1, atstype_usint x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gte_usint]
ATSinline()
atstype_bool
atspre_g0uint_eq_usint
(
  atstype_usint x1, atstype_usint x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_eq_usint]
ATSinline()
atstype_bool
atspre_g0uint_neq_usint
(
  atstype_usint x1, atstype_usint x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_neq_usint]
ATSinline()
atstype_int
atspre_g0uint_compare_usint
(
  atstype_usint x1, atstype_usint x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0uint_compare_usint]
ATSinline()
atstype_usint
atspre_g0uint_max_usint
  (atstype_usint x1, atstype_usint x2) { return (x1 >= x2 ? x1 : x2) ; }
// end of [atspre_g0uint_max_usint]
ATSinline()
atstype_usint
atspre_g0uint_min_usint
  (atstype_usint x1, atstype_usint x2) { return (x1 <= x2 ? x1 : x2) ; }
// end of [atspre_g0uint_min_usint]
ATSinline()
atstype_bool
atspre_g0uint_isltez_usint (atstype_usint x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isltez_usint]
ATSinline()
atstype_bool
atspre_g0uint_isgtz_usint (atstype_usint x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isgtz_usint]
ATSinline()
atstype_bool
atspre_g0uint_iseqz_usint (atstype_usint x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_iseqz_usint]
ATSinline()
atstype_bool
atspre_g0uint_isneqz_usint (atstype_usint x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isneqz_usint]
//
#define atspre_g1uint_succ_usint atspre_g0uint_succ_usint
#define atspre_g1uint_pred_usint atspre_g0uint_pred_usint
#define atspre_g1uint_half_usint atspre_g0uint_half_usint
#define atspre_g1uint_add_usint atspre_g0uint_add_usint
#define atspre_g1uint_sub_usint atspre_g0uint_sub_usint
#define atspre_g1uint_mul_usint atspre_g0uint_mul_usint
#define atspre_g1uint_div_usint atspre_g0uint_div_usint
#define atspre_g1uint_mod_usint atspre_g0uint_mod_usint
#define atspre_g1uint_lt_usint atspre_g0uint_lt_usint
#define atspre_g1uint_lte_usint atspre_g0uint_lte_usint
#define atspre_g1uint_gt_usint atspre_g0uint_gt_usint
#define atspre_g1uint_gte_usint atspre_g0uint_gte_usint
#define atspre_g1uint_eq_usint atspre_g0uint_eq_usint
#define atspre_g1uint_neq_usint atspre_g0uint_neq_usint
#define atspre_g1uint_compare_usint atspre_g0uint_compare_usint
#define atspre_g1uint_max_usint atspre_g0uint_max_usint
#define atspre_g1uint_min_usint atspre_g0uint_min_usint
#define atspre_g1uint_isltez_usint atspre_g0uint_isltez_usint
#define atspre_g1uint_isgtz_usint atspre_g0uint_isgtz_usint
#define atspre_g1uint_iseqz_usint atspre_g0uint_iseqz_usint
#define atspre_g1uint_isneqz_usint atspre_g0uint_isneqz_usint
//
/* ****** ****** */

#endif // ifndef ATSLIB_PRELUDE_CATS_INTEGER_SHORT

/* ****** ****** */

/* end of [integer_short.cats] */
