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
** $PATSHOME/prelude/CATS/CODEGEN/integer_size.atxt
** Time of generation: Sun Aug 21 20:48:34 2016
*/

/* ****** ****** */

#ifndef ATS2CPP_PRELUDE_CATS_INTEGER_SIZE
#define ATS2CPP_PRELUDE_CATS_INTEGER_SIZE

/* ****** ****** */
//
#define \
atspre_g0int2uint_int_size(x) ((atstype_size)(x))
#define \
atspre_g1int2uint_int_size(x) atspre_g0int2uint_int_size(x)
#define \
atspre_g0uint2uint_uint_size(x) ((atstype_size)(x))
#define \
atspre_g1uint2uint_uint_size(x) atspre_g0uint2uint_uint_size(x)
//
#define \
atspre_g0int2int_int_ssize(x) ((atstype_ssize)(x))
#define \
atspre_g1int2int_int_ssize(x) atspre_g0int2int_int_ssize(x)
#define \
atspre_g0uint2int_uint_ssize(x) ((atstype_ssize)(x))
#define \
atspre_g1uint2int_uint_ssize(x) atspre_g0uint2int_uint_ssize(x)
//
/* ****** ****** */
//
#define \
atspre_g0int2uint_lint_size(x) ((atstype_size)(x))
#define \
atspre_g1int2uint_lint_size(x) atspre_g0int2uint_lint_size(x)
#define \
atspre_g0uint2uint_ulint_size(x) ((atstype_size)(x))
#define \
atspre_g1uint2uint_ulint_size(x) atspre_g0uint2uint_ulint_size(x)
//
/* ****** ****** */
//
#define \
atspre_g0int2int_lint_ssize(ssz) ((atstype_ssize)(ssz))
#define \
atspre_g1int2int_lint_ssize(ssz) atspre_g0int2int_lint_ssize(ssz)
//
/* ****** ****** */
//
#define \
atspre_g0uint2int_size_int(sz) ((atstype_int)(sz))
#define \
atspre_g1uint2int_size_int(sz) atspre_g0uint2int_size_int(sz)
//
#define \
atspre_g0uint2uint_size_uint(sz) ((atstype_uint)(sz))
#define \
atspre_g1uint2uint_size_uint(sz) atspre_g0uint2uint_size_uint(sz)
//
#define \
atspre_g0uint2uint_size_size(sz) ((atstype_size)(sz))
#define \
atspre_g1uint2uint_size_size(sz) atspre_g0uint2uint_size_size(sz)
//
/* ****** ****** */
//
#define \
atspre_g0int2int_ssize_int(ssz) ((atstype_int)(ssz))
#define \
atspre_g1int2int_ssize_int(ssz) atspre_g0int2int_ssize_int(ssz)
//
#define \
atspre_g0int2uint_ssize_uint(ssz) ((atstype_uint)(ssz))
#define \
atspre_g1int2uint_ssize_uint(ssz) atspre_g0int2uint_ssize_uint(ssz)
//
#define \
atspre_g0int2int_ssize_ssize(ssz) ((atstype_ssize)(ssz))
#define \
atspre_g1int2int_ssize_ssize(ssz) atspre_g0int2int_ssize_ssize(ssz)
//
/* ****** ****** */
//
#define \
atspre_g0uint2int_size_ssize(sz) ((atstype_ssize)(sz))
#define \
atspre_g1uint2int_size_ssize(sz) atspre_g0uint2int_size_ssize(sz)
#define \
atspre_g0int2uint_ssize_size(ssz) ((atstype_size)(ssz))
#define \
atspre_g1int2uint_ssize_size(ssz) atspre_g0int2uint_ssize_size(ssz)
//
/* ****** ****** */
//
ATSinline()
atstype_size
atspre_g0uint_succ_size
  (atstype_size x) { return (x + 1) ; }
// end of [atspre_g0uint_succ_size]
ATSinline()
atstype_size
atspre_g0uint_pred_size
  (atstype_size x) { return (x - 1) ; }
// end of [atspre_g0uint_pred_size]
ATSinline()
atstype_size
atspre_g0uint_half_size
  (atstype_size x) { return (x >> 1) ; }
// end of [atspre_g0uint_half_size]
ATSinline()
atstype_size
atspre_g0uint_add_size
  (atstype_size x1, atstype_size x2) { return (x1 + x2) ; }
// end of [atspre_g0uint_add_size]
ATSinline()
atstype_size
atspre_g0uint_sub_size
  (atstype_size x1, atstype_size x2) { return (x1 - x2) ; }
// end of [atspre_g0uint_sub_size]
ATSinline()
atstype_size
atspre_g0uint_mul_size
  (atstype_size x1, atstype_size x2) { return (x1 * x2) ; }
// end of [atspre_g0uint_mul_size]
ATSinline()
atstype_size
atspre_g0uint_div_size
  (atstype_size x1, atstype_size x2) { return (x1 / x2) ; }
// end of [atspre_g0uint_div_size]
ATSinline()
atstype_size
atspre_g0uint_mod_size
  (atstype_size x1, atstype_size x2) { return (x1 % x2) ; }
// end of [atspre_g0uint_mod_size]
ATSinline()
atstype_size
atspre_g0uint_lsl_size
  (atstype_size x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0uint_lsl_size]
ATSinline()
atstype_size
atspre_g0uint_lsr_size
  (atstype_size x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0uint_lsr_size]
ATSinline()
atstype_size
atspre_g0uint_lnot_size
  (atstype_size x) { return ~(x) ; }
// end of [atspre_g0uint_lnot_size]
ATSinline()
atstype_size
atspre_g0uint_lor_size
  (atstype_size x, atstype_size y) { return (x | y) ; }
// end of [atspre_g0uint_size_size]
ATSinline()
atstype_size
atspre_g0uint_land_size
  (atstype_size x, atstype_size y) { return (x & y) ; }
// end of [atspre_g0uint_size_size]
ATSinline()
atstype_size
atspre_g0uint_lxor_size
  (atstype_size x, atstype_size y) { return (x ^ y) ; }
// end of [atspre_g0uint_size_size]
ATSinline()
atstype_bool
atspre_g0uint_lt_size
(
  atstype_size x1, atstype_size x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lt_size]
ATSinline()
atstype_bool
atspre_g0uint_lte_size
(
  atstype_size x1, atstype_size x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lte_size]
ATSinline()
atstype_bool
atspre_g0uint_gt_size
(
  atstype_size x1, atstype_size x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gt_size]
ATSinline()
atstype_bool
atspre_g0uint_gte_size
(
  atstype_size x1, atstype_size x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gte_size]
ATSinline()
atstype_bool
atspre_g0uint_eq_size
(
  atstype_size x1, atstype_size x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_eq_size]
ATSinline()
atstype_bool
atspre_g0uint_neq_size
(
  atstype_size x1, atstype_size x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_neq_size]
ATSinline()
atstype_int
atspre_g0uint_compare_size
(
  atstype_size x1, atstype_size x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0uint_compare_size]
ATSinline()
atstype_size
atspre_g0uint_max_size
  (atstype_size x1, atstype_size x2) { return (x1 >= x2 ? x1 : x2) ; }
// end of [atspre_g0uint_max_size]
ATSinline()
atstype_size
atspre_g0uint_min_size
  (atstype_size x1, atstype_size x2) { return (x1 <= x2 ? x1 : x2) ; }
// end of [atspre_g0uint_min_size]
ATSinline()
atstype_bool
atspre_g0uint_isltez_size (atstype_size x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isltez_size]
ATSinline()
atstype_bool
atspre_g0uint_isgtz_size (atstype_size x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isgtz_size]
ATSinline()
atstype_bool
atspre_g0uint_iseqz_size (atstype_size x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_iseqz_size]
ATSinline()
atstype_bool
atspre_g0uint_isneqz_size (atstype_size x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isneqz_size]
//
#define atspre_g1uint_succ_size atspre_g0uint_succ_size
#define atspre_g1uint_pred_size atspre_g0uint_pred_size
#define atspre_g1uint_half_size atspre_g0uint_half_size
#define atspre_g1uint_add_size atspre_g0uint_add_size
#define atspre_g1uint_sub_size atspre_g0uint_sub_size
#define atspre_g1uint_mul_size atspre_g0uint_mul_size
#define atspre_g1uint_div_size atspre_g0uint_div_size
#define atspre_g1uint_mod_size atspre_g0uint_mod_size
#define atspre_g1uint_lt_size atspre_g0uint_lt_size
#define atspre_g1uint_lte_size atspre_g0uint_lte_size
#define atspre_g1uint_gt_size atspre_g0uint_gt_size
#define atspre_g1uint_gte_size atspre_g0uint_gte_size
#define atspre_g1uint_eq_size atspre_g0uint_eq_size
#define atspre_g1uint_neq_size atspre_g0uint_neq_size
#define atspre_g1uint_compare_size atspre_g0uint_compare_size
#define atspre_g1uint_max_size atspre_g0uint_max_size
#define atspre_g1uint_min_size atspre_g0uint_min_size
#define atspre_g1uint_isltez_size atspre_g0uint_isltez_size
#define atspre_g1uint_isgtz_size atspre_g0uint_isgtz_size
#define atspre_g1uint_iseqz_size atspre_g0uint_iseqz_size
#define atspre_g1uint_isneqz_size atspre_g0uint_isneqz_size
//
/* ****** ****** */
//
ATSinline()
atstype_ssize
atspre_g0int_neg_ssize
  (atstype_ssize x) { return (-x) ; }
// end of [atspre_g0int_neg_ssize]
ATSinline()
atstype_ssize
atspre_g0int_abs_ssize
  (atstype_ssize x) { return (x >= 0 ? x : -x) ; }
// end of [atspre_g0int_abs_ssize]
ATSinline()
atstype_ssize
atspre_g0int_succ_ssize
  (atstype_ssize x) { return (x + 1) ; }
// end of [atspre_g0int_succ_ssize]
ATSinline()
atstype_ssize
atspre_g0int_pred_ssize
  (atstype_ssize x) { return (x - 1) ; }
// end of [atspre_g0int_pred_ssize]
ATSinline()
atstype_ssize
atspre_g0int_half_ssize
  (atstype_ssize x) { return (x / 2) ; }
// end of [atspre_g0int_half_ssize]
ATSinline()
atstype_ssize
atspre_g0int_add_ssize
  (atstype_ssize x1, atstype_ssize x2) { return (x1 + x2) ; }
// end of [atspre_g0int_add_ssize]
ATSinline()
atstype_ssize
atspre_g0int_sub_ssize
  (atstype_ssize x1, atstype_ssize x2) { return (x1 - x2) ; }
// end of [atspre_g0int_sub_ssize]
ATSinline()
atstype_ssize
atspre_g0int_mul_ssize
  (atstype_ssize x1, atstype_ssize x2) { return (x1 * x2) ; }
// end of [atspre_g0int_mul_ssize]
ATSinline()
atstype_ssize
atspre_g0int_div_ssize
  (atstype_ssize x1, atstype_ssize x2) { return (x1 / x2) ; }
// end of [atspre_g0int_div_ssize]
ATSinline()
atstype_ssize
atspre_g0int_mod_ssize
  (atstype_ssize x1, atstype_ssize x2) { return (x1 % x2) ; }
// end of [atspre_g0int_mod_ssize]
ATSinline()
atstype_ssize
atspre_g0int_nmod_ssize
  (atstype_ssize x1, atstype_ssize x2) { return (x1 % x2) ; }
// end of [atspre_g0int_nmod_ssize]
ATSinline()
atstype_ssize
atspre_g0int_asl_ssize
  (atstype_ssize x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0int_asl_ssize]
ATSinline()
atstype_ssize
atspre_g0int_asr_ssize
  (atstype_ssize x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0int_asr_ssize]
ATSinline()
atstype_bool
atspre_g0int_lt_ssize
(
  atstype_ssize x1, atstype_ssize x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lt_ssize]
ATSinline()
atstype_bool
atspre_g0int_lte_ssize
(
  atstype_ssize x1, atstype_ssize x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lte_ssize]
ATSinline()
atstype_bool
atspre_g0int_gt_ssize
(
  atstype_ssize x1, atstype_ssize x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gt_ssize]
ATSinline()
atstype_bool
atspre_g0int_gte_ssize
(
  atstype_ssize x1, atstype_ssize x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gte_ssize]
ATSinline()
atstype_bool
atspre_g0int_eq_ssize
(
  atstype_ssize x1, atstype_ssize x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_eq_ssize]
ATSinline()
atstype_bool
atspre_g0int_neq_ssize
(
  atstype_ssize x1, atstype_ssize x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_neq_ssize]
ATSinline()
atstype_int
atspre_g0int_compare_ssize
(
  atstype_ssize x1, atstype_ssize x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0int_compare_ssize]
ATSinline()
atstype_ssize
atspre_g0int_max_ssize
  (atstype_ssize x1, atstype_ssize x2) { return (x1 >= x2 ? x1 : x2) ; }
// end of [atspre_g0int_max_ssize]
ATSinline()
atstype_ssize
atspre_g0int_min_ssize
  (atstype_ssize x1, atstype_ssize x2) { return (x1 <= x2 ? x1 : x2) ; }
// end of [atspre_g0int_min_ssize]
ATSinline()
atstype_bool
atspre_g0int_isltz_ssize (atstype_ssize x)
{
  return (x < 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltz_ssize]
ATSinline()
atstype_bool
atspre_g0int_isltez_ssize (atstype_ssize x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltez_ssize]
ATSinline()
atstype_bool
atspre_g0int_isgtz_ssize (atstype_ssize x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtz_ssize]
ATSinline()
atstype_bool
atspre_g0int_isgtez_ssize (atstype_ssize x)
{
  return (x >= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtez_ssize]
ATSinline()
atstype_bool
atspre_g0int_iseqz_ssize (atstype_ssize x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_iseqz_ssize]
ATSinline()
atstype_bool
atspre_g0int_isneqz_ssize (atstype_ssize x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isneqz_ssize]
//
#define atspre_g1int_abs_ssize atspre_g0int_abs_ssize
#define atspre_g1int_neg_ssize atspre_g0int_neg_ssize
#define atspre_g1int_succ_ssize atspre_g0int_succ_ssize
#define atspre_g1int_pred_ssize atspre_g0int_pred_ssize
#define atspre_g1int_half_ssize atspre_g0int_half_ssize
#define atspre_g1int_add_ssize atspre_g0int_add_ssize
#define atspre_g1int_sub_ssize atspre_g0int_sub_ssize
#define atspre_g1int_mul_ssize atspre_g0int_mul_ssize
#define atspre_g1int_div_ssize atspre_g0int_div_ssize
#define atspre_g1int_nmod_ssize atspre_g0int_nmod_ssize
#define atspre_g1int_lt_ssize atspre_g0int_lt_ssize
#define atspre_g1int_lte_ssize atspre_g0int_lte_ssize
#define atspre_g1int_gt_ssize atspre_g0int_gt_ssize
#define atspre_g1int_gte_ssize atspre_g0int_gte_ssize
#define atspre_g1int_eq_ssize atspre_g0int_eq_ssize
#define atspre_g1int_neq_ssize atspre_g0int_neq_ssize
#define atspre_g1int_compare_ssize atspre_g0int_compare_ssize
#define atspre_g1int_max_ssize atspre_g0int_max_ssize
#define atspre_g1int_min_ssize atspre_g0int_min_ssize
#define atspre_g1int_isltz_ssize atspre_g0int_isltz_ssize
#define atspre_g1int_isltez_ssize atspre_g0int_isltez_ssize
#define atspre_g1int_isgtz_ssize atspre_g0int_isgtz_ssize
#define atspre_g1int_isgtez_ssize atspre_g0int_isgtez_ssize
#define atspre_g1int_iseqz_ssize atspre_g0int_iseqz_ssize
#define atspre_g1int_isneqz_ssize atspre_g0int_isneqz_ssize
//
/* ****** ****** */
//
ATSinline()
atstype_size
atspre_g0string2uint_size
  (atstype_string inp)
  { return strtoul((char*)inp, NULL, 10) ; }
//
ATSinline()
atstype_ssize
atspre_g0string2int_ssize
  (atstype_string inp) { return atol((char*)inp) ; }
//
/* ****** ****** */

#endif // ifndef(ATS2CPP_PRELUDE_CATS_INTEGER_SIZE)

/* ****** ****** */

/* end of [integer_size.cats] */

