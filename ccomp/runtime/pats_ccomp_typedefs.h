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

#ifndef PATS_CCOMP_TYPEDEFS_H
#define PATS_CCOMP_TYPEDEFS_H

/* ****** ****** */

/*
** HX:
** of indefinite size
*/
struct atstype_struct ;

/* ****** ****** */

typedef void atstype_void ;
typedef void atsvoid_t0ype ;

/* ****** ****** */

typedef int atstype_int ;
typedef unsigned int atstype_uint ;

typedef long int atstype_lint ;
typedef unsigned long int atstype_ulint ;

typedef long long int atstype_llint ;
typedef unsigned long long int atstype_ullint ;

typedef short int atstype_sint ;
typedef unsigned short int atstype_usint ;

/* ****** ****** */

typedef atstype_lint atstype_ssize ;
typedef atstype_ulint atstype_size ;

/* ****** ****** */
//
// HX: true/false: 1/0
//
typedef int atstype_bool ;
//
/* ****** ****** */

typedef unsigned char atstype_byte ;

/* ****** ****** */

typedef char atstype_char ;
typedef signed char atstype_schar ;
typedef unsigned char atstype_uchar ;

/* ****** ****** */

typedef char *atstype_string ;
typedef char *atstype_stropt ;
typedef char *atstype_strptr ;

/* ****** ****** */

typedef float atstype_float ;
typedef double atstype_double ;
typedef long double atstype_ldouble ;

/* ****** ****** */
/*
** HX: for pointers
*/
typedef void *atstype_ptr ;
typedef void *atstype_ptrk ;
/*
** HX: for references
*/
typedef void *atstype_ref ;
/*
** HX: for boxed values
*/
typedef void* atstype_boxed ;
/*
** HX: for [datconptr]
*/
typedef void* atstype_datconptr ;
/*
** HX: for [datcontyp]
*/
typedef void* atstype_datcontyp ;

/* ****** ****** */

#ifdef \
_ATS_CCOMP_EXCEPTION_NONE_
//
// HX: should a message be issued?
//
#else
//
typedef struct
{
  atstype_int exntag ;
  atstype_string exnmsg ;
} atstype_exncon ;
//
typedef
atstype_exncon *atstype_exnconptr ;
//
#endif // end of [_ATS_CCOMP_EXCEPTION_NONE_]

/* ****** ****** */
/*
** HX: for pointers to arrays
*/
typedef void* atstype_arrptr ;
/*
** HX: for arrays plus size info
*/
typedef
struct {
  atstype_arrptr ptr ; atstype_size size ;
} atstype_arrpsz ;

/* ****** ****** */

typedef void* atstype_funptr ;
typedef void* atstype_cloptr ;

/* ****** ****** */

#define atstkind_type(tk) tk
#define atstkind_t0ype(tk) tk

/* ****** ****** */
//
// HX-2014-09-16:
// making it unusable unless
// _ATS_ARRAY_FIELD is defined
//
#ifdef _ATS_ARRAY_FIELD_
#define atstyarr_field(fname) fname[]
#else
#define atstyarr_field(fname) atstyarr_field_undef(fname)
#endif // end of [_ATS_ARRAY_FIELD_]
//
/* ****** ****** */
//
// HX-2014-05:
// making it not usable!!!
//
#ifdef _ATSTYPE_VAR_SIZE_
// HX: it is set by the user
#else
#define _ATSTYPE_VAR_SIZE_ 0X10000
#endif // end of [#ifdef]
//
// HX-2014-05:
// for 8-bit or 16-bit march,
// _ATSTYPE_VAR_SIZE can be set to 0X100
//
typedef
struct{char _[_ATSTYPE_VAR_SIZE_];} atstype_var[0] ;
//
/* ****** ****** */

#define atstyvar_type(a) atstype_var

/* ****** ****** */

#define atstybox_type(hit) atstype_boxed

/* ****** ****** */

#define atstyclo_top struct{ void *cfun; }
#define atstyclo_type(flab) flab##__closure_t0ype

/* ****** ****** */

#define atsrefarg0_type(hit) hit
#define atsrefarg1_type(hit) atstype_ref

/* ****** ****** */

#endif /* PATS_CCOMP_TYPEDEFS_H */

/* ****** ****** */

/* end of [pats_ccomp_typedefs.h] */
