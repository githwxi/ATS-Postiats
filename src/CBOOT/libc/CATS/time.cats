/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2010 Hongwei Xi, ATS Trustful Software, Inc.
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

#ifndef ATS_LIBC_TIME_CATS
#define ATS_LIBC_TIME_CATS

/* ****** ****** */

#include <time.h>

/* ****** ****** */

#include "libc/sys/CATS/types.cats"

/* ****** ****** */

typedef struct tm ats_tm_struct_type ;
typedef struct timespec ats_timespec_type ;
typedef struct itimerspec ats_itimerspec_type ;

/* ****** ****** */

#define atslib_difftime difftime

/* ****** ****** */

ATSinline()
ats_int_type
atslib_tm_get_sec
  (ats_ptr_type tm) {
  return ((struct tm*)tm)->tm_sec ;
} // end of [atslib_tm_get_sec]

ATSinline()
ats_int_type
atslib_tm_get_min
  (ats_ptr_type tm) {
  return ((struct tm*)tm)->tm_min ;
} // end of [atslib_tm_get_min]

ATSinline()
ats_int_type
atslib_tm_get_hour
  (ats_ptr_type tm) {
  return ((struct tm*)tm)->tm_hour ;
} // end of [atslib_tm_get_hour]

ATSinline()
ats_int_type
atslib_tm_get_mday
  (ats_ptr_type tm) {
  return ((struct tm*)tm)->tm_mday ;
} // end of [atslib_tm_get_mday]

ATSinline()
ats_int_type
atslib_tm_get_mon
  (ats_ptr_type tm) {
  return ((struct tm*)tm)->tm_mon ;
} // end of [atslib_tm_get_mon]

ATSinline()
ats_int_type
atslib_tm_get_year
  (ats_ptr_type tm) {
  return ((struct tm*)tm)->tm_year ;
} // end of [atslib_tm_get_year]

ATSinline()
ats_int_type
atslib_tm_get_wday
  (ats_ptr_type tm) {
  return ((struct tm*)tm)->tm_wday ;
} // end of [atslib_tm_get_wday]

ATSinline()
ats_int_type
atslib_tm_get_yday
  (ats_ptr_type tm) {
  return ((struct tm*)tm)->tm_yday ;
} // end of [atslib_tm_get_yday]

ATSinline()
ats_int_type
atslib_tm_get_isdst
  (ats_ptr_type tm) {
  return ((struct tm*)tm)->tm_isdst ;
} // end of [atslib_tm_get_isdst]

//

/* ****** ****** */

ATSinline()
ats_time_type
atslib_time_get () { return time((time_t*)0) ; }

ATSinline()
ats_int_type
atslib_time_get_and_set
  (ats_ref_type p) {
  time_t err = time((time_t*)p) ;
  return (err > 0) ? ats_true_bool : ats_false_bool ;
} // end of [atslib_time_get_and_set]

/* ****** ****** */

#define atslib_ctime ctime
#define atslib_ctime_r ctime_r

/* ****** ****** */

#define atslib_localtime localtime
#define atslib_localtime_r localtime_r

#define atslib_gmtime gmtime
#define atslib_gmtime_r gmtime_r

/* ****** ****** */

#define atslib_mktime mktime

/* ****** ****** */

#define atslib_asctime asctime
#define atslib_strftime strftime

/* ****** ****** */

extern int getdate_err ;

ATSinline()
ats_int_type
atslib_getdate_err_get() { return getdate_err ;}
//
ATSinline()
ats_void_type
atslib_getdate_err_set(ats_int_type n) { getdate_err = n ; return ; }
//
#define atslib_getdate getdate

#define atslib_strptime strptime

/* ****** ****** */

#define atslib_tzset tzset

/* ****** ****** */

#define atslib_clock clock

/* ****** ****** */

#define atslib_nanosleep nanosleep
#define atslib_nanosleep_null(ts) nanosleep_null(ts, NULL)

/* ****** ****** */

#define atslib_clock_gettime clock_gettime
#define atslib_clock_getres clock_getres
#define atslib_clock_settime clock_settime

/* ****** ****** */

#define atslib_timer_create timer_create
#define atslib_timer_create_null(cid, p_tid) timer_create(cid, NULL, p_tid)
#define atslib_timer_delete timer_delete
#define atslib_timer_gettime timer_gettime
#define atslib_timer_settime timer_settime
#define atslib_timer_getoverrun timer_getoverrun

/* ****** ****** */

#endif /* ATS_LIBC_TIME_CATS */

/* end of [time.cats] */
