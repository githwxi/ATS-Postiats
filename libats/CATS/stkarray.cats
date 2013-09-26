/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: September, 2013 *)
*/

/* ****** ****** */

#ifndef ATSHOME_LIBATS_STKARRAY_CATS
#define ATSHOME_LIBATS_STKARRAY_CATS

/* ****** ****** */

typedef
struct {
  atstype_ptr stkarray_beg ; // the beg pointer
  atstype_ptr stkarray_end ; // the end pointer
  atstype_ref stkarray_cur ; // the current pointer
} atslib_stkarray_struct ;

/* ****** ****** */

ATSinline()
atstype_ptr
atslib_stkarray_make_ngc
(
  atstype_ptr p
, atstype_ptr A
, atstype_size m
, atstype_size tsz
) {
  atslib_stkarray_struct *p_stk ;
  p_stk = (atslib_stkarray_struct*)p ;
  p_stk->stkarray_beg = A ;
  p_stk->stkarray_end = (char*)A + m * tsz ;
  p_stk->stkarray_cur = A ;
  return p_stk ;
} // end of [atslib_stkarray_make_ngc]

/* ****** ****** */

ATSinline()
atstype_size
atslib_stkarray_get_size__tsz
(
  atstype_ptr p, atstype_size tsz
) {
  atslib_stkarray_struct *p_stk ;
  p_stk = (atslib_stkarray_struct*)p ;
  return ((char*)(p_stk->stkarray_cur) - (char*)(p_stk->stkarray_beg)) / tsz ;
} // end of [atslib_stkarray_get_size__tsz]

ATSinline()
atstype_size
atslib_stkarray_get_capacity__tsz
(
  atstype_ptr p, atstype_size tsz
) {
  atslib_stkarray_struct *p_stk ;
  p_stk = (atslib_stkarray_struct*)p ;
  return ((char*)(p_stk->stkarray_end) - (char*)(p_stk->stkarray_beg)) / tsz ;
} // end of [atslib_stkarray_get_capacity__tsz]

/* ****** ****** */

ATSinline()
atstype_ptr
atslib_stkarray_get_ptrbeg
  (atstype_ptr p)
{
  return ((atslib_stkarray_struct*)p)->stkarray_beg ;
} // end of [atslib_stkarray_get_ptrbeg]

/* ****** ****** */

ATSinline()
atstype_ptr
atslib_stkarray_get_ptrcur
  (atstype_ptr p)
{
  return ((atslib_stkarray_struct*)p)->stkarray_cur ;
} // end of [atslib_stkarray_get_ptrcur]

ATSinline()
atsvoid_t0ype
atslib_stkarray_set_ptrcur
  (atstype_ptr p, atstype_ptr p2)
{
  ((atslib_stkarray_struct*)p)->stkarray_cur = p2 ; return ;
} // end of [atslib_stkarray_set_ptrcur]

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atslib_stkarray_free_nil
  (atstype_ptr p)
{
  atstype_ptr p_beg ;
  p_beg = ((atslib_stkarray_struct*)p)->stkarray_beg ;
  ATS_MFREE(p) ; ATS_MFREE(p_beg) ;
  return ;
} // end of [atslib_stkarray_free_nil]

/* ****** ****** */

ATSinline()
atstype_ptr
atslib_stkarray_getfree_arrayptr
  (atstype_ptr p)
{
  atstype_ptr p_beg ;
  p_beg = ((atslib_stkarray_struct*)p)->stkarray_beg ;
  ATS_MFREE(p) ;
  return p_beg ;
} // end of [atslib_stkarray_getfree_arrayptr]

/* ****** ****** */

ATSinline()
atstype_bool
atslib_stkarray_is_nil
  (atstype_ptr p)
{
  atslib_stkarray_struct *p_stk ;
  p_stk = (atslib_stkarray_struct*)p ;
  return (p_stk->stkarray_beg==p_stk->stkarray_cur ? atsbool_true : atsbool_false) ;
} // end of [atslib_stkarray_is_nil]
ATSinline()
atstype_bool
atslib_stkarray_isnot_nil
  (atstype_ptr p)
{
  atslib_stkarray_struct *p_stk ;
  p_stk = (atslib_stkarray_struct*)p ;
  return (p_stk->stkarray_beg < p_stk->stkarray_cur ? atsbool_true : atsbool_false) ;
} // end of [atslib_stkarray_isnot_nil]

/* ****** ****** */

ATSinline()
atstype_bool
atslib_stkarray_is_full
  (atstype_ptr p)
{
  atslib_stkarray_struct *p_stk ;
  p_stk = (atslib_stkarray_struct*)p ;
  return (p_stk->stkarray_cur==p_stk->stkarray_end ? atsbool_true : atsbool_false) ;
} // end of [atslib_stkarray_is_full]
ATSinline()
atstype_bool
atslib_stkarray_isnot_full
  (atstype_ptr p)
{
  atslib_stkarray_struct *p_stk ;
  p_stk = (atslib_stkarray_struct*)p ;
  return (p_stk->stkarray_cur < p_stk->stkarray_end ? atsbool_true : atsbool_false) ;
} // end of [atslib_stkarray_isnot_full]

/* ****** ****** */

#endif // ifndef ATSHOME_LIBATS_STKARRAY_CATS

/* ****** ****** */

/* end of [stkarray.cats] */
