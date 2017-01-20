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
** $PATSHOME/prelude/CATS/CODEGEN/fprintf.atxt
** Time of generation: Sun Nov 20 15:37:54 2016
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: September, 2015 *)
*/

/* ****** ****** */

#ifndef ATSLIB_PRELUDE_CATS_FPRINTF
#define ATSLIB_PRELUDE_CATS_FPRINTF

/* ****** ****** */
//
// HX-2013-09: declared in [stdio.h]
//
#ifndef fprintf
//
extern "C"
{
int
fprintf (FILE *stream, const char *format, ...) ;
}
//
#endif // end of [ifndef]
//
/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_bool (
  atstype_ref out, atstype_bool x
) {
  int err = 0 ;
  err += fprintf((FILE*)out, "%s", atspre_bool2string(x)) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_bool] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_bool]
#define atspre_print_bool(x) atspre_fprint_bool(stdout, (x))
#define atspre_prerr_bool(x) atspre_fprint_bool(stderr, (x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_char
(
  atstype_ref out, atstype_char c
) {
  int err = 0 ;
  err += fprintf ((FILE*)out, "%c", c) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_char] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end of [atspre_fprint_char]
#define atspre_print_char(c) atspre_fprint_char(stdout, (c))
#define atspre_prerr_char(c) atspre_fprint_char(stderr, (c))

ATSinline()
atsvoid_t0ype
atspre_fprint_uchar
(
  atstype_ref out, atstype_uchar c
) {
  atspre_fprint_char (out, (atstype_char)c) ; return ;
} // end of [atspre_fprint_uchar]
#define atspre_print_uchar(c) atspre_fprint_uchar(stdout, (c))
#define atspre_prerr_uchar(c) atspre_fprint_uchar(stderr, (c))

ATSinline()
atsvoid_t0ype
atspre_fprint_schar
(
  atstype_ref out, atstype_schar c
) {
  atspre_fprint_char (out, (atstype_char)c) ; return ;
} // end of [atspre_fprint_schar]
#define atspre_print_schar(c) atspre_fprint_schar(stdout, (c))
#define atspre_prerr_schar(c) atspre_fprint_schar(stderr, (c))

/* ****** ****** */
  
ATSinline()
atsvoid_t0ype
atspre_fprint_int
(
  atstype_ref out, atstype_int x
) {
  int err = 0 ;
  err += fprintf((FILE*)out, "%i", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_int] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_int]
#define atspre_print_int(x) atspre_fprint_int(stdout, (x))
#define atspre_prerr_int(x) atspre_fprint_int(stderr, (x))

ATSinline()
atsvoid_t0ype
atspre_fprint_lint
(
  atstype_ref out, atstype_lint x
) {
  int err = 0 ;
  err += fprintf((FILE*)out, "%li", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_lint] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_lint]
#define atspre_print_lint(x) atspre_fprint_lint(stdout, (x))
#define atspre_prerr_lint(x) atspre_fprint_lint(stderr, (x))

ATSinline()
atsvoid_t0ype
atspre_fprint_llint
(
  atstype_ref out, atstype_llint x
) {
  int err = 0 ;
  err += fprintf((FILE*)out, "%lli", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_llint] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_llint]
#define atspre_print_llint(x) atspre_fprint_llint(stdout, (x))
#define atspre_prerr_llint(x) atspre_fprint_llint(stderr, (x))

ATSinline()
atsvoid_t0ype
atspre_fprint_ssize
(
  atstype_ref out, atstype_ssize x
) {
  int err = 0 ;
  err += fprintf((FILE*)out, "%li", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_ssize] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_ssize]
#define atspre_print_ssize(x) atspre_fprint_ssize(stdout, (x))
#define atspre_prerr_ssize(x) atspre_fprint_ssize(stderr, (x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_uint
(
  atstype_ref out, atstype_uint x
) {
  int err = 0 ;
  err += fprintf((FILE*)out, "%u", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_uint] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_uint]
#define atspre_print_uint(x) atspre_fprint_uint(stdout, (x))
#define atspre_prerr_uint(x) atspre_fprint_uint(stderr, (x))

ATSinline()
atsvoid_t0ype
atspre_fprint_ulint
(
  atstype_ref out, atstype_ulint x
) {
  int err = 0 ;
  err += fprintf((FILE*)out, "%lu", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_ulint] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_ulint]
#define atspre_print_ulint(x) atspre_fprint_ulint(stdout, (x))
#define atspre_prerr_ulint(x) atspre_fprint_ulint(stderr, (x))

ATSinline()
atsvoid_t0ype
atspre_fprint_ullint
(
  atstype_ref out, atstype_ullint x
) {
  int err = 0 ;
  err += fprintf((FILE*)out, "%llu", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_ullint] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_ullint]
#define atspre_print_ullint(x) atspre_fprint_ullint(stdout, (x))
#define atspre_prerr_ullint(x) atspre_fprint_ullint(stderr, (x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_size
(
  atstype_ref out, atstype_size x
) {
  int err = 0 ;
  atstype_ulint x2 = x ;
  err += fprintf((FILE*)out, "%lu", x2) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_size] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_size]
#define atspre_print_size(x) atspre_fprint_size(stdout, (x))
#define atspre_prerr_size(x) atspre_fprint_size(stderr, (x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_ptr (
  atstype_ref out, atstype_ptr x
) {
  int err ;
  err = fprintf((FILE*)out, "%p", x) ;
  return ;
} // end [atspre_fprint_ptr]
#define atspre_print_ptr(x) atspre_fprint_ptr(stdout, (x))
#define atspre_prerr_ptr(x) atspre_fprint_ptr(stderr, (x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_float (
  atstype_ref r, atstype_float x
) {
  int err = 0 ;
  err += fprintf((FILE*)r, "%f", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_float] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_float]
#define atspre_print_float(x) atspre_fprint_float(stdout, (x))
#define atspre_prerr_float(x) atspre_fprint_float(stderr, (x))

ATSinline()
atsvoid_t0ype
atspre_fprint_double (
  atstype_ref r, atstype_double x
) {
  int err = 0 ;
  err += fprintf((FILE*)r, "%f", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_double] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_double]
#define atspre_print_double(x) atspre_fprint_double(stdout, (x))
#define atspre_prerr_double(x) atspre_fprint_double(stderr, (x))

ATSinline()
atsvoid_t0ype
atspre_fprint_ldouble (
  atstype_ref r, atstype_ldouble x
) {
  int err = 0 ;
  err += fprintf((FILE*)r, "%Lf", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_ldouble] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_ldouble]
#define atspre_print_ldouble(x) atspre_fprint_ldouble(stdout, (x))
#define atspre_prerr_ldouble(x) atspre_fprint_ldouble(stderr, (x))

/* ****** ****** */

#if(0)
//
ATSinline()
atsvoid_t0ype
atspre_fprint_intptr
(
  atstype_ref r, atstype_intptr x
) {
  int err ;
  err = fprintf((FILE*)r, "%lli", (atstype_llint)x) ;
  return ;
} // end [atspre_fprint_intptr]
#define atspre_print_intptr(x) atspre_fprint_intptr(stdout, (x))
#define atspre_prerr_intptr(x) atspre_fprint_intptr(stderr, (x))
//
ATSinline()
atsvoid_t0ype
atspre_fprint_uintptr
(
  atstype_ref r, atstype_uintptr x
) {
  int err ;
  err = fprintf((FILE*)r, "%llu", (atstype_ullint)x) ;
  return ;
} // end [atspre_fprint_uintptr]
#define atspre_print_uintptr(x) atspre_fprint_uintptr(stdout, (x))
#define atspre_prerr_uintptr(x) atspre_fprint_uintptr(stderr, (x))
//
#endif // [#if(0)]

/* ****** ****** */

#if(0)
//
ATSinline()
atsvoid_t0ype
atspre_fprint_int8
(
  atstype_ref r, atstype_int8 x
) {
  int err ;
  err = fprintf((FILE*)r, "%i", (atstype_int)x) ;
  return ;
} // end [atspre_fprint_int8]
#define atspre_print_int8(x) atspre_fprint_int8(stdout, (x))
#define atspre_prerr_int8(x) atspre_fprint_int8(stderr, (x))
//
ATSinline()
atsvoid_t0ype
atspre_fprint_int16
(
  atstype_ref r, atstype_int16 x
) {
  int err ;
  err = fprintf((FILE*)r, "%i", (atstype_int)x) ;
  return ;
} // end [atspre_fprint_int16]
#define atspre_print_int16(x) atspre_fprint_int16(stdout, (x))
#define atspre_prerr_int16(x) atspre_fprint_int16(stderr, (x))
//
ATSinline()
atsvoid_t0ype
atspre_fprint_int32
(
  atstype_ref r, atstype_int32 x
) {
  int err ;
  err = fprintf((FILE*)r, "%li", (atstype_lint)x) ;
  return ;
} // end [atspre_fprint_int32]
#define atspre_print_int32(x) atspre_fprint_int32(stdout, (x))
#define atspre_prerr_int32(x) atspre_fprint_int32(stderr, (x))
//
ATSinline()
atsvoid_t0ype
atspre_fprint_int64
(
  atstype_ref r, atstype_int64 x
) {
  int err ;
  err = fprintf((FILE*)r, "%lli", (atstype_llint)x) ;
  return ;
} // end [atspre_fprint_int64]
#define atspre_print_int64(x) atspre_fprint_int64(stdout, (x))
#define atspre_prerr_int64(x) atspre_fprint_int64(stderr, (x))
//
#endif // [#if(0)]

/* ****** ****** */

#if(0)
//
ATSinline()
atsvoid_t0ype
atspre_fprint_uint8
(
  atstype_ref r, atstype_uint8 x
) {
  int err ;
  err = fprintf((FILE*)r, "%u", (atstype_uint)x) ;
  return ;
} // end [atspre_fprint_uint8]
#define atspre_print_uint8(x) atspre_fprint_uint8(stdout, (x))
#define atspre_prerr_uint8(x) atspre_fprint_uint8(stderr, (x))
//
ATSinline()
atsvoid_t0ype
atspre_fprint_uint16
(
  atstype_ref r, atstype_uint16 x
) {
  int err ;
  err = fprintf((FILE*)r, "%u", (atstype_uint)x) ;
  return ;
} // end [atspre_fprint_uint16]
#define atspre_print_uint16(x) atspre_fprint_uint16(stdout, (x))
#define atspre_prerr_uint16(x) atspre_fprint_uint16(stderr, (x))
//
ATSinline()
atsvoid_t0ype
atspre_fprint_uint32
(
  atstype_ref r, atstype_uint32 x
) {
  int err ;
  err = fprintf((FILE*)r, "%lu", (atstype_ulint)x) ;
  return ;
} // end [atspre_fprint_uint32]
#define atspre_print_uint32(x) atspre_fprint_uint32(stdout, (x))
#define atspre_prerr_uint32(x) atspre_fprint_uint32(stderr, (x))
//
ATSinline()
atsvoid_t0ype
atspre_fprint_uint64
(
  atstype_ref r, atstype_uint64 x
) {
  int err ;
  err = fprintf((FILE*)r, "%llu", (atstype_ullint)x) ;
  return ;
} // end [atspre_fprint_uint64]
#define atspre_print_uint64(x) atspre_fprint_uint64(stdout, (x))
#define atspre_prerr_uint64(x) atspre_fprint_uint64(stderr, (x))
//
#endif // [#if(0)]

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_string
(
  atstype_ref out, atstype_string x
) {
  int err = 0 ;
  err += fprintf((FILE*)out, "%s", (char*)x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_string] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end of [atspre_fprint_string]
#define atspre_print_string(x) atspre_fprint_string(stdout, (x))
#define atspre_prerr_string(x) atspre_fprint_string(stderr, (x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_substring
(
  atstype_ref out
, atstype_string x
, atstype_size st, atstype_size ln  
) {
  int err = 0 ;
  err += fwrite(((char*)x)+st, 1, ln, out) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_substring] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end of [atspre_fprint_substring]

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_stropt
(
  atstype_ref out, atstype_stropt x
) {
  int err = 0 ;
  if (!x)
  {
    err += fprintf((FILE*)out, "strnone()") ;
  } else {
    err += fprintf((FILE*)out, "strsome(%s)", (char*)x) ;
  }
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_stropt] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end of [atspre_fprint_stropt]
#define atspre_print_stropt(x) atspre_fprint_stropt(stdout, (x))
#define atspre_prerr_stropt(x) atspre_fprint_stropt(stderr, (x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_strptr
(
  atstype_ref out, atstype_strptr x
) {
  int err = 0 ;
  if (x != 0) {
    err += fprintf((FILE*)out, "%s", (char*)x) ;
  } else {
    err += fprintf((FILE*)out, "%s", "(strnull)") ;
  } // end of [if]
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_strptr] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end of [atspre_fprint_strptr]
#define atspre_print_strptr(x) atspre_fprint_strptr(stdout, (x))
#define atspre_prerr_strptr(x) atspre_fprint_strptr(stderr, (x))

/* ****** ****** */

#define atspre_fprint_strbuf atspre_fprint_strptr
#define atspre_print_strbuf(x) atspre_fprint_strbuf(stdout, (x))
#define atspre_prerr_strbuf(x) atspre_fprint_strbuf(stderr, (x))

/* ****** ****** */

#endif // ifndef(ATSLIB_PRELUDE_CATS_FPRINTF)

/* ****** ****** */

/* end of [fprintf.cats] */
