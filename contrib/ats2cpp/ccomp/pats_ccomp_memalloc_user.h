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
//
// stdlib.h
//
extern void exit (int code) ;
//
/* ****** ****** */

extern void atsruntime_mfree_user (void *ptr) ;
extern void *atsruntime_malloc_user (size_t bsz) ;
extern void *atsruntime_calloc_user (size_t asz, size_t tsz) ;
extern void *atsruntime_realloc_user (void *ptr, size_t bsz) ;

/* ****** ****** */

ATSinline()
atstype_ptr
atsruntime_malloc_user_exn
  (atstype_size bsz)
{
  atstype_ptr p ;
  p = atsruntime_malloc_user(bsz) ;
  if (!p) {
    fprintf(stderr, "exit(ATS): atsruntime_malloc_user_exn: [malloc] failed.\n") ;
    exit(1) ;
  } // end of [if]
  return (p) ;
} /* end of [atsruntime_malloc_user_exn] */

/* ****** ****** */

/* end of [pats_ccomp_memalloc_user.h] */
