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
//
#define
ATS_PACKNAME "PATSOLVE_SMT2_COMMARG"
//
(* ****** ****** *)

datatype
commarg =
//
  | CAhelp of (string)
//
  | CAgitem of (string)
//
  | CAinput of (string)
  | CAoutput of (int(*knd*), string)
//
  | CAprintln of (string)
  | CAprintfile of (string)
//
  | CAargend of ((*void*))
// end of [commarg]

(* ****** ****** *)
//
typedef
commarglst = List0(commarg)
vtypedef
commarglst_vt = List0_vt(commarg)
//
(* ****** ****** *)
//
fun
fprint_commarg
(
  out: FILEref, ca: commarg
) : void // end-of-fun
//
overload fprint with fprint_commarg
//
(* ****** ****** *)
//
fun
patsolve_smt2_cmdline
  {n:nat}
(
  argc: int(n), argv: !argv(n)
) : commarglst_vt // end-of-fun
//
(* ****** ****** *)
//
fun
patsolve_smt2_commarglst
  (arglst: commarglst_vt): void
// 
(* ****** ****** *)
//
fun
the_constraint_real((*void*)): int
//
(* ****** ****** *)

(* end of [patsolve_smt2_commarg.sats] *)
