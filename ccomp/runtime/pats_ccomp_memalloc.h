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

#include <stdio.h>
#include <stdlib.h>

/* ****** ****** */

extern void exit (int code) ;
extern void *malloc (size_t bsz) ;
extern
int fprintf (FILE *stream, const char *format, ...) ;
// in [stdio.h]

/* ****** ****** */

ATSinline()
atstype_ptr
ats_malloc_ngc
(atstype_size bsz) { return malloc(bsz) ; }

ATSinline()
atstype_ptr
ats_malloc_ngc_exn
(atstype_size bsz)
{
  atstype_ptr p ;
  p = ats_malloc_ngc (bsz) ;
  if (!p) {
    fprintf(stderr, "ats_malloc_ngc_exn: [malloc] failed.\n") ;
    exit(1) ;
  } // end of [if]
  return (p) ;
} /* end of [ats_malloc_ngc_exn] */

/* ****** ****** */

ATSinline()
atsvoid_t0ype
ats_free_ngc (atstype_ptr p) { free(p) ; return ; }

/* ****** ****** */

#ifndef ATS_MALLOC
#define ATS_MALLOC ats_malloc_ngc_exn
#endif // end of [ifndef]

#ifndef ATS_FREE
#define ATS_FREE ats_free_ngc
#endif // end of [ifndef]

/* ****** ****** */

#endif /* PATS_CCOMP_MEMALLOC_H */

/* ****** ****** */

/* end of [pats_ccomp_memalloc.h] */
