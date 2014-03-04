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

/* ****** ****** */

/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATS_TYPES_H
#define ATS_TYPES_H

/* ****** ****** */

#include <inttypes.h>
#include <stddef.h> // for both [size_t] and [ptrdiff_t]
#include <unistd.h> // for [ssize_t]

/* ****** ****** */

struct ats_struct_type ; /* of indefinite size */

/* ****** ****** */

typedef struct ats_struct_type ats_abs_type ;

typedef void *ats_ptr_type ;
typedef void *ats_ref_type ;

/*
typedef struct ats_struct_type *ats_ptr_type ;
typedef struct ats_struct_type *ats_ref_type ;
*/

#ifdef _ATS_GEIZELLA
typedef void ats_var_type ; // for ATS/Geizella
#else
typedef struct ats_struct_type ats_var_type ;
#endif // end of [_ATS_GEIZELLA]
typedef void ats_varet_type ;

typedef void ats_void_type ;

typedef struct{} ats_empty_type ;

/* ****** ****** */

typedef int ats_bool_type ;
typedef unsigned char ats_byte_type ;

typedef char ats_char_type ;
typedef signed char ats_schar_type ;
typedef unsigned char ats_uchar_type ;

typedef double ats_double_type ;
typedef long double ats_ldouble_type ;
typedef float ats_float_type ;

/* ****** ****** */

typedef int ats_int_type ;
typedef unsigned int ats_uint_type ;

typedef long int ats_lint_type ;
typedef unsigned long int ats_ulint_type ;
typedef long long int ats_llint_type ;
typedef unsigned long long int ats_ullint_type ;

typedef short int ats_sint_type ;
typedef unsigned short int ats_usint_type ;

typedef size_t ats_size_type ;
typedef ssize_t ats_ssize_type ;
typedef ptrdiff_t ats_ptrdiff_type ;

/* ****** ****** */

typedef int8_t ats_int8_type ;
typedef uint8_t ats_uint8_type ;

typedef int16_t ats_int16_type ;
typedef uint16_t ats_uint16_type ;

typedef int32_t ats_int32_type ;
typedef uint32_t ats_uint32_type ;

typedef int64_t ats_int64_type ;
typedef uint64_t ats_uint64_type ;

/* ****** ****** */

//
// HX-2010-12-06:
// the erasure name of [ptr] is [ats_ptrself_type]
//
typedef void *ats_ptrself_type ;

/* ****** ****** */

/*
typedef ats_ptr_type ats_string_type ;
*/

/* ****** ****** */

/*
//
// HX: this is intended: no definition for [ats_atarray_type].
//
*/

typedef struct {
  ats_ptr_type data ;
  ats_int_type size ;
} ats_a1rray_type ;

typedef
ats_a1rray_type *ats_a1rray_ptr_type ;
typedef ats_a1rray_ptr_type ats_array_type ;

typedef struct {
  ats_ptr_type data ;
  ats_int_type size_row ;
  ats_int_type size_col ;
} ats_a2rray_type ;

typedef
ats_a2rray_type *ats_a2rray_ptr_type ;
typedef ats_a2rray_ptr_type ats_matrix_type ;

/* ****** ****** */

typedef
struct { int tag ; } ats_sum_type ;
typedef ats_sum_type *ats_sum_ptr_type ;

/* ****** ****** */

typedef
struct { 
  int tag ; char *name ;
} ats_exn_type ;
typedef ats_exn_type *ats_exn_ptr_type ;

/* ****** ****** */

typedef void *ats_fun_ptr_type ;

/* ****** ****** */

typedef struct { void *closure_fun ; } ats_clo_type ;

typedef ats_clo_type *ats_clo_ptr_type ;
typedef ats_clo_type *ats_clo_ref_type ;

/* ****** ****** */

#endif /* ATS_TYPES_H */

/* end of [ats_types.h] */
