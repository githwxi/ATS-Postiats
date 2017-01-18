(*
##
## ATS-extsolve-smt2:
## Outputing ATS-constraints
## in the format of smt-lib2
##
*)

(* ****** ****** *)

(*
//
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: June, 2016
//
** Author: William Blair
** Authoremail: wdblairATgmailDOTcom
** Start time: Some time in 2015
//
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "{$JSONC}/DATS/json.dats"

(* ****** ****** *)
//
local
#include"prelude/DATS/filebas.dats"
in (*nothing*) end // end of [local]
//
(* ****** ****** *)
//
local
#include"{$JSONC}/DATS/json_ML.dats"
in (*nothing*) end // end of [local]
//
(* ****** ****** *)

(* end of [patsolve_smt2_mylib.dats] *)
