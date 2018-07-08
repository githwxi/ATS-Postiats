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
** Copyright (C) 2002-2009 Hongwei Xi.
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

#ifndef ATS_PRELUDE_SIZETYPE_CATS
#define ATS_PRELUDE_SIZETYPE_CATS

/* ****** ****** */

#include <limits.h>

/* ****** ****** */

extern
int fprintf (FILE *stream, const char *format, ...) ;
// in [stdio.h]

/* ****** ****** */
//
// unsigned size type
//
/* ****** ****** */

extern void exit (int) ; // HX: see [stdlib.h]

/* ****** ****** */

ATSinline()
ats_size_type
atspre_size_of_int
  (ats_int_type i) {
  if (i < 0) {
    fprintf (stderr, "[atspre_size_of_int(%i)] failed\n", i) ;
    exit (1) ;
  } /* end of [if] */
  return ((ats_size_type)i) ;
} // end of [atspre_size_of_int]

#define atspre_int_of_size atspre_int1_of_size1
#define atspre_size_of_int1 atspre_size1_of_int1
#define atspre_uint_of_size atspre_uint1_of_size1
#define atspre_size_of_uint atspre_size1_of_uint1

/* ****** ****** */

#define atspre_add_size_int atspre_add_size1_int1
#define atspre_add_size_size atspre_add_size1_size1

#define atspre_sub_size_int atspre_sub_size1_int1
#define atspre_sub_size_size atspre_sub_size1_size1

#define atspre_mul_int_size atspre_mul_int1_size1
#define atspre_mul_size_int atspre_mul_size1_int1
#define atspre_mul_size_size atspre_mul_size1_size1

#define atspre_div_size_int atspre_div_size1_int1
#define atspre_div_size_size atspre_div_size1_size1

#define atspre_mod_size_int atspre_mod_size1_int1
#define atspre_mod_size_size atspre_mod_size1_size1

#define atspre_lt_size_size atspre_lt_size1_size1
#define atspre_lte_size_size atspre_lte_size1_size1

#define atspre_gt_size_int atspre_gt_size1_int1
#define atspre_gt_size_size atspre_gt_size1_size1
#define atspre_gte_size_int atspre_gte_size1_int1
#define atspre_gte_size_size atspre_gte_size1_size1

#define atspre_eq_size_int atspre_eq_size1_int1
#define atspre_eq_size_size atspre_eq_size1_size1

#define atspre_neq_size_int atspre_neq_size1_int1
#define atspre_neq_size_size atspre_neq_size1_size1

#define atspre_max_size_size atspre_max_size1_size1
#define atspre_min_size_size atspre_min_size1_size1

/* ****** ****** */

ATSinline()
ats_size_type
atspre_land_size_size (ats_size_type x, ats_size_type y) {
  return (x & y) ;
}

ATSinline()
ats_size_type
atspre_lor_size_size (ats_size_type x, ats_size_type y) {
  return (x | y) ;
}

ATSinline()
ats_size_type
atspre_lxor_size_size (ats_size_type x, ats_size_type y) {
  return (x ^ y) ;
}

/* ****** ****** */

ATSinline()
ats_size_type
atspre_lsl_size_int1 (ats_size_type sz, ats_int_type n) {
  return (sz << n) ;
}

ATSinline()
ats_size_type
atspre_lsr_size_int1 (ats_size_type sz, ats_int_type n) {
  return (sz >> n) ;
}

/* ****** ****** */

// print functions

ATSinline()
ats_void_type
atspre_fprint_size (
  ats_ptr_type out, ats_size_type sz
) {
  fprintf ((FILE*)out, "%lu", (ats_ulint_type)sz) ; return ;
} // end of [atspre_fprint_size]

ATSinline()
ats_void_type
atspre_print_size (ats_size_type sz) {
//  atspre_stdout_view_get () ;
  atspre_fprint_size ((ats_ptr_type)stdout, sz) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_size (ats_size_type sz) {
//  atspre_stderr_view_get () ;
  atspre_fprint_size ((ats_ptr_type)stderr, sz) ;
//  atspre_stderr_view_set () ;
  return ;
}

/* ****** ****** */
//
// unsigned size type (indexed)
//
/* ****** ****** */

ATSinline()
ats_int_type
atspre_int1_of_size1
  (ats_size_type sz) {
  if (INT_MAX < sz) {
    fprintf (stderr, "[atspre_int_of_size(%lu)] failed\n", (ats_ulint_type)sz) ;
    exit (1) ;
  } /* end of [if] */
  return ((ats_int_type)sz) ;
} // end of [atspre_int1_of_size1]

ATSinline()
ats_uint_type
atspre_uint1_of_size1
  (ats_size_type sz) {
  if (UINT_MAX < sz) {
    fprintf (stderr, "[atspre_uint_of_size(%lu)] failed\n", (ats_ulint_type)sz) ;
    exit (1) ;
  } /* end of [if] */
  return ((ats_uint_type)sz) ;
} // end of [atspre_uint1_of_size1]

/* ****** ****** */

ATSinline()
ats_size_type
atspre_size1_of_int1 (ats_int_type i) { return (ats_size_type)i ; }

ATSinline()
ats_size_type
atspre_size1_of_uint1 (ats_uint_type u) { return (ats_size_type)u ; }

ATSinline()
ats_size_type
atspre_size1_of_ptrdiff1 (ats_ptrdiff_type x) { return (ats_size_type)x ; }

/* ****** ****** */

ATSinline()
ats_size_type
atspre_succ_size1 (ats_size_type sz) { return (sz + 1) ; }

ATSinline()
ats_size_type
atspre_pred_size1 (ats_size_type sz) { return (sz - 1) ; }

/* ****** ****** */

ATSinline()
ats_size_type
atspre_add_size1_int1 (ats_size_type sz1, ats_int_type i2) {
  return (sz1 + i2) ;
}

ATSinline()
ats_size_type
atspre_add_size1_size1 (
  ats_size_type sz1, ats_size_type sz2
) {
  return (sz1 + sz2) ;
} // end of [atspre_add_size1_size1]

/* ****** ****** */

ATSinline()
ats_size_type
atspre_sub_size1_int1 (ats_size_type sz1, ats_int_type i2) {
  return (sz1 - i2) ;
}

ATSinline()
ats_size_type
atspre_sub_size1_size1 (
  ats_size_type sz1, ats_size_type sz2
) {
  return (sz1 - sz2) ;
} // end of [atspre_sub_size1_size1]

/* ****** ****** */

ATSinline()
ats_size_type
atspre_mul_int1_size1 (
  ats_int_type i1, ats_size_type sz2
) {
  return (i1 * sz2) ;
} // end of [atspre_mul_int1_size1]

ATSinline()
ats_size_type
atspre_mul_size1_int1 (
  ats_size_type sz1, ats_int_type i2
) {
  return (sz1 * i2) ;
} // end of [atspre_mul_size1_int1]

ATSinline()
ats_size_type
atspre_mul_size1_size1 (
  ats_size_type sz1, ats_size_type sz2
) {
  return (sz1 * sz2) ;
} // end of [atspre_mul_size1_size1]

#define atspre_mul1_size1_size1 atspre_mul_size1_size1
#define atspre_mul2_size1_size1 atspre_mul_size1_size1

/* ****** ****** */

ATSinline()
ats_size_type
atspre_div_size1_int1 (
  ats_size_type sz1, ats_int_type i2
) {
  return (sz1 / i2) ;
} // end of [atspre_div_size1_int1]

#define atspre_div2_size1_int1 atspre_div_size1_int1

ATSinline()
ats_size_type
atspre_div_size1_size1 (
  ats_size_type sz1, ats_size_type sz2
) {
  return (sz1 / sz2) ;
} // end of [atspre_div_size1_size1]

#define atspre_div2_size1_size1 atspre_div_size1_size1

/* ****** ****** */

ATSinline()
ats_int_type
atspre_mod_size1_int1
  (ats_size_type sz1, ats_int_type i2) {
  return (sz1 % i2) ;
} // end of [atspre_mod_size1_int1]

#define atspre_mod1_size1_int1 atspre_mod_size1_int1
#define atspre_mod2_size1_int1 atspre_mod_size1_int1

ATSinline()
ats_size_type
atspre_mod_size1_size1
  (ats_size_type sz1, ats_size_type sz2) {
  return (sz1 % sz2) ;
} // end of [atspre_mod_size1_size1]

#define atspre_mod1_size1_size1 atspre_mod_size1_size1
#define atspre_mod2_size1_size1 atspre_mod_size1_size1

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_lt_size1_size1
  (ats_size_type sz1, ats_size_type sz2) {
  return (sz1 < sz2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lt_size1_size1]

ATSinline()
ats_bool_type
atspre_lt_int1_size1
  (ats_int_type i1, ats_size_type sz2) {
  return ((ats_size_type)i1 < sz2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lt_int1_size1]

ATSinline()
ats_bool_type
atspre_lt_size1_int1
  (ats_size_type sz1, ats_int_type i2) {
  return (sz1 < (ats_size_type)i2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lt_size1_int1]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_lte_size1_size1
  (ats_size_type sz1, ats_size_type sz2) {
  return (sz1 <= sz2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lte_size1_size1]

ATSinline()
ats_bool_type
atspre_lte_int1_size1
  (ats_int_type i1, ats_size_type sz2) {
  return ((ats_size_type)i1 <= sz2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lte_int1_size1]

ATSinline()
ats_bool_type
atspre_lte_size1_int1
  (ats_size_type sz1, ats_int_type i2) {
  return (sz1 <= (ats_size_type)i2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lte_size1_int1]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_gt_size1_size1
  (ats_size_type sz1, ats_size_type sz2) {
  return (sz1 > sz2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gt_size1_size1]

ATSinline()
ats_bool_type
atspre_gt_size1_int1
  (ats_size_type sz1, ats_int_type i2) {
  return (sz1 > (ats_size_type)i2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gt_size1_int1]

ATSinline()
ats_bool_type
atspre_gte_size1_size1
  (ats_size_type sz1, ats_size_type sz2) {
  return (sz1 >= sz2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gte_size1_size1]

ATSinline()
ats_bool_type
atspre_gte_size1_int1
  (ats_size_type sz1, ats_int_type i2) {
  return (sz1 >= (ats_size_type)i2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gte_size1_int1]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_eq_size1_size1
  (ats_size_type sz1, ats_size_type sz2) {
  return (sz1 == sz2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_eq_size1_size1]

ATSinline()
ats_bool_type
atspre_eq_size1_int1
  (ats_size_type sz1, ats_int_type i2) {
  return (sz1 == (ats_size_type)i2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_eq_size1_int1]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_neq_size1_size1
  (ats_size_type sz1, ats_size_type sz2) {
  return (sz1 != sz2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_neq_size1_size1]

ATSinline()
ats_bool_type
atspre_neq_size1_int1
  (ats_size_type sz1, ats_int_type i2) {
  return (sz1 != (ats_size_type)i2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_neq_size1_int1]

/* ****** ****** */

ATSinline()
ats_size_type
atspre_max_size1_size1
  (ats_size_type sz1, ats_size_type sz2) {
  return (sz1 >= sz2 ? sz1 : sz2) ;
} // end of [atspre_max_size1_size1]

ATSinline()
ats_size_type
atspre_min_size1_size1
  (ats_size_type sz1, ats_size_type sz2) {
  return (sz1 <= sz2 ? sz1 : sz2) ;
} // end of [atspre_min_size1_size1]

/* ****** ****** */
//
// signed size type
//
/* ****** ****** */

#define atspre_int_of_ssize atspre_int1_of_ssize1
#define atspre_ssize_of_int atspre_ssize1_of_int1

#define atspre_add_ssize_ssize atspre_add_ssize1_ssize1
#define atspre_sub_ssize_ssize atspre_sub_ssize1_ssize1
#define atspre_mul_ssize_ssize atspre_mul_ssize1_ssize1
#define atspre_div_ssize_ssize atspre_div_ssize1_ssize1

/* ****** ****** */
//
// signed size type (indexed)
//
/* ****** ****** */

ATSinline()
ats_int_type
atspre_int1_of_ssize1
  (ats_ssize_type ssz) {
  if (INT_MAX < ssz || ssz < INT_MIN) {
    fprintf (stderr,
      "exit(ATS): [atspre_int1_of_ssize1(%li)] failed\n", (ats_lint_type)ssz
    ) ; exit (1) ;
  } /* end of [if] */
  return (ats_int_type)ssz ;
} // end of [atspre_int1_of_ssize1]

ATSinline()
ats_ssize_type
atspre_ssize1_of_int1
  (ats_int_type i) { return (ats_ssize_type)i ; }
// end of [atspre_ssize1_of_int1]

/* ****** ****** */

ATSinline()
ats_ssize_type
atspre_add_ssize1_ssize1 (
  ats_ssize_type i, ats_ssize_type j
) {
  return (i + j) ;
} // end of [atspre_add_ssize1_ssize1]

ATSinline()
ats_ssize_type
atspre_sub_ssize1_ssize1 (
  ats_ssize_type i, ats_ssize_type j
) {
  return (i - j) ;
} // end of [atspre_sub_ssize1_ssize1]

ATSinline()
ats_ssize_type
atspre_mul_ssize1_ssize1 (
  ats_ssize_type i, ats_ssize_type j
) {
  return (i * j) ;
} // end of [atspre_mul_ssize1_ssize1]

ATSinline()
ats_ssize_type
atspre_div_ssize1_ssize1 (
  ats_ssize_type i, ats_ssize_type j
) {
  return (i / j) ;
} // end of [atspre_div_ssize1_ssize1]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_lt_ssize1_int1
  (ats_ssize_type ssz1, ats_int_type i2) {
  return (ssz1 < i2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lt_ssize1_int1]

ATSinline()
ats_bool_type
atspre_lte_ssize1_int1
  (ats_ssize_type ssz1, ats_int_type i2) {
  return (ssz1 <= i2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_lte_ssize1_int1]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_gt_ssize1_int1
  (ats_ssize_type ssz1, ats_int_type i2) {
  return (ssz1 > i2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gt_ssize1_int1]

ATSinline()
ats_bool_type
atspre_gte_ssize1_int1
  (ats_ssize_type ssz1, ats_int_type i2) {
  return (ssz1 >= i2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_gte_ssize1_int1]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_eq_ssize1_ssize1
  (ats_ssize_type ssz1, ats_ssize_type ssz2) {
  return (ssz1 == ssz2 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_eq_ssize1_ssize1]

ATSinline()
ats_bool_type
atspre_neq_ssize1_ssize1
  (ats_ssize_type ssz1, ats_ssize_type ssz2) {
  return (ssz1 != ssz2 ? ats_true_bool : ats_false_bool) ;
} /* end of [atspre_eq_ssize1_ssize1] */

/* ****** ****** */

// print functions

ATSinline()
ats_void_type
atspre_fprint_ssize (
  ats_ptr_type out, ats_ssize_type ssz
) {
  fprintf ((FILE*)out, "%li", (ats_lint_type)ssz) ; return ;
} // end of [atspre_fprint_ssize]

ATSinline()
ats_void_type
atspre_print_ssize
  (ats_ssize_type ssz) {
//  atspre_stdout_view_get () ;
  atspre_fprint_ssize ((ats_ptr_type)stdout, ssz) ;
//  atspre_stdout_view_set () ;
  return ;
} // end of [atspre_print_ssize]

ATSinline()
ats_void_type
atspre_prerr_ssize
  (ats_size_type ssz) {
//  atspre_stderr_view_get () ;
  atspre_fprint_ssize ((ats_ptr_type)stderr, ssz) ;
//  atspre_stderr_view_set () ;
  return ;
} // end of [atspre_prerr_ssize]

/* ****** ****** */

#endif /* ATS_PRELUDE_SIZETYPE_CATS */

/* end of [sizetype.cats] */
