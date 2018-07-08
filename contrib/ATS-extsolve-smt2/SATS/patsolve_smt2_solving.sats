(*
##
## ATS-extsolve-smt2:
## Outputing ATS-constraints
## in the format of smt-lib2
##
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: June, 2016
*)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"PATSOLVE_SMT2_SOLVING"
//
(* ****** ****** *)
//
#define
PATSOLVE_targetloc "./../ATS-extsolve"
//
(* ****** ****** *)
//
#staload
"{$PATSOLVE}/SATS/patsolve_cnstrnt.sats"
//
(* ****** ****** *)
//
fun
c3nstr_smt2_solve
  (out: FILEref, c3t0: c3nstr): void
//
(* ****** ****** *)
//
datatype form =
//
  | FORMint of (int)
  | FORMbool of bool
  | FORMintrep of (string(*rep*))
//
  | FORMs2var of (s2var)
  | FORMs2cst of (s2cst)
// (*
  | FORMs2exp of (s2exp) // unprocessed
// *)
//
  | FORMnot of (form)
  | FORMconj of (form, form)
  | FORMdisj of (form, form)
  | FORMimpl of (form, form)
//
(* ****** ****** *)
//
typedef formlst = List0 (form)
vtypedef formlst_vt = List0_vt (form)
//
(* ****** ****** *)
//
fun print_form : form -> void
fun prerr_form : form -> void
fun fprint_form : fprint_type(form)
//
overload print with print_form
overload prerr with prerr_form
overload fprint with fprint_form
//
(* ****** ****** *)

fun formula_null (): form

fun formula_true (): form
fun formula_false (): form

(* ****** ****** *)

fun formula_int (i: int): form
fun formula_intrep (rep: string): form

(* ****** ****** *)
//
fun formula_not (form): form
fun formula_disj (form, form): form
fun formula_conj (form, form): form
fun formula_impl (form, form): form
//
(* ****** ****** *)

fun formula_conj_list (formlst): form
fun formula_conj_list1 (formlst, form): form
fun formula_impl_list1 (formlst, form): form

(* ****** ****** *)
//
fun formula_ineg (form): form
//
fun formula_iadd (form, form): form
fun formula_isub (form, form): form
//
fun formula_imul (form, form): form
//
fun formula_idiv (form, form): form
fun formula_ndiv (form, form): form
//
fun formula_ilt (form, form): form
fun formula_ilte (form, form): form
fun formula_igt (form, form): form
fun formula_igte (form, form): form
fun formula_ieq (form, form): form
fun formula_ineq (form, form): form
//
(* ****** ****** *)
//
fun formula_iabs (form): form
//
fun formula_isgn (form): form
//
fun formula_imax (form, form): form
fun formula_imin (form, form): form
//
(* ****** ****** *)
//
fun formula_bneg (form): form
//
fun formula_badd (form, form): form
fun formula_bmul (form, form): form
//
fun formula_blt (form, form): form
fun formula_blte (form, form): form
fun formula_bgt (form, form): form
fun formula_bgte (form, form): form
fun formula_beq (form, form): form
fun formula_bneq (form, form): form
//
(* ****** ****** *)
//
fun
formula_real
  {p,q:int | q > 0}
  (num: int(p), den: int(q)): form
//
fun formula_int2real: (form) -> form
//
fun formula_neg_real: (form) -> form
fun formula_abs_real: (form) -> form
//
fun
formula_add_real_real(form, form): form
fun
formula_sub_real_real(form, form): form
fun
formula_mul_real_real(form, form): form
fun
formula_div_real_real(form, form): form
//
fun formula_add_int_real(form, form): form
fun formula_add_real_int(form, form): form
fun formula_sub_int_real(form, form): form
fun formula_sub_real_int(form, form): form
fun formula_mul_int_real(form, form): form
fun formula_div_real_int(form, form): form
//
fun
formula_lt_real_real: (form, form) -> form
fun
formula_lte_real_real: (form, form) -> form
fun
formula_gt_real_real: (form, form) -> form
fun
formula_gte_real_real: (form, form) -> form
fun
formula_eq_real_real: (form, form) -> form
fun
formula_neq_real_real: (form, form) -> form
//
fun formula_lt_real_int: (form, form) -> form
fun formula_lte_real_int: (form, form) -> form
fun formula_gt_real_int: (form, form) -> form
fun formula_gte_real_int: (form, form) -> form
fun formula_eq_real_int: (form, form) -> form
fun formula_neq_real_int: (form, form) -> form
//
(* ****** ****** *)
//
fun
formula_cond
(
  f_cond: form, f_then: form, f_else: form
) : form // end of [formula_cond]
//
(* ****** ****** *)
//
fun
formula_eqeq(s2e1: form, s2e2: form): form
//
(* ****** ****** *)
//
fun
formula_sizeof_t0ype(s2e_t0ype: form): form
//
(* ****** ****** *)
//
datatype
solvercmd =
//
| SOLVERCMDpop of ()
| SOLVERCMDpush of ()
//
| SOLVERCMDassert of (form)
| SOLVERCMDchecksat of ()
//
| SOLVERCMDecholoc of (loc_t)
//
| SOLVERCMDpopenv of (s2varlst)
| SOLVERCMDpushenv of ((*void*))
//
| SOLVERCMDpopenv2 of ((*void*))
| SOLVERCMDpushenv2 of (s2varlst)
//
(* ****** ****** *)
//
fun
print_solvercmd (solvercmd): void
and
prerr_solvercmd (solvercmd): void
fun
fprint_solvercmd : fprint_type(solvercmd)
//
overload print with print_solvercmd
overload prerr with prerr_solvercmd
overload fprint with fprint_solvercmd
//
(* ****** ****** *)
//
fun
solvercmdlst_reverse
  (List_vt(solvercmd)): List0_vt(solvercmd)
//
(* ****** ****** *)

absvtype smtenv_vtype = ptr
vtypedef smtenv = smtenv_vtype

(* ****** ****** *)
//
fun
smtenv_create(): smtenv
fun
smtenv_destroy(env: smtenv): List0_vt(solvercmd)
//
(* ****** ****** *)
//
(*
fun
s2var_pop_payload(s2var): form
fun
s2var_top_payload(s2var): form
fun
s2var_push_payload(s2var, form): void
*)
//
(* ****** ****** *)
//
fun
smtenv_add_s2var
  (env: !smtenv, s2v: s2var): void
fun
smtenv_add_s2exp
  (env: !smtenv, s2e: s2exp): void
fun
smtenv_add_h3ypo
  (env: !smtenv, h3p: h3ypo): void
//
(* ****** ****** *)
//
fun
formula_error_s2cst(s2c0: s2cst): form
fun
formula_error_s2exp(s2e0: s2exp): form
//
overload formula_error with formula_error_s2cst
overload formula_error with formula_error_s2exp
//
(* ****** ****** *)
//
fun
formula_make_s2cst
  (env: !smtenv, s2c: s2cst): form
(*
fun
formula_make_s2cst_fresh
  (env: !smtenv, s2c: s2cst): form
*)
//
fun
formula_make_s2var
  (env: !smtenv, s2v: s2var): form
(*
fun
formula_make_s2var_fresh
  (env: !smtenv, s2v: s2var): form
*)
//
fun
formula_make_s2Var_fresh
  (env: !smtenv, s2V: s2Var, s2t: s2rt): form
//
(* ****** ****** *)
//
fun
formula_make_s2exp
  (env: !smtenv, s2e: s2exp): form
fun
formulas_make_s2explst
  (env: !smtenv, s2es: s2explst): formlst
fun
formulas_make_labs2explst
  (env: !smtenv, ls2es: labs2explst): formlst
//
fun
formula_make_s2cst_s2explst
  (env: !smtenv, s2c: s2cst, s2es: s2explst): form
//
(* ****** ****** *)
//
fun
the_s2cinterp_initize(): void
//
fun
s2cst_get_s2cinterp(s2c: s2cst): s2cstopt
//
(* ****** ****** *)

absview smtenv_push_v

(* ****** ****** *)
//
fun
smtenv_pop(smtenv_push_v | !smtenv): void
//
fun
smtenv_push(env: !smtenv): (smtenv_push_v | void)
//
(* ****** ****** *)
//
fun
smtenv_solve_formula
(
  env: !smtenv, loc0: loc_t, fml: form
) : void // end-of-function
// 
(* ****** ****** *)
//
fun emit_form(out: FILEref, fml: form): void
//
fun emit_s2rt(out: FILEref, s2t: s2rt): void
fun emit_s2rtlst(out: FILEref, s2ts: s2rtlst): void
//
fun emit_s2cst(out: FILEref, s2e: s2cst): void
fun emit_s2var(out: FILEref, s2e: s2var): void
fun emit_s2exp(out: FILEref, s2e: s2exp): void
//
fun emit_decl_s2cst(out: FILEref, s2c: s2cst): void
fun emit_decl_s2cstlst(out: FILEref, s2cs: s2cstlst): void
//
fun emit_decl_s2var(out: FILEref, s2v: s2var): void
fun emit_decl_s2varlst(out: FILEref, s2vs: s2varlst): void
//
fun emit_solvercmd(out: FILEref, cmd: solvercmd): void
fun emit_solvercmdlst(out: FILEref, cmds: List(solvercmd)): void
//
(* ****** ****** *)
//
fun emit_preamble(FILEref): void
//
fun emit_preamble_real(FILEref): void
//
(*
fun emit_preamble_set(FILEref): void
fun emit_preamble_mset(FILEref): void
fun emit_preamble_array(FILEref): void
*)
//
(* ****** ****** *)
//
fun emit_the_s2cstmap(out: FILEref): void
//
(* ****** ****** *)

(* end of [patsolve_smt2_solving.sats] *)
