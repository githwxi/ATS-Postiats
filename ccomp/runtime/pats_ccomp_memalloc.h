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
#include <stdio.h>
//
extern
int fprintf (FILE *stream, const char *format, ...) ;
//
/* ****** ****** */
//
#include <stdlib.h>
//
extern void exit (int code) ;
extern void free (void *ptr) ;
extern void *malloc (size_t bsz) ;
//
/* ****** ****** */
//
// HX: [afree] matches [alloca]
//
ATSinline()
atsvoid_t0ype
atsruntime_afree_libc
  (atstype_ptr ptr) { return ; }
// end of [atsruntime_afree_libc]

ATSinline()
atstype_ptr
atsruntime_alloca_libc
  (atstype_size bsz) { return alloca(bsz) ; }
// end of [atsruntime_alloca_libc]

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atsruntime_mfree_libc
  (atstype_ptr ptr) { free(ptr) ; return ; }
// end of [atsruntime_mfree_libc]

ATSinline()
atstype_ptr
atsruntime_malloc_libc
  (atstype_size bsz) { return malloc(bsz) ; }
// end of [atsruntime_malloc_libc]

ATSinline()
atstype_ptr
atsruntime_malloc_libc_exn
  (atstype_size bsz)
{
  atstype_ptr p ;
  p = atsruntime_malloc_libc(bsz) ;
  if (!p) {
    fprintf(stderr, "atsruntime_malloc_libc_exn: [malloc] failed.\n") ;
    exit(1) ;
  } // end of [if]
  return (p) ;
} /* end of [atsruntime_malloc_libc_exn] */

/* ****** ****** */

#ifndef ATS_MFREE
#define ATS_MFREE atsruntime_mfree_libc
#endif // end of [ifndef]
#ifndef ATS_MALLOC
#define ATS_MALLOC atsruntime_malloc_libc_exn
#endif // end of [ifndef]

/* ****** ****** */

#endif /* PATS_CCOMP_MEMALLOC_H */

/* ****** ****** */

/* end of [pats_ccomp_memalloc.h] */
