/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/*                              Hongwei Xi                             */
/*                                                                     */
/***********************************************************************/

/*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see  the  file  COPYING.  If not, write to the Free
** Software Foundation, 51  Franklin  Street,  Fifth  Floor,  Boston,  MA
** 02110-1301, USA.
*/

/* ****** ****** */
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: July, 2013
//
/* ****** ****** */

#include <gdbm.h>

/* ****** ****** */

#include "libc/gdbm/CATS/datum.cats"

/* ****** ****** */

ATSinline()
gdbm_error
atslib_gdbm_errno_get () { return gdbm_errno ; }

/* ****** ****** */

#define atslib_gdbm_open gdbm_open
#define atslib_gdbm_close gdbm_close

#define atslib_gdbm_store gdbm_store

#define atslib_gdbm_fetch gdbm_fetch
#define atslib_gdbm_exists gdbm_exists

#define atslib_gdbm_delete gdbm_delete

#define atslib_gdbm_firstkey gdbm_firstkey
#define atslib_gdbm_nextkey gdbm_nextkey

#define atslib_gdbm_reorganize gdbm_reorganize

#define atslib_gdbm_sync gdbm_sync

#define atslib_gdbm_export gdbm_export
#define atslib_gdbm_import gdbm_import

#define atslib_gdbm_strerror gdbm_strerror

/* ****** ****** */

#define atslib_gdbm_setopt gdbm_setopt
#define atslib_gdbm_getopt gdbm_setopt

/* ****** ****** */

#ifdef GDBM_GETDBNAME
ATSinline()
gdbm_getdbname
(
  atstype_ptr dbf
) {
  int err ; char *dbname ;
  err = gdbm_setopt((GDBM_FILE)dbf, GDBM_GETDBNAME, &dbname, sizeof(void*)) ;
  if (err < 0) return (char*)0 ;
  return dbname ;
} // end of [gdbm_getdbname]
#endif // end of [GDBM_GETDBNAME]

/* ****** ****** */

#define atslib_gdbm_fdesc gdbm_fdesc

/* ****** ****** */

/* end of [gdbm.cats] */
