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

// Author: Will Blair

/* ****** ****** */

// Author: Hongwei Xi

/* ****** ****** */

#ifndef Z3_Z3_CATS
#define Z3_Z3_CATS

/* ****** ****** */

#include <z3.h>

/* ****** ****** */

#define atscntrb_Z3_mk_config Z3_mk_config
#define atscntrb_Z3_del_config Z3_del_config
#define atscntrb_Z3_set_param_value Z3_set_param_value

/* ****** ****** */

#define atscntrb_Z3_mk_context Z3_mk_context
#define atscntrb_Z3_mk_context_rc Z3_mk_context_rc
#define atscntrb_Z3_del_context Z3_del_context

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_inc_ref
  (Z3_ast a) { Z3_inc_ref (a); return a ; }
// end of [atscntrb_Z3_inc_ref]

#define atscntrb_Z3_dec_ref(a) Z3_dec_ref(a)

/* ****** ****** */

#include "z3_sort.cats"

/* ****** ****** */

#include "z3_constapp.cats"

/* ****** ****** */

#include "z3_propeq.cats" // for prop and equality

/* ****** ****** */

#include "./z3_arithmetic.cats"

/* ****** ****** */

#endif // end of [Z3_Z3_CATS]

/* ****** ****** */

/* end of [z3.cats] */
