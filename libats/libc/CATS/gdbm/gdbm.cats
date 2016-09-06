/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: July, 2013
//
/* ****** ****** */

#ifndef \
ATSLIB_LIBATS_LIBC_CATS_GDBM_GDBM
#define \
ATSLIB_LIBATS_LIBC_CATS_GDBM_GDBM

/* ****** ****** */

#include <gdbm.h>

/* ****** ****** */
//
#include \
"libats/libc/CATS/gdbm/datum.cats"
//
/* ****** ****** */
//
ATSinline()
gdbm_error
atslib_libc_gdbm_errno_get
  (/*void*/) { return gdbm_errno ; }
//
/* ****** ****** */

#define atslib_libc_gdbm_open gdbm_open
#define atslib_libc_gdbm_close gdbm_close

#define atslib_libc_gdbm_store gdbm_store

#define atslib_libc_gdbm_fetch gdbm_fetch
#define atslib_libc_gdbm_exists gdbm_exists

#define atslib_libc_gdbm_delete gdbm_delete

#define atslib_libc_gdbm_nextkey gdbm_nextkey
#define atslib_libc_gdbm_firstkey gdbm_firstkey

#define atslib_libc_gdbm_sync gdbm_sync

#define atslib_libc_gdbm_export gdbm_export
#define atslib_libc_gdbm_import gdbm_import

#define atslib_libc_gdbm_reorganize gdbm_reorganize

/* ****** ****** */

#define \
atslib_libc_gdbm_strerror(ec) ((char*)gdbm_strerror(ec))

/* ****** ****** */

#define atslib_libc_gdbm_setopt gdbm_setopt
#define atslib_libc_gdbm_getopt gdbm_getopt

/* ****** ****** */

#ifdef \
GDBM_GETDBNAME
//
ATSinline()
atstype_string
atslib_libc_gdbm_getdbname
(
  atstype_ptr dbf
) {
  int err ; char *dbname ;
  err =
  gdbm_setopt
  (
    (GDBM_FILE)dbf
  , GDBM_GETDBNAME, &dbname, sizeof(void*)
  ) ; // gdbm_setopt
  if(err >= 0) return dbname ; else return (char*)0 ;
} // end of [atslib_libc_gdbm_getdbname]
//
#endif // end of [GDBM_GETDBNAME]

/* ****** ****** */

#define atslib_libc_gdbm_fdesc gdbm_fdesc

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_GDBM_GDBM

/* ****** ****** */

/* end of [gdbm.cats] */
