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
ATS2CPP_LIBATS_LIBC_CATS_SYS_STAT
#define \
ATS2CPP_LIBATS_LIBC_CATS_SYS_STAT

/* ****** ****** */

#include <sys/stat.h>

/* ****** ****** */

typedef
struct stat
atslib_libats_libc_stat_struct ;

/* ****** ****** */

#define atslib_libats_libc_umask umask

/* ****** ****** */

#define atslib_libats_libc_chmod chmod

/* ****** ****** */

#define atslib_libats_libc_mkdir mkdir
#define atslib_libats_libc_mkdirat mkdirat

/* ****** ****** */

#define atslib_libats_libc_mkfifo mkfifo

/* ****** ****** */

#define atslib_libats_libc_stat stat
#define atslib_libats_libc_fstat fstat
#define atslib_libats_libc_lstat lstat

/* ****** ****** */

#endif // ifndef(ATS2CPP_LIBATS_LIBC_CATS_SYS_STAT)

/* ****** ****** */

/* end of [stat.cats] */
