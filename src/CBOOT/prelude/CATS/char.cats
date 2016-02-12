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

#ifndef ATS_PRELUDE_CHAR_CATS
#define ATS_PRELUDE_CHAR_CATS

/* ****** ****** */

#include <ctype.h>

/* ****** ****** */

#if(0)
#ifndef isascii
extern int isascii (int c) ; // _XOPEN_SOURCE
#endif // end of [isascii]

#ifndef isblank
extern int isblank (int c) ; // _XOPEN_SOURCE >= 600
#endif // end of [isblank]

#ifndef toascii
extern int toascii (int c) ; // _XOPEN_SOURCE
#endif // end of [toascii]
#endif // end of [ #if(0) ]

/* ****** ****** */

extern
int fprintf (FILE *stream, const char *format, ...) ;
// in [stdio.h]

/* ****** ****** */
//
// HX: implemented in [prelude/DATS/basics.dats]
//
extern
ats_void_type
ats_exit_errmsg(ats_int_type n, ats_ptr_type msg) ;

/* ****** ****** */

/*
//
// HX: these are now casting functions:
//
ATSinline()
ats_char_type
atspre_char_of_schar (ats_schar_type c) { return c ; }

ATSinline()
ats_schar_type
atspre_schar_of_char (ats_char_type c) { return c ; }

ATSinline()
ats_char_type
atspre_char_of_uchar (ats_uchar_type c) { return c ; }

ATSinline()
ats_uchar_type
atspre_uchar_of_char (ats_char_type c) { return c ; }

*/

/* ****** ****** */

ATSinline()
ats_char_type
atspre_char_of_int (ats_int_type i) { return i ; }

ATSinline()
ats_schar_type
atspre_schar_of_int (ats_int_type i) { return i ; }

ATSinline()
ats_uchar_type
atspre_uchar_of_int (ats_int_type i) { return i ; }

/* ****** ****** */

ATSinline()
ats_char_type
atspre_char_of_uint (ats_uint_type u) { return u ; }

ATSinline()
ats_schar_type
atspre_schar_of_uint (ats_uint_type u) { return u ; }

ATSinline()
ats_uchar_type
atspre_uchar_of_uint (ats_uint_type u) { return u ; }

/* ****** ****** */

#define atspre_char1_of_char atspre_char_of_char
#define atspre_char1_of_int atspre_char_of_int
#define atspre_char1_of_uint atspre_char_of_uint

/* ****** ****** */

ATSinline()
ats_int_type
atspre_sub_char_char (
  ats_char_type c1
, ats_char_type c2
) {
  return (c1 - c2) ;
} /* end of [atspre_sub_char_char] */

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_lt_char_char
  (ats_char_type c1, ats_char_type c2) {
  return (c1 < c2) ;
} // end of [atspre_lt_char_char]

ATSinline()
ats_bool_type
atspre_lte_char_char
  (ats_char_type c1, ats_char_type c2) {
  return (c1 <= c2) ;
} // end of [atspre_lte_char_char]

ATSinline()
ats_bool_type
atspre_gt_char_char
  (ats_char_type c1, ats_char_type c2) {
  return (c1 > c2) ;
} // end of [atspre_gt_char_char]

ATSinline()
ats_bool_type
atspre_gte_char_char
  (ats_char_type c1, ats_char_type c2) {
  return (c1 >= c2) ;
} // end of [atspre_gte_char_char]

ATSinline()
ats_bool_type
atspre_eq_char_char
  (ats_char_type c1, ats_char_type c2) {
  return (c1 == c2) ;
} // end of [atspre_eq_char_char]

ATSinline()
ats_bool_type
atspre_neq_char_char
  (ats_char_type c1, ats_char_type c2) {
  return (c1 != c2) ;
} // end of [atspre_neq_char_char]

ATSinline()
ats_int_type
atspre_compare_char_char
  (ats_char_type c1, ats_char_type c2) {
  int i = c1 - c2 ;
  if (i > 0) return  1 ;
  if (i < 0) return -1 ;
  return 0 ;
} /* end of [atspre_compare_char_char] */

/* ****** ****** */
//
// HX: print functions
//
ATSinline()
ats_void_type
atspre_fprint_char (
  ats_ptr_type out, ats_char_type c
) {
  int n = fputc ((unsigned char)c, (FILE*)out) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"Exit: [fprint_char] failed.\n") ;
  } // end of [if]
  return ;
} // end of [atspre_fprint_char]

ATSinline()
ats_void_type
atspre_print_char
  (ats_char_type c) {
//  atspre_stdout_view_get () ;
  atspre_fprint_char((ats_ptr_type)stdout, c) ;
//  atspre_stdout_view_set () ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_char
  (ats_char_type c) {
//  atspre_stderr_view_get () ;
  atspre_fprint_char((ats_ptr_type)stderr, c) ;
//  atspre_stderr_view_set () ;
  return ;
}

// stringization

ATSinline()
ats_ptr_type
atspre_tostrptr_char
  (ats_char_type c) {
  char *p ;
  p = (char *)ATS_MALLOC(2) ; *p = (char)c ; *(p+1) = '\000' ;
  return (ats_ptr_type)p ;
} // end of [atspre_tostrptr_char]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_char_isalnum (ats_char_type c) { return isalnum((int)c) ; }

ATSinline()
ats_bool_type
atspre_char_isalpha (ats_char_type c) { return isalpha((int)c) ; }

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_char_isascii (ats_char_type c) { return isascii((int)c) ; }

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_char_isblank (ats_char_type c) { return isblank((int)c) ; }

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_char_iscntrl (ats_char_type c) { return iscntrl((int)c) ; }

ATSinline()
ats_bool_type
atspre_char_isdigit (ats_char_type c) { return isdigit((int)c) ; }

ATSinline()
ats_bool_type
atspre_char_isgraph (ats_char_type c) { return isgraph((int)c) ; }

ATSinline()
ats_bool_type
atspre_char_islower (ats_char_type c) { return islower((int)c) ; }

ATSinline()
ats_bool_type
atspre_char_isnull (ats_char_type c) {
  return (c == '\000' ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_char_isnull]

ATSinline()
ats_bool_type
atspre_char_isprint (ats_char_type c) { return isprint((int)c) ; }

ATSinline()
ats_bool_type
atspre_char_ispunct (ats_char_type c) { return ispunct((int)c) ; }

ATSinline()
ats_bool_type
atspre_char_isspace (ats_char_type c) { return isspace((int)c) ; }

ATSinline()
ats_bool_type
atspre_char_isupper (ats_char_type c) { return isupper((int)c) ; }

ATSinline()
ats_bool_type
atspre_char_isxdigit (ats_char_type c) { return isxdigit((int)c) ; }

/* ****** ****** */

ATSinline()
ats_char_type
atspre_char_tolower (ats_char_type c) { return (int)tolower((int)c) ; }

ATSinline()
ats_char_type
atspre_char_toupper (ats_char_type c) { return (int)toupper((int)c) ; }

/* ****** ****** */

#endif /* ATS_PRELUDE_CHAR_CATS */

/* end of [char.cats] */
