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

#ifndef ATS_PRELUDE_BOOL_CATS
#define ATS_PRELUDE_BOOL_CATS

/* ****** ****** */

extern
int fprintf (FILE *stream, const char *format, ...) ;
// in [stdio.h]

/* ****** ****** */

extern
ats_void_type
ats_exit_errmsg(ats_int_type n, ats_ptr_type msg) ;

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_neg_bool
  (ats_bool_type b) {
  return (b ? ats_false_bool : ats_true_bool) ;
} // end of [atspre_neg_bool]

/* ****** ****** */

#if(0)
ATSinline()
ats_bool_type
atspre_add_bool_bool (
  ats_bool_type b1, ats_bool_type b2
) {
  if (b1) { return ats_true_bool ; } else { return b2 ; }
} // end of [atspre_add_bool_bool]

ATSinline()
ats_bool_type
atspre_mul_bool_bool (
  ats_bool_type b1, ats_bool_type b2
) {
  if (b1) { return b2 ; } else { return ats_false_bool ; }
} // end of [atspre_mul_bool_bool]
#endif
#define atspre_add_bool_bool(b1, b2) ((b1) || (b2))
#define atspre_mul_bool_bool(b1, b2) ((b1) && (b2))

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_lt_bool_bool (
  ats_bool_type b1, ats_bool_type b2
) {
  return (!b1 && b2) ;
} // end of [atspre_lt_bool_bool]

ATSinline()
ats_bool_type
atspre_lte_bool_bool (
  ats_bool_type b1, ats_bool_type b2
) {
  return (!b1 || b2) ;
} // end of [atspre_lte_bool_bool]

ATSinline()
ats_bool_type
atspre_gt_bool_bool (
  ats_bool_type b1, ats_bool_type b2
) {
  return (b1 && !b2) ;
} // end of [atspre_gt_bool_bool]

ATSinline()
ats_bool_type
atspre_gte_bool_bool (
  ats_bool_type b1, ats_bool_type b2
) {
  return (b1 || !b2) ;
} // end of [atspre_gte_bool_bool]

ATSinline()
ats_bool_type
atspre_eq_bool_bool (
  ats_bool_type b1, ats_bool_type b2
) {
  if (b1) { return b2 ; } else { return !b2 ; }
} // end of [atspre_eq_bool_bool]

ATSinline()
ats_bool_type
atspre_neq_bool_bool
  (ats_bool_type b1, ats_bool_type b2) {
  if (b1) { return !b2 ; } else { return b2 ; }
} // end of [atspre_neq_bool_bool]

/* ****** ****** */
//
// HX: print functions
//
ATSinline()
ats_void_type
atspre_fprint_bool (
  ats_ptr_type out, ats_bool_type b
) {
  int n ;
  if (b) {
    n = fprintf ((FILE *)out, "true") ;
  } else {
    n = fprintf ((FILE *)out, "false") ;
  } // end of [if]
  if (n < 0) {
    ats_exit_errmsg(n, (ats_ptr_type)"Exit: [fprint_bool] failed.\n") ;
  } // end of [if]
  return ;
} // end of [atspre_fprint_bool]

ATSinline()
ats_void_type
atspre_print_bool
  (ats_bool_type b) {
//  atspre_stdout_view_get() ;
  atspre_fprint_bool ((ats_ptr_type)stdout, b) ;
//  atspre_stdout_view_set() ;
  return ;
} // end of [atspre_print_bool]

ATSinline()
ats_void_type
atspre_prerr_bool
  (ats_bool_type b) {
//  atspre_stderr_view_get() ;
  atspre_fprint_bool ((ats_ptr_type)stderr, b) ;
//  atspre_stderr_view_set() ;
  return ;
} // end of [atspre_prerr_bool]

//
// HX: stringization
//
ATSinline()
ats_ptr_type
atspre_tostring_bool
  (ats_bool_type b) {
  return (b ? (ats_ptr_type)"true" : (ats_ptr_type)"false") ;
} // end of [atspre_tostring_bool]

/* ****** ****** */

#define atspre_neg_bool1 atspre_neg_bool
#define atspre_add_bool1_bool1 atspre_add_bool_bool
#define atspre_mul_bool1_bool1 atspre_mul_bool_bool

#define atspre_lt_bool1_bool1 atspre_lt_bool_bool
#define atspre_lte_bool1_bool1 atspre_lte_bool_bool
#define atspre_gt_bool1_bool1 atspre_gt_bool_bool
#define atspre_gte_bool1_bool1 atspre_gte_bool_bool
#define atspre_eq_bool1_bool1 atspre_eq_bool_bool
#define atspre_neq_bool1_bool1 atspre_neq_bool_bool

#define atspre_compare_bool1_bool1 atspre_compare_bool_bool

/* ****** ****** */

#endif /* ATS_PRELUDE_BOOL_CATS */

/* end of [bool.cats] */
