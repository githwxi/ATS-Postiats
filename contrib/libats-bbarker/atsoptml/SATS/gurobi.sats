(* ****** ****** *)

(*
** Author: Brandon Barker 
** Authoremail: brandonDOTbarkerATgmailDOTcom)
*)

(* ****** ****** *)

%{#
//
#include "atsoptml/CATS/gurobi.cats"
//
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.atsoptml"
//#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_atsoptml_" // prefix for external names

(* ****** ****** *)

absvt@ype
GRBmodel_vt0ype = $extype"atscntrb_atsoptml_GRBmodel"
vtypedef model = GRBmodel_vt0ype

//? typedef atscntrb_atsoptml_GRBmodel *ptrGRBmodel;

absvt@ype
GRBenv_vt0ype = $extype"atscntrb_atsoptml_GRBenv"
vtypedef env = GRBenv_vt0ype

//? typedef atscntrb_atsoptml_GRBenv *ptrGRBenv;

absvt@ype
GRBvartype_vt0ype = 
$extype"atscntrb_atsoptml_GRB_VARTYPE_TYPE"
vtypedef vartyp = GRBvartype_vt0ype

fun
loadenv(env: &env, glog: String1): int

fun
geterrormsg(env: env): String0

fun
freemodel(model: model): int

fun
freeenv(env: env): int

//
// Ideally we do not call this function
// directly but develop other abstractions.
//
fun
{n,nv:nat} newmodel(
env: env, model: &modelP, mname: String (n), 
numvars: int (nv), obj: cPtr0(double), 
lb: cPtr0(double), ub: cPtr0(double),
vtype: String, varnames: stringlst_vt)

// change to using cPtr0(double)

// e.g.  $UN.cast{cPtr0(a)}(pi)
