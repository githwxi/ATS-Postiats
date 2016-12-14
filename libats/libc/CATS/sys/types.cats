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
(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: March, 2013 *)
*/

/* ****** ****** */

#ifndef \
ATSLIB_LIBATS_LIBC_CATS_SYS_TYPES
#define \
ATSLIB_LIBATS_LIBC_CATS_SYS_TYPES

/* ****** ****** */

#include <sys/types.h>

/* ****** ****** */

typedef mode_t atslib_libats_libc_mode_type ;

/* ****** ****** */
//
// HX-2013-8:
// [atslib_libats_libc_time_type] is already
// defined in [libats/libc/CATS/time.cats]
//
typedef time_t atslib_libats_libc_types_time_type ;
//
/* ****** ****** */

#if(0)
//
// HX-2013-05: where are they?
// HX-2013-06: they are declared in [time.h]
//
typedef clock_t atslib_libats_libc_clock_type ;
typedef clockid_t atslib_libats_libc_clockid_type ;
#endif

/* ****** ****** */

typedef ino_t atslib_libats_libc_ino_type ;
typedef off_t atslib_libats_libc_off_type ;

/* ****** ****** */

typedef pid_t atslib_libats_libc_pid_type ;
typedef uid_t atslib_libats_libc_uid_type ;
typedef gid_t atslib_libats_libc_gid_type ;

/* ****** ****** */

ATSinline()
atslib_libats_libc_mode_type
atslib_libats_libc_lor_mode_mode
(
  atslib_libats_libc_mode_type m1
, atslib_libats_libc_mode_type m2
) {
  return (m1 | m2) ;
} // end of [atslib_libats_libc_lor_mode_mode]

ATSinline()
atslib_libats_libc_mode_type
atslib_libats_libc_land_mode_mode
(
  atslib_libats_libc_mode_type m1
, atslib_libats_libc_mode_type m2
) {
  return (m1 & m2) ;
} // end of [atslib_libats_libc_land_mode_mode]

/* ****** ****** */

ATSinline()
atstype_bool
atslib_libats_libc_lt_time_time
(
  atslib_libats_libc_types_time_type t1
, atslib_libats_libc_types_time_type t2
)
{
  return \
  (t1 < t2 ? atsbool_true : atsbool_false) ;
} // end of [atslib_libats_libc_lt_time_time]
ATSinline()
atstype_bool
atslib_libats_libc_lte_time_time
(
  atslib_libats_libc_types_time_type t1
, atslib_libats_libc_types_time_type t2
)
{
  return \
  (t1 <= t2 ? atsbool_true : atsbool_false) ;
} // end of [atslib_libats_libc_lte_time_time]

/* ****** ****** */

#define \
atslib_libats_libc_gt_time_time(t1, t2) \
  atslib_libats_libc_lt_time_time(t2, t1)
#define \
atslib_libats_libc_gte_time_time(t1, t2) \
  atslib_libats_libc_lte_time_time(t2, t1)

/* ****** ****** */

ATSinline()
atstype_bool
atslib_libats_libc_eq_time_time
(
  atslib_libats_libc_types_time_type t1
, atslib_libats_libc_types_time_type t2
)
{
  return (t1 == t2 ? atsbool_true : atsbool_false) ;
} // end of [atslib_libats_libc_eq_time_time]
ATSinline()
atstype_bool
atslib_libats_libc_neq_time_time
(
  atslib_libats_libc_types_time_type t1
, atslib_libats_libc_types_time_type t2
)
{
  return (t1 != t2 ? atsbool_true : atsbool_false) ;
} // end of [atslib_libats_libc_neq_time_time]

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_SYS_TYPES

/* ****** ****** */

/* end of [types.cats] */
