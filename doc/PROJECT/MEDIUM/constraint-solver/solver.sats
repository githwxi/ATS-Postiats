(*
  The interface to the SMT constraint solver
*)
//
#include
"share/atspre_define.hats"

staload "{$JSONC}/SATS/json.sats"
staload "{$JSONC}/SATS/json_ML.sats"

abstype solver
abstype constraint

fun solver_make (): solver

fun constraint_solve (jsonval): int

fun constraint_solve_main (solver, constraint): int