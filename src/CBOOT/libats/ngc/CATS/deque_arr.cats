/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2010 Hongwei Xi, ATS Trustful Software, Inc.
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

#ifndef ATS_LIBATS_NGC_DEQUE_ARR_CATS
#define ATS_LIBATS_NGC_DEQUE_ARR_CATS

/* ****** ****** */

typedef struct {
  ats_size_type cap ;
  ats_size_type nitm ;
  ats_ptr_type qarr_lft ;
  ats_ptr_type qarr_rgt ;
  ats_ptr_type qarr_beg ;
  ats_ptr_type qarr_end ;
} atslib_ngc_deque_arr_DEQUE ;

/* ****** ****** */

#ifndef memcpy
//
// HX: [memcpy] is not a macro
//
extern
void *memcpy (void *dst, const void* src, size_t n) ;
#endif // end of [memcpy]

/* ****** ****** */
//
// HX: these two are implemented in ATS:
//
extern
ats_void_type
atslib_ngc_deque_arr_deque_initialize_tsz (
  ats_ptr_type pq
, ats_size_type qsz
, ats_ptr_type parr
, ats_size_type tsz
) ; // end of [atslib_ngc_deque_arr_deque_initialize_tsz]

extern
ats_ptr_type
atslib_ngc_deque_arr_deque_uninitialize (ats_ptr_type) ;

/* ****** ****** */

ATSinline()
ats_ptr_type
atslib_ngc_deque_arr_deque_takeout_tsz (
  ats_ref_type q0
, ats_size_type i
, ats_size_type tsz
) {
  atslib_ngc_deque_arr_DEQUE *q = (atslib_ngc_deque_arr_DEQUE*)q0 ;
  char *p_lft = q->qarr_lft ;
  char *p_rgt = q->qarr_rgt ;
  char *p_beg = q->qarr_beg ;
  char *p_elt = p_beg + i * tsz ;
  if (p_elt >= p_rgt) {
    p_elt = p_lft + (p_elt - p_rgt) ;
  } // end of [if]
  return p_elt ;
} // end of [atslib_ngc_deque_arr_deque_takeout_tsz]

/* ****** ****** */

ATSinline()
ats_void_type
atslib_ngc_deque_arr_deque_insert_end_many_tsz (
  ats_ref_type q0
, ats_size_type k
, ats_ptr_type p0_xs /* buffer */
, ats_size_type tsz
) {
  atslib_ngc_deque_arr_DEQUE *q = (atslib_ngc_deque_arr_DEQUE*)q0 ;
  char *p_xs = (char*)p0_xs ;
  char *p_lft = q->qarr_lft ;
  char *p_rgt = q->qarr_rgt ;
  char *p_end = q->qarr_end ;
  size_t ktsz = k * tsz ;
  size_t diff = p_rgt - p_end ;
  q->nitm += k ;
  if (ktsz <= diff) {
    memcpy(p_end, p_xs, ktsz) ;
    q->qarr_end = p_end + ktsz ;
  } else {
    memcpy(p_end, p_xs, diff) ;
    memcpy(p_lft, p_xs+diff, ktsz-diff) ;
    q->qarr_end = p_lft + (ktsz-diff) ;
  } // end of [if]
  return ;
} // end of [atslib_ngc_deque_arr_deque_insert_end_many_tsz]

/* ****** ****** */

ATSinline()
ats_void_type
atslib_ngc_deque_arr_deque_remove_beg_many_tsz (
  ats_ref_type q0
, ats_size_type k
, ats_ptr_type p0_xs /* buffer */
, ats_size_type tsz
) {
  atslib_ngc_deque_arr_DEQUE *q = (atslib_ngc_deque_arr_DEQUE*)q0 ;
  char *p_xs = (char*)p0_xs ;
  char *p_lft = q->qarr_lft ;
  char *p_rgt = q->qarr_rgt ;
  char *p_beg = q->qarr_beg ;
  size_t ktsz = k * tsz ;
  size_t diff = p_rgt - p_beg ;
  q->nitm -= k ;
  if (ktsz <= diff) {
    memcpy(p_xs, p_beg, ktsz) ;
    q->qarr_beg = p_beg + ktsz ;
  } else {
    memcpy(p_xs, p_beg, diff) ;
    memcpy(p_xs+diff, p_lft, ktsz-diff) ;
    q->qarr_beg = p_lft + (ktsz-diff) ;
  } // end of [if]
  return ;
} // end of [atslib_ngc_deque_arr_deque_remove_beg_many_tsz]

/* ****** ****** */

ATSinline()
ats_void_type
atslib_ngc_deque_arr_deque_copyout_tsz (
  ats_ref_type q0
, ats_size_type i
, ats_size_type k
, ats_ptr_type p0_xs /* buffer */
, ats_size_type tsz
) {
  atslib_ngc_deque_arr_DEQUE *q = (atslib_ngc_deque_arr_DEQUE*)q0 ;
  char *p_xs = (char*)p0_xs ;
  char *p_lft = q->qarr_lft ;
  char *p_rgt = q->qarr_rgt ;
  char *p_beg = q->qarr_beg ;
  size_t itsz = i * tsz ;
  char *p_i = p_beg + itsz ;
  if (p_i >= p_rgt) {
    p_i = p_lft + (p_i - p_rgt) ;
  }
  size_t ktsz = k * tsz ;
  size_t diff = p_rgt - p_i ;
  if (ktsz <= diff) {
    memcpy(p_xs, p_i, ktsz) ;
  } else {
    memcpy(p_xs, p_i, diff) ;
    memcpy(p_xs+diff, p_lft, ktsz-diff) ;
  } // end of [if]
  return ;
} // end of [atslib_ngc_deque_arr_deque_copyout_tsz]

/* ****** ****** */

ATSinline()
ats_ptr_type
atslib_ngc_deque_arr_deque_update_capacity_tsz (
  ats_ref_type q0
, ats_size_type m2
, ats_ptr_type p0_xs /* buffer */
, ats_size_type tsz
) {
  atslib_ngc_deque_arr_DEQUE *q = (atslib_ngc_deque_arr_DEQUE*)q0 ;
  char *p_xs = (char*)p0_xs ;
  char *p_lft = q->qarr_lft ;
  char *p_rgt = q->qarr_rgt ;
  char *p_beg = q->qarr_beg ;
  size_t ntsz = q->nitm * tsz ;
  size_t diff = p_rgt - p_beg ;
//
  q->cap = m2 ; 
  q->qarr_lft = p_xs ;
  q->qarr_rgt = p_xs + m2 * tsz ;
  q->qarr_beg = p_xs ;
  q->qarr_end = p_xs + ntsz ;
//
  if (ntsz <= diff) {
    memcpy(p_xs, p_beg, ntsz) ;
  } else {
    memcpy(p_xs, p_beg, diff) ;
    memcpy(p_xs+diff, p_lft, ntsz-diff) ;
  } // end of [if]
//
  return p_lft ;
//
} // end of [atslib_ngc_deque_arr_deque_update_capacity_tsz]

/* ****** ****** */

#endif /* ATS_LIBATS_NGC_DEQUE_ARR_CATS */

/* end of [deque_arr.cats] */ 
