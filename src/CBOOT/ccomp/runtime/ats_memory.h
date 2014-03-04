/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2008 Hongwei Xi, ATS Trustful Software, Inc.
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
*) */

/* ****** ****** */

/*
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) 
**
*/

/* ****** ****** */

#ifndef	ATS_MEMORY_H
#define ATS_MEMORY_H

/* ****** ****** */

#include "ats_types.h"

/* ****** ****** */
//
// HX: the function [alloca] is declared in
extern void *alloca (size_t nsz) ; // [alloca.h] or [stdlib.h]

#define ATS_ALLOCA(sz) alloca(sz)
#define ATS_ALLOCA2(n, sz) alloca((n)*(sz))

/* ****** ****** */

#define ATS_GC_INIT ats_gc_init
#define ATS_GC_MARKROOT ats_gc_markroot

/* ****** ****** */

#define ATS_FREE ats_free_gc
#define ATS_MALLOC ats_malloc_gc
#define ATS_MALLOC2(n, sz) ATS_MALLOC((n)*(sz))
#define ATS_CALLOC ats_calloc_gc
#define ATS_REALLOC ats_realloc_gc

/* ****** ****** */

extern
ats_void_type ats_gc_init () ;

extern
ats_void_type
ats_gc_markroot (ats_ptr_type p, ats_size_type bsz) ;

/* ****** ****** */

extern
ats_ptr_type
ats_malloc_ngc (ats_size_type n) ;

extern
ats_ptr_type
ats_calloc_ngc (ats_size_type nmemb, ats_size_type bsz) ;

extern
ats_void_type
ats_free_ngc (const ats_ptr_type p) ;

extern
ats_ptr_type
ats_realloc_ngc (const ats_ptr_type p, ats_size_type n) ;

/* ****** ****** */

extern
ats_ptr_type
ats_malloc_gc (ats_size_type bsz) ;

extern
ats_ptr_type
ats_calloc_gc
(ats_size_type nmemb, ats_size_type bsz) ;

extern
ats_void_type
ats_free_gc (const ats_ptr_type p) ;

extern
ats_ptr_type
ats_realloc_gc (const ats_ptr_type p, ats_size_type bsz) ;

/* ****** ****** */

#endif	/* ATS_MEMORY_H */

/* end of [ats_memory.h] */
