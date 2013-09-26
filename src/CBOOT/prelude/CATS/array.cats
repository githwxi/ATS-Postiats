/************************************************************************/
/*                                                                      */
/*                         Applied Type System                          */
/*                                                                      */
/*                              Hongwei Xi                              */
/*                                                                      */
/************************************************************************/

/*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2008 Hongwei Xi.
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
*/

/* ****** ****** */

/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATS_PRELUDE_ARRAY_CATS
#define ATS_PRELUDE_ARRAY_CATS

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
atspre_array0_of_array1 (ats_ptr_type A) { return A ; }

ATSinline()
ats_ptr_type
atspre_array1_of_array0 (ats_ptr_type A) { return A ; }

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_array_ptr_alloc_tsz (
ats_size_type n, ats_size_type tsz
) {
  return ATS_MALLOC(n * tsz) ;
} /* end of [atspre_array_ptr_alloc_tsz] */

ATSinline()
ats_void_type
atspre_array_ptr_free
  (ats_ptr_type base) { 
  ATS_FREE(base); return ;
} /* end of [atspre_array_ptr_free] */

/* ****** ****** */

//
// HX: implemented in
// $ATSHOME/prelude/DATS/array.dats
//
extern
ats_void_type
atspre_array_ptr_initialize_elt_tsz (
  ats_ptr_type A
, ats_size_type asz
, ats_ptr_type ini
, ats_size_type tsz
)  ;

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_array_ptr_split_tsz (
  ats_ptr_type base
, ats_size_type offset
, ats_size_type tsz
) {
  return (ats_ptr_type)((char*)base + offset * tsz) ;
} /* end of [atspre_array_ptr_split_tsz] */

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_array_ptr_takeout_tsz (
  ats_ptr_type base
, ats_size_type offset
, ats_size_type tsz
) {
  return (ats_ptr_type)((char*)base + offset * tsz) ;
} /* end of [atspre_array_ptr_takeout_tsz] */

/* ****** ****** */

ATSinline()
ats_void_type
atspre_array_ptr_copy_tsz (
   ats_ptr_type p1
 , ats_ptr_type p2
 , ats_size_type asz
 , ats_size_type tsz
 ) {
  memcpy (p2, p1, asz * tsz) ; return ;
} /* end of [atspre_array_ptr_copy_tsz] */

ATSinline()
ats_void_type
atspre_array_ptr_move_tsz (
  ats_ptr_type p1
, ats_ptr_type p2
, ats_size_type asz
, ats_size_type tsz
) {
  memcpy (p2, p1, asz * tsz) ; return ;
} /* end of [atspre_array_ptr_move_tsz] */

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_array2_ptr_takeout_tsz (
  ats_ptr_type base
, ats_size_type iofs
, ats_size_type ncol
, ats_size_type tsz
) {
  return (ats_ptr_type)((char*)base + (iofs * ncol) * tsz) ;
} /* end of [atspre_array2_ptr_takeout_tsz] */

/* ****** ****** */

#endif /* ATS_PRELUDE_ARRAY_CATS */

/* end of [array.cats] */
