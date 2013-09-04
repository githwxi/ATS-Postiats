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
** Copyright (C) 2002-2009 Hongwei Xi.
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

/* author: Likai Liu (liulk AT cs DOT bu DOT edu) */
/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATSRUNTIME_GCBDW_C
#define ATSRUNTIME_GCBDW_C

/* ****** ****** */

#include <gc/gc.h> // interface file for [GCBDW]

/* ****** ****** */

ats_void_type
ats_gc_init () { GC_INIT() ; return ; }
// end of [ats_gc_init]

ats_void_type
ats_gc_markroot (
  const ats_ptr_type p, ats_size_type bsz
) {
  return ;
} // end of [ats_gc_markroot]

ats_int_type
ats_gc_chunk_count_limit_get () { return 0 ; }
// end of [ats_gc_chunk_count_limit_get]

ats_void_type
ats_gc_chunk_count_limit_set
  (ats_int_type nchunk) { return ; }
// end of [ats_gc_chunk_count_limit_set]

ats_int_type
ats_gc_chunk_count_limit_max_get () { return 0 ; }
// end of [ats_gc_chunk_count_limit_max_get]

ats_void_type
ats_gc_chunk_count_limit_max_set
  (ats_int_type nchunk) { return ; }
// end of [ats_gc_chunk_count_limit_max_set]

/* ****** ****** */

ats_ptr_type
ats_malloc_gc (
  ats_size_type nbytes
) { 
  return GC_MALLOC(nbytes) ; // allocated memory is cleared
} // end of [ats_malloc_gc]

ats_ptr_type
ats_calloc_gc (
  ats_size_type nitm
, ats_size_type bsz
) {
  return GC_MALLOC(nitm * bsz) ; // allocated memory is cleared
} // end of [ats_calloc_gc]

ats_void_type
ats_free_gc
  (ats_ptr_type p) { GC_FREE(p) ; return ; }
// end of [ats_free_gc]

ats_ptr_type
ats_realloc_gc (
  ats_ptr_type p_old
, ats_size_type nbytes_new
) {
  return GC_REALLOC(p_old, nbytes_new) ;
} // end of [ats_realloc_gc]

/* ****** ****** */

ats_ptr_type
ats_malloc_ngc (
  ats_size_type nbytes
) { 
  return GC_MALLOC_UNCOLLECTABLE(nbytes) ; // allocated memory is cleared
} // end of [ats_malloc_ngc]

ats_ptr_type
ats_calloc_ngc (
  ats_size_type nitm
, ats_size_type bsz
) {
  return GC_MALLOC_UNCOLLECTABLE(nitm * bsz) ; // allocated memory is cleared
} // end of [ats_calloc_ngc]

ats_void_type
ats_free_ngc (ats_ptr_type p) { GC_FREE (p) ; return ; }
// end of [ats_free_ngc]

ats_ptr_type
ats_realloc_ngc (
  ats_ptr_type p_old
, ats_size_type nbytes_new
) {
  return GC_REALLOC (p_old, nbytes_new) ;
} // end of [ats_realloc_ngc]

/* ****** ****** */

#endif /* ATSRUNTIME_GCBDW_C */

/* end of [ats_prelude_gcbdw.c] */
