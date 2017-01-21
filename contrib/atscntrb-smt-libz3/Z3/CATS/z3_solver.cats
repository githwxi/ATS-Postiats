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

#ifndef Z3_Z3_SOLVER_CATS
#define Z3_Z3_SOLVER_CATS

/* ****** ****** */

#define \
atscntrb_Z3_mk_tactic Z3_mk_tactic

/* ****** ****** */

#define \
atscntrb_Z3_tactic_dec_ref Z3_tactic_dec_ref

/* ****** ****** */
//
#define atscntrb_Z3_mk_solver Z3_mk_solver
//
#define \
atscntrb_Z3_mk_solver_from_tactic Z3_mk_solver_from_tactic
//
/* ****** ****** */

ATSinline()
Z3_solver
atscntrb_Z3_solver_inc_ref
  (Z3_context ctx, Z3_solver slvr)
{
  Z3_solver_inc_ref(ctx, slvr); return slvr;
} // end of [atscntrb_Z3_solver_inc_ref]

#define \
atscntrb_Z3_solver_dec_ref Z3_solver_dec_ref

/* ****** ****** */

#define atscntrb_Z3_solver_pop Z3_solver_pop
#define atscntrb_Z3_solver_push Z3_solver_push

/* ****** ****** */

#define atscntrb_Z3_solver_check Z3_solver_check
#define atscntrb_Z3_solver_assert Z3_solver_assert

/* ****** ****** */

#define atscntrb_Z3_get_num_scopes Z3_get_num_scopes

/* ****** ****** */

#endif // end of [Z3_Z3_SOLVER_CATS]

/* ****** ****** */

/* end of [z3_solver.cats] */
