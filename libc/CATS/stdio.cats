/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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

#ifndef ATS_LIBC_STDIO_CATS
#define ATS_LIBC_STDIO_CATS

/* ****** ****** */

#include <errno.h>
#include <stdio.h>

/* ****** ****** */

#define atslib_clearerr clearerr

/* ****** ****** */

#define atslib_fclose_err fclose

ATSinline()
atstype_void
atslib_fclose_exn
  (atsptr_type filp) {
  int err ;
  err = atslib_close_err (filp) ;
  if (err < 0) {
    perror ("fclose") ;    
    fprintf (stderr, "exit(ATS): [fclose] failed.\n") ;
    exit (1) ;
  } // end of [if]
  return ;
} // end of [atslib_fclose_exn]

#define atslib_fclose_stdin() atslib_fclose_exn(stdin)
#define atslib_fclose_stdout() atslib_fclose_exn(stdout)
#define atslib_fclose_stderr() atslib_fclose_exn(stderr)

/* ****** ****** */

#endif /* ATS_LIBC_STDIO_CATS */

/* end of [stdio.cats] */
