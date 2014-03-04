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

#ifndef ATS_LIBC_FCNTL_CATS
#define ATS_LIBC_FCNTL_CATS

/* ****** ****** */

#include <fcntl.h>
#include <stdio.h>

/* ****** ****** */

#include "libc/sys/CATS/types.cats"

/* ****** ****** */
//
// HX: functions declared in [unistd.h]
//
extern ssize_t read  (int fd, void *buf, size_t cnt) ;
extern ssize_t write  (int fd, const void *buf, size_t cnt) ;

/* ****** ****** */
//
// HX: implemented in [prelude/DATS/basics.dats]
//
extern ats_void_type
ats_exit_errmsg(ats_int_type n, ats_ptr_type msg) ;

/* ****** ****** */

typedef ats_int_type ats_fcntlflag_type ;

/* ****** ****** */

ATSinline()
ats_int_type
atslib_lnot_disjflag
  (ats_fcntlflag_type df) { return (~df) ; }
// end of [atslib_lnot_disjflag]

ATSinline()
ats_int_type
atslib_lor_flag_disjflag (
  ats_fcntlflag_type f, ats_fcntlflag_type df
) {
  return (f | df) ;
} // end of [atslib_lor_flag_disjflag]

ATSinline()
ats_int_type
atslib_land_flag_conjflag (
  ats_fcntlflag_type f, ats_fcntlflag_type cf
) {
  return (f & cf) ;
} // end of [atslib_land_flag_conjflag]

/* ****** ****** */

ATSinline()
ats_int_type
atslib_open_flag_err (
  ats_ptr_type path, ats_fcntlflag_type flag
) {
  return open((char*)path, flag) ;
} // end of [atslib_open_flag_err]

ATSinline()
ats_int_type
atslib_open_flag_mode_err (
  ats_ptr_type path
, ats_fcntlflag_type flag
, ats_mode_type mode
) {
  return open((char*)path, flag, mode) ;
} // end of [atslib_open_flag_mode_err]

/* ****** ****** */

ATSinline()
ats_int_type
atslib_open_flag_exn
  (ats_ptr_type path, ats_fcntlflag_type flag)
{
  int fd = open((char*)path, flag) ;
  if (fd < 0) {
    perror ("open") ;
    ats_exit_errmsg(1, "exit(ATS): [open_flag] failed.\n") ;
  } // end of [if]
  return fd ;
} // end of [atslib_open_flag_exn]

ATSinline()
ats_int_type
atslib_open_flag_mode_exn (
  ats_ptr_type path
, ats_fcntlflag_type flag
, ats_mode_type mode
) {
  int fd = open((char*)path, flag, mode) ;
  if (fd < 0) {
    perror ("open") ;
    ats_exit_errmsg(1, "exit(ATS): [open_flag_mode] failed.\n") ;
  } // end of [if]
  return fd ;
} // end of [atslib_open_flag_mode_exn]

/* ****** ****** */

ATSinline()
ats_int_type
atslib_close_err (ats_int_type fd) { return close(fd) ; }

/* ****** ****** */

ATSinline()
ats_ssize_type
atslib_fildes_read_err
  (ats_int_type fd, ats_ptr_type buf, ats_size_type cnt) {
  return read(fd, buf, cnt) ;
} // end of [atslib_fildes_read_err]

ATSinline()
ats_size_type
atslib_fildes_read_exn
  (ats_int_type fd, ats_ptr_type buf, ats_size_type cnt) {
  ats_ssize_type res ;
  res = read(fd, buf, cnt) ;
  if (res < 0) {
    perror("read") ; ats_exit_errmsg(1, "exit(ATS): [fildes_read] failed.\n") ;
  } // end of [if]
  return res ;
} // end of [atslib_fildes_read_exn]

/* ****** ****** */

ATSinline()
ats_ssize_type
atslib_fildes_write_err
  (ats_int_type fd, ats_ptr_type buf, ats_size_type cnt) {
  return write(fd, buf, cnt) ;
} // end of [atslib_fildes_write_err]

ATSinline()
ats_size_type
atslib_fildes_write_exn
  (ats_int_type fd, ats_ptr_type buf, ats_size_type cnt) {
  ats_ssize_type res ;
  res = write(fd, buf, cnt) ;
  if (res < 0) {
    perror("write") ; ats_exit_errmsg(1, "exit(ATS): [fildes_write] failed.\n") ;
  } // end of [if]
  return res ;
} // end of [atslib_fildes_write_exn]

/* ****** ****** */

ATSinline()
ats_ssize_type
atslib_fildes_write_substring_err (
  ats_int_type fd, ats_ptr_type str, ats_size_type start, ats_size_type n
) {
  return write(fd, ((char*)str)+start, n) ;
} // end of [atslib_fildes_write_substring_err]

ATSinline()
ats_size_type
atslib_fildes_write_substring_exn (
  ats_int_type fd, ats_ptr_type str, ats_size_type start, ats_size_type n
) {
  ats_ssize_type res ;
  res = write(fd, ((char*)str)+start, n) ;
  if (res < 0) {
    perror("write") ; ats_exit_errmsg(1, "exit(ATS): [fildes_write] failed.\n") ;
  } // end of [if]
  return res ;
} // end of [ats_fildes_write_substring_exn]

/* ****** ****** */

ATSinline()
ats_fcntlflag_type
atslib_fcntl_getfl (ats_int_type fd) { return fcntl(fd, F_GETFL) ; }

ATSinline()
ats_int_type
atslib_fcntl_setfl (
  ats_int_type fd, ats_fcntlflag_type flag
) {
  return fcntl(fd, F_SETFL, flag) ;
} // end of [atslib_fcntl_setfl]

/* ****** ****** */

#endif /* ATS_LIBC_FCNTL_CATS */
