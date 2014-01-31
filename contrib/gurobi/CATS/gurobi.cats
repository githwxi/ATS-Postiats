/* ****** ****** */
//
// API in ATS for GUROBI
//
/* ****** ****** */

/*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/

/* ****** ****** */

/*
** Author: Brandon Barker 
** Authoremail: brandonDOTbarkerATgmailDOTcom)
*/

/* ****** ****** */

/*
** Author: Hongwei Xi (gmhwxiDOTgmailDOTcom)
*/

/* ****** ****** */

#ifndef GUROBI_GUROBI_CATS
#define GUROBI_GUROBI_CATS

/* ****** ****** */

#include <gurobi_c.h>

/* ****** ****** */

#define atscntrb_gurobi_GRBloadenv GRBloadenv
#define atscntrb_gurobi_GRBloadclientenv GRBloadclientenv

/* ****** ****** */

#define atscntrb_gurobi_GRBfreeenv GRBfreeenv

/* ****** ****** */

#define atscntrb_gurobi_GRBnewmodel GRBnewmodel
#define atscntrb_gurobi_GRBnewmodel_null(env, modelP, Pname) \
  GRBnewmodel(env, modelP, Pname, 0/*nv*/, 0/*obj*/, 0/*lb*/, 0/*ub*/, 0/*vtype*/, 0/*names*/)

/* ****** ****** */

#define atscntrb_gurobi_GRBloadmodel GRBloadmodel
#define atscntrb_gurobi_GRBcopymodel GRBcopymodel

/* ****** ****** */

#define atscntrb_gurobi_GRBfreemodel GRBfreemodel

/* ****** ****** */

#define atscntrb_gurobi_GRBaddvar GRBaddvar
#define atscntrb_gurobi_GRBaddvars GRBaddvars

/* ****** ****** */

#define atscntrb_gurobi_GRBupdatemodel GRBupdatemodel

/* ****** ****** */

#define atscntrb_gurobi_GRBversion GRBversion

/* ****** ****** */

#endif // ifndef GUROBI_GUROBI_CATS

/* end of [gurobi.cats] */
