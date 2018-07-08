(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: May, 2015
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#define
LIBJSONC_targetloc
"\
$PATSHOME/contrib\
/atscntrb/atscntrb-hx-libjson-c"
//
#staload
"{$LIBJSONC}/DATS/json.dats"
//
(* ****** ****** *)
//
local
#include
"{$LIBJSONC}/DATS/json_ML.dats"
in (*nothing*) end // end of [local]
//
(* ****** ****** *)

(* end of [patsolve_mylib.dats] *)
