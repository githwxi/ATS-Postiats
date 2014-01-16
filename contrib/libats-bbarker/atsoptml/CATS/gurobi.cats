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
// Put versioning here

/* ****** ****** */

typedef GRBmodel atscntrb_gurobi_GRBmodel;
typedef atscntrb_gurobi_GRBmodel *ptrGRBmodel;
typedef GRBenv atscntrb_gurobi_GRBenv;
typedef atscntrb_gurobi_GRBenv *ptrGRBenv;

/* ****** ****** */
//
// Gurobi constants and flags
//
// !!!!! Fill these in !!!!!!!!!!!!

/* ****** ****** */
//
// model alloc/free
//
#define atscntrb_gurobi_GRBnewmodel GRBnewmodel
#define atscntrb_gurobi_GRBloadmodel GRBloadmodel
#define atscntrb_gurobi_GRBfreeenv GRBfreemodel

/* ****** ****** */
//
// environment alloc/free
//
#define atscntrb_gurobi_GRBloadenv GRBloadenv
#define atscntrb_gurobi_GRBfreeenv GRBfreeenv

/* ****** ****** */
//
// model set-functions
//
#define atscntrb_gurobi_GRBaddvars GRBaddvars
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

#endif // ifndef GUROBI_CATS

/* ****** ****** */

/* end of [gurobi.cats] */
