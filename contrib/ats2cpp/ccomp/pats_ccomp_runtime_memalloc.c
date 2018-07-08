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
(* Start time: April, 2013 *)
*/

/* ****** ****** */

#ifdef ATS_MEMALLOC_LIBC

extern "C"
{
//
void
atsruntime_mfree_undef (void *ptr)
{
 atsruntime_mfree_libc (ptr) ; return ;
}
void
*atsruntime_malloc_undef (size_t bsz)
{
 return atsruntime_malloc_libc (bsz) ;
}
void
*atsruntime_calloc_undef
  (size_t asz, size_t tsz)
{
 return atsruntime_calloc_libc (asz, tsz) ;
}
void
*atsruntime_realloc_undef
   (void *ptr, size_t bsz)
{
 return atsruntime_realloc_libc (ptr, bsz) ;
}
//
} // end of [extern "C"]

#endif // ATS_MEMALLOC_LIBC

/* ****** ****** */

#ifdef ATS_MEMALLOC_GCBDW

extern "C"
{
//
void
atsruntime_mfree_undef (void *ptr)
{
 atsruntime_mfree_gcbdw (ptr) ; return ;
}
extern
void
*atsruntime_malloc_undef (size_t bsz)
{
 return atsruntime_malloc_gcbdw (bsz) ;
}
extern
void
*atsruntime_calloc_undef
  (size_t asz, size_t tsz)
{
 return atsruntime_calloc_gcbdw (asz, tsz) ;
}
extern
void
*atsruntime_realloc_undef
   (void *ptr, size_t bsz)
{
 return atsruntime_realloc_gcbdw (ptr, bsz) ;
}
//
} // end of [extern "C"]
//
#endif // ATS_MEMALLOC_GCBDW

/* ****** ****** */

/* end of [pats_ccomp_runtime_memalloc.c] */
