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

#ifndef ATS_LIBC_UNISTD_CATS
#define ATS_LIBC_UNISTD_CATS

/* ****** ****** */

#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h> // for [wait]
#include <unistd.h>

/* ****** ****** */

#include "libc/sys/CATS/types.cats" // for [pid_t]

/* ****** ****** */
//
// HX: implemented in [prelude/DATS/basics.dats]
//
extern ats_void_type
ats_exit_errmsg(ats_int_type n, ats_ptr_type msg) ;

/* ****** ****** */

#define atslib_dup dup
#define atslib_dup2 dup2

/* ****** ****** */

#define atslib__exit _exit // equivalent to _Exit in stdlib

/* ****** ****** */

ATSinline()
ats_ptr_type
atslib_strarr_get (
  ats_ptr_type A, ats_size_type i
) {
 return ((char**)A)[i] ;
} // end of [atslib_strarr_get]

/* ****** ****** */

#define atslib_execv execv
#define atslib_execvp execvp

#define atslib_execl execl // HX: no interface in ATS
#define atslib_execlp execlp // HX: no interface in ATS

/* ****** ****** */

#define atslib_fork_err fork

/* ****** ****** */

#define atslib_getcwd getcwd

/* ****** ****** */

#define atslib_alarm_set alarm
#define atslib_alarm_cancel() alarm(0U)

/* ****** ****** */

#define atslib_sleep sleep
#define atslib_usleep usleep

/* ****** ****** */

#define atslib_getpagesize getpagesize

/* ****** ****** */

#define atslib_getuid getuid
#define atslib_geteuid geteuid

#define atslib_getgid getgid
#define atslib_getegid getegid

/* ****** ****** */

#define atslib_getpid getpid
#define atslib_getppid getppid

#define atslib_setsid setsid
#define atslib_getsid getsid

#define atslib_setpgid setpgid
#define atslib_getpgid getpgid

/* ****** ****** */

#define atslib_getlogin getlogin
#define atslib_getlogin_r getlogin_r

/* ****** ****** */

#define atslib_access access

/* ****** ****** */

#define atslib_chroot chroot

/* ****** ****** */

#define atslib_chdir chdir
#define atslib_fchdir fchdir

/* ****** ****** */

#define atslib_nice nice

/* ****** ****** */

#define atslib_rmdir rmdir

/* ****** ****** */

#define atslib_link link
#define atslib_unlink unlink

/* ****** ****** */

#define atslib_fildes_lseek_err lseek

ATSinline()
ats_off_type
atslib_fildes_lseek_exn (
  ats_int_type fd
, ats_off_type ofs
, ats_int_type whence
) {
  off_t ofs_new ;
  ofs_new = lseek(fd, ofs, whence) ;
  if (ofs_new == (ats_off_type)(-1)) {
    perror ("lseek") ;
    ats_exit_errmsg (1, "exit(ATS): [lseek] failed\n") ;
  }
  return ofs_new ;
} /* end of [atslib_fildes_lseek_exn] */

/* ****** ****** */

#define atslib_fildes_pread pread
#define atslib_fildes_pwrite pwrite

/* ****** ****** */

#define atslib_sync sync
#define atslib_fsync fsync
#define atslib_fdatasync fdatasync

/* ****** ****** */

#define atslib_pathconf pathconf
#define atslib_fpathconf fpathconf

/* ****** ****** */

#define atslib_readlink readlink

/* ****** ****** */

#define atslib_tcsetpgrp tcsetpgrp
#define atslib_tcgetpgrp tcgetpgrp

/* ****** ****** */

#define atslib_ttyname ttyname
#define atslib_ttyname_r ttyname_r

#define atslib_isatty isatty

/* ****** ****** */

ATSinline()
ats_int_type
atslib_gethostname (
  ats_ptr_type bufp, ats_size_type len
) {
  int rtn ;
  rtn = gethostname((char*)bufp, len) ;
  if (rtn == 0) ((char*)bufp)[len] = '\0' ; // HX: force it to be null terminated!
  return rtn ;
} // end of [atslib_gethostname]

#define atslib_sethostname sethostname

/* ****** ****** */

ATSinline()
ats_int_type
atslib_getdomainname (
  ats_ptr_type bufp, ats_size_type len
) {
  int rtn ;
  rtn = getdomainname((char*)bufp, len) ;
  if (rtn == 0) ((char*)bufp)[len] = '\0' ; // HX: force it to be null terminated!
  return rtn ;
} // end of [atslib_getdomainname]

#define atslib_setdomainname setdomainname

/* ****** ****** */

#define atslib_pause pause

/* ****** ****** */

#endif /* ATS_LIBC_UNISTD_CATS */

/* end of [unistd.cats] */
