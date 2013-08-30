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

#ifndef ATS_PRELUDE_BYTE_CATS
#define ATS_PRELUDE_BYTE_CATS

/* ****** ****** */

#include <ctype.h>

/* ****** ****** */

extern
int fprintf (FILE *stream, const char *format, ...) ;
// in [stdio.h]

/* ****** ****** */

extern
ats_void_type
ats_exit_errmsg (ats_int_type n, ats_ptr_type msg) ;

/* ****** ****** */

/*

//
// HX: these are now casting functions:
//
ATSinline()
ats_byte_type
atspre_byte_of_char (ats_char_type c) { return c ; }

ATSinline()
ats_char_type
atspre_char_of_byte (ats_byte_type b) { return b ; }

*/

/* ****** ****** */

ATSinline()
ats_byte_type
atspre_byte_of_int (ats_int_type i) { return i ; }

ATSinline()
ats_int_type
atspre_int_of_byte (ats_byte_type b) { return b ; }

/* ****** ****** */

ATSinline()
ats_byte_type
atspre_byte_of_uint (ats_uint_type u) { return u ; }

ATSinline()
ats_uint_type
atspre_uint_of_byte (ats_byte_type b) { return b ; }

/* ****** ****** */

// arithmetic operations

ATSinline()
ats_byte_type
atspre_succ_byte(ats_byte_type i) { return (i + 1) ; }

ATSinline()
ats_byte_type
atspre_pred_byte(ats_byte_type i) { return (i - 1) ; }

ATSinline()
ats_byte_type
atspre_add_byte_byte(ats_byte_type i1, ats_byte_type i2) {
  return (i1 + i2) ;
}

ATSinline()
ats_byte_type
atspre_sub_byte_byte(ats_byte_type i1, ats_byte_type i2) {
  return (i1 - i2) ;
}

ATSinline()
ats_byte_type
atspre_mul_byte_byte(ats_byte_type i1, ats_byte_type i2) {
  return (i1 * i2) ;
}

ATSinline()
ats_byte_type
atspre_div_byte_byte(ats_byte_type i1, ats_byte_type i2) {
  return (i1 / i2) ;
}

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_lt_byte_byte(ats_byte_type b1, ats_byte_type b2) {
  return (b1 < b2) ;
}
ATSinline()
ats_bool_type
atspre_lte_byte_byte(ats_byte_type b1, ats_byte_type b2) {
  return (b1 <= b2) ;
}
ATSinline()
ats_bool_type
atspre_gt_byte_byte(ats_byte_type b1, ats_byte_type b2) {
  return (b1 > b2) ;
}
ATSinline()
ats_bool_type
atspre_gte_byte_byte(ats_byte_type b1, ats_byte_type b2) {
  return (b1 >= b2) ;
}

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_eq_byte_byte
  (ats_byte_type b1, ats_byte_type b2) { return (b1 == b2) ; }
// end of [atspre_eq_byte_byte]

ATSinline()
ats_bool_type
atspre_neq_byte_byte
  (ats_byte_type b1, ats_byte_type b2) { return (b1 != b2) ; }
// end of [atspre_neq_byte_byte]

//
// bitwise operations
//

ATSinline()
ats_byte_type
atspre_lnot_byte(ats_byte_type b) { return (~b) ; }

ATSinline()
ats_byte_type
atspre_land_byte_byte
  (ats_byte_type b1, ats_byte_type b2) { return (b1 & b2) ; }
// end of [atspre_land_byte_byte]

ATSinline()
ats_byte_type
atspre_lor_byte_byte
  (ats_byte_type b1, ats_byte_type b2) { return (b1 | b2) ; }
// end of [atspre_lor_byte_byte]

ATSinline()
ats_byte_type
atspre_lxor_byte_byte
  (ats_byte_type b1, ats_byte_type b2) { return (b1 ^ b2) ; }
// end of [atspre_lxor_byte_byte]

ATSinline()
ats_byte_type
atspre_lsl_byte_int1
  (ats_byte_type b, ats_int_type n) { return (b << n) ; }
// end of [atspre_lsl_byte_int1]

ATSinline()
ats_byte_type
atspre_lsr_byte_int1
  (ats_byte_type b, ats_int_type n) { return (b >> n) ; }
// end of [atspre_lsr_byte_int1]

//
// print functions
//

ATSinline()
ats_void_type
atspre_fprint_byte (
  const ats_ptr_type out, const ats_byte_type b
) {
/*
  int n = fputc (b, (FILE *)out) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"Exit: [fprint_byte] failed.\n") ;
  } // end of [if]
*/
  (void)fputc (b, (FILE *)out) ; return ;
} // end of [atspre_fprint_byte]

ATSinline()
ats_void_type
atspre_print_byte
  (const ats_byte_type c) {
//  atspre_stdout_view_get () ;
  atspre_fprint_byte((ats_ptr_type)stdout, c) ;
//  atspre_stdout_view_set () ;
  return ;
} // end of [atspre_print_byte]

ATSinline()
ats_void_type
atspre_prerr_byte
  (const ats_byte_type c) {
//  atspre_stderr_view_get () ;
  atspre_fprint_byte((ats_ptr_type)stderr, c) ;
//  atspre_stderr_view_set () ;
  return ;
} // end of [atspre_prerr_byte]

/* ****** ****** */

#define atspre_lt_byte1_byte1 atspre_lt_byte_byte
#define atspre_lte_byte1_byte1 atspre_lte_byte_byte
#define atspre_gt_byte1_byte1 atspre_gt_byte_byte
#define atspre_gte_byte1_byte1 atspre_gte_byte_byte
#define atspre_eq_byte1_byte1 atspre_eq_byte_byte
#define atspre_neq_byte1_byte1 atspre_neq_byte_byte

/* ****** ****** */

#endif /* ATS_PRELUDE_BYTE_CATS */

/* end of [byte.cats] */
