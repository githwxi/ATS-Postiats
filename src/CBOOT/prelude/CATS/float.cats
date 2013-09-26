/************************************************************************/
/*                                                                      */
/*                         Applied Type System                          */
/*                                                                      */
/*                              Hongwei Xi                              */
/*                                                                      */
/************************************************************************/

/*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2008 Hongwei Xi.
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
*/

/* ****** ****** */

/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATS_PRELUDE_FLOAT_CATS
#define ATS_PRELUDE_FLOAT_CATS

/* ****** ****** */

#include <math.h>

/* ****** ****** */

extern
int fprintf (FILE *stream, const char *format, ...) ;
// in [stdio.h]

/* ****** ****** */
//
// HX: these functions are in [stdlib.h]
//
extern double atof (const char *str) ;
extern long int atol (const char *str) ;
extern long long int atoll (const char *str) ;

/* ****** ****** */

#include "ats_types.h"

/* ****** ****** */

extern
ats_ptr_type
atspre_tostringf (ats_ptr_type fmt, ...) ;
extern
ats_void_type
ats_exit_errmsg(ats_int_type n, ats_ptr_type msg) ;

/* ****** ****** */

/* floating point numbers of single precision */

/* ****** ****** */

ATSinline()
ats_int_type
atspre_int_of_float (ats_float_type f) { return f ; }

ATSinline()
ats_lint_type
atspre_lint_of_float (ats_float_type f) { return f ; }

ATSinline()
ats_llint_type
atspre_llint_of_float (ats_float_type f) { return f ; }

//

ATSinline()
ats_float_type
atspre_float_of_int (ats_int_type i) { return (ats_float_type)i ; }

ATSinline()
ats_float_type
atspre_float_of_uint (ats_uint_type u) { return (ats_float_type)u ; }

//

ATSinline()
ats_float_type
atspre_float_of_lint (ats_lint_type i) { return (ats_float_type)i ; }

ATSinline()
ats_float_type
atspre_float_of_ulint (ats_ulint_type u) { return (ats_float_type)u ; }

//

ATSinline()
ats_float_type
atspre_float_of_llint (ats_llint_type i) { return (ats_float_type)i ; }

ATSinline()
ats_float_type
atspre_float_of_ullint (ats_ullint_type u) { return (ats_float_type)u ; }

//

ATSinline()
ats_float_type
atspre_float_of_size (ats_size_type sz) { return (ats_float_type)sz ; }

//

ATSinline()
ats_float_type
atspre_float_of_double
  (ats_double_type d) { return (ats_float_type)d ; }
// end of [atspre_float_of_double]

ATSinline()
ats_float_type
atspre_float_of_string
  (const ats_ptr_type s) { return (ats_float_type)(atof ((char *)s)) ; }
// end of [atspre_float_of_string]

/* ****** ****** */

ATSinline()
ats_float_type
atspre_abs_float
  (ats_float_type f) { return (f >= 0.0 ? f : -f) ; }
// end of [atspre_abs_float]

ATSinline()
ats_float_type
atspre_neg_float (ats_float_type f) { return (-f) ; }

ATSinline()
ats_float_type
atspre_succ_float (ats_float_type f) { return (f + 1.0) ; }

ATSinline()
ats_float_type
atspre_pred_float (ats_float_type f) { return (f - 1.0) ; }

//

ATSinline()
ats_float_type
atspre_add_float_float
  (ats_float_type f1, ats_float_type f2) {
  return (f1 + f2) ;
} // end of [atspre_add_float_float]

ATSinline()
ats_float_type
atspre_sub_float_float
  (ats_float_type f1, ats_float_type f2) {
  return (f1 - f2) ;
} // end of [atspre_sub_float_float]

//

ATSinline()
ats_float_type
atspre_mul_float_float
  (ats_float_type f1, ats_float_type f2) { return (f1 * f2) ; }
// end of [atspre_mul_float_float]

ATSinline()
ats_float_type
atspre_mul_int_float
  (ats_int_type i1, ats_float_type f2) { return ((float)i1 * f2) ; }
// end of [atspre_mul_int_float]

ATSinline()
ats_float_type
atspre_mul_float_int
  (ats_float_type f1, ats_int_type i2) { return (f1 * (float)i2) ; }
// end of [atspre_mul_float_int]

//

ATSinline()
ats_float_type
atspre_div_float_float
  (ats_float_type f1, ats_float_type f2) { return (f1 / f2) ; }
// end of [atspre_div_float_float]

ATSinline()
ats_float_type
atspre_div_float_int
  (ats_float_type f1, ats_int_type i2) { return (f1 / (float)i2) ; }
// end of [atspre_div_float_int]

ATSinline()
ats_float_type
atspre_div_int_float
  (ats_float_type i1, ats_int_type f2) { return ((float)i1 / f2) ; }
// end of [atspre_div_int_float]

//

ATSinline()
ats_bool_type
atspre_lt_float_float (
  ats_float_type f1, ats_float_type f2
) {
  return (f1 < f2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lt_float_float]

ATSinline()
ats_bool_type
atspre_lte_float_float (
  ats_float_type f1, ats_float_type f2
) {
  return (f1 <= f2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lte_float_float]

ATSinline()
ats_bool_type
atspre_gt_float_float (
  ats_float_type f1, ats_float_type f2
) {
  return (f1 > f2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gt_float_float]

ATSinline()
ats_bool_type
atspre_gte_float_float (
  ats_float_type f1, ats_float_type f2
) {
  return (f1 >= f2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gte_float_float]

ATSinline()
ats_bool_type
atspre_eq_float_float (
  ats_float_type f1, ats_float_type f2
) {
  return (f1 == f2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_eq_float_float]

ATSinline()
ats_bool_type
atspre_neq_float_float (
  ats_float_type f1, ats_float_type f2
) {
  return (f1 != f2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_neq_float_float]

// compare, max and min

ATSinline()
ats_int_type
atspre_compare_float_float
  (ats_float_type f1, ats_float_type f2) {
  if (f1 < f2) return (-1) ;
  if (f1 > f2) return ( 1) ;
  return 0 ;
}

ATSinline()
ats_float_type
atspre_max_float_float
  (ats_float_type f1, ats_float_type f2) {
  return (f1 >= f2) ? f1 : f2 ;
}

ATSinline()
ats_float_type
atspre_min_float_float
  (ats_float_type f1, ats_float_type f2) {
  return (f1 <= f2) ? f1 : f2 ;
}

// square function

ATSinline()
ats_float_type
atspre_square_float (ats_float_type f) { return (f * f) ; }

// cube function

ATSinline()
ats_float_type
atspre_cube_float (ats_float_type f) { return (f * f * f) ; }

// print function

ATSinline()
ats_void_type
atspre_fprint_float (
  ats_ptr_type out, ats_float_type f
) {
  int n = fprintf ((FILE*)out, "%f", f) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_float] failed.\n") ;
  } // end of [if]
  return ;
} /* end of [atspre_fprint_float] */

ATSinline()
ats_void_type
atspre_print_float (ats_float_type f) {
//  atspre_stdout_view_get () ;
  atspre_fprint_float ((ats_ptr_type)stdout, f) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_float (ats_float_type f) {
//  atspre_stderr_view_get () ;
  atspre_fprint_float ((ats_ptr_type)stderr, f) ;
//  atspre_stderr_view_set () ;
  return ;
}

// stringization

ATSinline()
ats_ptr_type
atspre_tostrptr_float
  (ats_float_type f) {
  return atspre_tostringf ((ats_ptr_type)"%f", f) ;
} // end of [atspre_tostrptr_float]

/* ****** ****** */

/* floating point numbers of double precision */

/* ****** ****** */

ATSinline()
ats_int_type
atspre_int_of_double (ats_double_type d) { return (ats_int_type)d ; }

ATSinline()
ats_lint_type
atspre_lint_of_double (ats_double_type d) { return (ats_lint_type)d ; }

ATSinline()
ats_llint_type
atspre_llint_of_double (ats_double_type d) { return (ats_llint_type)d ; }
// end of [atspre_llint_of_double]

ATSinline()
ats_ullint_type
atspre_ullint_of_double (ats_double_type d) { return ((ats_ullint_type)d) ; }
// end of [atspre_ullint_of_double]

/* ****** ****** */

ATSinline()
ats_double_type
atspre_double_of_int (ats_int_type i) { return (ats_double_type)i ; }
// end of [atspre_double_of_int]

ATSinline()
ats_double_type
atspre_double_of_uint (ats_uint_type u) { return (ats_double_type)u ; }
// end of [atspre_double_of_uint]

ATSinline()
ats_double_type
atspre_double_of_lint (ats_lint_type i) { return (ats_double_type)i ; }
// end of [atspre_double_of_lint]

ATSinline()
ats_double_type
atspre_double_of_ulint (ats_ulint_type u) { return (ats_double_type)u ; }
// end of [atspre_double_of_ulint]

ATSinline()
ats_double_type
atspre_double_of_llint (ats_llint_type i) { return (ats_double_type)i ; }
// end of [atspre_double_of_llint]

ATSinline()
ats_double_type
atspre_double_of_ullint (ats_ullint_type u) { return (ats_double_type)u ; }
// end of [atspre_double_of_ullint]

ATSinline()
ats_double_type
atspre_double_of_size (ats_size_type sz) { return (ats_double_type)sz ; }
// end of [atspre_double_of_size]

ATSinline()
ats_double_type
atspre_double_of_float (ats_float_type f) { return (ats_double_type)f ; }
// end of [atspre_double_of_float]

ATSinline()
ats_double_type
atspre_double_of_string
  (const ats_ptr_type s) { return (ats_double_type)(atof ((char*)s)) ; }
// end of [atspre_double_of_string]

/* ****** ****** */

ATSinline()
ats_double_type
atspre_abs_double
  (ats_double_type f) { return (f >= 0.0 ? f : -f) ; }
// end of [atspre_abs_double]

ATSinline()
ats_double_type
atspre_neg_double (ats_double_type f) { return (-f) ; }

ATSinline()
ats_double_type
atspre_succ_double (ats_double_type f) { return (f + 1.0) ; }

ATSinline()
ats_double_type
atspre_pred_double (ats_double_type f) { return (f - 1.0) ; }

/* ****** ****** */

ATSinline()
ats_double_type
atspre_add_double_double
  (ats_double_type f1, ats_double_type f2) { return (f1 + f2) ; }
// end of [atspre_add_double_double]

ATSinline()
ats_double_type
atspre_add_double_int
  (ats_double_type f1, ats_int_type i2) { return (f1 + i2) ; }
// end of [atspre_add_double_int]

ATSinline()
ats_double_type
atspre_add_int_double
  (ats_int_type i1, ats_double_type f2) { return (i1 + f2) ; }
// end of [atspre_add_int_double]

ATSinline()
ats_double_type
atspre_sub_double_double
  (ats_double_type f1, ats_double_type f2) { return (f1 - f2) ; }
// end of [atspre_sub_double_double]

ATSinline()
ats_double_type
atspre_sub_double_int
  (ats_double_type f1, ats_int_type i2) {
  return (f1 - i2) ;
}

ATSinline()
ats_double_type
atspre_sub_int_double
  (ats_int_type i1, ats_double_type f2) { return (i1 - f2) ; }
// end of [atspre_sub_int_double]

ATSinline()
ats_double_type
atspre_mul_double_double
  (ats_double_type d1, ats_double_type d2) { return (d1 * d2) ; }
// end of [atspre_mul_double_double]

ATSinline()
ats_double_type
atspre_mul_double_int
  (ats_double_type d1, ats_int_type i2) { return (d1 * (double)i2) ; }
// end of [atspre_mul_double_int]

ATSinline()
ats_double_type
atspre_mul_int_double
  (ats_int_type i1, ats_double_type d2) { return ((double)i1 * d2) ; }
// end of [atspre_mul_int_double]

ATSinline()
ats_double_type
atspre_div_double_double
  (ats_double_type d1, ats_double_type d2) { return (d1 / d2) ; }
// end of [atspre_div_double_double]

ATSinline()
ats_double_type
atspre_div_double_int
  (ats_double_type d1, ats_int_type i2) { return (d1 / (double)i2) ; }
// end of [atspre_div_double_int]

ATSinline()
ats_double_type
atspre_div_int_double
  (ats_int_type i1, ats_double_type d2) { return ((double)i1 / d2) ; }
// end of [atspre_div_int_double]

ATSinline()
ats_bool_type
atspre_lt_double_double (
  ats_double_type d1, ats_double_type d2
) {
  return (d1 < d2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lt_double_double]

ATSinline()
ats_bool_type
atspre_lte_double_double (
  ats_double_type d1, ats_double_type d2
) {
  return (d1 <= d2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lte_double_double]

ATSinline()
ats_bool_type
atspre_gt_double_double
  (ats_double_type d1, ats_double_type d2) {
  return (d1 > d2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gt_double_double]

ATSinline()
ats_bool_type
atspre_gte_double_double
  (ats_double_type d1, ats_double_type d2) {
  return (d1 >= d2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gte_double_double]

ATSinline()
ats_bool_type
atspre_eq_double_double
  (ats_double_type d1, ats_double_type d2) {
  return (d1 == d2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_eq_double_double]

ATSinline()
ats_bool_type
atspre_neq_double_double
  (ats_double_type d1, ats_double_type d2) {
  return (d1 != d2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_neq_double_double]

//
// compare, max and min
//

ATSinline()
ats_int_type
atspre_compare_double_double
  (ats_double_type d1, ats_double_type d2) {
  if (d1 < d2) return (-1) ;
  else if (d1 > d2) return ( 1) ;
  else return 0 ;
} // end of [atspre_compare_double_double]

ATSinline()
ats_double_type
atspre_max_double_double
  (ats_double_type d1, ats_double_type d2) {
  return (d1 >= d2) ? d1 : d2 ;
} // end of [atspre_max_double_double]

ATSinline()
ats_double_type
atspre_min_double_double
  (ats_double_type d1, ats_double_type d2) {
  return (d1 <= d2) ? d1 : d2 ;
} // end of [atspre_min_double_double]

// square function

ATSinline()
ats_double_type
atspre_square_double (ats_double_type d) { return (d * d) ; }

// cube function

ATSinline()
ats_double_type
atspre_cube_double (ats_double_type d) { return (d * d * d) ; }

// print functions

ATSinline()
ats_void_type
atspre_fprint_double
  (ats_ptr_type out, ats_double_type f) {
  int n = fprintf ((FILE *)out, "%f", f) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_double] failed.\n") ;
  } // end of [if]
  return ;
} /* end of [atspre_fprint_double] */

ATSinline()
ats_void_type
atspre_print_double
  (ats_double_type f) {
//  atspre_stdout_view_get () ;
  atspre_fprint_double ((ats_ptr_type)stdout, f) ;
//  atspre_stdout_view_set () ;
  return ;
} // end of [atspre_print_double]

ATSinline()
ats_void_type
atspre_prerr_double
  (ats_double_type f) {
//  atspre_stderr_view_get () ;
  atspre_fprint_double ((ats_ptr_type)stderr, f) ;
//  atspre_stderr_view_set () ;
  return ;
} // end of [atspre_prerr_double]

// stringization

ATSinline()
ats_ptr_type
atspre_tostrptr_double
  (ats_double_type f) {
  return atspre_tostringf ((ats_ptr_type)"%f", f) ;
} // end of [atspre_tostrptr_double]

/* ****** ****** */

/* floating point numbers of long double precision */

/* ****** ****** */

ATSinline()
ats_int_type
atspre_int_of_ldouble (ats_ldouble_type ld) { return ld ; }

ATSinline()
ats_lint_type
atspre_lint_of_ldouble (ats_ldouble_type ld) { return ld ; }

ATSinline()
ats_llint_type
atspre_llint_of_ldouble (ats_ldouble_type ld) { return ld ; }

//

ATSinline()
ats_ldouble_type
atspre_ldouble_of_int
  (ats_int_type i) { return ((ats_ldouble_type)i) ; }
// end of [atspre_ldouble_of_int]

ATSinline()
ats_ldouble_type
atspre_ldouble_of_lint
  (ats_lint_type li) { return (ats_ldouble_type)li ; }
// end of [atspre_ldouble_of_lint]

ATSinline()
ats_ldouble_type
atspre_ldouble_of_llint
  (ats_llint_type lli) { return (ats_ldouble_type)lli ; }
// end of [atspre_ldouble_of_llint]

//

ATSinline()
ats_ldouble_type
atspre_ldouble_of_float
  (ats_float_type f) { return ((ats_ldouble_type)f) ; }
// end of [atspre_ldouble_of_float]

ATSinline()
ats_ldouble_type
atspre_ldouble_of_double
  (ats_double_type d) { return ((ats_ldouble_type)d) ; }
// end of [atspre_ldouble_of_double]

//

ATSinline()
ats_ldouble_type
atspre_abs_ldouble
  (ats_ldouble_type f) { return (f >= 0.0 ? f : -f) ; }

ATSinline()
ats_ldouble_type
atspre_neg_ldouble (ats_ldouble_type f) { return (-f) ; }

ATSinline()
ats_ldouble_type
atspre_succ_ldouble (ats_ldouble_type f) { return (f + 1.0) ; }

ATSinline()
ats_ldouble_type
atspre_pred_ldouble (ats_ldouble_type f) { return (f - 1.0) ; }

ATSinline()
ats_ldouble_type
atspre_add_ldouble_ldouble
  (ats_ldouble_type f1, ats_ldouble_type f2) {
  return (f1 + f2) ;
} // end of [atspre_add_ldouble_ldouble]

ATSinline()
ats_ldouble_type
atspre_sub_ldouble_ldouble
  (ats_ldouble_type f1, ats_ldouble_type f2) {
  return (f1 - f2) ;
} // end of [atspre_sub_ldouble_ldouble]

//

ATSinline()
ats_ldouble_type
atspre_mul_ldouble_ldouble
  (ats_ldouble_type ld1, ats_ldouble_type ld2) {
  return (ld1 * ld2) ;
} // end of [atspre_mul_ldouble_ldouble]

ATSinline()
ats_ldouble_type
atspre_mul_int_ldouble
  (ats_int_type i1, ats_ldouble_type ld2) {
  return ((long double)i1 * ld2) ;
} // end of [atspre_mul_int_ldouble]

ATSinline()
ats_ldouble_type
atspre_mul_ldouble_int
  (ats_ldouble_type ld1, ats_int_type i2) {
  return (ld1 * (long double)i2) ;
} // end of [atspre_mul_ldouble_int]


//

ATSinline()
ats_ldouble_type
atspre_div_ldouble_ldouble (
  ats_ldouble_type ld1, ats_ldouble_type ld2
) {
  return (ld1 / ld2) ;
} // end of [atspre_div_ldouble_ldouble]

ATSinline()
ats_ldouble_type
atspre_div_ldouble_int
  (ats_ldouble_type ld1, ats_int_type i2) {
  return (ld1 / (long double)i2) ;
} // end of [atspre_div_ldouble_int]

//

ATSinline()
ats_bool_type
atspre_lt_ldouble_ldouble
  (ats_ldouble_type ld1, ats_ldouble_type ld2) {
  return (ld1 == ld2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lt_ldouble_ldouble]

ATSinline()
ats_bool_type
atspre_lte_ldouble_ldouble
  (ats_ldouble_type ld1, ats_ldouble_type ld2) {
  return (ld1 <= ld2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lte_ldouble_ldouble]

ATSinline()
ats_bool_type
atspre_gt_ldouble_ldouble
  (ats_ldouble_type ld1, ats_ldouble_type ld2) {
  return (ld1 > ld2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gt_ldouble_ldouble]

ATSinline()
ats_bool_type
atspre_gte_ldouble_ldouble
  (ats_ldouble_type ld1, ats_ldouble_type ld2) {
  return (ld1 >= ld2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gte_ldouble_ldouble]

ATSinline()
ats_bool_type
atspre_eq_ldouble_ldouble (
  ats_ldouble_type ld1, ats_ldouble_type ld2
) {
  return (ld1 == ld2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_eq_ldouble_ldouble]

ATSinline()
ats_bool_type
atspre_neq_ldouble_ldouble (
  ats_ldouble_type ld1, ats_ldouble_type ld2
) {
  return (ld1 != ld2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_neq_ldouble_ldouble]

// compare, max and min

ATSinline()
ats_int_type
atspre_compare_ldouble_ldouble
  (ats_ldouble_type ld1, ats_ldouble_type ld2) {
  if (ld1 < ld2) return (-1) ;
  else if (ld1 > ld2) return ( 1) ;
  else return 0 ;
} // end of [atspre_compare_ldouble_ldouble]

ATSinline()
ats_ldouble_type
atspre_max_ldouble_ldouble
  (ats_ldouble_type ld1, ats_ldouble_type ld2) {
  return (ld1 >= ld2) ? ld1 : ld2 ;
} // end of [atspre_max_ldouble_ldouble]

ATSinline()
ats_ldouble_type
atspre_min_ldouble_ldouble
  (ats_ldouble_type ld1, ats_ldouble_type ld2) {
  return (ld1 <= ld2) ? ld1 : ld2 ;
} // end of [atspre_min_ldouble_ldouble]

// square function

ATSinline()
ats_ldouble_type
atspre_square_ldouble (ats_ldouble_type ld) { return (ld * ld) ; }

// cube function

ATSinline()
ats_ldouble_type
atspre_cube_ldouble (ats_ldouble_type ld) { return (ld * ld * ld) ; }

// print functions

ATSinline()
ats_void_type
atspre_fprint_ldouble (
  ats_ptr_type out, ats_ldouble_type f
) {
  int n = fprintf ((FILE *)out, "%Lf", f) ;
  if (n < 0) { ats_exit_errmsg
    (n, (ats_ptr_type)"exit(ATS): [fprint_ldouble] failed.\n") ;
  } // end of [if]
  return ;
} /* end of [atspre_fprint_ldouble] */

ATSinline()
ats_void_type
atspre_print_ldouble
  (ats_ldouble_type f) {
//  atspre_stdout_view_get () ;
  atspre_fprint_ldouble ((ats_ptr_type)stdout, f) ;
//  atspre_stdout_view_set () ;
  return ;
} // end of [atspre_print_ldouble]

ATSinline()
ats_void_type
atspre_prerr_ldouble
  (ats_ldouble_type f) {
//  atspre_stderr_view_get () ;
  atspre_fprint_ldouble ((ats_ptr_type)stderr, f) ;
//  atspre_stderr_view_set () ;
  return ;
} // end of [atspre_prerr_ldouble]

// stringization

ATSinline()
ats_ptr_type
atspre_tostrptr_ldouble
  (ats_ldouble_type f) {
  return atspre_tostringf ((ats_ptr_type)"%Lf", f) ;
} // end of [atspre_tostrptr_ldouble]

/* ****** ****** */

#endif /* ATS_PRELUDE_FLOAT_CATS */

/* end of [float.cats] */
