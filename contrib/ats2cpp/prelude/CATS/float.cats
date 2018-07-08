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
** Source:
** $PATSHOME/prelude/CATS/CODEGEN/float.atxt
** Time of generation: Sun Nov 27 09:09:17 2016
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: April, 2012 *)
*/

/* ****** ****** */

#ifndef ATS2CPP_PRELUDE_CATS_FLOAT
#define ATS2CPP_PRELUDE_CATS_FLOAT

/* ****** ****** */

ATSinline()
atstype_float
atspre_g0int2float_int_float
  (atstype_int x) { return ((atstype_float)x) ; }
// end of [atspre_g0int2float_int_float]

ATSinline()
atstype_double
atspre_g0int2float_int_double
  (atstype_int x) { return ((atstype_double)x) ; }
// end of [atspre_g0int2float_int_double]

ATSinline()
atstype_double
atspre_g0int2float_lint_double
  (atstype_lint x) { return ((atstype_double)x) ; }
// end of [atspre_g0int2float_lint_double]

/* ****** ****** */

ATSinline()
atstype_int
atspre_g0float2int_float_int
  (atstype_float x) { return ((atstype_int)x) ; }
ATSinline()
atstype_lint
atspre_g0float2int_float_lint
  (atstype_float x) { return ((atstype_lint)x) ; }
ATSinline()
atstype_llint
atspre_g0float2int_float_llint
  (atstype_float x) { return ((atstype_llint)x) ; }

ATSinline()
atstype_int
atspre_g0float2int_double_int
  (atstype_double x) { return ((atstype_int)x) ; }
ATSinline()
atstype_lint
atspre_g0float2int_double_lint
  (atstype_double x) { return ((atstype_lint)x) ; }
ATSinline()
atstype_llint
atspre_g0float2int_double_llint
  (atstype_double x) { return ((atstype_llint)x) ; }

/* ****** ****** */

ATSinline()
atstype_float
atspre_g0float2float_float_float (atstype_float x) { return (x) ; }

ATSinline()
atstype_double
atspre_g0float2float_double_double (atstype_double x) { return (x) ; }

ATSinline()
atstype_double
atspre_g0float2float_float_double
(
atstype_float x
)
{
 return ((atstype_double)x) ;
}

ATSinline()
atstype_float
atspre_g0float2float_double_float
(
atstype_double x
)
{
 return ((atstype_float)x) ;
}

/* ****** ****** */
//
extern "C"
{
double atof (const char *inp) throw ();
}
//
ATSinline()
atstype_double
atspre_g0string2float_double
  (atstype_string inp) { return atof((char*)inp) ; }
//
/* ****** ****** */

ATSinline()
atstype_float
atspre_g0float_neg_float (atstype_float f) { return (-f) ; }
ATSinline()
atstype_double
atspre_g0float_neg_double (atstype_double f) { return (-f) ; }
ATSinline()
atstype_ldouble
atspre_g0float_neg_ldouble (atstype_ldouble f) { return (-f) ; }

ATSinline()
atstype_float
atspre_g0float_abs_float (atstype_float f) { return (f >= 0 ? f : -f) ; }
ATSinline()
atstype_double
atspre_g0float_abs_double (atstype_double f) { return (f >= 0 ? f : -f) ; }
ATSinline()
atstype_ldouble
atspre_g0float_abs_ldouble (atstype_ldouble f) { return (f >= 0 ? f : -f) ; }

ATSinline()
atstype_float
atspre_g0float_succ_float (atstype_float f) { return (f+1) ; }
ATSinline()
atstype_double
atspre_g0float_succ_double (atstype_double f) { return (f+1) ; }
ATSinline()
atstype_ldouble
atspre_g0float_succ_ldouble (atstype_ldouble f) { return (f+1) ; }

ATSinline()
atstype_float
atspre_g0float_pred_float (atstype_float f) { return (f-1) ; }
ATSinline()
atstype_double
atspre_g0float_pred_double (atstype_double f) { return (f-1) ; }
ATSinline()
atstype_ldouble
atspre_g0float_pred_ldouble (atstype_ldouble f) { return (f-1) ; }

/* ****** ****** */

//
ATSinline()
atstype_float
atspre_g0float_add_float
  (atstype_float f1, atstype_float f2) { return (f1 + f2) ; }
// end of [atspre_g0float_add_float]
ATSinline()
atstype_float
atspre_g0float_sub_float
  (atstype_float f1, atstype_float f2) { return (f1 - f2) ; }
// end of [atspre_g0float_sub_float]
ATSinline()
atstype_float
atspre_g0float_mul_float
  (atstype_float f1, atstype_float f2) { return (f1 * f2) ; }
// end of [atspre_g0float_mul_float]
ATSinline()
atstype_float
atspre_g0float_div_float
  (atstype_float f1, atstype_float f2) { return (f1 / f2) ; }
// end of [atspre_g0float_div_float]
//
ATSinline()
atstype_double
atspre_g0float_add_double
  (atstype_double f1, atstype_double f2) { return (f1 + f2) ; }
// end of [atspre_g0float_add_double]
ATSinline()
atstype_double
atspre_g0float_sub_double
  (atstype_double f1, atstype_double f2) { return (f1 - f2) ; }
// end of [atspre_g0float_sub_double]
ATSinline()
atstype_double
atspre_g0float_mul_double
  (atstype_double f1, atstype_double f2) { return (f1 * f2) ; }
// end of [atspre_g0float_mul_double]
ATSinline()
atstype_double
atspre_g0float_div_double
  (atstype_double f1, atstype_double f2) { return (f1 / f2) ; }
// end of [atspre_g0float_div_double]
//
ATSinline()
atstype_ldouble
atspre_g0float_add_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) { return (f1 + f2) ; }
// end of [atspre_g0float_add_ldouble]
ATSinline()
atstype_ldouble
atspre_g0float_sub_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) { return (f1 - f2) ; }
// end of [atspre_g0float_sub_ldouble]
ATSinline()
atstype_ldouble
atspre_g0float_mul_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) { return (f1 * f2) ; }
// end of [atspre_g0float_mul_ldouble]
ATSinline()
atstype_ldouble
atspre_g0float_div_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) { return (f1 / f2) ; }
// end of [atspre_g0float_div_ldouble]
//
extern "C"
{
atstype_float fmodf (atstype_float, atstype_float) throw ();
atstype_double fmod (atstype_double, atstype_double) throw ();
atstype_ldouble fmodl (atstype_ldouble, atstype_ldouble) throw ();
}
//
ATSinline()
atstype_float
atspre_g0float_mod_float
  (atstype_float f1, atstype_float f2) { return fmodf(f1, f2) ; }
ATSinline()
atstype_double
atspre_g0float_mod_double
  (atstype_double f1, atstype_double f2) { return fmod(f1, f2) ; }
ATSinline()
atstype_ldouble
atspre_g0float_mod_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) { return fmodl(f1, f2) ; }
//
/* ****** ****** */

//
ATSinline()
atstype_bool
atspre_g0float_lt_float
  (atstype_float f1, atstype_float f2) {
  return (f1 < f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_lt_float]
ATSinline()
atstype_bool
atspre_g0float_lte_float
  (atstype_float f1, atstype_float f2) {
  return (f1 <= f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_lte_float]
ATSinline()
atstype_bool
atspre_g0float_gt_float
  (atstype_float f1, atstype_float f2) {
  return (f1 > f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_gt_float]
ATSinline()
atstype_bool
atspre_g0float_gte_float
  (atstype_float f1, atstype_float f2) {
  return (f1 >= f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_gte_float]
ATSinline()
atstype_bool
atspre_g0float_eq_float
  (atstype_float f1, atstype_float f2) {
  return (f1 == f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_eq_float]
ATSinline()
atstype_bool
atspre_g0float_neq_float
  (atstype_float f1, atstype_float f2) {
  return (f1 != f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_neq_float]
//
ATSinline()
atstype_bool
atspre_g0float_lt_double
  (atstype_double f1, atstype_double f2) {
  return (f1 < f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_lt_double]
ATSinline()
atstype_bool
atspre_g0float_lte_double
  (atstype_double f1, atstype_double f2) {
  return (f1 <= f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_lte_double]
ATSinline()
atstype_bool
atspre_g0float_gt_double
  (atstype_double f1, atstype_double f2) {
  return (f1 > f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_gt_double]
ATSinline()
atstype_bool
atspre_g0float_gte_double
  (atstype_double f1, atstype_double f2) {
  return (f1 >= f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_gte_double]
ATSinline()
atstype_bool
atspre_g0float_eq_double
  (atstype_double f1, atstype_double f2) {
  return (f1 == f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_eq_double]
ATSinline()
atstype_bool
atspre_g0float_neq_double
  (atstype_double f1, atstype_double f2) {
  return (f1 != f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_neq_double]
//
ATSinline()
atstype_bool
atspre_g0float_lt_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) {
  return (f1 < f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_lt_ldouble]
ATSinline()
atstype_bool
atspre_g0float_lte_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) {
  return (f1 <= f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_lte_ldouble]
ATSinline()
atstype_bool
atspre_g0float_gt_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) {
  return (f1 > f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_gt_ldouble]
ATSinline()
atstype_bool
atspre_g0float_gte_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) {
  return (f1 >= f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_gte_ldouble]
ATSinline()
atstype_bool
atspre_g0float_eq_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) {
  return (f1 == f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_eq_ldouble]
ATSinline()
atstype_bool
atspre_g0float_neq_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) {
  return (f1 != f2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0float_neq_ldouble]
//
/* ****** ****** */

ATSinline()
atstype_int
atspre_g0float_compare_float
(
  atstype_float f1, atstype_float f2
)
{
  if (f1 > f2) return 1 ; else if (f1 < f2) return -1 ; else return 0 ;
} // end of [atspre_g0float_compare_float]

ATSinline()
atstype_int
atspre_g0float_compare_double
(
  atstype_double f1, atstype_double f2
)
{
  if (f1 > f2) return 1 ; else if (f1 < f2) return -1 ; else return 0 ;
} // end of [atspre_g0float_compare_double]

ATSinline()
atstype_int
atspre_g0float_compare_ldouble
(
  atstype_ldouble f1, atstype_ldouble f2
)
{
  if (f1 > f2) return 1 ; else if (f1 < f2) return -1 ; else return 0 ;
} // end of [atspre_g0float_compare_ldouble]

/* ****** ****** */

ATSinline()
atstype_float
atspre_g0float_min_float
  (atstype_float f1, atstype_float f2) { return (f1 <= f2 ? f1 : f2) ; }
// end of [atspre_g0float_min_float]
ATSinline()
atstype_double
atspre_g0float_min_double
  (atstype_double f1, atstype_double f2) { return (f1 <= f2 ? f1 : f2) ; }
// end of [atspre_g0float_min_double]
ATSinline()
atstype_ldouble
atspre_g0float_min_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) { return (f1 <= f2 ? f1 : f2) ; }
// end of [atspre_g0float_min_ldouble]

ATSinline()
atstype_float
atspre_g0float_max_float
  (atstype_float f1, atstype_float f2) { return (f1 >= f2 ? f1 : f2) ; }
// end of [atspre_g0float_max_float]
ATSinline()
atstype_double
atspre_g0float_max_double
  (atstype_double f1, atstype_double f2) { return (f1 >= f2 ? f1 : f2) ; }
// end of [atspre_g0float_max_double]
ATSinline()
atstype_ldouble
atspre_g0float_max_ldouble
  (atstype_ldouble f1, atstype_ldouble f2) { return (f1 >= f2 ? f1 : f2) ; }
// end of [atspre_g0float_max_ldouble]

/* ****** ****** */

//
ATSinline()
atstype_float
atspre_add_int_float
  (atstype_int i1, atstype_float f2) { return (((atstype_float)i1) + f2) ; }
// end of [atspre_add_int_float]
ATSinline()
atstype_float
atspre_sub_int_float
  (atstype_int i1, atstype_float f2) { return (((atstype_float)i1) - f2) ; }
// end of [atspre_sub_int_float]
ATSinline()
atstype_float
atspre_mul_int_float
  (atstype_int i1, atstype_float f2) { return (((atstype_float)i1) * f2) ; }
// end of [atspre_mul_int_float]
ATSinline()
atstype_float
atspre_div_int_float
  (atstype_int i1, atstype_float f2) { return (((atstype_float)i1) / f2) ; }
// end of [atspre_div_int_float]
//
ATSinline()
atstype_double
atspre_add_int_double
  (atstype_int i1, atstype_double f2) { return (((atstype_double)i1) + f2) ; }
// end of [atspre_add_int_double]
ATSinline()
atstype_double
atspre_sub_int_double
  (atstype_int i1, atstype_double f2) { return (((atstype_double)i1) - f2) ; }
// end of [atspre_sub_int_double]
ATSinline()
atstype_double
atspre_mul_int_double
  (atstype_int i1, atstype_double f2) { return (((atstype_double)i1) * f2) ; }
// end of [atspre_mul_int_double]
ATSinline()
atstype_double
atspre_div_int_double
  (atstype_int i1, atstype_double f2) { return (((atstype_double)i1) / f2) ; }
// end of [atspre_div_int_double]
//
ATSinline()
atstype_ldouble
atspre_add_int_ldouble
  (atstype_int i1, atstype_ldouble f2) { return (((atstype_ldouble)i1) + f2) ; }
// end of [atspre_add_int_ldouble]
ATSinline()
atstype_ldouble
atspre_sub_int_ldouble
  (atstype_int i1, atstype_ldouble f2) { return (((atstype_ldouble)i1) - f2) ; }
// end of [atspre_sub_int_ldouble]
ATSinline()
atstype_ldouble
atspre_mul_int_ldouble
  (atstype_int i1, atstype_ldouble f2) { return (((atstype_ldouble)i1) * f2) ; }
// end of [atspre_mul_int_ldouble]
ATSinline()
atstype_ldouble
atspre_div_int_ldouble
  (atstype_int i1, atstype_ldouble f2) { return (((atstype_ldouble)i1) / f2) ; }
// end of [atspre_div_int_ldouble]
//
/* ****** ****** */

//
ATSinline()
atstype_float
atspre_add_float_int
  (atstype_float f1, atstype_int i2) { return (f1 + ((atstype_float)i2)) ; }
// end of [atspre_add_float_int]
ATSinline()
atstype_float
atspre_sub_float_int
  (atstype_float f1, atstype_int i2) { return (f1 - ((atstype_float)i2)) ; }
// end of [atspre_sub_float_int]
ATSinline()
atstype_float
atspre_mul_float_int
  (atstype_float f1, atstype_int i2) { return (f1 * ((atstype_float)i2)) ; }
// end of [atspre_mul_float_int]
ATSinline()
atstype_float
atspre_div_float_int
  (atstype_float f1, atstype_int i2) { return (f1 / ((atstype_float)i2)) ; }
// end of [atspre_div_float_int]
//
ATSinline()
atstype_double
atspre_add_double_int
  (atstype_double f1, atstype_int i2) { return (f1 + ((atstype_double)i2)) ; }
// end of [atspre_add_double_int]
ATSinline()
atstype_double
atspre_sub_double_int
  (atstype_double f1, atstype_int i2) { return (f1 - ((atstype_double)i2)) ; }
// end of [atspre_sub_double_int]
ATSinline()
atstype_double
atspre_mul_double_int
  (atstype_double f1, atstype_int i2) { return (f1 * ((atstype_double)i2)) ; }
// end of [atspre_mul_double_int]
ATSinline()
atstype_double
atspre_div_double_int
  (atstype_double f1, atstype_int i2) { return (f1 / ((atstype_double)i2)) ; }
// end of [atspre_div_double_int]
//
ATSinline()
atstype_ldouble
atspre_add_ldouble_int
  (atstype_ldouble f1, atstype_int i2) { return (f1 + ((atstype_ldouble)i2)) ; }
// end of [atspre_add_ldouble_int]
ATSinline()
atstype_ldouble
atspre_sub_ldouble_int
  (atstype_ldouble f1, atstype_int i2) { return (f1 - ((atstype_ldouble)i2)) ; }
// end of [atspre_sub_ldouble_int]
ATSinline()
atstype_ldouble
atspre_mul_ldouble_int
  (atstype_ldouble f1, atstype_int i2) { return (f1 * ((atstype_ldouble)i2)) ; }
// end of [atspre_mul_ldouble_int]
ATSinline()
atstype_ldouble
atspre_div_ldouble_int
  (atstype_ldouble f1, atstype_int i2) { return (f1 / ((atstype_ldouble)i2)) ; }
// end of [atspre_div_ldouble_int]
//
/* ****** ****** */

#endif // ifndef(ATS2CPP_PRELUDE_CATS_FLOAT)

/* ****** ****** */

/* end of [float.cats] */

