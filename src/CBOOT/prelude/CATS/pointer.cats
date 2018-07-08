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

#ifndef ATS_PRELUDE_POINTER_CATS
#define ATS_PRELUDE_POINTER_CATS

/* ****** ****** */

extern
int fprintf (FILE *stream, const char *format, ...) ;
// in [stdio.h]

/* ****** ****** */
//
// HX: [string.h]
//
#ifdef memset
//
// HX: [memset] is a macro on MACOS
//
#else
extern
void *memset(void *s, int c, size_t n);
#endif
#ifdef memcpy
//
// HX: [memcpy] is a macro on MACOS
//
#else
extern
void *memcpy(void *dest, const void *src, size_t n) ;
#endif

/* ****** ****** */

static
ats_ptr_type atspre_null_ptr = (ats_ptr_type)0 ;

ATSinline()
ats_bool_type
atspre_ptr_is_null
  (ats_ptr_type p) {
  return (p == (ats_ptr_type)0 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_ptr_is_null]

ATSinline()
ats_bool_type
atspre_ptr_isnot_null (ats_ptr_type p) {
  return (p != (ats_ptr_type)0 ? ats_true_bool : ats_false_bool) ;
} // end of [atspre_ptr_isnot_null]

/* ****** ****** */

//
// HX-2010-04-19:
// this one is to be used by various "free_null" functions
//
ATSinline()
ats_void_type
atspre_ptr_free_null (ats_ptr_type p) { return ; }
// end of [atspre_ptr_free_null]

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_psucc (ats_ptr_type p) {
  return (ats_ptr_type)((ats_byte_type*)p + 1) ;
}

ATSinline()
ats_ptr_type
atspre_ppred (ats_ptr_type p) {
  return (ats_ptr_type)((ats_byte_type*)p - 1) ;
}

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_padd_int (
  ats_ptr_type p, ats_int_type n
) {
  return (ats_ptr_type)((ats_byte_type*)p + n) ;
} // end of [atspre_padd_int]

ATSinline()
ats_ptr_type
atspre_padd_size (
  ats_ptr_type p, ats_size_type n
) {
  return (ats_ptr_type)((ats_byte_type*)p + n) ;
} // end of [atspre_padd_size]

ATSinline()
ats_ptr_type
atspre_psub_int (
  ats_ptr_type p, ats_int_type n
) {
  return (ats_ptr_type)((ats_byte_type*)p - n) ;
} // end of [atspre_psub_int]

ATSinline()
ats_ptr_type
atspre_psub_size (
  ats_ptr_type p, ats_size_type n
) {
  return (ats_ptr_type)((ats_byte_type*)p - n) ;
} // end of [atspre_psub_size]

ATSinline()
ats_ptrdiff_type
atspre_pdiff (
  ats_ptr_type p1, ats_ptr_type p2
) {
  return ((ats_byte_type*)p1 - (ats_byte_type*)p2) ;
}

/* ****** ****** */

ATSinline()
ats_bool_type
atspre_plt (ats_ptr_type p1, ats_ptr_type p2) {
  return (p1 < p2) ;
}

ATSinline()
ats_bool_type
atspre_plte (ats_ptr_type p1, ats_ptr_type p2) {
  return (p1 <= p2) ;
}

ATSinline()
ats_bool_type
atspre_pgt (ats_ptr_type p1, ats_ptr_type p2) {
  return (p1 > p2) ;
}

ATSinline()
ats_bool_type
atspre_pgte (ats_ptr_type p1, ats_ptr_type p2) {
  return (p1 >= p2) ;
}

ATSinline()
ats_bool_type
atspre_peq (ats_ptr_type p1, ats_ptr_type p2) {
  return (p1 == p2) ;
}

ATSinline()
ats_bool_type
atspre_pneq (ats_ptr_type p1, ats_ptr_type p2) {
  return (p1 != p2) ;
}

ATSinline()
ats_int_type
atspre_compare_ptr_ptr (
  ats_ptr_type p1, ats_ptr_type p2
) {
  if (p1 < p2) return (-1) ;
  else if (p1 > p2) return ( 1) ;
  else return (0) ;  
} /* end of [atspre_compare_ptr_ptr] */

/* ****** ****** */

// print functions

ATSinline()
ats_void_type
atspre_fprint_ptr (
  ats_ptr_type out, ats_ptr_type p
) {
  int n = fprintf ((FILE *)out, "%p", p) ;
  if (n < 0) {
    ats_exit_errmsg (n, (ats_ptr_type)"exit(ATS): [fprint_pointer] failed.\n") ;
  } /* end of [if] */
  return ;
}

ATSinline()
ats_void_type
atspre_print_ptr(ats_ptr_type p) {
//  atspre_stdout_view_get() ;
  atspre_fprint_ptr ((ats_ptr_type)stdout, p) ;
//  atspre_stdout_view_set() ;
  return ;
}

ATSinline()
ats_void_type
atspre_prerr_ptr(ats_ptr_type p) {
//  atspre_stderr_view_get() ;
  atspre_fprint_ptr ((ats_ptr_type)stderr, p) ;
//  atspre_stderr_view_set() ;
  return ;
}

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_ptr_alloc_tsz
  (ats_size_type tsz) {
  ats_ptr_type p ; p = ATS_MALLOC(tsz) ; return (ats_ptr_type)p ;
} // end of [atspre_ptr_alloc_tsz]

ATSinline()
ats_void_type
atspre_ptr_free(ats_ptr_type ptr) { ATS_FREE(ptr) ; return ; }

/* ****** ****** */

ATSinline()
ats_void_type
atspre_ptr_zero_tsz
  (ats_ref_type p, ats_size_type tsz) { memset (p, 0, tsz) ; return ; }
// end of [atspre_ptr_zero]

/* ****** ****** */

// HX: for both [ptr_move_t_tsz] and [ptr_move_vt_tsz]

ATSinline()
ats_void_type
atspre_ptr_move_tsz (
  ats_ptr_type p1
, ats_ptr_type p2
, ats_size_type tsz
) {
  memcpy ((void*)p2, (void*)p1, tsz) ; return ;
} // end of ...

/* ****** ****** */

#endif /* ATS_PRELUDE_POINTER_CATS */

/* end of [pointer.cats] */
