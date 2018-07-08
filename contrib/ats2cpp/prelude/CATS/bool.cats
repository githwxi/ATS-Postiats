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
** $PATSHOME/prelude/CATS/CODEGEN/bool.atxt
** Time of generation: Fri Feb 28 17:55:34 2014
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: February, 2012 *)
*/

/* ****** ****** */

#ifndef ATS2CPP_PRELUDE_CATS_BOOL
#define ATS2CPP_PRELUDE_CATS_BOOL

/* ****** ****** */

ATSinline()
atstype_bool
atspre_int2bool (atstype_int x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
}
#define atspre_int2bool0 atspre_int2bool
#define atspre_int2bool1 atspre_int2bool

/* ****** ****** */

#define atspre_bool2int0(x) x
#define atspre_bool2int1(x) x

/* ****** ****** */

ATSinline()
atstype_bool
atspre_neg_bool
  (atstype_bool b) {
  return (b) ? atsbool_false : atsbool_true ;
} // end of [atspre_neg_bool]
#define atspre_neg_bool0 atspre_neg_bool
#define atspre_neg_bool1 atspre_neg_bool

ATSinline()
atstype_bool
atspre_add_bool_bool (
  atstype_bool b1, atstype_bool b2
) {
  return (b1) ? atsbool_true : (b2) ;
} // end of [atspre_add_bool_bool]
#define atspre_add_bool0_bool0 atspre_add_bool_bool
#define atspre_add_bool1_bool1 atspre_add_bool_bool

ATSinline()
atstype_bool
atspre_mul_bool_bool (
  atstype_bool b1, atstype_bool b2
) {
  return (b1) ? (b2) : atsbool_false ;
} // end of [atspre_mul_bool_bool]
#define atspre_mul_bool0_bool0 atspre_mul_bool_bool
#define atspre_mul_bool1_bool1 atspre_mul_bool_bool

/* ****** ****** */

ATSinline()
atstype_bool
atspre_xor_bool_bool (
  atstype_bool b1, atstype_bool b2
) {
  return (b1) ? (!b2) : (b2) ;
} // end of [atspre_xor_bool_bool]
#define atspre_xor_bool0_bool0 atspre_xor_bool_bool
#define atspre_xor_bool1_bool1 atspre_xor_bool_bool

/* ****** ****** */

ATSinline()
atstype_bool
atspre_lt_bool_bool (
  atstype_bool b1, atstype_bool b2
) {
  return (b1) ? atsbool_false : (b2) ;
} // end of [atspre_lt_bool_bool]
#define atspre_lt_bool0_bool0 atspre_lt_bool_bool
#define atspre_lt_bool1_bool1 atspre_lt_bool_bool
ATSinline()
atstype_bool
atspre_lte_bool_bool (
  atstype_bool b1, atstype_bool b2
) {
  return (b1) ? (b2) : atsbool_true ;
} // end of [atspre_lte_bool_bool]
#define atspre_lte_bool0_bool0 atspre_lte_bool_bool
#define atspre_lte_bool1_bool1 atspre_lte_bool_bool

ATSinline()
atstype_bool
atspre_gt_bool_bool (
  atstype_bool b1, atstype_bool b2
) {
  return (b2) ? atsbool_false : (b1) ;
} // end of [atspre_gt_bool_bool]
#define atspre_gt_bool0_bool0 atspre_gt_bool_bool
#define atspre_gt_bool1_bool1 atspre_gt_bool_bool
ATSinline()
atstype_bool
atspre_gte_bool_bool (
  atstype_bool b1, atstype_bool b2
) {
  return (b2) ? (b1) : atsbool_true ;
} // end of [atspre_gte_bool_bool]
#define atspre_gte_bool0_bool0 atspre_gte_bool_bool
#define atspre_gte_bool1_bool1 atspre_gte_bool_bool

ATSinline()
atstype_bool
atspre_eq_bool_bool (
  atstype_bool b1, atstype_bool b2
) {
  return (b1 == b2) ;
} // end of [atspre_eq_bool_bool]
#define atspre_eq_bool0_bool0 atspre_eq_bool_bool
#define atspre_eq_bool1_bool1 atspre_eq_bool_bool
ATSinline()
atstype_bool
atspre_neq_bool_bool (
  atstype_bool b1, atstype_bool b2
) {
  return (b1 != b2) ;
} // end of [atspre_neq_bool_bool]
#define atspre_neq_bool0_bool0 atspre_neq_bool_bool
#define atspre_neq_bool1_bool1 atspre_neq_bool_bool

/* ****** ****** */

ATSinline()
atstype_int
atspre_compare_bool_bool (
  atstype_bool b1, atstype_bool b2
) {
  return (b1 - b2) ;
} // end of [atspre_compare_bool_bool]
#define atspre_compare_bool0_bool0 atspre_compare_bool_bool
#define atspre_compare_bool1_bool1 atspre_compare_bool_bool

/* ****** ****** */

ATSinline()
atstype_string
atspre_bool2string (
  atstype_bool x
) {
  return (x) ? "true" : "false" ;
} // end of [atspre_bool2string]

ATSinline()
atstype_string
atspre_tostring_bool (
  atstype_bool x
) {
  return (x) ? "true" : "false" ;
} // end of [atspre_tostring_bool]

/* ****** ****** */

#endif // ifndef(ATS2CPP_PRELUDE_CATS_BOOL)

/* ****** ****** */

/* end of [bool.cats] */
