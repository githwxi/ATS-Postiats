/* ******************************************************************* */
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/* ******************************************************************* */

/*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: October, 2012 *)
*/

/* ****** ****** */

#ifndef PATS_CCOMP_MEMALLOC_H
#define PATS_CCOMP_MEMALLOC_H

/* ****** ****** */
//
// HX: for size_t
//
#include <stddef.h>
//
/* ****** ****** */
/*
extern "C"
{
void atsruntime_mfree_undef(void *ptr) ;
void *atsruntime_malloc_undef(size_t bsz) ;
void *atsruntime_calloc_undef(size_t asz, size_t tsz) ;
void *atsruntime_realloc_undef(void *ptr, size_t bsz) ;
}
*/
//
#include <stdlib.h>
//
/* ****** ****** */

#ifdef ATS_MEMALLOC_FLAG
#undef ATS_MEMALLOC_FLAG
#endif // ifdef(ATS_MEMALLOC_FLAG)

/* ****** ****** */

#ifdef ATS_MEMALLOC_LIBC
//
#define ATS_MEMALLOC_FLAG
//
#include "pats_ccomp_memalloc_libc.h"
//
#define ATS_MINIT atsruntime_minit_libc
#define ATS_MFREE atsruntime_mfree_libc
#define ATS_MALLOC atsruntime_malloc_libc_exn
#define ATS_CALLOC atsruntime_calloc_libc_exn
#define ATS_REALLOC atsruntime_realloc_libc_exn
//
#endif // end of [ATS_MEMALLOC_LIBC]

/* ****** ****** */

#ifdef ATS_MEMALLOC_GCBDW
//
#define ATS_MEMALLOC_FLAG
//
#include "pats_ccomp_memalloc_gcbdw.h"
//
#define ATS_MINIT atsruntime_minit_gcbdw
#define ATS_MFREE atsruntime_mfree_gcbdw
#define ATS_MALLOC atsruntime_malloc_gcbdw_exn
#define ATS_CALLOC atsruntime_calloc_gcbdw_exn
#define ATS_REALLOC atsruntime_realloc_gcbdw_exn
//
#endif // end of [ATS_MEMALLOC_GCBDW]

/* ****** ****** */

#ifdef ATS_MEMALLOC_USER
//
#define ATS_MEMALLOC_FLAG
//
#include "pats_ccomp_memalloc_user.h"
//
#define ATS_MINIT atsruntime_minit_user
#define ATS_MFREE atsruntime_mfree_user
#define ATS_MALLOC atsruntime_malloc_user
#define ATS_CALLOC atsruntime_calloc_user
#define ATS_REALLOC atsruntime_realloc_user
//
#endif // end of [ATS_MEMALLOC_USER]

/* ****** ****** */

#ifndef ATS_MEMALLOC_FLAG
#define ATS_MEMALLOC_FLAG
//
#define ATS_MINIT atsruntime_minit_undef
#define ATS_MFREE atsruntime_mfree_undef
#define ATS_MALLOC atsruntime_malloc_undef
#define ATS_CALLOC atsruntime_calloc_undef
#define ATS_REALLOC atsruntime_realloc_undef
//
#endif // end of [ATS_MEMALLOC_FLAG]

/* ****** ****** */

#endif /* PATS_CCOMP_MEMALLOC_H */

/* ****** ****** */

/* end of [pats_ccomp_memalloc.h] */
