/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
** Source:
** $PATSHOME/prelude/CATS/CODEGEN/string.atxt
** Time of generation: Fri Feb 28 17:55:36 2014
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: April, 2012 *)
*/

/* ****** ****** */

#ifndef ATSLIB_PRELUDE_STRING_CATS
#define ATSLIB_PRELUDE_STRING_CATS

/* ****** ****** */

#define atspre_stropt_none() atsptr_null

/* ****** ****** */

#if(0)
//
ATSinline()
atstype_bool
atspre_lt_string_string (
  atstype_string x1, atstype_string x2
) {
  return (strcmp((char*)x1, (char*)x2) < 0 ? atsbool_true : atsbool_false) ;
} // [atspre_lt_string_string]

ATSinline()
atstype_bool
atspre_lte_string_string (
  atstype_string x1, atstype_string x2
) {
  return (strcmp((char*)x1, (char*)x2) <= 0 ? atsbool_true : atsbool_false) ;
} // [atspre_lte_string_string]

ATSinline()
atstype_bool
atspre_gt_string_string(
  atstype_string x1, atstype_string x2
) {
  return (strcmp((char*)x1, (char*)x2) > 0 ? atsbool_true : atsbool_false) ;
} // [atspre_gt_string_string]

ATSinline()
atstype_bool
atspre_gte_string_string (
  atstype_string x1, atstype_string x2
) {
  return (strcmp((char*)x1, (char*)x2) >= 0 ? atsbool_true : atsbool_false) ;
} // [atspre_gte_string_string]

ATSinline()
atstype_bool
atspre_eq_string_string (
  atstype_string x1, atstype_string x2
) {
  return (strcmp((char*)x1, (char*)x2)==0 ? atsbool_true : atsbool_false) ;
} // [atspre_eq_string_string]

ATSinline()
atstype_bool
atspre_neq_string_string (
  atstype_string x1, atstype_string x2
) {
  return (strcmp((char*)x1, (char*)x2)!=0 ? atsbool_true : atsbool_false) ;
} // [atspre_neq_string_string]
//
#endif // end of [#if(0)]

/* ****** ****** */

#define atspre_string_equal atspre_eq_string_string
#define atspre_string_noteq atspre_neq_string_string

/* ****** ****** */

#if(0)
//
ATSinline()
atstype_int
atspre_compare_string_string
  (atstype_string x1, atstype_string x2) { return strcmp((char*)x1, (char*)x2) ; }
// [atspre_compare_string_string]
//
#endif // end of [#if(0)]

/* ****** ****** */

#endif // ifndef ATSLIB_PRELUDE_STRING_CATS

/* ****** ****** */

/* end of [string.cats] */
