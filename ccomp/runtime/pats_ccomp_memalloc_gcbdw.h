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
(* Start time: March, 2013 *)
*/

/* ****** ****** */
//
#include <stdio.h>
/*
extern
int fprintf (FILE *stream, const char *format, ...) ;
*/
/* ****** ****** */
/*
#include <stdlib.h>
*/
extern void exit (int code) ; 

/* ****** ****** */
/*
#include <gc.h>
*/
extern void GC_init () ;
extern void GC_free (void *ptr) ;
extern void *GC_malloc(size_t bsz) ;
extern void *GC_realloc(void *ptr, size_t bsz) ;

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atsruntime_minit_gcbdw
  (/*void*/) { GC_init() ; return ; }
// end of [atsruntime_minit_gcbdw]

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atsruntime_mfree_gcbdw
  (void *ptr) { GC_free(ptr) ; return ; }
// end of [atsruntime_mfree_gcbdw]

/* ****** ****** */

ATSinline()
atstype_ptr
atsruntime_malloc_gcbdw
  (size_t bsz) { return GC_malloc(bsz) ; }
// end of [atsruntime_malloc_gcbdw]

ATSinline()
atstype_ptr
atsruntime_malloc_gcbdw_exn
  (size_t bsz)
{
  void *ptr ;
  ptr = atsruntime_malloc_gcbdw(bsz) ;
  if (!ptr)
  {
    fprintf(
      stderr, "exit(ATS): atsruntime_malloc_gcbdw_exn: [malloc] failed.\n"
    ) ; exit(1) ;
  } // end of [if]
  return (ptr) ;
} /* end of [atsruntime_malloc_gcbdw_exn] */

/* ****** ****** */
//
// HX:
// [GC_malloc] already
// clears the allocated region!
//
ATSinline()
atstype_ptr
atsruntime_calloc_gcbdw
  (size_t asz, size_t tsz)
{
  return atsruntime_malloc_gcbdw (asz*tsz) ;
} // end of [atsruntime_calloc_gcbdw]

ATSinline()
atstype_ptr
atsruntime_calloc_gcbdw_exn
  (size_t asz, size_t tsz)
{
  return atsruntime_malloc_gcbdw_exn (asz*tsz) ;
} // end of [atsruntime_calloc_gcbdw_exn]

/* ****** ****** */

ATSinline()
atstype_ptr
atsruntime_realloc_gcbdw
  (void *ptr, size_t bsz) { return GC_realloc(ptr, bsz) ; }
// end of [atsruntime_realloc_gcbdw]

ATSinline()
atstype_ptr
atsruntime_realloc_gcbdw_exn
  (void *ptr, size_t bsz)
{
  void *ptr2 ;
  ptr2 = atsruntime_realloc_gcbdw(ptr, bsz) ;
  if (!ptr2)
  {
    fprintf(
    stderr, "exit(ATS): atsruntime_realloc_gcbdw_exn: [realloc] failed.\n"
    ) ; exit(1) ;
  } // end of [if]
  return (ptr2) ;
} /* end of [atsruntime_realloc_gcbdw_exn] */

/* ****** ****** */

/* end of [pats_ccomp_memalloc_gcbdw.h] */
