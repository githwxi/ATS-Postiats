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

// constants
macdef BT = $extval(char, "atscntrb_atsoptml_GRB_BINARY")

fun
loadenv(env: &env, glog: String1): int

fun
geterrormsg(env: env): String0

fun
freemodel(model: model): int

fun
freeenv(env: env): int

//
// Ideally we do not call the following functions
// directly but develop other abstractions.
//
fun
newmodel {n:nat}(
env: env, model: &model, mname: String, 
numvars: int (n), obj: cPtr0(double), 
lb: cPtr0(double), ub: cPtr0(double),
vtype: string (n), varnames: cPtr0(cPtr0(char))): int
//TODO: write a function to convert stringlst_vt
//to char**, probably using bytes[] or similar


fun
addvars {n:nat}(
model:model, numvars:int, numnz: int, vbeg: cPtr0(int), 
vind: cPtr0(int), vval: cPtr0(double), obj: cPtr0(double), 
lb: cPtr0(double), ub:cPtr0(double), vtype: string (n),
cPtr0(cPtr0(char))): int

