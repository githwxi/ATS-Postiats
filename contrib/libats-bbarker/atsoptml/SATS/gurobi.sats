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
#define ATS_STALOADFLAG 0 // no static loading at run-time
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
vtypedef gvartyp = GRBvartype_vt0ype

// Need to verify API later
fun
loadenv(env: env, glog: String1): int

