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
(* Start time: April, 2013 *)
*/

/* ****** ****** */
//
#include <stdio.h>
//
extern void exit (int) ; // in [stdlib.h]
//
/* ****** ****** */

#include "pats_ccomp_basics.h"
#include "pats_ccomp_typedefs.h"

/* ****** ****** */

extern
void
atsruntime_handle_uncaughtexn
  (const void *exn0)
{
  atstype_exncon *exn ;
  exn = (atstype_exncon*)exn0 ;
  fprintf(
    stderr
  , "exit(ATS): uncaught exception at run-time: %s(%d)\n"
  , exn->exnmsg, exn->exntag
  ) ; exit(1) ;
  return ; // deadcode
} /* end of [atsruntime_handle_uncaughtexn] */

/* ****** ****** */

extern
void
atsruntime_handle_unmatchedval
  (const char *msg0)
{
  fprintf(
    stderr
  , "exit(ATS): unmatched value at run-time:\n%s\n", msg0
  ) ; exit(1) ;
  return ; // deadcode
} /* end of [atsruntime_handle_unmatchedval] */

/* ****** ****** */

/* end of [pats_ccomp_runtime.c] */
