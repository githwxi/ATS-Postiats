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
staload "./patsolve_smt2_solving_ctx.dats"
//
(* ****** ****** *)
//
extern
fun
SMT2_assert(env: !smtenv, form): void
//
(* ****** ****** *)
//
datavtype
SMT2_solver =
SMT2_SOLVER of List0_vt(solvercmd)
//
(* ****** ****** *)
//
fun
SMT2_solver_pop
(
  solver: !SMT2_solver
) : void =
{
//
val+@SMT2_SOLVER(xs) = solver
val ((*void*)) =
(
//
xs :=
list_vt_cons(SOLVERCMDpop(), xs)
//
) (* end of [val] *)
prval ((*folded*)) = fold@(solver)
} (* end of [SMT2_solver_pop] *)
//
fun
SMT2_solver_push
(
  solver: !SMT2_solver
) : void =
{
val+@SMT2_SOLVER(xs) = solver
val ((*void*)) =
(
//
xs :=
list_vt_cons(SOLVERCMDpush(), xs)
//
) (* end of [val] *)
prval ((*folded*)) = fold@(solver)
} (* end of [SMT2_solver_push] *)
//
(* ****** ****** *)

fun
SMT2_solver_echoloc
(
  solver: !SMT2_solver, loc: loc_t
) : void =
{
val+@SMT2_SOLVER(xs) = solver
val ((*void*)) =
(
//
xs :=
list_vt_cons(SOLVERCMDecholoc(loc), xs)
//
) (* end of [val] *)
prval ((*folded*)) = fold@(solver)
//
} (* end of [SMT2_solver_echoloc] *)

(* ****** ****** *)
//
fun
SMT2_solver_checksat
(
  solver: !SMT2_solver
) : void =
{
val+@SMT2_SOLVER(xs) = solver
val ((*void*)) =
(
//
  xs :=
  list_vt_cons(SOLVERCMDchecksat(), xs)
//
) (* end of [val] *)
prval ((*folded*)) = fold@(solver)
} (* end of [SMT2_solver_checksat] *)
//
fun
SMT2_solver_assert
(
  solver: !SMT2_solver, fml: form
) : void =
{
//
val+@SMT2_SOLVER(xs) = solver
val ((*void*)) =
(
  xs := list_vt_cons(SOLVERCMDassert(fml), xs)
) (* end of [val] *)
prval ((*folded*)) = fold@(solver)
//
} (* end of [SMT2_solver_assert] *)
//
(* ****** ****** *)
//
fun
SMT2_solver_popenv
(
  solver: !SMT2_solver, s2vs: s2varlst
) : void =
{
//
val s2vs =
list_vt2t(list_reverse(s2vs))
//
val+@SMT2_SOLVER(xs) = solver
val ((*void*)) =
(
  xs :=
  list_vt_cons(SOLVERCMDpopenv(s2vs), xs)
) (* end of [val] *)
//
prval ((*folded*)) = fold@(solver)
//
} (* end of [SMT2_solver_popenv] *)
//
fun
SMT2_solver_pushenv
  (solver: !SMT2_solver): void =
{
//
val+@SMT2_SOLVER(xs) = solver
val ((*void*)) =
(
  xs := list_vt_cons(SOLVERCMDpushenv(), xs)
) (* end of [val] *)
//
prval ((*folded*)) = fold@(solver)
//
} (* end of [SMT2_solver_pushenv] *)
//
(* ****** ****** *)
//
fun
SMT2_solver_getfree
(
  solver: SMT2_solver
) : List0_vt(solvercmd) =
  xs where
{
//
val+~SMT2_SOLVER(xs) = solver
//
} (* end of [SMT2_solver_getfree] *)
//
(* ****** ****** *)

datavtype
smtenv =
SMTENV of
(
  smtenv_struct
) where smtenv_struct = @{
//
smtenv_solver= SMT2_solver
,
smtenv_s2varlst = s2varlst
,
smtenv_s2varlstlst = List0_vt(s2varlst)
//
} (* end of [smtenv_struct] *)

(* ****** ****** *)
//
extern
fun
smtenv_s2varlstlst_vt_free
  (xss: List0_vt(s2varlst)): void
//
implement
smtenv_s2varlstlst_vt_free(xss) = list_vt_free(xss)
//
(* ****** ****** *)

assume smtenv_vtype = smtenv
assume smtenv_push_v = unit_v

(* ****** ****** *)

implement
smtenv_create
  () = env where
{
//
val env = SMTENV(_)
//
val+SMTENV(env_s) = env
//
val () =
(
  env_s.smtenv_solver := SMT2_SOLVER(nil_vt)
)
//
val () = env_s.smtenv_s2varlst := nil((*void*))
val () = env_s.smtenv_s2varlstlst := nil_vt(*void*)
//
prval () = fold@(env)
//
} (* end of [smtenv_create] *)

(* ****** ****** *)

implement
smtenv_destroy
  (env) = xs where
{
//
val+~SMTENV(env_s) = env
//
val xs = SMT2_solver_getfree(env_s.smtenv_solver)
val () = smtenv_s2varlstlst_vt_free(env_s.smtenv_s2varlstlst)
//
} (* end of [smtenv_destroy] *)

(* ****** ****** *)

implement
smtenv_pop
  (pf | env) = let
//
prval
unit_v((*void*)) = pf
//
val+@SMTENV(env_s) = env
//
val ((*void*)) =
SMT2_solver_popenv
(
  env_s.smtenv_solver
, env_s.smtenv_s2varlst
)
val s2vss = env_s.smtenv_s2varlstlst
val-~list_vt_cons(s2vs, s2vss) = s2vss
val ((*void*)) = env_s.smtenv_s2varlst := s2vs
val ((*void*)) = env_s.smtenv_s2varlstlst := s2vss
//
prval ((*folded*)) = fold@(env)
//
in
  // nothing
end // end of [smtenv_pop]

(* ****** ****** *)

implement
smtenv_push
  (env) = let
//
val+@SMTENV(env_s) = env
//
val ((*void*)) =
  SMT2_solver_pushenv(env_s.smtenv_solver)
//
val s2vs = env_s.smtenv_s2varlst
val s2vss = env_s.smtenv_s2varlstlst
val ((*void*)) =
  env_s.smtenv_s2varlst := nil((*void*))
val ((*void*)) =
  env_s.smtenv_s2varlstlst := cons_vt(s2vs, s2vss)
//
prval ((*folded*)) = fold@(env)
//
in
  (unit_v() | ())
end // end of [smtenv_push]

(* ****** ****** *)

implement
smtenv_add_s2var
  (env, s2v0) = () where
{
//
val+@SMTENV(env_s) = env
//
val s2vs = env_s.smtenv_s2varlst
val ((*void*)) =
  env_s.smtenv_s2varlst := cons(s2v0, s2vs)
prval ((*void*)) = fold@(env)
//
} (* end of [smtenv_add_s2var] *)

(* ****** ****** *)

implement
smtenv_add_s2exp
  (env, s2p0) =
{
//
val
s2p0 =
formula_make_s2exp
  (env, s2p0)
//
val+
@SMTENV(env_s) = env
//
val ((*void*)) =
SMT2_solver_assert(env_s.smtenv_solver, s2p0)
//
prval ((*folded*)) = fold@(env)
//
} (* end of [smtenv_add_s2exp] *)

(* ****** ****** *)
//
implement
smtenv_add_h3ypo
  (env, h3p0) = let
//
(*
val () =
fprintln!
(
  stdout_ref
, "smtenv_add_h3ypo: h3p0 = ", h3p0
) (* end of [val] *)
*)
//
in
//
case+
h3p0.h3ypo_node
of (* case+ *)
| H3YPOprop s2p =>
    smtenv_add_s2exp(env, s2p)
  // end of [H3YPOprop]
//
| H3YPObind
    (s2v1, s2e2) => let
  in
    if s2var_is_impred(s2v1)
      then ()
      else let
        val s2p =
        s2exp_eqeq
          (s2exp_var(s2v1), s2e2)
        // end of [val]
      in
        smtenv_add_s2exp(env, s2p)
      end // end of [else]
  end // end of [H3YPObind]
//
| H3YPOeqeq
    (s2e1, s2e2) =>
  (
    smtenv_add_s2exp(env, s2exp_eqeq(s2e1, s2e2))
  ) (* end of [H3YPOeqeq] *)
//
end // end of [smtenv_add_h3ypo]

(* ****** ****** *)

implement
smtenv_solve_formula
  (env, loc0, s2p0) =
{
//
val+
@SMTENV(env_s) = env
//
val () =
SMT2_solver_push(env_s.smtenv_solver)
//
val () =
SMT2_solver_assert
  (env_s.smtenv_solver, formula_not(s2p0))
//
val () =
SMT2_solver_echoloc
(
  env_s.smtenv_solver, loc0(*constraint*)
) (* end of [val] *)
//
val () =
  SMT2_solver_checksat(env_s.smtenv_solver)
//
val () = SMT2_solver_pop(env_s.smtenv_solver)
//
prval ((*void*)) = fold@(env)
//
} (* end of [smtenv_solve_formula] *)

(* ****** ****** *)

(* end of [patsolve_smt2_solving_smtenv.dats] *)
