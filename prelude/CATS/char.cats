/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
*/

/* ****** ****** */
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: February, 2012
//
/* ****** ****** */

#include "prelude/params.hats"

/* ****** ****** */

#if VERBOSE_PRELUDE #then
#print "Loading [char.cats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

/* ****** ****** */

ATSinline()
atstype_bool
atspre_lt_char_char
  (atstype_char c1, atstype_char c2) {
  return (c1 < c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_lt_char_char]
ATSinline()
atstype_bool
atspre_lte_char_char
  (atstype_char c1, atstype_char c2) {
  return (c1 <= c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_lte_char_char]

ATSinline()
atstype_bool
atspre_gt_char_char
  (atstype_char c1, atstype_char c2) {
  return (c1 > c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_gt_char_char]
ATSinline()
atstype_bool
atspre_gte_char_char
  (atstype_char c1, atstype_char c2) {
  return (c1 >= c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_gte_char_char]

ATSinline()
atstype_bool
atspre_eq_char_char
  (atstype_char c1, atstype_char c2) {
  return (c1 == c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_eq_char_char]
ATSinline()
atstype_bool
atspre_neq_char_char
  (atstype_char c1, atstype_char c2) {
  return (c1 != c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_neq_char_char]

/* ****** ****** */

#define atspre_lt_char1_char1 atspre_lt_char_char
#define atspre_lte_char1_char1 atspre_lte_char_char
#define atspre_gt_char1_char1 atspre_gt_char_char
#define atspre_gte_char1_char1 atspre_gte_char_char
#define atspre_eq_char1_char1 atspre_eq_char_char
#define atspre_neq_char1_char1 atspre_neq_char_char
#define atspre_compare_char1_char1 atspre_compare_char_char

/* ****** ****** */

ATSinline()
atstype_int
atspre_compare_char_char
  (atstype_char c1, atstype_char c2) {
  return ((atstype_int)c1) - ((atstype_int)c2)
} // end of [atspre_compare_char_char]

/* ****** ****** */

ATSinline()
atstype_void
atspre_fprint_char (
  atstype_ref out, atstype_char c
) {
  fprintf ((FILE*)out, "%c", c) ; return ;
} // end of [atspre_fprint_char]

/* ****** ****** */
//
// unsigned characters
//
/* ****** ****** */

ATSinline()
atstype_bool
atspre_lt_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 < c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_lt_uchar_uchar]
ATSinline()
atstype_bool
atspre_lte_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 <= c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_lte_uchar_uchar]

ATSinline()
atstype_bool
atspre_gt_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 > c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_gt_uchar_uchar]
ATSinline()
atstype_bool
atspre_gte_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 >= c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_gte_uchar_uchar]

ATSinline()
atstype_bool
atspre_eq_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 == c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_eq_uchar_uchar]
ATSinline()
atstype_bool
atspre_neq_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 != c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_neq_uchar_uchar]

/* ****** ****** */

ATSinline()
atstype_int
atspre_compare_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  if c1 < c2 then return -1 ;
  if c1 > c2 then return  1 ;
  return 0 ; // HX: c1 == c2
} // end of [atspre_compare_uchar_uchar]

/* ****** ****** */

ATSinline()
atstype_bool
atspre_isalpha (atstype_int c) {
  return (isalpha(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_isalpha]

ATSinline()
atstype_bool
atspre_isalnum (atstype_int c) {
  return (isalnum(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_isalnum]

ATSinline()
atstype_bool
atspre_isascii (atstype_int c) {
  return (isascii(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_isascii]

ATSinline()
atstype_bool
atspre_isblank (atstype_int c) {
  return (isblank(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_isblank]

ATSinline()
atstype_bool
atspre_isspace (atstype_int c) {
  return (isspace(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_isspace]

ATSinline()
atstype_bool
atspre_iscntrl (atstype_int c) {
  return (iscntrl(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_iscntrl]

ATSinline()
atstype_bool
atspre_isdigit (atstype_int c) {
  return (isdigit(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_isdigit]

ATSinline()
atstype_bool
atspre_isxdigit (atstype_int c) {
  return (isxdigit(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_isxdigit]

ATSinline()
atstype_bool
atspre_isgraph (atstype_int c) {
  return (isgraph(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_isgraph]

ATSinline()
atstype_bool
atspre_isprint (atstype_int c) {
  return (isprint(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_isprint]

ATSinline()
atstype_bool
atspre_ispunct (atstype_int c) {
  return (ispunct(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_ispunct]

ATSinline()
atstype_bool
atspre_islower (atstype_int c) {
  return (islower(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_islower]

ATSinline()
atstype_bool
atspre_isupper (atstype_int c) {
  return (isupper(c) ? atsbool_true : atsbool_false) ;
} // end of [atspre_isupper]

ATSinline()
atstype_int
atspre_toascii
  (atstype_int c) { return toascii(c) ; }
// end of [atspre_toascii]

ATSinline()
atstype_int
atspre_tolower
  (atstype_int c) { return tolower(c) ; }
// end of [atspre_tolower]

ATSinline()
atstype_int
atspre_toupper
  (atstype_int c) { return toupper(c) ; }
// end of [atspre_toupper]

/* ****** ****** */

#if VERBOSE_PRELUDE #then
#print "Loading [char.cats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

/* ****** ****** */

/* end of [char.cats] */
