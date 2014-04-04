/* ******************************************************************* */
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/* ******************************************************************* */

/*
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
*/

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
//
// HX: boolean values
//
#define atsbool_true 1
#define atsbool_false 0
//
#define atsptr_null ((void*)0)
//
#define ATSextval(name) name
//
/* ****** ****** */

#define ATSinline() static inline

/* ****** ****** */

#define ATSglobaldec() extern
#define ATSstaticdec() static

/* ****** ****** */

#define ATSdynload0(flag) int flag = 0
#define ATSdynload1(flag) ATSglobaldec() int flag
#define ATSdynloadset(flag) flag = 1
#define ATSdynloadfcall(dynloadfun) dynloadfun()

/* ****** ****** */

#ifndef _ATS_CCOMP_EXCEPTION_NONE
//
#define \
ATSdynexn_dec(d2c) atstype_exncon d2c = { 0, "ats-exncon-name" }
#define ATSdynexn_initize(d2c, exnmsg) the_atsexncon_initize(&(d2c), exnmsg)
#define ATSdynexn_extdec(d2c) ATSglobaldec() atstype_exncon d2c
//
#endif // end of [_ATS_CCOMP_EXCEPTION_NONE]

/* ****** ****** */

#define ATSassume(flag) void *flag = (void*)0

/* ****** ****** */

#define ATSdyncst_mac(d2c)
#define ATSdyncst_castfn(d2c)
#define ATSdyncst_extfun(d2c, targs, tres) ATSglobaldec() tres d2c targs
#define ATSdyncst_stafun(d2c, targs, tres) ATSstaticdec() tres d2c targs

/* ****** ****** */

#define ATSdyncst_valimp(d2c, type) type d2c
#define ATSdyncst_valdec(d2c, type) ATSglobaldec() type d2c
#define ATSdyncst_valbind(d2c, pmv) d2c = (pmv)

/* ****** ****** */

#define ATSmainats_void_0(err) mainats_void_0()
#define ATSmainats_argc_argv_0(argc, argv, err) mainats_argc_argv_0(argc, argv)
#define ATSmainats_argc_argv_envp_0(argc, argv, envp, err) mainats_argc_argv_envp_0(argc, argv, envp)

#define ATSmainats_void_int(err) err = mainats_void_int()
#define ATSmainats_argc_argv_int(argc, argv, err) err = mainats_argc_argv_int(argc, argv)
#define ATSmainats_argc_argv_envp_int(argc, argv, envp, err) err = mainats_argc_argv_envp_int(argc, argv, envp)

/* ****** ****** */

extern
void atsruntime_raise (void *exn) ;
extern
void atsruntime_handle_uncaughtexn (void *exn0) ;
extern
void atsruntime_handle_unmatchedval (char *msg0) ;

/* ****** ****** */

#endif /* PATS_CCOMP_BASICS_H */

/* ****** ****** */

/* end of [pats_ccomp_basics.h] */
