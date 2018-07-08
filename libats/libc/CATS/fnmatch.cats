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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: March, 2013 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBATS_LIBC_CATS_FNMATCH
#define ATSLIB_LIBATS_LIBC_CATS_FNMATCH

/* ****** ****** */

#include <fnmatch.h>

/* ****** ****** */

#define \
atslib_libats_libc_fnmatch_null(pat, str) fnmatch((char*)pat, (char*)str, 0)
#define \
atslib_libats_libc_fnmatch_flags(pat, str, flags) fnmatch((char*)pat, (char*)str, flags)

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_FNMATCH

/* ****** ****** */

/* end of [fnmatch.cats] */
