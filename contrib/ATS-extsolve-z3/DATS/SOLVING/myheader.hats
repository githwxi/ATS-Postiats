(*
##
## ATS-extsolve-z3:
## Solving ATS-constraints with Z3
##
*)

(* ****** ****** *)
//
#define
SMT_LIBZ3_targetloc
"\
$PATSHOME/contrib\
/atscntrb/atscntrb-smt-libz3"
//
#define
PATSOLVE_targetloc "./../../ATS-extsolve"
//
(* ****** ****** *)
//
#staload "{$SMT_LIBZ3}/SATS/z3.sats"
//
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
