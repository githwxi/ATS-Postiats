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
(* Start time: April, 2014 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBATS_LIBC_CATS_SIGNAL
#define ATSLIB_LIBATS_LIBC_CATS_SIGNAL

/* ****** ****** */

#include <signal.h>

/* ****** ****** */
//
typedef int signum_t ;
//
typedef
void (*sighandler_t)(signum_t) ;
//
/* ****** ****** */

typedef
struct sigaction
atslib_libats_libc_sigaction_struct ;

/* ****** ****** */

#define atslib_libats_libc_signal signal

/* ****** ****** */

#define atslib_libats_libc_sigaddset sigaddset
#define atslib_libats_libc_sigdelset sigdelset
#define atslib_libats_libc_sigemptyset sigemptyset
#define atslib_libats_libc_sigfillset sigfillset

/* ****** ****** */

#define \
atslib_libats_libc_sigaction sigaction
#define \
atslib_libats_libc_sigaction_null(sgn, act) \
atslib_libats_libc_sigaction(sgn, act, (atslib_libats_libc_sigaction_struct*)0)

/* ****** ****** */

#define atslib_libats_libc_kill kill
#define atslib_libats_libc_killpg killpg
#define atslib_libats_libc_raise raise

/* ****** ****** */

#define atslib_libats_libc_sigset sigset
#define atslib_libats_libc_sighold sighold
#define atslib_libats_libc_sigignore sigignore
#define atslib_libats_libc_sigrelse sigrelse

/* ****** ****** */

#define atslib_libats_libc_sigwait sigwait

/* ****** ****** */

#define atslib_libats_libc_sigpause sigpause
#define atslib_libats_libc_sigsuspend sigsuspend

/* ****** ****** */

#define atslib_libats_libc_sigpending sigpending
#define atslib_libats_libc_siginterrupt siginterrupt

/* ****** ****** */

#define atslib_libats_libc_psignal psignal

/* ****** ****** */

/*
//
// declared in <string.h>
//
extern
char* strsignal (int signum) ;
*/
#define atslib_libats_libc_strsignal strsignal

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_SIGNAL

/* ****** ****** */

/* end of [signal.cats] */
