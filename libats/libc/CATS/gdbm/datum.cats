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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: July, 2013
//
/* ****** ****** */

#ifndef \
ATSLIB_LIBATS_LIBC_CATS_GDBM_DATUM
#define \
ATSLIB_LIBATS_LIBC_CATS_GDBM_DATUM

/* ****** ****** */
//
#include \
"libats/libc/CATS/string.cats"
//
/* ****** ****** */
//
typedef
datum atslib_libats_libc_datum_type ;
//
/* ****** ****** */

ATSinline()
atstype_bool
atslib_libats_libc_gdbm_datum_is_valid
  (datum x) { return (x.dptr != 0) ; }
// end of [atslib_libats_libc_gdbm_datum_is_valid]

ATSinline()
atstype_ptr
atslib_libats_libc_gdbm_datum_takeout_ptr
  (datum x) { return x.dptr ; }
// end of [atslib_libats_libc_gdbm_datum_takeout_ptr]

/* ****** ****** */

ATSinline()
datum
atslib_libats_libc_gdbm_datum_make0_string
(
  char *str
) {
  datum res ;
  res.dptr = str ;
  res.dsize = (int)(atslib_libats_libc_strlen(str) + 1) ; // HX: account for the trailing null char!
  return res ;
} // end of [atslib_libats_libc_gdbm_datum_make0_string]

ATSinline()
datum
atslib_libats_libc_gdbm_datum_make1_string
(
  char *str
) {
  datum res ;
  res.dptr = (char*)atslib_libats_libc_strdup_gc(str) ;
  res.dsize = (int)(atslib_libats_libc_strlen(str) + 1) ; // HX: account for the trailing null char!
  return res ;
} // end of [atslib_libats_libc_gdbm_datum_make1_string]

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atslib_libats_libc_gdbm_datum_free
  (datum x) {
  if (x.dptr) atspre_mfree_gc(x.dptr) ; return ;
} // end of [atslib_libats_libc_gdbm_datum_free]

/* ****** ****** */

#endif // ifndeg ATSLIB_LIBATS_LIBC_CATS_GDBM_DATUM

/* ****** ****** */

/* end of [datum.cats] */
