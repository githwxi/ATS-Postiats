/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
** $PATSHOME/libc/sys/CATS/CODEGEN/types.atxt
** Time of generation: Wed Jun  1 19:08:17 2016
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: March, 2013 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBC_SYS_CATS_TYPES
#define ATSLIB_LIBC_SYS_CATS_TYPES

/* ****** ****** */

#include <sys/types.h>

/* ****** ****** */

typedef mode_t atslib_mode_type ;

/* ****** ****** */
//
// HX-2013-8:
// [atslib_time_type] is already
// defined in [libc/CATS/time.cats]
//
typedef time_t atslib_types_time_type ;
//
/* ****** ****** */

#if(0)
//
// HX-2013-05: where are they?
// HX-2013-06: they are declared in [time.h]
//
typedef clock_t atslib_clock_type ;
typedef clockid_t atslib_clockid_type ;
#endif

/* ****** ****** */

typedef ino_t atslib_ino_type ;
typedef off_t atslib_off_type ;

/* ****** ****** */

typedef pid_t atslib_pid_type ;
typedef uid_t atslib_uid_type ;
typedef gid_t atslib_gid_type ;

/* ****** ****** */

ATSinline()
atstype_bool
atslib_eq_mode_mode
(
  atslib_mode_type m1
, atslib_mode_type m2
) {
  return (m1 == m2 ? atsbool_true : atsbool_false) ;
} // end of [atslib_eq_mode_mode]

ATSinline()
atstype_bool
atslib_neq_mode_mode
(
  atslib_mode_type m1
, atslib_mode_type m2
) {
  return (m1 != m2 ? atsbool_true : atsbool_false) ;
} // end of [atslib_neq_mode_mode]

/* ****** ****** */

ATSinline()
atslib_mode_type
atslib_lor_mode_mode
(
  atslib_mode_type m1
, atslib_mode_type m2
) {
  return (m1 | m2) ;
} // end of [atslib_lor_mode_mode]

ATSinline()
atslib_mode_type
atslib_land_mode_mode
(
  atslib_mode_type m1
, atslib_mode_type m2
) {
  return (m1 & m2) ;
} // end of [atslib_land_mode_mode]

/* ****** ****** */

ATSinline()
atstype_bool
atslib_lt_time_time
(
  atslib_types_time_type t1
, atslib_types_time_type t2
)
{
  return (t1 < t2 ? atsbool_true : atsbool_false) ;
} // end of [atslib_lt_time_time]
ATSinline()
atstype_bool
atslib_lte_time_time
(
  atslib_types_time_type t1
, atslib_types_time_type t2
)
{
  return (t1 <= t2 ? atsbool_true : atsbool_false) ;
} // end of [atslib_lte_time_time]

#define \
atslib_gt_time_time(t1, t2) atslib_lt_time_time(t2, t1)
#define \
atslib_gte_time_time(t1, t2) atslib_lte_time_time(t2, t1)

/* ****** ****** */

  ATSinline()
atstype_bool
atslib_eq_time_time
(
  atslib_types_time_type t1
, atslib_types_time_type t2
)
{
  return (t1 == t2 ? atsbool_true : atsbool_false) ;
} // end of [atslib_eq_time_time]
ATSinline()
atstype_bool
atslib_neq_time_time
(
  atslib_types_time_type t1
, atslib_types_time_type t2
)
{
  return (t1 != t2 ? atsbool_true : atsbool_false) ;
} // end of [atslib_neq_time_time]

/* ****** ****** */

#endif // ifndef ATSLIB_LIBC_SYS_CATS_TYPES

/* ****** ****** */

/* end of [types.cats] */
