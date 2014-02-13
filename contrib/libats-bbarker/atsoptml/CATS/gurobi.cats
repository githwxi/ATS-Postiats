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

// Initially tested with Gurobi 5.6
// Last tested with Gurobi 5.6
// Docs at: 
// http://www.gurobi.com/documentation/5.6/reference-manual/c_reference_manual 

/* ****** ****** */

#ifndef GUROBI_GUROBI_CATS
#define GUROBI_GUROBI_CATS

/* ****** ****** */

#include <gurobi_c.h>

/* ****** ****** */

#define atscntrb_gurobi_GRBversion GRBversion
#define atscntrb_gurobi_GRB_VERSION_MAJOR GRB_VERSION_MAJOR
#define atscntrb_gurobi_GRB_VERSION_MINOR GRB_VERSION_MINOR
#define atscntrb_gurobi_GRB_VERSION_TECHNICAL GRB_VERSION_TECHNICAL

//
// Gurobi constants and flags
//

/* Model status codes (after call to GRBoptimize()) */

#define atscntrb_gurobi_GRB_LOADED GRB_LOADED
#define atscntrb_gurobi_GRB_OPTIMAL GRB_OPTIMAL
#define atscntrb_gurobi_GRB_INFEASIBLE GRB_INFEASIBLE
#define atscntrb_gurobi_GRB_INF_OR_UNBD GRB_INF_OR_UNBD
#define atscntrb_gurobi_GRB_UNBOUNDED GRB_UNBOUNDED
#define atscntrb_gurobi_GRB_CUTOFF GRB_CUTOFF
#define atscntrb_gurobi_GRB_ITERATION_LIMIT GRB_ITERATION_LIMIT
#define atscntrb_gurobi_GRB_NODE_LIMIT GRB_NODE_LIMIT
#define atscntrb_gurobi_GRB_TIME_LIMIT GRB_TIME_LIMIT
#define atscntrb_gurobi_GRB_SOLUTION_LIMIT GRB_SOLUTION_LIMIT
#define atscntrb_gurobi_GRB_INTERRUPTED GRB_INTERRUPTED
#define atscntrb_gurobi_GRB_NUMERIC GRB_NUMERIC
#define atscntrb_gurobi_GRB_SUBOPTIMAL GRB_SUBOPTIMAL
#define atscntrb_gurobi_GRB_INPROGRESS GRB_INPROGRESS  

/* Variable types */
#define atscntrb_gurobi_GRB_CONTINUOUS GRB_CONTINUOUS
#define atscntrb_gurobi_GRB_BINARY GRB_BINARY
#define atscntrb_gurobi_GRB_INTEGER GRB_INTEGER
#define atscntrb_gurobi_GRB_SEMICONT GRB_SEMICONT
#define atscntrb_gurobi_GRB_SEMIINT GRB_SEMIINT

/* Constraint senses */

#define atscntrb_gurobi_GRB_LESS_EQUAL GRB_LESS_EQUAL
#define atscntrb_gurobi_GRB_GREATER_EQUAL GRB_GREATER_EQUAL  
#define atscntrb_gurobi_GRB_EQUAL GRB_EQUAL

#define atscntrb_gurobi_GRB_MAXIMIZE GRB_MAXIMIZE
#define atscntrb_gurobi_GRB_MINIMIZE GRB_MINIMIZE

/* Model attributes */

// # of constraints
#define atscntrb_gurobi_GRB_INT_ATTR_NUMCONSTRS \
GRB_INT_ATTR_NUMCONSTRS
// # of vars   
#define atscntrb_gurobi_GRB_INT_ATTR_NUMVARS \
GRB_INT_ATTR_NUMVARS
// # of sos constraints 
#define atscntrb_gurobi_GRB_INT_ATTR_NUMSOS \
GRB_INT_ATTR_NUMSOS 
// # of quadratic constraints
#define atscntrb_gurobi_GRB_INT_ATTR_NUMQCONSTRS \
GRB_INT_ATTR_NUMQCONSTRS
// # of nz in A
#define atscntrb_gurobi_GRB_INT_ATTR_NUMNZS \
GRB_INT_ATTR_NUMNZS
// # of nz in Q
#define atscntrb_gurobi_GRB_INT_ATTR_NUMQNZS \
GRB_INT_ATTR_NUMQNZS
// # of nz in q constraints
#define atscntrb_gurobi_GRB_INT_ATTR_NUMQCNZS \
GRB_INT_ATTR_NUMQCNZS
//  # of integer vars 
#define atscntrb_gurobi_GRB_INT_ATTR_NUMINTVARS \
GRB_INT_ATTR_NUMINTVARS
// # of binary vars
#define atscntrb_gurobi_GRB_INT_ATTR_NUMBINVARS \
GRB_INT_ATTR_NUMBINVARS
// model name
#define atscntrb_gurobi_GRB_STR_ATTR_MODELNAME \
GRB_STR_ATTR_MODELNAME
// 1=min, -1=max 
#define atscntrb_gurobi_GRB_INT_ATTR_MODELSENSE \
GRB_INT_ATTR_MODELSENSE
// Objective constant
#define atscntrb_gurobi_GRB_DBL_ATTR_OBJCON \
GRB_DBL_ATTR_OBJCON
// Is model a MIP?
#define atscntrb_gurobi_GRB_INT_ATTR_IS_MIP \
GRB_INT_ATTR_IS_MIP
// Model has quadratic obj?
#define atscntrb_gurobi_GRB_INT_ATTR_IS_QP \
GRB_INT_ATTR_IS_QP
// Model has quadratic constr?
#define atscntrb_gurobi_GRB_INT_ATTR_IS_QCP \
GRB_INT_ATTR_IS_QCP
//  Name of compute server
#define atscntrb_gurobi_GRB_STR_ATTR_SERVER \
GRB_STR_ATTR_SERVER

/* Model solution attributes */

// Run time for optimization
#define atscntrb_gurobi_GRB_DBL_ATTR_RUNTIME \
GRB_DBL_ATTR_RUNTIME
// Optimization status 
#define atscntrb_gurobi_GRB_INT_ATTR_STATUS \
GRB_INT_ATTR_STATUS
// Solution objective
#define atscntrb_gurobi_GRB_DBL_ATTR_OBJVAL \
GRB_DBL_ATTR_OBJVAL
// Best bound on solution
#define atscntrb_gurobi_GRB_DBL_ATTR_OBJBOUND \
GRB_DBL_ATTR_OBJBOUND
// MIP optimality gap
#define atscntrb_gurobi_GRB_DBL_ATTR_MIPGAP \
GRB_DBL_ATTR_MIPGAP
// # of solutions found
#define atscntrb_gurobi_GRB_INT_ATTR_SOLCOUNT \
GRB_INT_ATTR_SOLCOUNT
// Iters performed (simplex)
#define atscntrb_gurobi_GRB_DBL_ATTR_ITERCOUNT \
GRB_DBL_ATTR_ITERCOUNT
// Iters performed (barrier)
#define atscntrb_gurobi_GRB_INT_ATTR_BARITERCOUNT \
GRB_INT_ATTR_BARITERCOUNT
// Nodes explored (B&C)
#define atscntrb_gurobi_GRB_DBL_ATTR_NODECOUNT \
GRB_DBL_ATTR_NODECOUNT
// 0: no basis, 1: has basis; can be computed, 2: available 
#define atscntrb_gurobi_GRB_INT_ATTR_HASDUALNORM \
GRB_INT_ATTR_HASDUALNORM

/* Variable attributes related to the current solution */

// Solution value
#define atscntrb_gurobi_GRB_DBL_ATTR_X GRB_DBL_ATTR_X
// Alternate MIP solution
#define atscntrb_gurobi_GRB_DBL_ATTR_Xn GRB_DBL_ATTR_Xn
// Reduced costs 
#define atscntrb_gurobi_GRB_DBL_ATTR_RC GRB_DBL_ATTR_RC
// Dual norm square
#define atscntrb_gurobi_GRB_DBL_ATTR_VDUALNORM GRB_DBL_ATTR_VDUALNORM
// Variable basis status
#define atscntrb_gurobi_GRB_INT_ATTR_VBASIS GRB_INT_ATTR_VBASIS

/* ****** ****** */
//
// model alloc/free
//
#define atscntrb_gurobi_GRBnewmodel(env, modelP, Pname, numvars, obj, lb, ub, \
  vtype, varnames) \
  GRBnewmodel((GRBenv *)env, (GRBmodel **)modelP, Pname, numvars, obj, lb, ub, \
  vtype, varnames)

#define atscntrb_gurobi_GRBnewmodel_null(env, modelP, Pname) \
  GRBnewmodel((GRBenv *)env, (GRBmodel **)modelP, Pname, 0/*nv*/, 0/*obj*/, \
  0/*lb*/, 0/*ub*/, 0/*vtype*/, 0/*names*/ \
)

#define atscntrb_gurobi_GRBloadmodel GRBloadmodel
#define atscntrb_gurobi_GRBfreemodel GRBfreemodel

/* ****** ****** */
//
// environment alloc/free
//
#define atscntrb_gurobi_GRBloadenv(envP, logfilename) \
  GRBloadenv((GRBenv **) envP, (char *) logfilename)
#define atscntrb_gurobi_GRBfreeenv GRBfreeenv

/* ****** ****** */
//
// model set-functions
//
#define atscntrb_gurobi_GRBaddvars GRBaddvars
#define atscntrb_gurobi_GRBaddvars_nocon(model, numvars, numnz, obj, vtype, varnames)\
  GRBaddvars(model, numvars, numnz, 0/*vbeg*/, 0/*vind*/, 0/*vval*/, obj, 0/*lb*/, \
             0/*ub*/, vtype, varnames\
)
#define atscntrb_gurobi_GRBaddvars_nocon_noname(model, numvars, numnz, obj, vtype)\
  GRBaddvars(model, numvars, numnz, 0/*vbeg*/, 0/*vind*/, 0/*vval*/, obj, 0/*lb*/, \
             0/*ub*/, vtype, 0/*varnames*/\
)

#define atscntrb_gurobi_GRBaddconstr GRBaddconstr
#define atscntrb_gurobi_GRBaddqconstr GRBaddqconstr

/* ****** ****** */
//
// solver function
//
#define atscntrb_gurobi_GRBoptimize GRBoptimize

/* ****** ****** */
//
// apply pending attributes
//
#define atscntrb_gurobi_GRBupdatemodel GRBupdatemodel

/* ****** ****** */
//
// soft-reset (clear solution) function
//
#define atscntrb_gurobi_GRBaddresetmodel GRBresetmodel

/* ****** ****** */
//
// model scalar atrributes set-functions
//
#define atscntrb_gurobi_GRBsetintattr GRBsetintattr
#define atscntrb_gurobi_GRBsetdblattr GRBsetdblattr

/* ****** ****** */
//
// model scalar atrributes get-functions
//
#define atscntrb_gurobi_GRBgetintattr GRBgetintattr
#define atscntrb_gurobi_GRBgetdblattr GRBgetdblattr

/* ****** ****** */
//
// model array atrributes set-functions
//
#define atscntrb_gurobi_GRBsetintattrarray GRBsetintattrarray
#define atscntrb_gurobi_GRBsetdblattrarray GRBsetdblattrarray
#define atscntrb_gurobi_GRBsetcharattrarray GRBsetcharattrarray

#define atscntrb_gurobi_GRBsetintattrelement GRBsetintattrelement
#define atscntrb_gurobi_GRBsetdblattrelement GRBsetdblattrelement
#define atscntrb_gurobi_GRBsetcharattrelement GRBsetcharattrelement

/* ****** ****** */
//
// model array atrributes get-functions
//
#define atscntrb_gurobi_GRBgetintattrarray GRBgetintattrarray
#define atscntrb_gurobi_GRBgetdblattrarray GRBgetdblattrarray
#define atscntrb_gurobi_GRBgetcharattrarray GRBgetcharattrarray

#define atscntrb_gurobi_GRBgetintattrelement GRBgetintattrelement
#define atscntrb_gurobi_GRBgetdblattrelement GRBgetdblattrelement
#define atscntrb_gurobi_GRBgetcharattrelement GRBgetcharattrelement

/* ****** ****** */
//
// infeasible model analysis and utility functions
//
#define atscntrb_gurobi_GRBcomputeIIS GRBcomputeIIS
#define atscntrb_gurobi_GRBfeasrelax GRBfeasrelax

/* ****** ****** */
//
// error reporting
//
#define atscntrb_gurobi_GRBgeterrormsg GRBgeterrormsg

/* ****** ****** */
//
// other IO
//
#define atscntrb_gurobi_GRBwrite GRBwrite

/* ****** ****** */

#endif // ifndef GUROBI_CATS

/* end of [gurobi.cats] */
