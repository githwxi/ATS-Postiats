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

#ifndef ATS_PRELUDE_INTEGER_FIXED_CATS
#define ATS_PRELUDE_INTEGER_FIXED_CATS

/* ****** ****** */

extern
int fprintf (FILE *stream, const char *format, ...) ;
// in [stdio.h]

/* ****** ****** */

extern
ats_void_type
ats_exit_errmsg (ats_int_type n, ats_ptr_type msg) ;

/* ****** ****** */

/* signed and unsigned integers of fixed sizes */

/* ****** ****** */

// signed integer of size 8bit

ATSinline()
ats_int8_type
atspre_int8_of_int (ats_int_type i) {
  return i ;
}

ATSinline()
ats_int_type
atspre_int_of_int8 (ats_int8_type i) {
  return i ;
}

// ------ ------

ATSinline()
ats_int8_type
atspre_abs_int8 (ats_int8_type i) {
  return (i >= 0 ? i : -i) ;
}

ATSinline()
ats_int8_type
atspre_neg_int8 (ats_int8_type i) {
  return (-i) ;
}

ATSinline()
ats_int8_type
atspre_succ_int8 (ats_int8_type i) {
  return (i + 1) ;
}

ATSinline()
ats_int8_type
atspre_pred_int8 (ats_int8_type i) {
  return (i - 1) ;
}

ATSinline()
ats_int8_type
atspre_add_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 + i2) ;
}

ATSinline()
ats_int8_type
atspre_sub_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 - i2) ;
}

ATSinline()
ats_int8_type
atspre_mul_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 * i2) ;
}

ATSinline()
ats_int8_type
atspre_div_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 / i2) ;
}

ATSinline()
ats_int8_type
atspre_mod_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 % i2) ;
}

ATSinline()
ats_bool_type
atspre_lt_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 < i2) ;
}

ATSinline()
ats_bool_type
atspre_lte_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 <= i2) ;
}

ATSinline()
ats_bool_type
atspre_gt_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 > i2) ;
}

ATSinline()
ats_bool_type
atspre_gte_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 >= i2) ;
}

ATSinline()
ats_bool_type
atspre_eq_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 == i2) ;
}

ATSinline()
ats_bool_type
atspre_neq_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 != i2) ;
}

// compare, max, min

ATSinline()
ats_int_type
atspre_compare_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  if (i1 < i2) return (-1) ;
  else if (i1 > i2) return ( 1) ;
  else return (0) ;
}

ATSinline()
ats_int8_type
atspre_max_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 >= i2) ? i1 : i2 ;
}

ATSinline()
ats_int8_type
atspre_min_int8_int8 (ats_int8_type i1, ats_int8_type i2) {
  return (i1 <= i2) ? i1 : i2 ;
}

// print functions

ATSinline()
ats_void_type
atspre_fprint_int8 (ats_ptr_type out, ats_int8_type i) {
  int n = fprintf ((FILE*)out, "%hhd", i) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_int8] failed.\n") ;
  }
  return ;
}

ATSinline()
ats_void_type
atspre_print_int8 (ats_int8_type i) {
//  atspre_stdout_view_get () ;
  atspre_fprint_int8 ((ats_ptr_type)stdout, i) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_int8 (ats_int8_type i) {
  atspre_stderr_view_get () ;
  atspre_fprint_int8 ((ats_ptr_type)stderr, i) ;
  atspre_stderr_view_set () ;
  return ;
}

/* ****** ****** */

// unsigned integer of size 8bit

ATSinline()
ats_uint8_type
atspre_uint8_of_uint (ats_uint_type i) {
  return i ;
}

ATSinline()
ats_uint_type
atspre_uint_of_uint8 (ats_uint8_type i) {
  return i ;
}

// ------ ------

ATSinline()
ats_uint8_type
atspre_succ_uint8 (ats_uint8_type i) {
  return (i + 1) ;
}

ATSinline()
ats_uint8_type
atspre_pred_uint8 (ats_uint8_type i) {
  return (i - 1) ;
}

ATSinline()
ats_uint8_type
atspre_add_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 + i2) ;
}

ATSinline()
ats_uint8_type
atspre_sub_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 - i2) ;
}

ATSinline()
ats_uint8_type
atspre_mul_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 * i2) ;
}

ATSinline()
ats_uint8_type
atspre_div_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 / i2) ;
}

ATSinline()
ats_uint8_type
atspre_mod_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 % i2) ;
}

// ------ ------

// comparison operations

ATSinline()
ats_bool_type
atspre_lt_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 < i2) ;
}

ATSinline()
ats_bool_type
atspre_lte_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 <= i2) ;
}

ATSinline()
ats_bool_type
atspre_gt_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 > i2) ;
}

ATSinline()
ats_bool_type
atspre_gte_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 >= i2) ;
}

ATSinline()
ats_bool_type
atspre_eq_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 == i2) ;
}

ATSinline()
ats_bool_type
atspre_neq_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 != i2) ;
}

// compare, max, min

ATSinline()
ats_int_type
atspre_compare_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  if (i1 < i2) return (-1) ;
  else if (i1 > i2) return ( 1) ;
  else return (0) ;
}

ATSinline()
ats_uint8_type
atspre_max_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 >= i2) ? i1 : i2 ;
}

ATSinline()
ats_uint8_type
atspre_min_uint8_uint8 (ats_uint8_type i1, ats_uint8_type i2) {
  return (i1 <= i2) ? i1 : i2 ;
}

// print functions

ATSinline()
ats_void_type
atspre_fprint_uint8 (ats_ptr_type out, ats_uint8_type i) {
  int n = fprintf ((FILE*)out, "%hhu", i) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_uint8] failed.\n") ;
  }
  return ;
}

ATSinline()
ats_void_type
atspre_print_uint8 (ats_uint8_type i) {
//  atspre_stdout_view_get () ;
  atspre_fprint_uint8 ((ats_ptr_type)stdout, i) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_uint8 (ats_uint8_type i) {
  atspre_stderr_view_get () ;
  atspre_fprint_uint8 ((ats_ptr_type)stderr, i) ;
  atspre_stderr_view_set () ;
  return ;
}

/* ****** ****** */

// signed integer of size 16bit

ATSinline()
ats_int16_type
atspre_int16_of_int (ats_int_type i) {
  return i ;
}

ATSinline()
ats_int_type
atspre_int_of_int16 (ats_int16_type i) {
  return i ;
}

// ------ ------

ATSinline()
ats_int16_type
atspre_abs_int16 (ats_int16_type i) {
  return (i >= 0 ? i : -i) ;
}

ATSinline()
ats_int16_type
atspre_neg_int16 (ats_int16_type i) {
  return (-i) ;
}

ATSinline()
ats_int16_type
atspre_succ_int16 (ats_int16_type i) {
  return (i + 1) ;
}

ATSinline()
ats_int16_type
atspre_pred_int16 (ats_int16_type i) {
  return (i - 1) ;
}

ATSinline()
ats_int16_type
atspre_add_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 + i2) ;
}

ATSinline()
ats_int16_type
atspre_sub_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 - i2) ;
}

ATSinline()
ats_int16_type
atspre_mul_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 * i2) ;
}

ATSinline()
ats_int16_type
atspre_div_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 / i2) ;
}

ATSinline()
ats_int16_type
atspre_mod_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 % i2) ;
}

ATSinline()
ats_bool_type
atspre_lt_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 < i2) ;
}

ATSinline()
ats_bool_type
atspre_lte_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 <= i2) ;
}

ATSinline()
ats_bool_type
atspre_gt_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 > i2) ;
}

ATSinline()
ats_bool_type
atspre_gte_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 >= i2) ;
}

ATSinline()
ats_bool_type
atspre_eq_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 == i2) ;
}

ATSinline()
ats_bool_type
atspre_neq_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 != i2) ;
}

// compare, max, min

ATSinline()
ats_int_type
atspre_compare_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  if (i1 < i2) return (-1) ;
  else if (i1 > i2) return ( 1) ;
  else return (0) ;
}

ATSinline()
ats_int16_type
atspre_max_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 >= i2) ? i1 : i2 ;
}

ATSinline()
ats_int16_type
atspre_min_int16_int16 (ats_int16_type i1, ats_int16_type i2) {
  return (i1 <= i2) ? i1 : i2 ;
}

// print functions

ATSinline()
ats_void_type
atspre_fprint_int16 (ats_ptr_type out, ats_int16_type i) {
  int n = fprintf ((FILE*)out, "%d", i) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_int16] failed.\n") ;
  }
  return ;
}

ATSinline()
ats_void_type
atspre_print_int16 (ats_int16_type i) {
//  atspre_stdout_view_get () ;
  atspre_fprint_int16 ((ats_ptr_type)stdout, i) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_int16 (ats_int16_type i) {
  atspre_stderr_view_get () ;
  atspre_fprint_int16 ((ats_ptr_type)stderr, i) ;
  atspre_stderr_view_set () ;
  return ;
}

/* ****** ****** */

//
// unsigned integer of size 16bit
//

ATSinline()
ats_uint16_type
atspre_uint16_of_int (ats_int_type i) { return i ; }
ATSinline()
ats_int_type
atspre_int_of_uint16 (ats_uint16_type i) { return i ; }

ATSinline()
ats_uint16_type
atspre_uint16_of_uint (ats_uint_type i) { return i ; }
ATSinline()
ats_uint_type
atspre_uint_of_uint16 (ats_uint16_type i) { return i ; }

// ------ ------

ATSinline()
ats_uint16_type
atspre_succ_uint16 (ats_uint16_type i) {
  return (i + 1) ;
}

ATSinline()
ats_uint16_type
atspre_pred_uint16 (ats_uint16_type i) {
  return (i - 1) ;
}

ATSinline()
ats_uint16_type
atspre_add_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 + i2) ;
}

ATSinline()
ats_uint16_type
atspre_sub_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 - i2) ;
}

ATSinline()
ats_uint16_type
atspre_mul_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 * i2) ;
}

ATSinline()
ats_uint16_type
atspre_div_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 / i2) ;
}

ATSinline()
ats_uint16_type
atspre_mod_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 % i2) ;
}

// ------ ------

// comparison operations

ATSinline()
ats_bool_type
atspre_lt_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 < i2) ;
}

ATSinline()
ats_bool_type
atspre_lte_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 <= i2) ;
}

ATSinline()
ats_bool_type
atspre_gt_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 > i2) ;
}

ATSinline()
ats_bool_type
atspre_gte_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 >= i2) ;
}

ATSinline()
ats_bool_type
atspre_eq_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 == i2) ;
}

ATSinline()
ats_bool_type
atspre_neq_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 != i2) ;
}

// compare, max, min

ATSinline()
ats_int_type
atspre_compare_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  if (i1 < i2) return (-1) ;
  else if (i1 > i2) return ( 1) ;
  else return (0) ;
}

ATSinline()
ats_uint16_type
atspre_max_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 >= i2) ? i1 : i2 ;
}

ATSinline()
ats_uint16_type
atspre_min_uint16_uint16 (ats_uint16_type i1, ats_uint16_type i2) {
  return (i1 <= i2) ? i1 : i2 ;
}

//
// print functions
//

ATSinline()
ats_void_type
atspre_fprint_uint16 (ats_ptr_type out, ats_uint16_type i) {
  int n = fprintf ((FILE*)out, "%hu", i) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_uint16] failed.\n") ;
  }
  return ;
}

ATSinline()
ats_void_type
atspre_print_uint16 (ats_uint16_type i) {
//  atspre_stdout_view_get () ;
  atspre_fprint_uint16 ((ats_ptr_type)stdout, i) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_uint16 (ats_uint16_type i) {
  atspre_stderr_view_get () ;
  atspre_fprint_uint16 ((ats_ptr_type)stderr, i) ;
  atspre_stderr_view_set () ;
  return ;
}

/* ****** ****** */

// signed integer of size 32bit

ATSinline()
ats_int32_type
atspre_int32_of_int (ats_int_type i) {
  return i ;
}

ATSinline()
ats_int_type
atspre_int_of_int32 (ats_int32_type i) {
  return i ;
}

// ------ ------

ATSinline()
ats_int32_type
atspre_abs_int32 (ats_int32_type i) {
  return (i >= 0 ? i : -i) ;
}

ATSinline()
ats_int32_type
atspre_neg_int32 (ats_int32_type i) {
  return (-i) ;
}

ATSinline()
ats_int32_type
atspre_succ_int32 (ats_int32_type i) {
  return (i + 1) ;
}

ATSinline()
ats_int32_type
atspre_pred_int32 (ats_int32_type i) {
  return (i - 1) ;
}

ATSinline()
ats_int32_type
atspre_add_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 + i2) ;
}

ATSinline()
ats_int32_type
atspre_sub_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 - i2) ;
}

ATSinline()
ats_int32_type
atspre_mul_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 * i2) ;
}

ATSinline()
ats_int32_type
atspre_div_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 / i2) ;
}

ATSinline()
ats_int32_type
atspre_mod_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 % i2) ;
}

ATSinline()
ats_bool_type
atspre_lt_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 < i2) ;
}

ATSinline()
ats_bool_type
atspre_lte_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 <= i2) ;
}

ATSinline()
ats_bool_type
atspre_gt_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 > i2) ;
}

ATSinline()
ats_bool_type
atspre_gte_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 >= i2) ;
}

ATSinline()
ats_bool_type
atspre_eq_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 == i2) ;
}

ATSinline()
ats_bool_type
atspre_neq_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 != i2) ;
}

// compare, max, int

ATSinline()
ats_int_type
atspre_compare_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  if (i1 < i2) return (-1) ;
  else if (i1 > i2) return ( 1) ;
  else return (0) ;
}

ATSinline()
ats_int32_type
atspre_max_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 >= i2) ? i1 : i2 ;
}

ATSinline()
ats_int32_type
atspre_min_int32_int32 (ats_int32_type i1, ats_int32_type i2) {
  return (i1 <= i2) ? i1 : i2 ;
}

// print functions

ATSinline()
ats_void_type
atspre_fprint_int32 (ats_ptr_type out, ats_int32_type i) {
  int n ;
  n = fprintf ((FILE*)out, "%li", (ats_lint_type)i) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_int32] failed.\n") ;
  }
  return ;
}

ATSinline()
ats_void_type
atspre_print_int32 (ats_int32_type i) {
//  atspre_stdout_view_get () ;
  atspre_fprint_int32 ((ats_ptr_type)stdout, i) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_int32 (ats_int32_type i) {
  atspre_stderr_view_get () ;
  atspre_fprint_int32 ((ats_ptr_type)stderr, i) ;
  atspre_stderr_view_set () ;
  return ;
}

ATSinline()
ats_ptr_type
atspre_tostrptr_int32
  (ats_int32_type i) { return atspre_tostrptr_llint (i) ; }
// end of [atspre_tostrptr_int32]

/* ****** ****** */

//
// unsigned integer of size 32bit
//

ATSinline()
ats_uint32_type
atspre_uint32_of_int (ats_int_type i) { return i ; }
ATSinline()
ats_int_type
atspre_int_of_uint32 (ats_uint32_type i) { return i ; }

ATSinline()
ats_uint32_type
atspre_uint32_of_uint (ats_uint_type i) { return i ; }
ATSinline()
ats_uint_type
atspre_uint_of_uint32 (ats_uint32_type i) { return i ; }

// ------ ------

ATSinline()
ats_uint32_type
atspre_succ_uint32 (ats_uint32_type i) {
  return (i + 1) ;
}

ATSinline()
ats_uint32_type
atspre_pred_uint32 (ats_uint32_type i) {
  return (i - 1) ;
}

ATSinline()
ats_uint32_type
atspre_add_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 + i2) ;
}

ATSinline()
ats_uint32_type
atspre_sub_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 - i2) ;
}

ATSinline()
ats_uint32_type
atspre_mul_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 * i2) ;
}

ATSinline()
ats_uint32_type
atspre_div_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 / i2) ;
}

ATSinline()
ats_uint32_type
atspre_mod_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 % i2) ;
}

// ------ ------

// comparison operations

ATSinline()
ats_bool_type
atspre_lt_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 < i2) ;
}

ATSinline()
ats_bool_type
atspre_lte_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 <= i2) ;
}

ATSinline()
ats_bool_type
atspre_gt_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 > i2) ;
}

ATSinline()
ats_bool_type
atspre_gte_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 >= i2) ;
}

ATSinline()
ats_bool_type
atspre_eq_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 == i2) ;
}

ATSinline()
ats_bool_type
atspre_neq_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 != i2) ;
}

// compare, max, min

ATSinline()
ats_int_type
atspre_compare_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  if (i1 < i2) return (-1) ;
  else if (i1 > i2) return ( 1) ;
  else return (0) ;
}

ATSinline()
ats_uint32_type
atspre_max_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 >= i2) ? i1 : i2 ;
}

ATSinline()
ats_uint32_type
atspre_min_uint32_uint32 (ats_uint32_type i1, ats_uint32_type i2) {
  return (i1 <= i2) ? i1 : i2 ;
}

// print functions

ATSinline()
ats_void_type
atspre_fprint_uint32 (ats_ptr_type out, ats_uint32_type i) {
  int n = fprintf ((FILE*)out, "%lu", (ats_ulint_type)i) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_uint32] failed.\n") ;
  }
  return ;
}

ATSinline()
ats_void_type
atspre_print_uint32 (ats_uint32_type i) {
//  atspre_stdout_view_get () ;
  atspre_fprint_uint32 ((ats_ptr_type)stdout, i) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_uint32 (ats_uint32_type i) {
  atspre_stderr_view_get () ;
  atspre_fprint_uint32 ((ats_ptr_type)stderr, i) ;
  atspre_stderr_view_set () ;
  return ;
}

/* ****** ****** */

// signed integer of size 64bit

ATSinline()
ats_int64_type
atspre_int64_of_int (ats_int_type i) { return (i) ; }
ATSinline()
ats_int64_type
atspre_int64_of_lint (ats_lint_type i) { return (i) ; }
ATSinline()
ats_int64_type
atspre_int64_of_llint (ats_llint_type i) { return (i) ; }

ATSinline()
ats_int_type
atspre_int_of_int64 (ats_int64_type i) { return i ; }

// ------ ------

ATSinline()
ats_int64_type
atspre_abs_int64 (ats_int64_type i) {
  return (i >= 0 ? i : -i) ;
}

ATSinline()
ats_int64_type
atspre_neg_int64 (ats_int64_type i) {
  return (-i) ;
}

ATSinline()
ats_int64_type
atspre_succ_int64 (ats_int64_type i) { return (i + 1) ; }

ATSinline()
ats_int64_type
atspre_pred_int64 (ats_int64_type i) { return (i - 1) ; }

ATSinline()
ats_int64_type
atspre_add_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 + i2) ;
}

ATSinline()
ats_int64_type
atspre_sub_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 - i2) ;
}

ATSinline()
ats_int64_type
atspre_mul_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 * i2) ;
}

ATSinline()
ats_int64_type
atspre_div_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 / i2) ;
}

ATSinline()
ats_int64_type
atspre_mod_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 % i2) ;
}

ATSinline()
ats_bool_type
atspre_lt_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 < i2) ;
}

ATSinline()
ats_bool_type
atspre_lte_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 <= i2) ;
}

ATSinline()
ats_bool_type
atspre_gt_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 > i2) ;
}

ATSinline()
ats_bool_type
atspre_gte_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 >= i2) ;
}

ATSinline()
ats_bool_type
atspre_eq_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 == i2) ;
}

ATSinline()
ats_bool_type
atspre_neq_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 != i2) ;
}

// compare, max, min

ATSinline()
ats_int_type
atspre_compare_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  if (i1 < i2) return (-1) ;
  else if (i1 > i2) return ( 1) ;
  else return (0) ;
}

ATSinline()
ats_int64_type
atspre_max_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 >= i2) ? i1 : i2 ;
}

ATSinline()
ats_int64_type
atspre_min_int64_int64 (ats_int64_type i1, ats_int64_type i2) {
  return (i1 <= i2) ? i1 : i2 ;
}

// print functions

ATSinline()
ats_void_type
atspre_fprint_int64 (ats_ptr_type out, ats_int64_type i) {
  int n ;
  n = fprintf ((FILE*)out, "%lli", (ats_llint_type)i) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_int64] failed.\n") ;
  }
  return ;
}

ATSinline()
ats_void_type
atspre_print_int64 (ats_int64_type i) {
//  atspre_stdout_view_get () ;
  atspre_fprint_int64 ((ats_ptr_type)stdout, i) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_int64 (ats_int64_type i) {
  atspre_stderr_view_get () ;
  atspre_fprint_int64 ((ats_ptr_type)stderr, i) ;
  atspre_stderr_view_set () ;
  return ;
}

ATSinline()
ats_ptr_type
atspre_tostrptr_int64
  (ats_int64_type i) { return atspre_tostrptr_llint (i) ; }
// end of [atspre_tostrptr_int64]

/* ****** ****** */

// unsigned integer of size 64bit

ATSinline()
ats_uint64_type
atspre_uint64_of_int1 (ats_int_type i) { return i ; }
ATSinline()
ats_uint64_type
atspre_uint64_of_uint (ats_uint_type i) { return i ; }
ATSinline()
ats_uint64_type
atspre_uint64_of_ulint (ats_ulint_type i) { return i ; }
ATSinline()
ats_uint64_type
atspre_uint64_of_ullint (ats_ullint_type i) { return i ; }

ATSinline()
ats_uint_type
atspre_uint_of_uint64 (ats_uint64_type i) { return i ; }

/* ****** ****** */

ATSinline()
ats_uint64_type
atspre_succ_uint64 (ats_uint64_type i) { return (i + 1) ; }

ATSinline()
ats_uint64_type
atspre_pred_uint64 (ats_uint64_type i) { return (i - 1) ; }

/* ****** ****** */

ATSinline()
ats_uint64_type
atspre_add_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 + i2) ;
}

ATSinline()
ats_uint64_type
atspre_sub_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 - i2) ;
}

ATSinline()
ats_uint64_type
atspre_mul_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 * i2) ;
}

ATSinline()
ats_uint64_type
atspre_div_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 / i2) ;
}

ATSinline()
ats_uint64_type
atspre_mod_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 % i2) ;
}

/* ****** ****** */

// comparison operations

ATSinline()
ats_bool_type
atspre_lt_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 < i2) ;
}

ATSinline()
ats_bool_type
atspre_lte_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 <= i2) ;
}

ATSinline()
ats_bool_type
atspre_gt_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 > i2) ;
}

ATSinline()
ats_bool_type
atspre_gte_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 >= i2) ;
}

ATSinline()
ats_bool_type
atspre_eq_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 == i2) ;
}

ATSinline()
ats_bool_type
atspre_neq_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 != i2) ;
}

// compare, max, min

ATSinline()
ats_int_type
atspre_compare_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  if (i1 < i2) return (-1) ;
  else if (i1 > i2) return ( 1) ;
  else return (0) ;
}

ATSinline()
ats_uint64_type
atspre_max_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 >= i2) ? i1 : i2 ;
}

ATSinline()
ats_uint64_type
atspre_min_uint64_uint64 (ats_uint64_type i1, ats_uint64_type i2) {
  return (i1 <= i2) ? i1 : i2 ;
}

// print functions

ATSinline()
ats_void_type
atspre_fprint_uint64 (ats_ptr_type out, ats_uint64_type u) {
  int n = fprintf ((FILE*)out, "%llu", (ats_ullint_type)u) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_uint64] failed.\n") ;
  }
  return ;
}

ATSinline()
ats_void_type
atspre_print_uint64 (ats_uint64_type i) {
//  atspre_stdout_view_get () ;
  atspre_fprint_uint64 ((ats_ptr_type)stdout, i) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_uint64 (ats_uint64_type i) {
  atspre_stderr_view_get () ;
  atspre_fprint_uint64 ((ats_ptr_type)stderr, i) ;
  atspre_stderr_view_set () ;
  return ;
}

/* ****** ****** */

#endif /* ATS_PRELUDE_INTEGER_FIXED_CATS */

/* end of [integer_fixed.cats] */
