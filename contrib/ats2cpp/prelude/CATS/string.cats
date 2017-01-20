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

#ifndef ATS2CPP_PRELUDE_CATS_STRING
#define ATS2CPP_PRELUDE_CATS_STRING

/* ****** ****** */
//
#include <string.h>
//
/* ****** ****** */

#define atspre_stropt_none() atsptr_null

/* ****** ****** */

ATSinline()
atstype_bool
atspre_lt_string_string
(
  atstype_string x1, atstype_string x2
) {
  int sgn = strcmp((char*)x1, (char*)x2) ;
  return (sgn < 0 ? atsbool_true : atsbool_false) ;
} // [atspre_lt_string_string]

ATSinline()
atstype_bool
atspre_lte_string_string
(
  atstype_string x1, atstype_string x2
) {
  int sgn = strcmp((char*)x1, (char*)x2) ;
  return (sgn <= 0 ? atsbool_true : atsbool_false) ;
} // [atspre_lte_string_string]

ATSinline()
atstype_bool
atspre_gt_string_string
(
  atstype_string x1, atstype_string x2
) {
  int sgn = strcmp((char*)x1, (char*)x2) ;
  return (sgn > 0 ? atsbool_true : atsbool_false) ;
} // [atspre_gt_string_string]

ATSinline()
atstype_bool
atspre_gte_string_string
(
  atstype_string x1, atstype_string x2
) {
  int sgn = strcmp((char*)x1, (char*)x2) ;
  return (sgn >= 0 ? atsbool_true : atsbool_false) ;
} // [atspre_gte_string_string]

ATSinline()
atstype_bool
atspre_eq_string_string
(
  atstype_string x1, atstype_string x2
) {
  int sgn = strcmp((char*)x1, (char*)x2) ;
  return (sgn == 0 ? atsbool_true : atsbool_false) ;
} // [atspre_eq_string_string]

ATSinline()
atstype_bool
atspre_neq_string_string
(
  atstype_string x1, atstype_string x2
) {
  int sgn = strcmp((char*)x1, (char*)x2) ;
  return (sgn != 0 ? atsbool_true : atsbool_false) ;
} // [atspre_neq_string_string]

/* ****** ****** */

#define atspre_string_equal atspre_eq_string_string
#define atspre_string_noteq atspre_neq_string_string

/* ****** ****** */

ATSinline()
atstype_int
atspre_compare_string_string
(
  atstype_string x1, atstype_string x2
) {
  return atspre_int2sgn(strcmp((char*)x1, (char*)x2)) ;
} // [atspre_compare_string_string]

/* ****** ****** */

#define atspre_strcmp strcmp
#define atspre_strlen strlen
#define atspre_strchr strchr
#define atspre_strrchr strrchr
#define atspre_strstr strstr
#define atspre_strspn strspn
#define atspre_strcspn strcspn

#define atspre_string_memcpy memcpy

/* ****** ****** */
//
// HX-2013-09:
// declared in [stdio.h]
//
#ifndef snprintf
extern
int
snprintf
(char *str, size_t size, const char *format, ...) ;
#endif // end of [ifndef]
//
/* ****** ****** */
//
ATSinline()
atstype_string
atspre_g0int2string_int
  (atstype_int x)
{
  size_t n0 ;
  char *res ;
  size_t ntot ;
  n0 = 4 ;
  res = ATS_MALLOC(n0) ;
  ntot = snprintf(res, n0, "%i", x) ;
  if (ntot >= n0)
  {
    ATS_MFREE(res) ;
    res = (char*)ATS_MALLOC(ntot+1) ;
    ntot = snprintf(res, ntot+1, "%i", x) ;
  }
  return res ;
}
//
ATSinline()
atstype_string
atspre_g0int2string_lint
  (atstype_lint x)
{
  size_t n0 ;
  char *res ;
  size_t ntot ;
  n0 = 4 ;
  res = ATS_MALLOC(n0) ;
  ntot = snprintf(res, n0, "%li", x) ;
  if (ntot >= n0)
  {
    ATS_MFREE(res) ;
    res = (char*)ATS_MALLOC(ntot+1) ;
    ntot = snprintf(res, ntot+1, "%li", x) ;
  }
  return res ;
}
//
ATSinline()
atstype_string
atspre_g0int2string_llint
  (atstype_llint x)
{
  size_t n0 ;
  char *res ;
  size_t ntot ;
  n0 = 8 ;
  res = ATS_MALLOC(n0) ;
  ntot = snprintf(res, n0, "%lli", x) ;
  if (ntot >= n0)
  {
    ATS_MFREE(res) ;
    res = (char*)ATS_MALLOC(ntot+1) ;
    ntot = snprintf(res, ntot+1, "%lli", x) ;
  }
  return res ;
}
//
/* ****** ****** */
//
#include <stdarg.h>
//
// HX-2013-11:
// these are implemented in [string.dats]
//
extern "C"
{
atstype_string // Strptr0
atspre_string_make_snprintf(atstype_string fmt, ...) ;
atstype_string // Strptr0
atspre_string_make_vsnprintf
  (atstype_size bsz0, atstype_string fmt, va_list ap0) ;
}
//
/* ****** ****** */

#endif // ifndef(ATS2CPP_PRELUDE_CATS_STRING)

/* ****** ****** */

/* end of [string.cats] */
