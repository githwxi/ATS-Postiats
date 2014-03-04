/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2009 Hongwei Xi, ATS Trustful Software, Inc.
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
** A dynamically resizable vector implementation
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: Secptember, 2010
*/

/* ****** ****** */

#ifndef ATS_LIBATS_HASHTABLE_CHAIN_CATS
#define ATS_LIBATS_HASHTABLE_CHAIN_CATS

/* ****** ****** */

ATSinline()
ats_void_type
atslib_hashtbl_ptr_free__chain
  (ats_ptr_type pbeg) { ATS_FREE(pbeg) ; return ; }
// end of [atslib_hashtbl_ptr_free__chain]

/* ****** ****** */

ATSinline()
ats_ptr_type
atslib_hashtbl_make_null__chain
  (/*argumentless*/) { return (void*)0; }
// end of [atslib_hashtbl_make_null__chain]

/* ****** ****** */

ATSinline()
ats_void_type
atslib_hashtbl_free_null__chain
  (ats_ptr_type ptbl) { return ; }
// end of [atslib_hashtbl_free_null__chain]

/* ****** ****** */

#endif /* ATS_LIBATS_HASHTABLE_CHAIN_CATS */

/* end of [hashtable_chain.cats] */
