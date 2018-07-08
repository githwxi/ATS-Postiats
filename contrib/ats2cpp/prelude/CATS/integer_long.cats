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
(* Start time: January, 2013 *)
*/

/* ****** ****** */

/*
** Source:
** $PATSHOME/prelude/CATS/CODEGEN/integer_long.atxt
** Time of generation: Sun Aug 21 20:48:35 2016
*/

/* ****** ****** */

#ifndef ATS2CPP_PRELUDE_CATS_INTEGER_LONG
#define ATS2CPP_PRELUDE_CATS_INTEGER_LONG

/* ****** ****** */
//
#define \
atspre_g0int2int_int_lint(x) ((atstype_lint)(x))
#define \
atspre_g1int2int_int_lint(x) atspre_g0int2int_int_lint(x)
//
#define \
atspre_g0int2int_int_llint(x) ((atstype_llint)(x))
#define \
atspre_g1int2int_int_llint(x) atspre_g0int2int_int_llint(x)
//
/* ****** ****** */
//
#define \
atspre_g0int2int_lint_int(x) ((atstype_int)(x))
#define \
atspre_g1int2int_lint_int(x) atspre_g0int2int_lint_int(x)
//
#define \
atspre_g0int2int_lint_lint(x) ((atstype_lint)(x))
#define \
atspre_g1int2int_lint_lint(x) atspre_g0int2int_lint_lint(x)
//
#define \
atspre_g0int2int_lint_llint(x) ((atstype_llint)(x))
#define \
atspre_g1int2int_lint_llint(x) atspre_g0int2int_lint_llint(x)
//
/* ****** ****** */
//
#define \
atspre_g0int2uint_int_ulint(x) ((atstype_ulint)(x))
#define \
atspre_g1int2uint_int_ulint(x) atspre_g0int2uint_int_ulint(x)
//
#define \
atspre_g0int2uint_int_ullint(x) ((atstype_ullint)(x))
#define \
atspre_g1int2uint_int_ullint(x) atspre_g0int2uint_int_ullint(x)
//
#define \
atspre_g0int2uint_lint_ulint(x) ((atstype_ulint)(x))
#define \
atspre_g1int2uint_lint_ulint(x) atspre_g0int2uint_lint_ulint(x)
//
#define \
atspre_g0int2uint_lint_ullint(x) ((atstype_ullint)(x))
#define \
atspre_g1int2uint_lint_ullint(x) atspre_g0int2uint_lint_ullint(x)
//
#define \
atspre_g0int2uint_llint_ullint(x) ((atstype_ullint)(x))
#define \
atspre_g1int2uint_llint_ullint(x) atspre_g0int2uint_llint_ullint(x)
//
/* ****** ****** */

#define atspre_g0uint2int_uint_lint(x) ((atstype_lint)(x))
#define atspre_g0uint2int_uint_llint(x) ((atstype_llint)(x))
#define atspre_g1uint2int_uint_int atspre_g0uint2int_uint_int
#define atspre_g1uint2int_uint_lint atspre_g0uint2int_uint_lint
#define atspre_g1uint2int_uint_llint atspre_g0uint2int_uint_llint
#define atspre_g0uint2uint_uint_ulint(x) ((atstype_ulint)(x))
#define atspre_g0uint2uint_uint_ullint(x) ((atstype_ullint)(x))
#define atspre_g1uint2uint_uint_ulint atspre_g0uint2uint_uint_ulint
#define atspre_g1uint2uint_uint_ullint atspre_g0uint2uint_uint_ullint

/* ****** ****** */

#endif // ifndef(ATS2CPP_PRELUDE_CATS_INTEGER_LONG)

/* ****** ****** */

/* end of [integer_long.cats] */

