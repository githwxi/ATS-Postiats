/***********************************************************************/
/*                                                                     */
/*                        Applied Type System                          */
/*                                                                     */
/*                             Hongwei Xi                              */
/*                                                                     */
/***********************************************************************/

/*
** ATS/Anairiats - Unleashing the Power of Types!
**
** Copyright (C) 2002-2008 Hongwei Xi.
**
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
*/

/* ****** ****** */

// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: June 2008

/* ****** ****** */

#ifndef ATSRUNTIME_GCATS_C
#define ATSRUNTIME_GCATS_C

/* ****** ****** */

extern
ats_int_type gc_chunk_count_limit_get () ;
extern
ats_void_type gc_chunk_count_limit_set (ats_int_type n) ;

extern
ats_int_type gc_chunk_count_limit_max_get () ;
extern
ats_void_type gc_chunk_count_limit_max_set (ats_int_type n) ;

/* ****** ****** */

extern
ats_void_type gc_markroot_bsz (ats_ptr_type ptr, ats_int_type bsz) ;

/* ****** ****** */

extern
ats_ptr_type gc_aut_malloc_bsz (ats_int_type bsz) ;
extern
ats_ptr_type gc_aut_calloc_bsz (ats_int_type n, ats_int_type bsz) ;

extern ats_void_type gc_aut_free (ats_ptr_type ptr) ;
extern
ats_ptr_type gc_aut_realloc_bsz (ats_ptr_type ptr, ats_int_type bsz) ;

/* ****** ****** */

extern
ats_ptr_type gc_man_malloc_bsz (ats_int_type bsz) ;
extern
ats_ptr_type gc_man_calloc_bsz (ats_int_type n, ats_int_type bsz) ;

extern ats_void_type gc_man_free (ats_ptr_type ptr) ;
extern
ats_ptr_type gc_man_realloc_bsz (ats_ptr_type ptr, ats_int_type bsz) ;

/* ****** ****** */

extern void gc_init () ;
ats_void_type ats_gc_init () { gc_init () ; return ; }
// end of [ats_gc_init]

/* ****** ****** */

ats_void_type
ats_gc_markroot (const ats_ptr_type p, ats_size_type bsz) {
/*
  fprintf (stderr, "ats_gc_markroot: p = %p and bsz = %i\n", p, bsz) ;
*/
  gc_markroot_bsz (p, bsz) ; return ;
} // end of [ats_gc_markroot]

ats_int_type
ats_gc_chunk_count_limit_get () {
  return gc_chunk_count_limit_get () ;
} // end of [ats_gc_chunk_count_limit_get]

ats_void_type
ats_gc_chunk_count_limit_set
  (ats_int_type nchunk)
  { gc_chunk_count_limit_set (nchunk) ; return ; }
// end of [ats_gc_chunk_count_limit_set]

ats_int_type
ats_gc_chunk_count_limit_max_get () {
  return gc_chunk_count_limit_max_get () ;
} // end of [ats_gc_chunk_count_limit_max_get]

ats_void_type
ats_gc_chunk_count_limit_max_set
  (ats_int_type nchunk)
  { gc_chunk_count_limit_max_set (nchunk) ; return ; }
// end of [ats_gc_chunk_count_limit_max_set]

/* ****** ****** */

ats_ptr_type
ats_malloc_gc (ats_size_type n) {
  ats_ptr_type *p ;
/*
  fprintf (stderr, "ats_malloc_gc: n = %i\n", n) ;
*/
  p = gc_aut_malloc_bsz(n) ;
/*
  fprintf (stderr, "ats_malloc_gc: p = %p(%li)\n", p, p) ;
*/
  if (!p) ats_exit_errmsg(1, "exit(ATS): [ats_malloc_gc] failed.\n") ;
  return p ;
} // end of [ats_malloc_gc]

ats_ptr_type
ats_calloc_gc (ats_size_type n, ats_size_type bsz) {
  ats_ptr_type *p ;
/*
  fprintf (stderr, "ats_calloc_gc: n = %i and bsz = %i\n", n, bsz) ;
*/
  p = gc_aut_calloc_bsz(n, bsz) ;
/*
  fprintf (stderr, "ats_calloc_gc: p = %p(%li)\n", p, p) ;
*/
  if (!p) ats_exit_errmsg(1, "exit(ATS): [ats_calloc_gc] failed.\n") ;
  return p ;
} // end of [ats_calloc_gc]

ats_void_type
ats_free_gc (const ats_ptr_type p) {
/*
  fprintf (stderr, "ats_free_gc: p = %p(%li)\n", p, p) ;
*/
  gc_aut_free(p) ; return ;
} // end of [ats_free_gc]

ats_ptr_type
ats_realloc_gc (const ats_ptr_type p, ats_size_type bsz) {
  ats_ptr_type p_new ;
/*
  fprintf (stderr, "ats_realloc_gc: p = %p and bsz = %i\n", p, bsz) ;
*/
  p_new = gc_aut_realloc_bsz(p, bsz) ;
/*
  fprintf (stderr, "ats_realloc_gc: p_new = %p(%li)\n", p_new, p_new) ;
*/
  if (!p_new) ats_exit_errmsg(1, "exit(ATS): [ats_realloc_gc] failed.\n") ;
  return p_new ;
} // end of [ats_realloc_gc]

/* ****** ****** */

ats_ptr_type
ats_malloc_ngc (ats_size_type n) {
  ats_ptr_type *p ;
/*
  fprintf (stderr, "ats_malloc_ngc: _ATS_GCATS: n = %i\n", n) ;
*/
  p = gc_man_malloc_bsz(n) ;
/*
  fprintf (stderr, "ats_malloc_ngc: _ATS_GCATS: p = %p(%li)\n", p, p) ;
*/
  return p ;
} // end of [ats_malloc_ngc]

ats_ptr_type
ats_calloc_ngc (ats_size_type n, ats_size_type bsz)
{
  ats_ptr_type *p ;
  p = gc_man_calloc_bsz(n, bsz) ;
  return p ;
} // end of [ats_calloc_ngc]

ats_void_type
ats_free_ngc (const ats_ptr_type p) {
/*
  fprintf (stderr, "ats_free_ngc: _ATS_GCATS: p = %p\n", p) ;
*/
  gc_man_free(p) ; return ;
} // end of [ats_free_ngc]

ats_ptr_type
ats_realloc_ngc (const ats_ptr_type p, ats_size_type bsz) {
  ats_ptr_type *p_new ;
/*
  fprintf (stderr, "ats_realloc_ngc: _ATS_GCATS: p = %p\n", p) ;
  fprintf (stderr, "ats_realloc_ngc: _ATS_GCATS: bsz = %i\n", bsz) ;
*/
  p_new = gc_man_realloc_bsz(p, bsz) ;
/*
  fprintf (stderr, "ats_realloc_ngc: _ATS_GCATS: p_new = %p\n", p_new) ;
*/
  return p_new ;
} // end of [ats_realloc_ngc]

/* ****** ****** */

#endif /* ATSRUNTIME_GCATS_C */

/* end of [ats_prelude_gcats.c] */
