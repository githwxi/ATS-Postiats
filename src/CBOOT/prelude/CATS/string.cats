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

#ifndef ATS_PRELUDE_STRING_CATS
#define ATS_PRELUDE_STRING_CATS

/* ****** ****** */

#include <string.h>

/* ****** ****** */

extern
int fprintf (FILE *stream, const char *format, ...) ;
// in [stdio.h]

/* ****** ****** */

ATSinline()
ats_void_type
atspre_strbuf_bytes_trans (ats_ptr_type p) {
  return ;
} /* end of [atspre_strbuf_bytes_trans] */

ATSinline()
ats_void_type
atspre_bytes_strbuf_trans
  (ats_ptr_type p, ats_size_type n) {
  ((char*)p)[n] = '\000' ; return ;
} /* end of [atspre_bytes_strbuf_trans] */

/* ****** ****** */

ATSinline()
ats_void_type
atspre_strbufptr_free
  (ats_ptr_type base) { ATS_FREE(base); return ; }
// end of [atspre_strbufptr_free]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_lt_string_string
  (const ats_ptr_type s1, const ats_ptr_type s2) {
  int i = strcmp((char*)s1, (char*)s2) ;
  return (i < 0 ? ats_true_bool : ats_false_bool) ;
} /* end of [atspre_lt_string_string] */

ATSinline()
ats_bool_type
atspre_lte_string_string
  (const ats_ptr_type s1, const ats_ptr_type s2) {
  int i = strcmp((char*)s1, (char*)s2) ;
  return (i <= 0 ? ats_true_bool : ats_false_bool) ;
} /* end of [atspre_lte_string_string] */

ATSinline()
ats_bool_type
atspre_gt_string_string
  (const ats_ptr_type s1, const ats_ptr_type s2) {
  int i = strcmp((char*)s1, (char*)s2) ;
  return (i > 0 ? ats_true_bool : ats_false_bool) ;
} /* end of [atspre_gt_string_string] */

ATSinline()
ats_bool_type
atspre_gte_string_string
  (const ats_ptr_type s1, const ats_ptr_type s2) {
  int i = strcmp((char*)s1, (char*)s2) ;
  return (i >= 0 ? ats_true_bool : ats_false_bool) ;
} /* end of [atspre_gte_string_string] */

ATSinline()
ats_bool_type
atspre_eq_string_string
  (const ats_ptr_type s1, const ats_ptr_type s2) {
  int i = strcmp((char*)s1, (char*)s2) ;
/*
  fprintf (stdout, "ats_eq_string_string: s1 = %s and s2 = %s\n", s1, s2) ;
  fprintf (stdout, "ats_eq_string_string: i = %i\n", i) ;
*/
  return (i == 0 ? ats_true_bool : ats_false_bool) ;
} /* end of [atspre_eq_string_string] */

ATSinline()
ats_bool_type
atspre_neq_string_string
  (const ats_ptr_type s1, const ats_ptr_type s2) {
  int i = strcmp((char*)s1, (char*)s2) ;
  return (i != 0 ? ats_true_bool : ats_false_bool) ;
} /* end of [atspre_neq_string_string] */

ATSinline()
ats_int_type
atspre_compare_string_string
  (const ats_ptr_type s1, const ats_ptr_type s2) {
  int i = strcmp((char*)s1, (char*)s2) ;
  if (i < 0) return -1 ;
  if (i > 0) return  1 ;
  return 0 ;
} /* end of [atspre_compare_string_string] */

// print functions

ATSinline()
ats_void_type
atspre_fprint_string
  (const ats_ptr_type out, const ats_ptr_type s) {
  int n = fprintf ((FILE *)out, "%s", (char*)s) ;
  if (n < 0) { ats_exit_errmsg
    (n, (ats_ptr_type)"exit(ATS): [fprint_string] failed.\n") ;
  } // end of [if]
  return ;
} /* end of [atspre_fprint_string] */

ATSinline()
ats_void_type
atspre_print_string (const ats_ptr_type s) {
//  atspre_stdout_view_get() ;
  atspre_fprint_string((ats_ptr_type)stdout, s) ;
//  atspre_stdout_view_set() ;
  return ;
} /* end of [atspre_print_string] */

ATSinline()
ats_void_type
atspre_prerr_string (const ats_ptr_type s) {
//  atspre_stderr_view_get() ;
  atspre_fprint_string((ats_ptr_type)stderr, s) ;
//  atspre_stderr_view_set() ;
  return ;
} /* end of [atspre_prerr_string] */

/* ****** ****** */

ATSinline()
ats_char_type
atspre_string_get_char_at
  (const ats_ptr_type s, ats_size_type offset) {
  return *((char*)s + offset) ;
} /* end of [atspre_string_get_char_at] */

ATSinline()
ats_char_type
atspre_string_get_char_at__intsz (
  const ats_ptr_type s, ats_int_type offset
) {
  return *((char*)s + offset) ;
} /* end of [atspre_string_get_char_at__intsz] */

ATSinline()
ats_void_type
atspre_strbuf_set_char_at (
  ats_ptr_type s, ats_size_type offset, ats_char_type c
) {
/*
  fprintf (stdout, "atspre_strbuf_set_char_at: s = %s\n", s);
  fprintf (stdout, "atspre_strbuf_set_char_at: offset = %li\n", (unsigned long)offset);
  fprintf (stdout, "atspre_strbuf_set_char_at: c = %c\n", c);
*/
  *((char*)s + offset) = c ; return ;
} /* end of [atspre_strbuf_set_char_at] */

ATSinline()
ats_void_type
atspre_strbuf_set_char_at__intsz (
  ats_ptr_type s, ats_int_type offset, ats_char_type c
) {
  *((char*)s + offset) = c ; return ;
} /* end of [atspre_strbuf_set_char_at__intsz] */

ATSinline()
ats_char_type
atspre_string_test_char_at (
  const ats_ptr_type s, ats_size_type offset
) {
  return *((char*)s + offset) ;
} /* end of [atspre_string_test_char_at] */

ATSinline()
ats_char_type
atspre_string_test_char_at__intsz (
  const ats_ptr_type s, ats_int_type offset
) {
  return *((char*)s + offset) ;
} /* end of [atspre_string_test_char_at__intsz] */

/* ****** ****** */

ATSinline()
ats_void_type
atspre_strbuf_initialize_substring (
  ats_ptr_type p_buf
, ats_ptr_type s, ats_size_type st, ats_size_type ln
) {
  memcpy (p_buf, ((char*)s)+st, ln) ; ((char*)p_buf)[ln] = '\000' ;
  return ;
} // end of [atspre_strbuf_initialize_substring]

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_string_copy
  (ats_ptr_type str) {
  int n ; char *des ;
  n = strlen((char*)str) ;
  des = (char*)ATS_MALLOC(n+1) ;
  des[n] = '\000' ;
  memcpy(des, str, n) ;
  return (des) ;
} // end of [atspre_string_copy]

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_string_append
  (ats_ptr_type s1, ats_ptr_type s2) {
  int n1, n2 ; char *des ;
  n1 = strlen((char*)s1) ;
  n2 = strlen((char*)s2) ;
  des = (char*)ATS_MALLOC(n1+n2+1) ;
  des[n1+n2] = '\000' ;
  memcpy(des, s1, n1) ; memcpy (des+n1, s2, n2) ;
  return (des) ;
} // end of [atspre_string_append]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_string_contains
  (ats_ptr_type s0, ats_char_type c) {
  char *s = strchr((char*)s0, (char)c) ;
  return (s != (char*)0 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_string_contains]

/* ****** ****** */

ATSinline()
ats_size_type
atspre_string_length
  (ats_ptr_type s) { return (strlen((char*)s)) ; }
// end of [atspre_string_length]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_string_is_empty
  (ats_ptr_type s) { return (*((char*)s) == '\000') ; }
// end of [atspre_string_is_empty]

ATSinline()
ats_bool_type
atspre_string_isnot_empty
  (ats_ptr_type s) { return (*((char*)s) != '\000') ; }
// end of [atspre_string_isnot_empty]

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_string_is_atend (
  ats_ptr_type s, ats_size_type i
) {
  return (*((char*)s + i) == '\000' ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_string_is_atend]

ATSinline()
ats_bool_type
atspre_string_isnot_atend (
  ats_ptr_type s, ats_size_type i
) {
  return (*((char*)s + i) != '\000' ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_string_isnot_atend]

/* ****** ****** */

ATSinline()
ats_ssize_type
atspre_string_index_of_char_from_left
  (const ats_ptr_type s, const ats_char_type c) {
  char *res ;
  res = strchr ((char*)s, c) ;
  if (res != (char*)0) return (res - (char*)s) ;
  return (-1) ;
} // end of [atspre_string_index_of_char_from_left]

ATSinline()
ats_ssize_type
atspre_string_index_of_char_from_right
  (const ats_ptr_type s, const ats_char_type c) {
  char *res ;
  res = strrchr ((char*)s, c) ;
  if (res != (char*)0) return (res - (char*)s) ;
  return (-1) ;
} // end of [atspre_string_index_of_char_from_right]

/* ****** ****** */

ATSinline()
ats_ssize_type
atspre_string_index_of_string
  (const ats_ptr_type s1, const ats_ptr_type s2) {
  char *res ;
  res = strstr ((char*)s1, (char*)s2) ;
  if (res != (char*)0) return (res - (char*)s1) ;
  return (-1) ;
} // end of [atspre_string_index_of_string]

/* ****** ****** */

extern
ats_ptr_type
atspre_string_make_char
(
  ats_size_type n, const ats_char_type c
) ; // implemented in [prelude/DATS/string.dats]

extern
ats_ptr_type
atspre_string_make_substring
(
  ats_ptr_type src0, ats_size_type start, ats_size_type len
) ; // implemented in [prelude/DATS/string.dats]

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_string_singleton
  (ats_char_type c) {
  return atspre_string_make_char (1, c) ;
} // end of [atspre_string_singleton]

/* ****** ****** */

// functions for optional strings

static
ats_ptr_type atspre_stropt_none = (ats_ptr_type)0 ;

ATSinline()
ats_bool_type
atspre_stropt_is_none
  (ats_ptr_type opt) { return (opt == (ats_ptr_type)0) ;
} // end of [atspre_stropt_is_none]

ATSinline()
ats_bool_type
atspre_stropt_is_some
  (ats_ptr_type opt) { return (opt != (ats_ptr_type)0) ;
} // end of [atspre_stropt_is_some]

ATSinline()
ats_void_type
atspre_fprint_stropt
(
  ats_ref_type out, ats_ptr_type opt
) {
  if (!opt)
    { fprintf ((FILE*)out, "None()") ; return ; }
  // end of [if]
  fprintf ((FILE*)out, "Some(%s)", (char*)opt) ;
  return ;
} // end of [atspre_fprint_stropt]

/* ****** ****** */

#define atspre_stropt_gc_none() ((ats_ptr_type)0)

ATSinline()
ats_void_type
atspre_stropt_gc_unnone (ats_ptr_type x) { return ; }

/* ****** ****** */

#define atspre_strptr_null() ((ats_ptr_type)0)

ATSinline()
ats_void_type
atspre_strptr_free
  (ats_ptr_type base) { if (base) ATS_FREE (base) ; return ; }
// end of [atspre_strptr_free]

#define atspre_fprint_strptr atspre_fprint_string

/* ****** ****** */

#endif /* ATS_PRELUDE_STRING_CATS */

/* end of [string.cats] */
