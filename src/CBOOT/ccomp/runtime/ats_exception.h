/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2008 Hongwei Xi, ATS Trustful Software, Inc.
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

/*
**
** Authors: 
** Likai Liu (liulk AT cs DOT bu DOT edu) // Summer 2005
** Rick Lavoie (coldfury AT cs DOT bu DOT edu) // Fall 2006
** Hongwei Xi (hwxi AT cs DOT bu DOT edu) // Summer 2007
**
*/

#ifndef ATS_EXCEPTION_H
#define ATS_EXCEPTION_H // the file should only be loaded once

/* ****** ****** */

/*
** always loaded after the following two files:
*/
#include "ats_types.h"
#include "ats_basics.h"

/* ****** ****** */
//
#include <setjmp.h>
//
/* ****** ****** */
//
typedef jmp_buf ats_jmp_buf_type ;
//
#define atspre_setjmp(env, mask) setjmp(env)
#define atspre_longjmp(env, ret) longjmp(env, ret)
//
/* ****** ****** */
//
// HX-2011-04-24:
// the function [alloca]
// is declared in [alloca.h] or [stdlib.h]
//
extern void *alloca (size_t bsz) ;
//
/* ****** ****** */

/*
** function for handling uncaught exceptions
*/

extern
ats_void_type
ats_uncaught_exception_handle(const ats_exn_ptr_type exn) ;

/* ****** ****** */

/* exception implementation */

typedef
struct ats_exception_frame_struct {
  ats_exn_ptr_type exn ;
  struct ats_exception_frame_struct *prev ;
  ats_jmp_buf_type env ;
} ats_exception_frame_type ;

/* ****** ****** */

#ifdef _ATS_MULTITHREAD
extern ATSthreadlocalstorage()
void *the_ats_exception_stack ;
#else /* single thread */
extern
void *the_ats_exception_stack ;
#endif // end of [_ATS_MULTITHREAD]

/* ****** ****** */

#define ATS_CURRENT_FRAME \
  ((ats_exception_frame_type*)the_ats_exception_stack)
#define ATS_CURRENT_FRAME_LVAL the_ats_exception_stack

#define ATS_ENTER_EXCEPTION_FRAME() \
  do { \
    ats_exception_frame_type *frame = \
      (ats_exception_frame_type*)alloca(sizeof(ats_exception_frame_type)); \
    frame->prev = ATS_CURRENT_FRAME ; \
    ATS_CURRENT_FRAME_LVAL = frame ; \
  } while (0) // end of [do]

#define ATS_LEAVE_EXCEPTION_FRAME() \
  do { ATS_CURRENT_FRAME_LVAL = ATS_CURRENT_FRAME->prev; } while (0)

#define ATS_RAISE(exn) \
  do { \
    if (ATS_CURRENT_FRAME == 0/*null*/) ats_uncaught_exception_handle(exn); \
    ATS_CURRENT_FRAME->exn = exn ; \
    atspre_longjmp(ATS_CURRENT_FRAME->env, 0) ; \
  } while (0) // end of [do]

/* ****** ****** */

/*
** WARNING: DO NOT USE THE FOLLOWING MACROS:
*/

#define ATS_TRYWITH_TRY(tmp_exn) \
do { \
ATS_ENTER_EXCEPTION_FRAME() ; \
tmp_exn = (ats_exn_ptr_type)((intptr_t)atspre_setjmp(ATS_CURRENT_FRAME->env, 0)) ; \
if ((intptr_t)tmp_exn == 0) { /* ... */

#define ATS_TRYWITH_WITH(tmp_exn) \
ATS_LEAVE_EXCEPTION_FRAME() ; \
} else { \
tmp_exn = ATS_CURRENT_FRAME->exn ; \
ATS_LEAVE_EXCEPTION_FRAME() ; /* exception handling */

#define ATS_TRYWITH_END() \
} \
} while(0)

/* end of WARNING */

/* ****** ****** */

static inline
ats_void_type ats_raise_exn // raising an exception
  (const ats_exn_ptr_type exn) { ATS_RAISE(exn) ; return ; }
/* end of [ats_raise_exn] */

/* ****** ****** */

/*
**
** function for generating new exception constructor tag
**
*/

extern int ats_exception_con_tag ;

static inline
int ats_exception_con_tag_new () {
  ats_exception_con_tag += 1 ; return (ats_exception_con_tag) ;
} /* end of [ats_exception_con_tag_new] */

/* functions for handling match failures */

extern
ats_void_type ats_caseof_failure(void) ;

extern
ats_void_type ats_funarg_match_failure(void) ;

/* ****** ****** */

#endif /* ATS_EXCEPTION_H */

/* end of [ats_exception.h] */
