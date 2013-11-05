/* ******************************************************************* */
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/* ******************************************************************* */

/*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: November, 2013 *)
*/

/* ****** ****** */

#ifndef ATSHOME_LIBATS_STRINGBUF_CATS
#define ATSHOME_LIBATS_STRINGBUF_CATS

/* ****** ****** */

typedef
struct {
  atstype_ptr stringbuf_beg ; // the beg pointer
  atstype_ptr stringbuf_end ; // the end pointer
  atstype_ptr stringbuf_cur ; // the current pointer
} atslib_stringbuf_struct ;

/* ****** ****** */

ATSinline()
atstype_size
atslib_stringbuf_get_size
(
  atstype_ptr p
) {
  atstype_ptr p_beg ;
  atstype_ptr p_cur ;
  p_beg = ((atslib_stringbuf_struct*)p)->stringbuf_beg ;
  p_cur = ((atslib_stringbuf_struct*)p)->stringbuf_cur ;
  return ((char*)p_cur - (char*)p_beg) ;
} // end of [atslib_stringbuf_get_size]

ATSinline()
atstype_size
atslib_stringbuf_get_capacity
(
  atstype_ptr p
) {
  atstype_ptr p_beg ;
  atstype_ptr p_end ;
  p_beg = ((atslib_stringbuf_struct*)p)->stringbuf_beg ;
  p_end = ((atslib_stringbuf_struct*)p)->stringbuf_end ;
  return ((char*)p_end - (char*)p_beg) ;
} // end of [atslib_stringbuf_get_capacity]

/* ****** ****** */

ATSinline()
atstype_ptr
atslib_stringbuf_make_ngc
(
  atstype_ptr p
, atstype_ptr A
, atstype_size m
) {
  atslib_stringbuf_struct *p_buf ;
  p_buf = (atslib_stringbuf_struct*)p ;
//
  p_buf->stringbuf_beg = A ;
  p_buf->stringbuf_end = (char*)A + m ;
  p_buf->stringbuf_cur = A ;
//
  return p_buf ;
//
} // end of [atslib_stringbuf_make_ngc]

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atslib_stringbuf_free
  (atstype_ptr p)
{
  atstype_ptr p_beg ;
  p_beg = ((atslib_stringbuf_struct*)p)->stringbuf_beg ;
  ATS_MFREE(p) ; ATS_MFREE(p_beg) ;
  return ;
} // end of [atslib_stringbuf_free]

/* ****** ****** */

ATSinline()
atstype_string
atslib_stringbuf_getfree_strnptr
  (atstype_ptr p, atstype_ptr n)
{
  atstype_ptr p_beg ;
  atstype_ptr p_cur ;
  p_beg = ((atslib_stringbuf_struct*)p)->stringbuf_beg ;
  p_cur = ((atslib_stringbuf_struct*)p)->stringbuf_cur ;
  *(char*)p_cur = (char)0 ; *(size_t*)n = (char*)p_cur - (char*)p_beg ;
  ATS_MFREE(p) ;
  return p_beg ;
} // end of [atslib_stringbuf_getfree_strnptr]

/* ****** ****** */

#define atspre_stringbuf_memcpy memcpy

/* ****** ****** */

ATSinline()
atstype_bool
atslib_stringbuf_reset_capacity
  (atstype_ptr p, atstype_size m2)
{
  atstype_ptr p_beg ;
  atstype_ptr p_cur ;
  atstype_ptr p2_beg ;
  p_beg = ((atslib_stringbuf_struct*)p)->stringbuf_beg ;
  p_cur = ((atslib_stringbuf_struct*)p)->stringbuf_cur ;
  atstype_size n = (char*)p_cur - (char*)p_beg ;
//
  if (m2 < n) return atsbool_false ; // HX-2013-11: ignored
//
  p2_beg = atspre_malloc_gc(m2+1) ;
  atspre_stringbuf_memcpy(p2_beg, p_beg, n) ;
  atspre_mfree_gc(p_beg) ;
  ((atslib_stringbuf_struct*)p)->stringbuf_beg = p2_beg ;
  ((atslib_stringbuf_struct*)p)->stringbuf_end = (char*)p2_beg+m2 ;
  ((atslib_stringbuf_struct*)p)->stringbuf_cur = (char*)p2_beg+n ;
  return atsbool_true ;
//
} // end of [atslib_stringbuf_reset_capacity]

/* ****** ****** */

#endif // ifndef ATSHOME_LIBATS_STRINGBUF_CATS

/* ****** ****** */

/* end of [stringbuf.cats] */
