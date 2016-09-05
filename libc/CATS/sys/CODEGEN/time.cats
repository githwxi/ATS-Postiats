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
** $PATSHOME/libc/sys/CATS/CODEGEN/time.atxt
** Time of generation: Wed Jun  1 19:08:17 2016
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: August, 2013 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBC_SYS_CATS_TIME
#define ATSLIB_LIBC_SYS_CATS_TIME

/* ****** ****** */

#include <sys/time.h>

/* ****** ****** */

typedef struct timeval atslib_timeval_type ;
typedef struct timezone atslib_timezone_type ;

/* ****** ****** */

#define atslib_gettimeofday_tv(tv) gettimeofday(tv, NULL)
#define atslib_gettimeofday_tz(tz) gettimeofday(NULL, tz)

#define atslib_settimeofday_tv(tv) settimeofday(tv, NULL)
#define atslib_settimeofday_tz(tz) settimeofday(NULL, tz)
#define atslib_settimeofday_tvtz(tv, tz) settimeofday(tv, tz)

/* ****** ****** */

#define atslib_utimes utimes
#define atslib_futimes futimes
#define atslib_futimesat futimesat

/* ****** ****** */

typedef struct itimerval ats_itimerval_type ;

#define atslib_getitimer getitimer
#define atslib_setitimer setitimer
#define atslib_setitimer_null(which, itval) setitimer(which, itval, NULL)

/* ****** ****** */

#endif // ifndef ATSLIB_LIBC_SYS_CATS_TIME

/* ****** ****** */

/* end of [time.cats] */
