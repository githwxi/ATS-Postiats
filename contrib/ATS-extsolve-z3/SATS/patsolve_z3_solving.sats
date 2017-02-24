(*
##
## ATS-extsolve-z3:
## Solving ATS-constraints with Z3
##
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: June, 2015
*)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"PATSOLVE_Z3_SOLVING"
//
(* ****** ****** *)
//
#define
PATSOLVE_targetloc
"./../ATS-extsolve"
//
#define
SMT_LIBZ3_targetloc
"$PATSHOME/contrib/atscntrb-smt-libz3"
//
(* ****** ****** *)
//
#staload "{$SMT_LIBZ3}/SATS/z3.sats"
//
#staload
"{$PATSOLVE}/SATS/patsolve_cnstrnt.sats"
//
(* ****** ****** *)
//
fun
c3nstr_z3_solve(c3nstr): void
//
(* ****** ****** *)
//
absvtype sort_vtype = ptr
//
vtypedef sort = sort_vtype
vtypedef sortlst = List0_vt (sort)
//
absvtype form_vtype = ptr
//
vtypedef form = form_vtype
vtypedef formlst = List0_vt (form)
//
absvtype func_decl_vtype = ptr
vtypedef func_decl = func_decl_vtype
//
(* ****** ****** *)
//
fun sort_decref (sort): void
fun sort_incref (!sort): sort
//
fun formula_decref (form): void
fun formula_incref (!form): form
//
(* ****** ****** *)
//
fun sort_int (): sort
fun sort_bool (): sort
//
fun sort_real (): sort
(*
fun sort_string (): sort
*)
(* ****** ****** *)

fun sort_mk_cls (): sort
fun sort_mk_eff (): sort

(* ****** ****** *)
//
fun sort_mk_type (): sort
fun sort_mk_vtype (): sort
//
fun sort_mk_t0ype (): sort
fun sort_mk_vt0ype (): sort
//
fun sort_mk_prop (): sort
fun sort_mk_view (): sort
//
fun sort_mk_tkind (): sort
//
(* ****** ****** *)

fun sort_mk_abstract(name: string): sort

(* ****** ****** *)
//
fun sort_error (s2rt): sort
//
(* ****** ****** *)
//
fun sort_make_s2rt (s2rt): sort
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
(*
fun formula_add_int_real(form, form): form
fun formula_add_real_int(form, form): form
fun formula_sub_int_real(form, form): form
fun formula_sub_real_int(form, form): form
fun formula_mul_int_real(form, form): form
fun formula_div_real_int(form, form): form
*)
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
(*
fun formula_lt_real_int: (form, form) -> form
fun formula_lte_real_int: (form, form) -> form
fun formula_gt_real_int: (form, form) -> form
fun formula_gte_real_int: (form, form) -> form
fun formula_eq_real_int: (form, form) -> form
fun formula_neq_real_int: (form, form) -> form
*)
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
formula_eqeq (s2e1: form, s2e2: form): form
//
(* ****** ****** *)

fun
formula_sizeof_t0ype (s2e_t0ype: form): form

(* ****** ****** *)
//
fun
func_decl_0
  (name: string, res: sort): func_decl
fun
func_decl_1
  (name: string, arg: sort, res: sort): func_decl
fun
func_decl_2
  (name: string, a0: sort, a1: sort, res: sort): func_decl
//
fun
func_decl_list
  (name: string, domain: sortlst, range: sort): func_decl
//
(* ****** ****** *)
//
fun
formula_fdapp_0(fd: func_decl): form
fun
formula_fdapp_1(fd: func_decl, arg: form): form
fun
formula_fdapp_2(fd: func_decl, a0: form, a1: form): form
fun
formula_fdapp_list(fd: func_decl, args: formlst): form
//
(* ****** ****** *)

absvtype smtenv_vtype = ptr
vtypedef smtenv = smtenv_vtype

(* ****** ****** *)
//
fun
smtenv_create(): smtenv
fun
smtenv_destroy(env: smtenv): void
//
(* ****** ****** *)
//
fun
s2var_pop_payload(s2var): form
fun
s2var_top_payload(s2var): form
fun
s2var_push_payload(s2var, form): void
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
fun
formula_make_s2cst_fresh
  (env: !smtenv, s2c: s2cst): form
//
fun
formula_make_s2var
  (env: !smtenv, s2v: s2var): form
fun
formula_make_s2var_fresh
  (env: !smtenv, s2v: s2var): form
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
datatype
s2cinterp =
//
  | S2CINTnone of ()
  | S2CINTsome of (ptr)
//
  | S2CINTbuiltin_0 of (() -> form)
  | S2CINTbuiltin_1 of (form -> form)
  | S2CINTbuiltin_2 of ((form, form) -> form)
//
  | S2CINTbuiltin_list of ((formlst) -<cloref1> form)
//
//
(* ****** ****** *)
//
fun print_s2cinterp (s2cinterp): void
and prerr_s2cinterp (s2cinterp): void
fun fprint_s2cinterp : fprint_type(s2cinterp)
//
overload print with print_s2cinterp
overload prerr with prerr_s2cinterp
overload fprint with fprint_s2cinterp
//
(* ****** ****** *)
//
fun
s2cst_get_s2cinterp(s2cst): s2cinterp
//
fun
s2cfun_initize_s2cinterp(s2cst): void
//
fun the_s2cinterp_initize((*void*)): void
//
(* ****** ****** *)

absview smtenv_push_v

(* ****** ****** *)
//
fun
smtenv_pop (smtenv_push_v | !smtenv): void
//
fun
smtenv_push (env: !smtenv): (smtenv_push_v | void)
//
(* ****** ****** *)
//
fun
smtenv_solve_formula(!smtenv, form): Z3_lbool
// 
(* ****** ****** *)

(* end of [patsolve_z3_solving.sats] *)
