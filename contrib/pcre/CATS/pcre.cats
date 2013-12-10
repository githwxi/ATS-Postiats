/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
(* Start time: August, 2013 *)
*/

/* ****** ****** */

#ifndef PCRE_PCRE_CATS
#define PCRE_PCRE_CATS

/* ****** ****** */

#include <pcre.h>

/* ****** ****** */

typedef unsigned char uchar ;

/* ****** ****** */

#ifndef memcpy
//
extern // HX: declared in [string.h]
void *memcpy (void* dst, const void* src, size_t n) ;
//
#endif // end of [#ifndef]

/* ****** ****** */

#define atscntrb_pcre_memcpy memcpy

/* ****** ****** */

#define atscntrb_pcre_pcre_version pcre_version

/* ****** ****** */

#define \
atscntrb_pcre_pcre_compile(code, options, errptr, erroffset, tableptr) \
pcre_compile(code, (int)options, (const char**)errptr, (int*)erroffset, (const uchar*)tableptr)

#define \
atscntr_pcre_pcre_compile2(code, options, errorcodeptr, errptr, erroffset, tableptr) \
pcre_compile2(code, (int)options, (int*)errorcodeptr, (const char**)errptr, (int*)erroffset, (const uchar*)tableptr)

/* ****** ****** */

#define atscntrb_pcre_pcre_free pcre_free

/* ****** ****** */

#define atscntrb_pcre_pcre_study pcre_study
#define atscntrb_pcre_pcre_free_study pcre_free_study

/* ****** ****** */

#define atscntrb_pcre_pcre_exec pcre_exec

/* ****** ****** */

#endif // ifndef PCRE_PCRE_CATS

/* ****** ****** */

/* end of [pcre.cats] */
