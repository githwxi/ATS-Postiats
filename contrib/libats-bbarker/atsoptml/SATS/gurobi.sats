(* ****** ****** *)

(*
** Author: Brandon Barker 
** Authoremail: brandonDOTbarkerATgmailDOTcom)
*)

typedef NSH(x:type) = x // for commenting: no sharing
typedef NONZERO(x:type) = x // for commenting: non-zero values only

// numnz has associtated values that shouldn't be zero:
// I believe ATS doesn't offer any static typing for doubles,
// and I'm not yet sure if gurobi does dynamic checking.
//
// Relatedly, numnz and other arrays (currently cPtr(T)s) 
// could be converted to dependent types.

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

macdef MSENS = $extval(string, "atscntrb_atsoptml_GRB_INT_ATTR_MODELSENSE")

macdef MAX = $extval(int, "atscntrb_atsoptml_GRB_MAXIMIZE")
macdef MIN = $extval(int, "atscntrb_atsoptml_GRB_MINIMIZE")

macdef L = $extval(string, "atscntrb_atsoptml_GRB_LESS_EQUAL")
macdef G = $extval(string, "atscntrb_atsoptml_GRB_GREATER_EQUAL")
macdef E = $extval(string, "atscntrb_atsoptml_GRB_EQUAL")


fun
loadenv(env: &env? >> env, logfilename: NSH(string)
): int = "mac#atscntrb_atsoptml_GRBloadenv"

fun
geterrormsg(env: env
): String0 = "mac#atscntrb_atsoptml_GRBgeterrormsg"

fun
freemodel(model: model
): int = "mac#atscntrb_atsoptml_GRBfreemodel"

fun
freeenv(env: env
): int = "mac#atscntrb_atsoptml_GRBfreeenv"

//
// Ideally we do not call the following functions
// directly but develop other abstractions.
//

absvtype varname = string

fun
newmodel {n:nat}(
env: env, model: &model? >> model, Pname: NSH(string), 
numvars: int (n), obj: cPtr0(double), 
lb: cPtr0(double), ub: cPtr0(double),
vtype: string (n), varnames: &array(varname, n)
): int = "mac#atscntrb_atsoptml_GRBnewmodel"

fun
updatemodel  (
model: model
): int = "mac#atscntrb_atsoptml_GRBupdatemodel"

//vbeg should be assigned a different, more specialized
//type than cPtr0: see gurobi docs 
fun
addvars {n:nat}(
model: model, numvars: int (n), numnz: int, vbeg: cPtr0(int), 
vind: cPtr0(int), vval: cPtr0(double), obj: cPtr0(double), 
lb: cPtr0(double), ub:cPtr0(double), vtype: string (n),
varnames: &array(varname, n)
): int = "mac#atscntrb_atsoptml_GRBaddvars"

fun 
setintattr (
model: model, attrname: NSH(string), newvalue: int
): int = "mac#atscntrb_atsoptml_GRBsetintattr"

fun
addconstr(
model: model, numnz: int, cind: cPtr0(int), cval: cPtr0(double),
sense: string, rhs: double, constrname: NSH(string)
): int = "mac#atscntrb_atsoptml_GRBaddconstr"

fun
optimize(
model: model
): int = "mac#atscntrb_atsoptml_GRBoptimize"

fun
write(
model: model, filename: NSH(string)
): int = "mac#atscntrb_atsoptml_GRBwrite"

// Include at end to prevent problems with ATS2 Mode in emacs:

(* ****** ****** *)

%{^
//
#include "atsoptml/CATS/gurobi.cats"
//
%} // end of [%{#]

(* ****** ****** *)
