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

#ifndef ATS_PRELUDE_LIST_CATS
#define ATS_PRELUDE_LIST_CATS

/* ****** ****** */

ATSinline()
ats_ptr_type
atspre_list0_of_list1 (ats_ptr_type x) { return x ; }

ATSinline()
ats_ptr_type
atspre_list0_of_list_vt (ats_ptr_type x) { return x ; }

ATSinline()
ats_ptr_type
atspre_list1_of_list0 (ats_ptr_type x) { return x ; }

/* ****** ****** */

#endif /* ATS_PRELUDE_LIST_CATS */

/* end of [list.cats] */
