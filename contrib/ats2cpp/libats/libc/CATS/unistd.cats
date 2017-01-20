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
(* Start time: April, 2012 *)
*/

/* ****** ****** */

#ifndef ATS2CPP_LIBATS_LIBC_CATS_UNISTD
#define ATS2CPP_LIBATS_LIBC_CATS_UNISTD

/* ****** ****** */

#include <unistd.h>

/* ****** ****** */

#define atslib_libats_libc_close close
#define atslib_libats_libc_close0 atslib_libats_libc_close
#define atslib_libats_libc_close1 atslib_libats_libc_close
#define atslib_libats_libc_close0_exn atslib_libats_libc_close_exn
#define atslib_libats_libc_close1_exn atslib_libats_libc_close_exn

/* ****** ****** */

#define atslib_libats_libc_dup dup
#define atslib_libats_libc_dup_fildes dup
#define atslib_libats_libc_dup2 dup2
#define atslib_libats_libc_dup3 dup3

/* ****** ****** */

#define atslib_libats_libc_execv(path, argv) execv((char*)path, (char**)argv)
#define atslib_libats_libc_execvp(path, argv) execvp((char*)path, (char**)argv)

/* ****** ****** */

#define atslib_libats_libc_encrypt encrypt

/* ****** ****** */

#define atslib_libats_libc_fork fork

/* ****** ****** */

#define atslib_libats_libc_getcwd getcwd

/* ****** ****** */

#define atslib_libats_libc_getlogin getlogin
#define atslib_libats_libc_getlogin_r getlogin_r

/* ****** ****** */

#define atslib_libats_libc_getpid getpid
#define atslib_libats_libc_getppid getppid

/* ****** ****** */

#define atslib_libats_libc_getuid getuid
#define atslib_libats_libc_setuid setuid
#define atslib_libats_libc_geteuid geteuid
#define atslib_libats_libc_seteuid seteuid

/* ****** ****** */

#define atslib_libats_libc_getgid getgid
#define atslib_libats_libc_setgid setgid
#define atslib_libats_libc_getegid getegid
#define atslib_libats_libc_setegid setegid

/* ****** ****** */

#define atslib_libats_libc_setreuid setreuid
#define atslib_libats_libc_setregid setregid
#define atslib_libats_libc_setresuid setresuid
#define atslib_libats_libc_setresgid setresgid

/* ****** ****** */

#define atslib_libats_libc_setfsuid setfsuid
#define atslib_libats_libc_setfsgid setfsgid

/* ****** ****** */

#define atslib_libats_libc_pause pause

/* ****** ****** */

#define atslib_libats_libc_read_err read
#define atslib_libats_libc_write_err write

/* ****** ****** */

#define atslib_libats_libc_pread pread
#define atslib_libats_libc_pwrite pwrite

/* ****** ****** */

#define atslib_libats_libc_alarm alarm
#define atslib_libats_libc_alarm_set alarm
#define atslib_libats_libc_alarm_cancel() alarm(0)

/* ****** ****** */

#define atslib_libats_libc_sleep_int sleep
#define atslib_libats_libc_sleep_uint sleep

/* ****** ****** */

#define atslib_libats_libc_usleep_int usleep
#define atslib_libats_libc_usleep_uint usleep

/* ****** ****** */

#define atslib_libats_libc_rmdir rmdir

/* ****** ****** */

#define atslib_libats_libc_link link
#define atslib_libats_libc_unlink unlink

/* ****** ****** */

#define atslib_libats_libc_symlink symlink
#define atslib_libats_libc_readlink readlink

/* ****** ****** */

#define atslib_libats_libc_sync sync
#define atslib_libats_libc_fsync fsync
#define atslib_libats_libc_fdatasync fdatasync

/* ****** ****** */

#define atslib_libats_libc_truncate truncate
#define atslib_libats_libc_ftruncate ftruncate

/* ****** ****** */

#endif // ifndef(ATS2CPP_LIBATS_LIBC_CATS_UNISTD)

/* ****** ****** */

/* end of [unistd.cats] */
