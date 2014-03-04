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

#ifndef ATS_LIBC_SYS_STAT_CATS
#define ATS_LIBC_SYS_STAT_CATS

/* ****** ****** */

#include <sys/stat.h>
#include "libc/sys/CATS/types.cats"
typedef struct stat ats_stat_type ;

/* ****** ****** */

extern
void perror (const char *msg) ; // declared in [stdio.h]

//
// HX: implemented in [prelude/DATS/basics.dats]
//
extern
ats_void_type
ats_exit_errmsg(ats_int_type n, ats_ptr_type msg) ;

/* ****** ****** */

ATSinline()
ats_bool_type
atslib_S_ISBLK (ats_mode_type m) { return S_ISBLK(m) ; }

ATSinline()
ats_bool_type
atslib_S_ISCHR (ats_mode_type m) { return S_ISCHR(m) ; }

ATSinline()
ats_bool_type
atslib_S_ISDIR (ats_mode_type m) { return S_ISDIR(m) ; }

ATSinline()
ats_bool_type
atslib_S_ISFIFO (ats_mode_type m) { return S_ISFIFO(m) ; }

ATSinline()
ats_bool_type
atslib_S_ISREG (ats_mode_type m) { return S_ISREG(m) ; }

ATSinline()
ats_bool_type
atslib_S_ISLNK (ats_mode_type m) { return S_ISLNK(m) ; }

ATSinline()
ats_bool_type
atslib_S_ISSOCK (ats_mode_type m) { return S_ISSOCK(m) ; }

/* ****** ****** */

#define atslib_chmod_err chmod

/* ****** ****** */

#define atslib_mkdir_err mkdir

/* ****** ****** */

#define atslib_stat_err stat
#define atslib_fstat_err fstat
#define atslib_lstat_err lstat

/* ****** ****** */

#define atslib_umask umask

/* ****** ****** */

#define atslib_mkfifo mkfifo

/* ****** ****** */

#endif /* end of [ATS_LIBC_SYS_STAT_CATS] */

/* end of [stat.cats] */
