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
** $PATSHOME/prelude/CATS/CODEGEN/char.atxt
** Time of generation: Fri Apr  4 23:21:55 2014
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: February, 2012 *)
*/

/* ****** ****** */

#ifndef ATS2CPP_PRELUDE_CATS_CHAR
#define ATS2CPP_PRELUDE_CATS_CHAR

/* ****** ****** */

ATSinline()
atstype_char
atspre_int2char (atstype_int i) { return ((atstype_char)i) ; }
#define atspre_int2char0 atspre_int2char

ATSinline()
atstype_schar
atspre_int2schar (atstype_int i) { return ((atstype_schar)i) ; }
#define atspre_int2schar0 atspre_int2schar

ATSinline()
atstype_uchar
atspre_int2uchar (atstype_int i) { return ((atstype_uchar)i) ; }
#define atspre_int2uchar0 atspre_int2uchar

/* ****** ****** */

ATSinline()
atstype_int
atspre_char2int (atstype_char c) { return ((atstype_int)c) ; }
#define atspre_char2int0 atspre_char2int

ATSinline()
atstype_int
atspre_schar2int (atstype_schar c) { return ((atstype_int)c) ; }
#define atspre_schar2int0 atspre_schar2int

ATSinline()
atstype_int
atspre_uchar2int (atstype_uchar c) { return ((atstype_int)c) ; }
#define atspre_uchar2int0 atspre_uchar2int

/* ****** ****** */

ATSinline()
atstype_uint
atspre_char2uint (atstype_char c) { return ((atstype_uint)c) ; }
#define atspre_char2uint0 atspre_char2uint

ATSinline()
atstype_uint
atspre_schar2uint (atstype_schar c) { return ((atstype_uint)c) ; }
#define atspre_schar2uint0 atspre_schar2uint

ATSinline()
atstype_uint
atspre_uchar2uint (atstype_uchar c) { return ((atstype_uint)c) ; }
#define atspre_uchar2uint0 atspre_uchar2uint

/* ****** ****** */

ATSinline()
atstype_int
atspre_char2u2int
  (atstype_char c) { return ((atstype_int)((atstype_uchar)c)) ; }
#define atspre_char2u2int0 atspre_char2u2int
ATSinline()
atstype_uint
atspre_char2u2uint
  (atstype_char c) { return ((atstype_uint)((atstype_uchar)c)) ; }
#define atspre_char2u2uint0 atspre_char2u2uint

/* ****** ****** */

ATSinline()
atstype_bool
atspre_char_iseqz
  (atstype_char c)
{
  return ((c == 0) ? atsbool_true : atsbool_false) ;
} // end of [atspre_char_iseqz]
#define atspre_char0_iseqz(c) atspre_char_iseqz(c) 
#define atspre_char1_iseqz(c) atspre_char_iseqz(c) 

ATSinline()
atstype_bool
atspre_char_isneqz
  (atstype_char c)
{
  return ((c != 0) ? atsbool_true : atsbool_false) ;
} // end of [atspre_char_isneqz]
#define atspre_char0_isneqz(c) atspre_char_isneqz(c) 
#define atspre_char1_isneqz(c) atspre_char_isneqz(c) 

/* ****** ****** */

ATSinline()
atstype_char
atspre_add_char_int
  (atstype_char c1, atstype_int i2) { return (c1 + i2) ; }
// end of [atspre_add_char_int]
#define atspre_add_char0_int0 atspre_add_char_int

/* ****** ****** */

ATSinline()
atstype_int
atspre_sub_char_char
  (atstype_char c1, atstype_char c2) { return (c1 - c2) ; }
// end of [sub_char0_char0]
#define atspre_sub_char0_char0 atspre_sub_char_char

/* ****** ****** */

ATSinline()
atstype_bool
atspre_lt_int_int
  (atstype_int i1, atstype_int i2) {
  return (i1 < i2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_lt_int_int]
#define atspre_lt_char0_char0 atspre_lt_int_int
#define atspre_lt_char1_char1 atspre_lt_int_int

ATSinline()
atstype_bool
atspre_lte_int_int
  (atstype_int i1, atstype_int i2) {
  return (i1 <= i2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_lte_int_int]
#define atspre_lte_char0_char0 atspre_lte_int_int
#define atspre_lte_char1_char1 atspre_lte_int_int

ATSinline()
atstype_bool
atspre_gt_int_int
  (atstype_int i1, atstype_int i2) {
  return (i1 > i2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_gt_int_int]
#define atspre_gt_char0_char0 atspre_gt_int_int
#define atspre_gt_char1_char1 atspre_gt_int_int

ATSinline()
atstype_bool
atspre_gte_int_int
  (atstype_int i1, atstype_int i2) {
  return (i1 >= i2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_gte_int_int]
#define atspre_gte_char0_char0 atspre_gte_int_int
#define atspre_gte_char1_char1 atspre_gte_int_int

ATSinline()
atstype_bool
atspre_eq_int_int
  (atstype_int i1, atstype_int i2) {
  return (i1 == i2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_eq_int_int]
#define atspre_eq_char0_char0 atspre_eq_int_int
#define atspre_eq_char1_char1 atspre_eq_int_int

ATSinline()
atstype_bool
atspre_neq_int_int
  (atstype_int i1, atstype_int i2) {
  return (i1 != i2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_neq_int_int]
#define atspre_neq_char0_char0 atspre_neq_int_int
#define atspre_neq_char1_char1 atspre_neq_int_int


/* ****** ****** */

ATSinline()
atstype_int
atspre_compare_int_int
  (atstype_int i1, atstype_int i2)
{
  return (i1 - i2) ;
} // end of [atspre_compare_int_int]
#define atspre_compare_char0_char0(c1, c2) atspre_compare_int_int(c1, c2)
#define atspre_compare_char1_char1(c1, c2) atspre_compare_int_int(c1, c2)

/* ****** ****** */

#define atspre_eq_char0_int0(c, i) atspre_eq_int_int(c, i)
#define atspre_eq_int0_char0(i, c) atspre_eq_int_int(i, c)
#define atspre_neq_char0_int0(c, i) atspre_neq_int_int(c, i)
#define atspre_neq_int0_char0(i, c) atspre_neq_int_int(i, c)

/* ****** ****** */

#define atspre_compare_char0_int0(c, i) atspre_compare_int_int(c, i)
#define atspre_compare_int0_char0(i, c) atspre_compare_int_int(i, c)

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
#define atspre_lt_uchar0_uchar0 atspre_lt_uchar_uchar
#define atspre_lt_uchar1_uchar1 atspre_lt_uchar_uchar

ATSinline()
atstype_bool
atspre_lte_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 <= c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_lte_uchar_uchar]
#define atspre_lte_uchar0_uchar0 atspre_lte_uchar_uchar
#define atspre_lte_uchar1_uchar1 atspre_lte_uchar_uchar

ATSinline()
atstype_bool
atspre_gt_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 > c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_gt_uchar_uchar]
#define atspre_gt_uchar0_uchar0 atspre_gt_uchar_uchar
#define atspre_gt_uchar1_uchar1 atspre_gt_uchar_uchar

ATSinline()
atstype_bool
atspre_gte_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 >= c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_gte_uchar_uchar]
#define atspre_gte_uchar0_uchar0 atspre_gte_uchar_uchar
#define atspre_gte_uchar1_uchar1 atspre_gte_uchar_uchar

ATSinline()
atstype_bool
atspre_eq_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 == c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_eq_uchar_uchar]
#define atspre_eq_uchar0_uchar0 atspre_eq_uchar_uchar
#define atspre_eq_uchar1_uchar1 atspre_eq_uchar_uchar

ATSinline()
atstype_bool
atspre_neq_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return (c1 != c2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_neq_uchar_uchar]
#define atspre_neq_uchar0_uchar0 atspre_neq_uchar_uchar
#define atspre_neq_uchar1_uchar1 atspre_neq_uchar_uchar


ATSinline()
atstype_int
atspre_compare_uchar_uchar
  (atstype_uchar c1, atstype_uchar c2) {
  return ((atstype_int)c1 - (atstype_int)c2) ;
} // end of [atspre_compare_uchar_uchar]
#define atspre_compare_uchar0_uchar0 atspre_compare_uchar_uchar
#define atspre_compare_uchar1_uchar1 atspre_compare_uchar_uchar

/* ****** ****** */

ATSinline()
atstype_char
atspre_int2digit
  (atstype_int i) { return ('0' + i) ; }
// end of [atspre_int2digit]
ATSinline()
atstype_char
atspre_int2xdigit
  (atstype_int i) {
  return (i < 10) ? ('0' + i) : ('a' + (i - 10)) ;
} // end of [atspre_int2xdigit]
ATSinline()
atstype_char
atspre_int2xxdigit
  (atstype_int i) {
  return (i < 10) ? ('0' + i) : ('A' + (i - 10)) ;
} // end of [atspre_int2xxdigit]

/* ****** ****** */

#endif // ifndef(ATS2CPP_PRELUDE_CATS_CHAR)

/* ****** ****** */

/* end of [char.cats] */
