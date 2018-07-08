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

#ifndef ATS_PRELUDE_INTEGER_PTR_CATS
#define ATS_PRELUDE_INTEGER_PTR_CATS

/* ****** ****** */

extern
int fprintf (FILE *stream, const char *format, ...) ;
// in [stdio.h]

/* ****** ****** */

// intptr and uintptr

typedef ats_ptr_type ats_intptr_type ;
typedef ats_ptr_type ats_uintptr_type ;

/* ****** ****** */

extern
ats_void_type
ats_exit_errmsg(ats_int_type n, ats_ptr_type msg) ;

/* ****** ****** */
//
// intptr_t: integers of one word size
//
ATSinline()
ats_int_type
atspre_int_of_intptr
  (ats_intptr_type i) {
  return (ats_int_type)(intptr_t)i ;
} // end of [atspre_int_of_intptr]

ATSinline()
ats_lint_type
atspre_lint_of_intptr
  (ats_intptr_type i) {
  return (ats_lint_type)(intptr_t)i ;
} // end of [atspre_lint_of_intptr]

ATSinline()
ats_intptr_type
atspre_intptr_of_int
  (ats_int_type i) {
  return (ats_intptr_type)(intptr_t)i ;
} // end of [atspre_intptr_of_int]

ATSinline()
ats_intptr_type
atspre_intptr_of_lint
  (ats_lint_type i) {
  return (ats_intptr_type)(intptr_t)i ;
} // end of [atspre_intptr_of_lint]

/* ****** ****** */

ATSinline()
ats_intptr_type
atspre_abs_intptr
  (ats_intptr_type i) {
  return ((intptr_t)i >= 0 ? i : (ats_intptr_type)(-(intptr_t)i)) ;
} // end of [atspre_abs_intptr]

ATSinline()
ats_intptr_type
atspre_neg_intptr
  (ats_intptr_type i) {
  return (ats_intptr_type)(-(intptr_t)i) ;
} // end of [atspre_neg_intptr]

ATSinline()
ats_intptr_type
atspre_succ_intptr
  (ats_intptr_type i) {
  return (ats_intptr_type)((intptr_t)i + 1) ;
} // end of [atspre_succ_intptr]

ATSinline()
ats_intptr_type
atspre_pred_intptr
  (ats_intptr_type i) {
  return (ats_intptr_type)((intptr_t)i - 1) ;
} // end of [atspre_pred_intptr]

//

ATSinline()
ats_intptr_type
atspre_add_intptr_int (
  ats_intptr_type i1, ats_int_type i2
) {
  return (ats_intptr_type)((intptr_t)i1 + (int)i2) ;
} // end of [atspre_add_intptr_int]

ATSinline()
ats_intptr_type
atspre_add_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (ats_intptr_type)((intptr_t)i1 + (intptr_t)i2) ;
} // end of [atspre_add_intptr_intptr]

//

ATSinline()
ats_intptr_type
atspre_sub_intptr_int (
  ats_intptr_type i1, ats_int_type i2
) {
  return (ats_intptr_type)((intptr_t)i1 - (int)i2) ;
} // end of [atspre_sub_intptr_int]

ATSinline()
ats_intptr_type
atspre_sub_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (ats_intptr_type)((intptr_t)i1 - (intptr_t)i2) ;
} // end of [atspre_sub_intptr_intptr]

//

ATSinline()
ats_intptr_type
atspre_mul_intptr_int (
  ats_intptr_type i1, ats_int_type i2
) {
  return (ats_intptr_type)((intptr_t)i1 * (int)i2) ;
} // end of [atspre_mul_intptr_int]

ATSinline()
ats_intptr_type
atspre_mul_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (ats_intptr_type)((intptr_t)i1 * (intptr_t)i2) ;
} // end of [atspre_mul_intptr_intptr]

//

ATSinline()
ats_intptr_type
atspre_div_intptr_int (
  ats_intptr_type i1, ats_int_type i2
) {
  return (ats_intptr_type)((intptr_t)i1 / (int)i2) ;
} // end of [atspre_div_intptr_int]

ATSinline()
ats_intptr_type
atspre_div_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (ats_intptr_type)((intptr_t)i1 / (intptr_t)i2) ;
} // end of [atspre_div_intptr_intptr]

//

ATSinline()
ats_intptr_type
atspre_mod_intptr_int (
  ats_intptr_type i1, ats_int_type i2) {
  return (ats_intptr_type)((intptr_t)i1 % (int)i2) ;
} // end of [atspre_mod_intptr_int]

ATSinline()
ats_intptr_type
atspre_mod_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (ats_intptr_type)((intptr_t)i1 % (intptr_t)i2) ;
} // end of [atspre_mod_intptr_intptr]

/* ****** ****** */

// comparison operations

ATSinline()
ats_bool_type
atspre_lt_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (
    (intptr_t)i1 < (intptr_t)i2 ? ats_true_bool : ats_false_bool
  ) ; // end of [return]
} // end of [atspre_lt_intptr_intptr]

ATSinline()
ats_bool_type
atspre_lte_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (
    (intptr_t)i1 <= (intptr_t)i2 ? ats_true_bool : ats_false_bool
  ) ; // end of [return]
} // end of [atspre_lte_intptr_intptr]

ATSinline()
ats_bool_type
atspre_gt_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (
    (intptr_t)i1 > (intptr_t)i2 ? ats_true_bool : ats_false_bool
  ) ; // end of [return]
} // end of [atspre_gt_intptr_intptr]

ATSinline()
ats_bool_type
atspre_gte_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (
    (intptr_t)i1 >= (intptr_t)i2 ? ats_true_bool : ats_false_bool
  ) ; // end of [return]
} // end of [atspre_gte_intptr_intptr]

ATSinline()
ats_bool_type
atspre_eq_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (
    (intptr_t)i1 == (intptr_t)i2 ? ats_true_bool : ats_false_bool
  ) ; // end of [return]
} // end of [atspre_eq_intptr_intptr]

ATSinline()
ats_bool_type
atspre_neq_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return (
    (intptr_t)i1 != (intptr_t)i2 ? ats_true_bool : ats_false_bool
  ) ; // end of [return]
} // end of [atspre_neq_intptr_intptr]

//
// compare, max and min
//

ATSinline()
ats_int_type
atspre_compare_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  if (i1 < i2) return (-1) ;
  else if (i1 > i2) return ( 1) ;
  else return (0) ;
} // end of [atspre_compare_intptr_intptr]

ATSinline()
ats_intptr_type
atspre_max_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return ((i1 >= i2) ? i1 : i2) ;
} // end of [atspre_max_intptr_intptr]

ATSinline()
ats_intptr_type
atspre_min_intptr_intptr (
  ats_intptr_type i1, ats_intptr_type i2
) {
  return ((i1 <= i2) ? i1 : i2) ;
} // end of [atspre_min_intptr_intptr]

//
// print functions
//

ATSinline()
ats_void_type
atspre_fprint_intptr (
  ats_ptr_type out, ats_intptr_type i
) {
  int n ;
  n = fprintf ((FILE*)out, "%lli", (ats_llint_type)(intptr_t)i) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_intptr] failed.\n") ;
  }
  return ;
} // end of [atspre_fprint_intptr]

ATSinline()
ats_void_type
atspre_print_intptr (ats_intptr_type i) {
//  atspre_stdout_view_get () ;
  atspre_fprint_intptr ((ats_ptr_type)stdout, i) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_intptr (ats_intptr_type i) {
//  atspre_stderr_view_get () ;
  atspre_fprint_intptr ((ats_ptr_type)stderr, i) ;
//  atspre_stderr_view_set () ;
  return ;
}

/* ****** ****** */

//
// uintptr_t: unsigned integers of one word size
//

/* ****** ****** */

ATSinline()
ats_uint_type
atspre_uint_of_uintptr
  (ats_uintptr_type u) {
  return (ats_uint_type)(uintptr_t)u ;
} // end of [atspre_uint_of_uintptr]

ATSinline()
ats_uintptr_type
atspre_uintptr_of_int1
  (ats_int_type i) {
  return (ats_uintptr_type)(uintptr_t)i ;
} // end of [atspre_uintptr_of_int1]

ATSinline()
ats_uintptr_type
atspre_uintptr_of_uint
  (ats_uint_type u) {
  return (ats_uintptr_type)(uintptr_t)u ;
} // end of [atspre_uintptr_of_uint]

ATSinline()
ats_uintptr_type
atspre_uintptr_of_ptr
  (ats_ptr_type p) {
  return (ats_uintptr_type)(uintptr_t)p ;
} // end of [atspre_uintptr_of_ptr]

// ------ ------

ATSinline()
ats_ulint_type
atspre_ulint_of_uintptr
  (ats_uintptr_type u) {
  return (ats_ulint_type)(uintptr_t)u ;
} // end of [atspre_ulint_of_uintptr]

ATSinline()
ats_uintptr_type
atspre_uintptr_of_ulint
  (ats_ulint_type u) {
  return (ats_uintptr_type)(uintptr_t)u ;
} // end of [atspre_uintptr_of_ulint]

// ------ ------

ATSinline()
ats_uintptr_type
atspre_succ_uintptr
  (ats_uintptr_type i) {
  return (ats_uintptr_type)((uintptr_t)i + 1) ;
}

ATSinline()
ats_uintptr_type
atspre_pred_uintptr
  (ats_uintptr_type i) {
  return (ats_uintptr_type)((uintptr_t)i - 1) ;
}

//

ATSinline()
ats_uintptr_type
atspre_add_uintptr_uint
  (ats_uintptr_type i1, ats_uint_type i2) {
  return (ats_uintptr_type)((uintptr_t)i1 + i2) ;
}

ATSinline()
ats_uintptr_type
atspre_add_uintptr_uintptr
  (ats_uintptr_type i1, ats_uintptr_type i2) {
  return (ats_uintptr_type)((uintptr_t)i1 + (uintptr_t)i2) ;
}

//

ATSinline()
ats_uintptr_type
atspre_sub_uintptr_uint
  (ats_uintptr_type i1, ats_uint_type i2) {
  return (ats_uintptr_type)((uintptr_t)i1 - i2) ;
}

ATSinline()
ats_uintptr_type
atspre_sub_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return (ats_uintptr_type)((uintptr_t)i1 - (uintptr_t)i2) ;
}

//

ATSinline()
ats_uintptr_type
atspre_mul_uintptr_uint (
  ats_uintptr_type i1, ats_uint_type i2
) {
  return (ats_uintptr_type)((uintptr_t)i1 * i2) ;
}

ATSinline()
ats_uintptr_type
atspre_mul_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return (ats_uintptr_type)((uintptr_t)i1 * (uintptr_t)i2) ;
}

//

ATSinline()
ats_uintptr_type
atspre_div_uintptr_uint (
  ats_uintptr_type i1, ats_uint_type i2
) {
  return (ats_uintptr_type)((uintptr_t)i1 / i2) ;
}

ATSinline()
ats_uintptr_type
atspre_div_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return (ats_uintptr_type)((uintptr_t)i1 / (uintptr_t)i2) ;
}

//

ATSinline()
ats_uintptr_type
atspre_mod_uintptr_uint (
  ats_uintptr_type i1, ats_uint_type i2
) {
  return (ats_uintptr_type)((uintptr_t)i1 % i2) ;
}

ATSinline()
ats_uintptr_type
atspre_mod_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return (ats_uintptr_type)((uintptr_t)i1 % (uintptr_t)i2) ;
}

//
// comparison operations on uintpr
//

ATSinline()
ats_bool_type
atspre_lt_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return ((uintptr_t)i1 < (uintptr_t)i2 ? ats_true_bool : ats_false_bool) ;
}

ATSinline()
ats_bool_type
atspre_lte_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return ((uintptr_t)i1 <= (uintptr_t)i2 ? ats_true_bool : ats_false_bool) ;
}

ATSinline()
ats_bool_type
atspre_gt_uintptr_uintptr (ats_uintptr_type i1, ats_uintptr_type i2) {
  return ((uintptr_t)i1 > (uintptr_t)i2 ? ats_true_bool : ats_false_bool) ;
}

ATSinline()
ats_bool_type
atspre_gte_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return ((uintptr_t)i1 >= (uintptr_t)i2 ? ats_true_bool : ats_false_bool) ;
}

ATSinline()
ats_bool_type
atspre_eq_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return ((uintptr_t)i1 == (uintptr_t)i2 ? ats_true_bool : ats_false_bool) ;
}

ATSinline()
ats_bool_type
atspre_neq_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return ((uintptr_t)i1 != (uintptr_t)i2 ? ats_true_bool : ats_false_bool) ;
}

//
// compare, max and min
//

ATSinline()
ats_int_type
atspre_compare_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  if (i1 < i2) return (-1) ;
  else if (i1 > i2) return ( 1) ;
  else return (0) ;
} // end of [atspre_compare_uintptr_uintptr]

ATSinline()
ats_uintptr_type
atspre_max_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return (i1 >= i2 ? i1 : i2) ;
}

ATSinline()
ats_uintptr_type
atspre_min_uintptr_uintptr (
  ats_uintptr_type i1, ats_uintptr_type i2
) {
  return (i1 <= i2 ? i1 : i2) ;
}

//
// bitwise operations
//

ATSinline()
ats_uintptr_type
atspre_lnot_uintptr
  (ats_uintptr_type x) {
  return (ats_uintptr_type)(~(uintptr_t)x) ;
}

ATSinline()
ats_uintptr_type
atspre_land_uintptr_uintptr
  (ats_uintptr_type x, ats_uintptr_type y) {
  return (ats_uintptr_type)((uintptr_t)x & (uintptr_t)y) ;
}

ATSinline()
ats_uintptr_type
atspre_lor_uintptr_uintptr
  (ats_uintptr_type x, ats_uintptr_type y) {
  return (ats_uintptr_type)((uintptr_t)x | (uintptr_t)y) ;
}

ATSinline()
ats_uintptr_type
atspre_lxor_uintptr_uintptr
  (ats_uintptr_type x, ats_uintptr_type y) {
  return (ats_uintptr_type)((uintptr_t)x ^ (uintptr_t)y) ;
}

ATSinline()
ats_uintptr_type
atspre_lsl_uintptr_int1
  (ats_uintptr_type x, ats_int_type n) {
  return (ats_uintptr_type)((uintptr_t)x << n) ;
}

ATSinline()
ats_uintptr_type
atspre_lsr_uintptr_int1
  (ats_uintptr_type x, ats_int_type n) {
  return (ats_uintptr_type)((uintptr_t)x >> n) ;
}

// print functions

ATSinline()
ats_void_type
atspre_fprint_uintptr (
  ats_ptr_type out, ats_uintptr_type u
) {
  int n ;
  n = fprintf ((FILE*)out, "%llu", (ats_ullint_type)(uintptr_t)u) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_uintptr] failed.\n") ;
  } // end of [if]
  return ;
} // end of [atspre_fprint_uintptr]

ATSinline()
ats_void_type
atspre_print_uintptr
  (ats_uintptr_type u) {
//  atspre_stdout_view_get () ;
  atspre_fprint_uintptr ((ats_ptr_type)stdout, u) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_uintptr
  (ats_uintptr_type u) {
//  atspre_stderr_view_get () ;
  atspre_fprint_uintptr ((ats_ptr_type)stderr, u) ;
//  atspre_stderr_view_set () ;
  return ;
}

/* ****** ****** */

#endif /* ATS_PRELUDE_INTEGER_PTR_CATS */

/* end of [integer_ptr.cats] */
