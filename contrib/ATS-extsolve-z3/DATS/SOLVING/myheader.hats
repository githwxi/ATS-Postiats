(*
##
## ATS-extsolve-z3:
## Solving ATS-constraints with Z3
##
*)

(* ****** ****** *)
//
#define
Z3_targetloc
"$PATSCONTRIB/contrib/SMT/Z3"
//
#define
PATSOLVE_targetloc "./../../ATS-extsolve"
//
(* ****** ****** *)

#staload "{$Z3}/SATS/z3.sats"

(* ****** ****** *)
//
#staload
"{$PATSOLVE}/SATS/patsolve_cnstrnt.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/patsolve_z3_solving.sats"
//
(* ****** ****** *)

(* end of [myheader.hats] *)
