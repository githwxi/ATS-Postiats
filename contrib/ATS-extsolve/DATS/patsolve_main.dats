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
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#staload
"./../SATS/patsolve_commarg.sats"
//
(* ****** ****** *)
//
(*
#dynload "patsolve_cnstrnt.dats"
*)
val () = patsolve_cnstrnt__dynload() where
{
  extern fun patsolve_cnstrnt__dynload(): void = "ext#"
}
//
(* ****** ****** *)
//
(*
#dynload "patsolve_parsing.dats"
*)
val () = patsolve_parsing__dynload() where
{
  extern fun patsolve_parsing__dynload(): void = "ext#"
}
//
(* ****** ****** *)
//
(*
#dynload "patsolve_commarg.dats"
*)
val () = patsolve_commarg__dynload() where
{
  extern fun patsolve_commarg__dynload(): void = "ext#"
}
//
(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () =
println! ("Hello from [patsolve]!")
//
val arglst =
  patsolve_cmdline (argc, argv)
//
// HX: skipping argv[0]
//
val-~list_vt_cons(arg, arglst) = arglst
//
val ((*void*)) = patsolve_commarglst (arglst)
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [patsolve_main.dats] *)
