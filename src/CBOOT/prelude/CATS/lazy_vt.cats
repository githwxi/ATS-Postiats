/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/*                              Hongwei Xi                             */
/*                                                                     */
/***********************************************************************/

/*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2008 Hongwei Xi, Boston University
**
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
**
*/

/* ****** ****** */

// author of the file: Hongwei Xi (hwxi AT cs DOT bu DOT edu)

/* ****** ****** */

#ifndef ATS_PRELUDE_LAZY_VT_CATS
#define ATS_PRELUDE_LAZY_VT_CATS

/* ****** ****** */

extern void free (void*) ; // see [stdlib.h]

/* ****** ****** */

#define ats_instr_move_lazy_ldelay_mac(tmp, hit, vp_clo) \
  do { tmp = (vp_clo) ; } while (0) /* end of [do ... while ...] */

#define ats_instr_move_lazy_lforce_mac(tmp, hit, vp_lazy) do { \
  tmp = \
    ((hit (*)(ats_ptr_type, ats_bool_type))ats_closure_fun(vp_lazy))(vp_lazy, ats_true_bool) ; \
  ATS_FREE (vp_lazy) ; \
} while (0) /* end of [do ... while ...] */

/* ****** ****** */

/*
** HX: [lazy_vt_free] is declared in $ATSHOME/prelude/basics_dyn.sats
*/
ATSinline()
ats_void_type
ats_lazy_vt_free (ats_ptr_type vp_lazy) {
  ((void (*)(ats_ptr_type, ats_bool_type))ats_closure_fun(vp_lazy))(vp_lazy, ats_false_bool) ;
  ATS_FREE (vp_lazy) ;
  return ;
} /* ats_lazy_vt_free */

/* ****** ****** */

#endif /* ATS_PRELUDE_LAZY_VT_CATS */

/* end of [lazy_vt.cats] */
