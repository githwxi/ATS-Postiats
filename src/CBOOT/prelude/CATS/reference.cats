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

/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATS_PRELUDE_REFERENCE_CATS
#define ATS_PRELUDE_REFERENCE_CATS

/* ****** ****** */

#ifdef memcpy
//
// HX: [memcpy] is a macro on MACOS
//
#else
//
// in [string.h]
//
extern
void *memcpy(void *dest, const void *src, size_t n) ;
//
#endif // memcpy

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_ref_make_elt_tsz (
  ats_ptr_type p0, ats_size_type sz
) {
  ats_ptr_type p ;
  p = ATS_MALLOC(sz) ;
  memcpy (p, p0, sz) ;
  return p ;
} // end of [atspre_ref_make_elt_tsz]

ATSinline()
ats_ptr_type
atspre_ref_void_make () { return (ats_ptr_type)0 ; }

ATSinline()
ats_ptr_type
atspre_ref_make_view_ptr (ats_ptr_type p) { return p ; }

/* ****** ****** */
//
// HX-2011-01-12: it is now a casting function; this is
// kept for backward compatibility
//
ATSinline()
ats_ptr_type
atspre_ref_get_view_ptr (ats_ptr_type r) { return r ; }


/* ****** ****** */

#endif /* ATS_PRELUDE_REFERENCE_CATS */

/* end of [reference.cats] */
