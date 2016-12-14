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

#ifndef ATSLIB_LIBATS_LIBC_CATS_DIRENT
#define ATSLIB_LIBATS_LIBC_CATS_DIRENT

/* ****** ****** */

#include <sys/types.h>
#include <dirent.h> // HX: after sys/types

/* ****** ****** */

#include "share/H/pats_atslib.h"

/* ****** ****** */
//
typedef DIR atslib_libats_libc_DIR_type ;
//
typedef
struct dirent atslib_libats_libc_dirent_type ;
//
/* ****** ****** */

#define \
atslib_libats_libc_dirent_get_d_ino(ent) \
(((atslib_libats_libc_dirent_type*)ent)->d_ino)
#define \
atslib_libats_libc_dirent_get_d_name(ent) \
(((atslib_libats_libc_dirent_type*)ent)->d_name)

/* ****** ****** */

#define \
atslib_libats_libc_direntp_get_d_name(entp) \
(((atslib_libats_libc_dirent_type*)entp)->d_name)

/* ****** ****** */

#define \
atslib_libats_libc_direntp_free(x) atspre_mfree_gc(x)

/* ****** ****** */

#define atslib_libats_libc_alphasort alphasort
#define atslib_libats_libc_versionsort versionsort

/* ****** ****** */

#define atslib_libats_libc_opendir opendir

/* ****** ****** */

#define atslib_libats_libc_closedir closedir

/* ****** ****** */

#define \
atslib_libats_libc_readdir readdir
#define \
atslib_libats_libc_readdir_r(dirp, ent, res) \
  readdir_r((DIR*)dirp, (struct dirent*)ent, (struct dirent**)res)

/* ****** ****** */

#define \
atslib_libats_libc_scandir(dirp, namelst, filter, compar) \
  scandir((char*)dirp, (struct dirent***)namelst, (void*)filter, (void*)compar)

/* ****** ****** */

#define \
atslib_libats_libc_rewinddir rewinddir

/* ****** ****** */

#define atslib_libats_libc_seekdir seekdir
#define atslib_libats_libc_telldir telldir

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_DIRENT

/* ****** ****** */

/* end of [dirent.cats] */
