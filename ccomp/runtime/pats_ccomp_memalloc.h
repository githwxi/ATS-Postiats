/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
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
*) */

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

#undef ATS_MEMALLOC_FLAG

/* ****** ****** */

#ifdef ATS_MEMALLOC_LIBC
//
#define ATS_MEMALLOC_FLAG
//
#include "pats_ccomp_memalloc_libc.h"
//
#define ATS_MFREE atsruntime_mfree_libc
#define ATS_MALLOC atsruntime_malloc_libc_exn
//
#endif // end of [ATS_MEMALLOC_LIBC]

/* ****** ****** */

#ifdef ATS_MEMALLOC_GCBDW
//
#define ATS_MEMALLOC_FLAG
//
#include "pats_ccomp_memalloc_gcbdw.h"
//
#define ATS_MFREE atsruntime_mfree_gcbdw
#define ATS_MALLOC atsruntime_malloc_gcbdw_exn
//
#endif // end of [ATS_MEMALLOC_GCBDW]

/* ****** ****** */

#ifdef ATS_MEMALLOC_USER
//
#define ATS_MEMALLOC_FLAG
//
#include "pats_ccomp_memalloc_user.h"
//
#define ATS_MFREE atsruntime_mfree_user
#define ATS_MALLOC atsruntime_malloc_user
//
#endif // end of [ATS_MEMALLOC_USER]

/* ****** ****** */

#endif /* PATS_CCOMP_MEMALLOC_H */

/* ****** ****** */

/* end of [pats_ccomp_memalloc.h] */
