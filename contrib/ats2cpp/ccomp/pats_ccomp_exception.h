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
(* Start time: June, 2013 *)
*/

/* ****** ****** */

#ifndef PATS_CCOMP_EXCEPTION_H
#define PATS_CCOMP_EXCEPTION_H

/* ****** ****** */

/*
use -D_XOPEN_SOURCE
*/
//
#include <alloca.h>
#include <setjmp.h>
/*
extern "C" void *alloca(size_t bsz);
*/
//
/* ****** ****** */

#define atstype_jmp_buf jmp_buf
#define atspre_setjmp(env, mask) setjmp(env)
#define atspre_longjmp(env, ret) longjmp(env, ret)

/* ****** ****** */

/*
extern
atstype_exncon *atspre_AssertExn_make() ;
extern
atstype_exncon *atspre_NotFoundExn_make() ;
extern
atstype_exncon *atspre_IllegalArgExn_make(const char*) ;
extern
atstype_exncon *atspre_ListSubscriptExn_make() ;
extern
atstype_exncon *atspre_StreamSubscriptExn_make() ;
extern
atstype_exncon *atspre_ArraySubscriptExn_make() ;
extern
atstype_exncon *atspre_MatrixSubscriptExn_make() ;
//
extern atstype_exncon *atspre_NotSomeExn_make() ;
//
extern
atstype_bool atspre_isListSubscriptExn (const atstype_exncon*) ;
extern
atstype_bool atspre_isStreamSubscriptExn (const atstype_exncon*) ;
extern
atstype_bool atspre_isArraySubscriptExn (const atstype_exncon*) ;
extern
atstype_bool atspre_isMatrixSubscriptExn (const atstype_exncon*) ;
//
extern atstype_bool atspre_isNotSomeExn (const atstype_exncon*) ; 
*/

/* ****** ****** */

typedef
struct atsexnframe
{
  atstype_jmp_buf env ;
  atstype_exnconptr exn ;
  struct atsexnframe *prev ;
} atsexnframe_t ;

typedef
atsexnframe_t *atsexnframe_ptr ;

/* ****** ****** */

#define \
atsexnframe_alloc() alloca(sizeof(atsexnframe_t))
#define \
atsexnframe_mfree(frame) /* there-is-nothing-to-do */

/* ****** ****** */

extern "C"
{
atsexnframe_ptr *my_atsexnframe_getref() ; // throw ();
} // end of [extern "C"]

/* ****** ****** */

static
inline
void my_atsexnframe_enter
(
  atsexnframe_ptr frame
, atsexnframe_ptr *framep
) {
  frame->prev = *framep ; *framep = frame ; return ;
} // end of [my_atsexnframe_enter]

static
inline
void my_atsexnframe_leave
(
  atsexnframe_ptr *framep
) {
  atsexnframe_mfree(*framep) ; *framep = (*framep)->prev ; return ;
} // end of [my_atsexnframe_leave]

/* ****** ****** */

/*
** HX:
** beg-of-WARNING:
** DO NOT USE THE FOLLOWING MACROS:
*/

#define \
ATStrywith_try(tmpexn) \
do { \
  int flag ; \
  atsexnframe_ptr frame ; \
  atsexnframe_ptr *framep ; \
  frame = atsexnframe_alloc() ; \
  framep = my_atsexnframe_getref() ; \
  my_atsexnframe_enter(frame, framep) ; \
  flag = atspre_setjmp(frame->env, 1) ; \
  if (flag==0) { /* normal */

#define \
ATStrywith_with(tmpexn) \
    my_atsexnframe_leave(framep) ; \
  } else { /* flag<>0 : exceptional */ \
    tmpexn = (*framep)->exn ; \
    my_atsexnframe_leave(framep) ;

#define \
ATStrywith_end(tmpexn) \
  } \
} while(0) ; /* end of [do] */

/* end-of-WARNING */

/* ****** ****** */

#endif /* PATS_CCOMP_EXCEPTION_H */

/* ****** ****** */

/* end of [pats_ccomp_exception.h] */
