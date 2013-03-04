/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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
** Source:
** $PATSHOME/prelude/CATS/CODEGEN/strptr.atxt
** Time of generation: Mon Mar  4 14:00:13 2013
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: March, 2013 *)
*/

/* ****** ****** */

#ifndef ATSHOME_PRELUDE_STRPTR_CATS
#define ATSHOME_PRELUDE_STRPTR_CATS

/* ****** ****** */
//
// [string.h]
//
extern
int // (sign)
strcmp (const char *x1, const char *x2) ;

/* ****** ****** */

#define atspre_strptr_free atspre_mfree_gc

/* ****** ****** */

ATSinline()
atstype_int
atspre_compare_strptr_strptr
(
  atstype_strptr x1, atstype_strptr x2
) {
  if (x1==0) {
    return (x2==0 ? 0 : -1) ;
  } else {
    return (x2==0 ? 1 : strcmp((char*)x1, (char*)x2)) ;
  } // end of [if]
} // end of [atspre_compare_strptr_strptr]

/* ****** ****** */

#endif // ifndef ATSHOME_PRELUDE_STRPTR_CATS

/* ****** ****** */

/* end of [strptr.cats] */
