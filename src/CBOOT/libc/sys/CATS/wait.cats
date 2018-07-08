/************************************************************************/
/*                                                                      */
/*                         Applied Type System                          */
/*                                                                      */
/*                              Hongwei Xi                              */
/*                                                                      */
/************************************************************************/

/*
** ATS - Unleashing the Power of Types!
** Copyright (C) 2002-2010 Hongwei Xi, Boston University
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
*/

/* ****** ****** */

/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATS_LIBC_SYS_WAIT_CATS
#define ATS_LIBC_SYS_WAIT_CATS

#include <sys/types.h>
#include <sys/wait.h>

/* ****** ****** */

#include "libc/sys/CATS/types.cats"

/* ****** ****** */

#if(0)
//
// HX-2010-10-8: these will also work:
//
#define atslib_WIFEXITED(status) WIFEXITED(status)
#define atslib_WIFSIGNALED(status) WIFSIGNALED(status)
#define atslib_WIFSTOPPED(status) WIFSTOPPED(status)
//
#define atslib_WEXITSTATUS(status) WEXITSTATUS(status)
#define atslib_WTERMSIG(status) WTERMSIG(status)
#define atslib_WSTOPSIG(status) WSTOPSIG(status)
//
#endif // end of [#if(0)]

/* ****** ****** */

ATSinline()
ats_int_type
atslib_WIFEXITED
  (ats_int_type status) { return WIFEXITED(status) ; }
// end of [atslib_WIFEXITED]

ATSinline()
ats_int_type
atslib_WEXITSTATUS
  (ats_int_type status) { return WEXITSTATUS(status) ; }
// end of [atslib_WEXITSTATUS]

/* ****** ****** */

ATSinline()
ats_int_type
atslib_WIFSIGNALED
  (ats_int_type status) { return WIFSIGNALED(status) ; }
// end of [atslib_WIFSIGNALED]

ATSinline()
ats_int_type
atslib_WTERMSIG
  (ats_int_type status) { return WTERMSIG(status) ; }
// end of [atslib_WTERMSIG]

/* ****** ****** */

ATSinline()
ats_int_type
atslib_WIFSTOPPED
  (ats_int_type status) { return WIFSTOPPED(status) ; }
// end of [atslib_WIFSTOPPED]

ATSinline()
ats_int_type
atslib_WSTOPSIG
  (ats_int_type status) { return WSTOPSIG(status) ; }
// end of [atslib_WSTOPSIG]

/* ****** ****** */

ATSinline()
ats_pid_type
atslib_wait_null () { return wait((int*)0) ; }

#define atslib_wait wait
#define atslib_waitpid waitpid

/* ****** ****** */

#endif /* end of [ATS_LIBC_SYS_WAIT_CATS] */

/* end of [wait.cats] */
