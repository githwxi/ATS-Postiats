/* ****** ****** */

/* author: Brandon Barker (brandonDOTbarkerATgmailDOTcom) */


// Initially tested with Gurobi 5.6
// Last tested with Gurobi 5.6
// Docs at: 
// http://www.gurobi.com/documentation/5.6/reference-manual/c_reference_manual 

/* ****** ****** */

#ifndef GUROBI_CATS
#define GUROBI_CATS

/* ****** ****** */

#include <gurobi_c.h>

/* ****** ****** */

#define atscntrb_atsoptml_GRBversion GRBversion
#define atscntrb_atsoptml_GRB_VERSION_MAJOR GRB_VERSION_MAJOR
#define atscntrb_atsoptml_GRB_VERSION_MINOR GRB_VERSION_MINOR
#define atscntrb_atsoptml_GRB_VERSION_TECHNICAL GRB_VERSION_TECHNICAL

/* ****** ****** */

typedef GRBmodel atscntrb_atsoptml_GRBmodel;
typedef atscntrb_atsoptml_GRBmodel *ptrGRBmodel;
typedef GRBenv atscntrb_atsoptml_GRBenv;
typedef atscntrb_atsoptml_GRBenv *ptrGRBenv;

/* ****** ****** */
//
// Gurobi constants and flags
//

/* Model status codes (after call to GRBoptimize()) */

#define atscntrb_atsoptml_GRB_LOADED GRB_LOADED
#define atscntrb_atsoptml_GRB_OPTIMAL GRB_OPTIMAL
#define atscntrb_atsoptml_GRB_INFEASIBLE GRB_INFEASIBLE
#define atscntrb_atsoptml_GRB_INF_OR_UNBD GRB_INF_OR_UNBD
#define atscntrb_atsoptml_GRB_UNBOUNDED GRB_UNBOUNDED
#define atscntrb_atsoptml_GRB_CUTOFF GRB_CUTOFF
#define atscntrb_atsoptml_GRB_ITERATION_LIMIT GRB_ITERATION_LIMIT
#define atscntrb_atsoptml_GRB_NODE_LIMIT GRB_NODE_LIMIT
#define atscntrb_atsoptml_GRB_TIME_LIMIT GRB_TIME_LIMIT
#define atscntrb_atsoptml_GRB_SOLUTION_LIMIT GRB_SOLUTION_LIMIT
#define atscntrb_atsoptml_GRB_INTERRUPTED GRB_INTERRUPTED
#define atscntrb_atsoptml_GRB_NUMERIC GRB_NUMERIC
#define atscntrb_atsoptml_GRB_SUBOPTIMAL GRB_SUBOPTIMAL
#define atscntrb_atsoptml_GRB_INPROGRESS GRB_INPROGRESS  

/* Variable types */

#define atscntrb_atsoptml_GRB_CONTINUOUS GRB_CONTINUOUS
#define atscntrb_atsoptml_GRB_BINARY GRB_BINARY
#define atscntrb_atsoptml_GRB_INTEGER GRB_INTEGER
#define atscntrb_atsoptml_GRB_SEMICONT GRB_SEMICONT
#define atscntrb_atsoptml_GRB_SEMIINT GRB_SEMIINT

/* Constraint senses */

#define atscntrb_atsoptml_GRB_LESS_EQUAL GRB_LESS_EQUAL
#define atscntrb_atsoptml_GRB_GREATER_EQUAL GRB_GREATER_EQUAL  
#define atscntrb_atsoptml_GRB_EQUAL GRB_EQUAL

#define atscntrb_atsoptml_GRB_MAXIMIZE GRB_MAXIMIZE
#define atscntrb_atsoptml_GRB_MINIMIZE GRB_MINIMIZE

/* Model attributes */

// # of constraints
#define atscntrb_atsoptml_GRB_INT_ATTR_NUMCONSTRS \
GRB_INT_ATTR_NUMCONSTRS
// # of vars   
#define atscntrb_atsoptml_GRB_INT_ATTR_NUMVARS \
GRB_INT_ATTR_NUMVARS
// # of sos constraints 
#define atscntrb_atsoptml_GRB_INT_ATTR_NUMSOS \
GRB_INT_ATTR_NUMSOS 
// # of quadratic constraints
#define atscntrb_atsoptml_GRB_INT_ATTR_NUMQCONSTRS \ 
GRB_INT_ATTR_NUMQCONSTRS
// # of nz in A
#define atscntrb_atsoptml_GRB_INT_ATTR_NUMNZS \
GRB_INT_ATTR_NUMNZS
// # of nz in Q
#define atscntrb_atsoptml_GRB_INT_ATTR_NUMQNZS \
GRB_INT_ATTR_NUMQNZS
// # of nz in q constraints
#define atscntrb_atsoptml_GRB_INT_ATTR_NUMQCNZS \
GRB_INT_ATTR_NUMQCNZS
//  # of integer vars 
#define atscntrb_atsoptml_GRB_INT_ATTR_NUMINTVARS \
GRB_INT_ATTR_NUMINTVARS
// # of binary vars
#define atscntrb_atsoptml_GRB_INT_ATTR_NUMBINVARS \
GRB_INT_ATTR_NUMBINVARS
// model name
#define atscntrb_atsoptml_GRB_STR_ATTR_MODELNAME \
GRB_STR_ATTR_MODELNAME
// 1=min, -1=max 
#define atscntrb_atsoptml_GRB_INT_ATTR_MODELSENSE \
GRB_INT_ATTR_MODELSENSE
// Objective constant
#define atscntrb_atsoptml_GRB_DBL_ATTR_OBJCON \
GRB_DBL_ATTR_OBJCON
// Is model a MIP?
#define atscntrb_atsoptml_GRB_INT_ATTR_IS_MIP \
GRB_INT_ATTR_IS_MIP
// Model has quadratic obj?
#define atscntrb_atsoptml_GRB_INT_ATTR_IS_QP \
GRB_INT_ATTR_IS_QP
// Model has quadratic constr?
#define atscntrb_atsoptml_GRB_INT_ATTR_IS_QCP \
GRB_INT_ATTR_IS_QCP
//  Name of compute server
#define atscntrb_atsoptml_GRB_STR_ATTR_SERVER \
GRB_STR_ATTR_SERVER

/* Model solution attributes */

// Run time for optimization
#define atscntrb_atsoptml_GRB_DBL_ATTR_RUNTIME \
GRB_DBL_ATTR_RUNTIME
// Optimization status 
#define atscntrb_atsoptml_GRB_INT_ATTR_STATUS \
GRB_INT_ATTR_STATUS
// Solution objective
#define atscntrb_atsoptml_GRB_DBL_ATTR_OBJVAL \
GRB_DBL_ATTR_OBJVAL
// Best bound on solution
#define atscntrb_atsoptml_GRB_DBL_ATTR_OBJBOUND \
GRB_DBL_ATTR_OBJBOUND
// MIP optimality gap
#define atscntrb_atsoptml_GRB_DBL_ATTR_MIPGAP \
GRB_DBL_ATTR_MIPGAP
// # of solutions found
#define atscntrb_atsoptml_GRB_INT_ATTR_SOLCOUNT \
GRB_INT_ATTR_SOLCOUNT
// Iters performed (simplex)
#define atscntrb_atsoptml_GRB_DBL_ATTR_ITERCOUNT \
GRB_DBL_ATTR_ITERCOUNT
// Iters performed (barrier)
#define atscntrb_atsoptml_GRB_INT_ATTR_BARITERCOUNT \
GRB_INT_ATTR_BARITERCOUNT
// Nodes explored (B&C)
#define atscntrb_atsoptml_GRB_DBL_ATTR_NODECOUNT \
GRB_DBL_ATTR_NODECOUNT
// 0: no basis, 1: has basis; can be computed, 2: available 
#define atscntrb_atsoptml_GRB_INT_ATTR_HASDUALNORM \
GRB_INT_ATTR_HASDUALNORM

/* Variable attributes related to the current solution */

// Solution value
#define atscntrb_atsoptml_GRB_DBL_ATTR_X GRB_DBL_ATTR_X
// Alternate MIP solution
#define atscntrb_atsoptml_GRB_DBL_ATTR_Xn GRB_DBL_ATTR_Xn
// Reduced costs 
#define atscntrb_atsoptml_GRB_DBL_ATTR_RC GRB_DBL_ATTR_RC
// Dual norm square
#define atscntrb_atsoptml_GRB_DBL_ATTR_VDUALNORM GRB_DBL_ATTR_VDUALNORM
// Variable basis status
#define atscntrb_atsoptml_GRB_INT_ATTR_VBASIS GRB_INT_ATTR_VBASIS

/* ****** ****** */
//
// model alloc/free
//
#define atscntrb_atsoptml_GRBnewmodel GRBnewmodel
#define atscntrb_atsoptml_GRBloadmodel GRBloadmodel
#define atscntrb_atsoptml_GRBfreeenv GRBfreemodel

/* ****** ****** */
//
// environment alloc/free
//
#define atscntrb_atsoptml_GRBloadenv GRBloadenv
#define atscntrb_atsoptml_GRBfreeenv GRBfreeenv

/* ****** ****** */
//
// model set-functions
//
#define atscntrb_atsoptml_GRBaddvars GRBaddvars
#define atscntrb_atsoptml_GRBaddconstr GRBaddconstr
#define atscntrb_atsoptml_GRBaddqconstr GRBaddqconstr

/* ****** ****** */
//
// solver function
//
#define atscntrb_atsoptml_GRBoptimize GRBoptimize

/* ****** ****** */
//
// apply pending attributes
//
#define atscntrb_atsoptml_GRBupdatemodel GRBupdatemodel

/* ****** ****** */
//
// soft-reset (clear solution) function
//
#define atscntrb_atsoptml_GRBaddresetmodel GRBresetmodel

/* ****** ****** */
//
// model scalar atrributes set-functions
//
#define atscntrb_atsoptml_GRBsetintattr GRBsetintattr
#define atscntrb_atsoptml_GRBsetdblattr GRBsetdblattr

/* ****** ****** */
//
// model scalar atrributes get-functions
//
#define atscntrb_atsoptml_GRBgetintattr GRBgetintattr
#define atscntrb_atsoptml_GRBgetdblattr GRBgetdblattr

/* ****** ****** */
//
// model array atrributes set-functions
//
#define atscntrb_atsoptml_GRBsetintattrarray GRBsetintattrarray
#define atscntrb_atsoptml_GRBsetdblattrarray GRBsetdblattrarray
#define atscntrb_atsoptml_GRBsetcharattrarray GRBsetcharattrarray

#define atscntrb_atsoptml_GRBsetintattrelement GRBsetintattrelement
#define atscntrb_atsoptml_GRBsetdblattrelement GRBsetdblattrelement
#define atscntrb_atsoptml_GRBsetcharattrelement GRBsetcharattrelement

/* ****** ****** */
//
// model array atrributes get-functions
//
#define atscntrb_atsoptml_GRBgetintattrarray GRBgetintattrarray
#define atscntrb_atsoptml_GRBgetdblattrarray GRBgetdblattrarray
#define atscntrb_atsoptml_GRBgetcharattrarray GRBgetcharattrarray

#define atscntrb_atsoptml_GRBgetintattrelement GRBgetintattrelement
#define atscntrb_atsoptml_GRBgetdblattrelement GRBgetdblattrelement
#define atscntrb_atsoptml_GRBgetcharattrelement GRBgetcharattrelement

/* ****** ****** */
//
// infeasible model analysis and utility functions
//
#define atscntrb_atsoptml_GRBcomputeIIS GRBcomputeIIS
#define atscntrb_atsoptml_GRBfeasrelax GRBfeasrelax

/* ****** ****** */
//
// error reporting
//
#define atscntrb_atsoptml_GRBgeterrormsg GRBgeterrormsg

/* ****** ****** */

#endif // ifndef GUROBI_CATS

/* end of [gurobi.cats] */
