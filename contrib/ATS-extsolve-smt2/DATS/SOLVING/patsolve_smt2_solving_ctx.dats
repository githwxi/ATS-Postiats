(*
##
## ATS-extsolve-smt2:
## Outputing ATS-constraints
## in the format of smt-lib2
##
*)

(* ****** ****** *)
//
#ifndef
PATSOLVE_SMT2_SOLVING
#include "./myheader.hats"
#endif // end of [ifndef]
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

absvtype SMT2_context = ptr

(* ****** ****** *)

extern
fun
the_SMT2_context_vget
(
// argumentless
) : (
  SMT2_context -<prf> void | SMT2_context
) = "ext#patsolve_the_SMT2_context_vget"

(* ****** ****** *)
//
implement
the_SMT2_context_vget() = $UN.castvwtp0(the_null_ptr)
//
(* ****** ****** *)

(* end of [patsolve_smt2_solving_ctx.dats] *)
