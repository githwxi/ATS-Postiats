/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2008 Hongwei Xi, ATS Trustful Software, Inc.
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

/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATS_LIBC_SYS_TYPES_CATS
#define ATS_LIBC_SYS_TYPES_CATS

/* ****** ****** */

#include <time.h>
#include <sys/types.h>

/* ****** ****** */
//
// typedef blksize_t ats_blksize_type ; // I/O block size
//
typedef blkcnt_t ats_blkcnt_type ; // number of blocks allowed

/* ****** ****** */
//
// HX: it should be defined in [sys/types.h] but it is actually in [time.h]
//
typedef clock_t ats_clock_type ; // for CLOCKS_PER_SEC

ATSinline()
ats_lint_type atslib_lint_of_clock (clock_t t) { return t ; }
ATSinline()
ats_double_type atslib_double_of_clock (clock_t t) { return t ; }

/* ****** ****** */

// HX: not supported on Mac OSX ?
// typedef clockid_t ats_clockid_type ; // for clock ID type

/* ****** ****** */

typedef dev_t ats_dev_type ; // for device IDs

ATSinline()
ats_bool_type
atslib_eq_dev_dev
  (dev_t x1, dev_t x2) {
  return (x1 == x2 ? ats_true_bool : ats_false_bool) ;
} // end of [atslib_eq_dev_dev]

/* ****** ****** */

typedef fsblkcnt_t ats_fsblkcnt_type ; // file system block counts

typedef fsfilcnt_t ats_fsfilcnt_type ; // file system file counts

typedef gid_t ats_gid_type ; // for group IDs

/* ****** ****** */

typedef ino_t ats_ino_type ; // for file serial numbers

ATSinline()
ats_bool_type
atslib_eq_ino_ino
  (ino_t x1, ino_t x2) {
  return (x1 == x2 ? ats_true_bool : ats_false_bool) ;
} // end of [atslib_eq_ino_ino]

/* ****** ****** */

typedef key_t ats_key_type ; // for XSI interprocess communication

/* ****** ****** */

typedef mode_t ats_mode_type ; // file mode

ATSinline()
ats_bool_type
atslib_eq_mode_mode
  (ats_mode_type m1, ats_mode_type m2) {
  return (m1 == m2 ? ats_true_bool : ats_false_bool) ;
} // end of [atslib_eq_mode_mode]

ATSinline()
ats_bool_type
atslib_neq_mode_mode
  (ats_mode_type m1, ats_mode_type m2) {
  return (m1 != m2 ? ats_true_bool : ats_false_bool) ;
} // end of [atslib_neq_mode_mode]

ATSinline()
ats_mode_type
atslib_lor_mode_mode
  (ats_mode_type m1, ats_mode_type m2) {
  return (m1 | m2) ;
} // end of [atslib_lor_mode_mode]

ATSinline()
ats_mode_type
atslib_land_mode_mode
  (ats_mode_type m1, ats_mode_type m2) {
  return (m1 & m2) ;
} // end of [atslib_land_mode_mode]

/* ****** ****** */

typedef nlink_t ats_nlink_type ; // number of hard links to a file

/* ****** ****** */

typedef off_t ats_off_type ; // file size in bytes

#if (0)
//
// HX: these are now cast functions
//
ATSinline()
ats_lint_type
atslib_lint_of_off (ats_off_type off) { return off ; }
ATSinline()
ats_off_type
atslib_off_of_lint (ats_lint_type li) { return li ; }
#endif // end of [if(0)]

/* ****** ****** */

typedef pid_t ats_pid_type ; // for process IDs // signed integer type

#if (0)
//
// HX: these are now cast functions
//
ATSinline()
ats_pid_type
atslib_pid_of_int (ats_int_type i) { return (i) ; }
ATSinline()
ats_int_type
atslib_int_of_pid (ats_pid_type p) { return (p) ; }
ATSinline()
ats_lint_type
atslib_lint_of_pid (ats_pid_type p) { return (p) ; }
#endif // end of [if(0)]

/* ****** ****** */
//
// HX: already defined in [ats_types.h]
// typedef size_t ats_size_type ; // for sizes of objects
// typedef ssize_t ats_ssize_type ; // for sizes or error indication
//
/* ****** ****** */

typedef time_t ats_time_type ; // for time in seconds

ATSinline()
ats_lint_type atslib_lint_of_time (time_t t) { return t ; }
ATSinline()
ats_double_type atslib_double_of_time (time_t t) { return t ; }

/* ****** ****** */
//
// HX: where is [timer_t] declared?
// typedef timer_t ats_timer_type ; // for timers returned by timer_create ()
//
#ifdef _XOPEN_SOURCE // for POSIX and XPG things
typedef useconds_t ats_useconds_type ; // for time in microseconds
typedef suseconds_t ats_suseconds_type ; // for signed time in microseconds
#endif // end of [_XOPEN_SOURCE]

/* ****** ****** */

typedef uid_t ats_uid_type ;

#if (0)
//
// HX: these are now cast functions
//
ATSinline()
ats_int_type
atslib_int_of_uid (ats_uid_type u) { return u ; }
ATSinline()
ats_uid_type
atslib_uid_of_int (ats_int_type i) { return i ; }
#endif // end of [if(0)]

/* ****** ****** */

#endif /* end of [ATS_LIBC_SYS_TYPES_CATS] */

/* end of [types.cats] */
