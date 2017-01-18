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
implement
print_form(x0) =
  fprint_form(stdout_ref, x0)
implement
prerr_form(x0) =
  fprint_form(stderr_ref, x0)
//
implement
fprint_form
  (out, x0) = (
//
case+ x0 of
| FORMint(i) =>
  fprint! (out, "FORMint(", i, ")")
| FORMbool(b) =>
  fprint! (out, "FORMint(", b, ")")
| FORMintrep(rep) =>
  fprint! (out, "FORMintrep(", rep, ")")
//
| FORMs2var(s2v) =>
  fprint! (out, "FORMs2var(", s2v, ")")
| FORMs2cst(s2c) =>
  fprint! (out, "FORMs2var(", s2c, ")")
//
| FORMs2exp(s2e) =>
  fprint! (out, "FORMs2exp(", s2e, ")")
//
| FORMnot(fml) =>
  (
    fprint (out, "FORMnot(");
    fprint_form(out, fml); fprint (out, ")")
  )
| FORMconj(fml1, fml2) =>
  (
    fprint (out, "FORMconj(");
    fprint_form(out, fml1); fprint_form(out, fml2); fprint (out, ")")
  )
| FORMdisj(fml1, fml2) =>
  (
    fprint (out, "FORMdisj(");
    fprint_form(out, fml1); fprint_form(out, fml2); fprint (out, ")")
  )
| FORMimpl(fml1, fml2) =>
  (
    fprint (out, "FORMimpl(");
    fprint_form(out, fml1); fprint_form(out, fml2); fprint (out, ")")
  )
//
) (* end of [fprint_form] *)
//
(* ****** ****** *)
//
implement
formula_null
  ((*void*)) = FORMint(0)
//
(* ****** ****** *)
//
implement
formula_true
  ((*void*)) = FORMbool(true)
implement
formula_false
  ((*void*)) = FORMbool(false)
//
(* ****** ****** *)
//
implement
formula_int
  (int) = FORMint(int)
implement
formula_intrep
  (rep) = FORMintrep(rep)
//  
(* ****** ****** *)
//
implement
formula_make_s2cst
  (env, s2c0) = FORMs2cst(s2c0)
implement
formula_make_s2var
  (env, s2v0) = FORMs2var(s2v0)
implement
formula_make_s2exp
  (env, s2p0) = FORMs2exp(s2p0)
//
(* ****** ****** *)

implement
formula_not(s2p) = FORMnot(s2p)

(* ****** ****** *)

implement
formula_conj_list
  (s2es) = let
//
fun
aux
(
  s2e0: form, s2es: formlst
) : form = (
//
case+ s2es of
| list_nil
    ((*void*)) => s2e0
| list_cons
    (s2e1, s2es2) =>
    aux(FORMconj(s2e0, s2e1), s2es2)
//
) (* end of [aux] *)
//
in
//
case+ s2es of
| list_nil() => FORMbool(true)
| list_cons(s2e, s2es) => aux(s2e, s2es)
//
end // end of [formula_conj_list]

(* ****** ****** *)

implement
formula_conj_list1
  (s2es_arg, s2e_res) = let
in
//
case+ s2es_arg of
| list_nil() => s2e_res
| list_cons _ =>
    FORMconj(formula_conj_list(s2es_arg), s2e_res)
  // end of [list_cons]
//
end // end of [formula_conj_list1]

implement
formula_impl_list1
  (s2es_arg, s2e_res) = let
in
//
case+ s2es_arg of
| list_nil() => s2e_res
| list_cons _ =>
    FORMimpl(formula_conj_list(s2es_arg), s2e_res)
  // end of [list_cons]
//
end // end of [formula_impl_list1]

(* ****** ****** *)

(* end of [patsolve_z3_solving_form.dats] *)
