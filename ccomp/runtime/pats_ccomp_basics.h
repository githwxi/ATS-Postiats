/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: October, 2012 *)
*/

/* ****** ****** */

#ifndef PATS_CCOMP_BASICS_H
#define PATS_CCOMP_BASICS_H

/* ****** ****** */

#define ATSextfun() extern

/* ****** ****** */

#define ATSdynload0(flag) int flag = 0
#define ATSdynload1(flag) extern int flag

/* ****** ****** */

#define ATSinline() static inline

/* ****** ****** */

#define ATSglobaldec()
#define ATSstaticdec() static

/* ****** ****** */
//
// HX: boolean values
//
#define atsbool_true 1
#define atsbool_false 0
//
/* ****** ****** */

#define atsptr_null ((void*)0)

/* ****** ****** */

#define ATStysum() struct{ int contag; }
#define ATStylist(tyelt) struct{ tyelt head; void *tail; }

/* ****** ****** */

#define ATSassume(flag) void *flag = (void*)0

/* ****** ****** */

#define ATSmainats_void_0(err) mainats_void_0()
#define ATSmainats_argc_argv_0(argc, argv, err) mainats_argc_argv_0(argc, argv)
#define ATSmainats_argc_argv_envp_0(argc, argv, envp, err) mainats_argc_argv_envp_0(argc, argv, envp)

#define ATSmainats_void_int(err) err = mainats_void_int()
#define ATSmainats_argc_argv_int(argc, argv, err) err = mainats_argc_argv_int(argc, argv)
#define ATSmainats_argc_argv_envp_int(argc, argv, envp, err) err = mainats_argc_argv_envp_int(argc, argv, envp)

/* ****** ****** */

#endif /* PATS_CCOMP_BASICS_H */

/* ****** ****** */

/* end of [pats_ccomp_basics.h] */
