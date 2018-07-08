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
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#staload
"./../SATS/patsolve_smt2_commarg.sats"
#staload
"./../SATS/patsolve_smt2_solving.sats"
//
(* ****** ****** *)
//
(*
dynload
"ATS-extsolve/DATS/patsolve_cnstrnt.dats"
*)
val () =
patsolve_cnstrnt__dynload() where
{
  extern
  fun
  patsolve_cnstrnt__dynload(): void = "ext#"
}
//
(* ****** ****** *)
//
(*
dynload
"ATS-extsolve/DATS/patsolve_parsing.dats"
*)
val () =
patsolve_parsing__dynload() where
{
  extern
  fun
  patsolve_parsing__dynload(): void = "ext#"
}
//
(* ****** ****** *)

#dynload "./patsolve_smt2_commarg.dats"
#dynload "./patsolve_smt2_solving.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () =
prerrln!
  ("Hello from [patsolve_smt2]!")
//
val () = the_s2cinterp_initize()
//
val
arglst =
patsolve_smt2_cmdline (argc, argv)
//
// HX: skipping argv[0]
//
val-~list_vt_cons(_, arglst) = arglst
//
val () = patsolve_smt2_commarglst(arglst)
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [patsolve_smt2_main.dats] *)
