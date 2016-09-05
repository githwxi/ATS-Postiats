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
** Source:
** $PATSHOME/libc/sys/CATS/CODEGEN/mman.atxt
** Time of generation: Wed Jun  1 19:08:17 2016
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: October, 2013 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBC_SYS_CATS_MMAN
#define ATSLIB_LIBC_SYS_CATS_MMAN

/* ****** ****** */
//
#include <fcntl.h>
#include <sys/types.h>
//
#include <sys/mman.h>
//
/* ****** ****** */

#define atslib_shm_open shm_open
#define atslib_shm_unlink shm_unlink

/* ****** ****** */

#endif // ifndef ATSLIB_LIBC_SYS_CATS_MMAN

/* ****** ****** */

/* end of [mman.cats] */
