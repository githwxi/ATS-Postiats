(*
##
## ATS-extsolve-smt2:
## Outputing ATS-constraints
## in the format of smt-lib2
##
*)

(* ****** ****** *)
//
#define
PATSOLVE_targetloc
"./../../ATS-extsolve"
//
(* ****** ****** *)
//
#staload
"{$PATSOLVE}/SATS/patsolve_cnstrnt.sats"
#staload
"{$PATSOLVE}/SATS/patsolve_parsing.sats"
//
(* ****** ****** *)
//
#staload
"./../../SATS/patsolve_smt2_solving.sats"
//
(* ****** ****** *)

(* end of [myheader.hats] *)
