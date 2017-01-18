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

fun
emit_bool
(
  out: FILEref, b: bool
) : void = (
//
fprint_string
(
  out, if b then "true" else "false"
)
//
) (* end of [emit_bool] *)

(* ****** ****** *)

implement
emit_form
  (out, fml) = let
(*
val () =
println! ("emit_form")
*)
in
//
case+ fml of
| FORMnot(fml) =>
  {
    val () =
      fprint(out, "(not ")
    // end of [val]
    val () = emit_form(out, fml)
    val () = fprint! (out, ")")
  }
| FORMs2exp(s2e) =>
  {
    val () = emit_s2exp(out, s2e)
  }
| _ (*rest*) => fprint_form(out, fml)
//
end // end of [emit_form]

(* ****** ****** *)

implement
emit_s2rt
  (out, s2t0) = let
//
(*
val () =
  println! ("emit_s2rt")
*)
//
macdef
emit(x) = fprint(out, ,(x))
//
in
//
case+ s2t0 of
//
| S2RTint() => emit("s2rt_int")
| S2RTaddr() => emit("s2rt_addr")
| S2RTbool() => emit("s2rt_bool")
//
| S2RTreal() => emit("s2rt_real")
//
| S2RTfloat() => emit("s2rt_float")
| S2RTstring() => emit("s2rt_string")
//
| S2RTcls() => emit("s2rt_cls")
| S2RTeff() => emit("s2rt_eff")
//
| S2RTtup() => emit("s2rt_tup")
//
| S2RTtype() => emit("s2rt_type")
| S2RTvtype() => emit("s2rt_vtype")
//
| S2RTt0ype() => emit("s2rt_t0ype")
| S2RTvt0ype() => emit("s2rt_vt0ype")
//
| S2RTprop() => emit("s2rt_prop")
| S2RTview() => emit("s2rt_view")
//
| S2RTtkind() => emit("s2rt_tkind")
//
| S2RTfun
  (
    s2ts_arg, s2t_res
  ) =>
  {
    val () = emit("(")
    val () = emit("s2rt_fun")
    val () = emit(" ")
    val () =
      emit_s2rtlst(out, s2ts_arg)
    // end of [val]
    val () = emit(" ")
    val () = emit_s2rt(out, s2t_res)
    val () = emit(")")
  }
//
| S2RTnamed
    (name) => fprint(out, name)
  // S2RTnamed
//
| S2RTerror() => emit("s2rt_error")
//
end // end of [emit_s2rt]

(* ****** ****** *)

implement
emit_s2rtlst
  (out, xs) = () where
{
//
val () = fprint(out, "(")
val () =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  {
    val () = emit_s2rt(out, x)
//
    var
    fwork =
    lam@
    (
      x: s2rt
    ) : void => (
    fprint (out, " "); emit_s2rt(out, x)
    ) (* end of [lam@] *)
//
    val () = list_foreach_clo(xs, fwork)
  }
)
val () = fprint(out, ")")
//
} (* end of [emit_s2rtlst] *)

(* ****** ****** *)

implement
emit_s2cst
  (out, s2c0) = let
//
val opt0 =
  s2cst_get_s2cinterp(s2c0)
//
in
//
case+ opt0 of
| Some _ =>
    fprint! (out, s2c0.name())
  // end of [Some]
| None _ => let
    val extdef = s2c0.extdef()
  in
    case+ extdef of
    | Some(name) => fprint! (out, name)
    | None((*void*)) =>
        fprint! (out, s2c0.name(), "!", s2c0.stamp())
      // end of [None]
  end // end of [None]
//
end // end of [emit_s2cst]

(* ****** ****** *)

implement
emit_s2var
  (out, s2v0) = let
//
val name = s2v0.name()
val stamp = s2v0.stamp()
//
in
  fprint! (out, name, "!", stamp)
end // end of [emit_s2var]

(* ****** ****** *)

implement
emit_s2exp
  (out, s2e0) = let
//
(*
val () = 
println! ("emit_s2exp")
*)
//
fun
aux_lt
(
  s2e1: s2exp, s2e2: s2exp
) : void =
{
   val () =
     fprint(out, "(< ")
   // end of [val]
   val () = emit_s2exp(out, s2e1)
   val () = fprint(out, " ")
   val () = emit_s2exp(out, s2e2)
   val () = fprint(out, ")")
}
//
fun
aux_lte
(
  s2e1: s2exp, s2e2: s2exp
) : void =
{
   val () =
     fprint(out, "(<= ")
   // end of [val]
   val () = emit_s2exp(out, s2e1)
   val () = fprint(out, " ")
   val () = emit_s2exp(out, s2e2)
   val () = fprint(out, ")")
}
//
fun
aux_metdec
(
  s2es1: s2explst, s2es2: s2explst
) : void =
(
case+ s2es1 of
| list_nil() =>
    emit_bool(out, false)
  // list_nil
| list_cons(s2e1, nil()) =>
  (
    case- s2es2 of
    | list_cons(s2e2, nil()) =>
      {
        val () = aux_lt(s2e1, s2e2)
      }
  )
| list_cons(s2e1, s2es1) =>
  (
    case- s2es2 of
    | list_cons(s2e2, s2es2) =>
      {
        val () = fprint(out, "(or ")
        val () = aux_lt(s2e1, s2e2)
        val () = fprint(out, " ")
        val () = fprint(out, "(and ")
        val () = aux_lte(s2e1, s2e2)
        val () = fprint(out, " ")
        val () = aux_metdec(s2es1, s2es2)
        val () = fprint(out, ")")
        val () = fprint(out, ")")
      }
  )
) (* end of [aux_metdec] *)
//
fun
auxsvs
(
  s2vs: s2varlst
) : void =
{
//
var
fwork =
lam@ (
  s2v: s2var
) : void =>
{
  val () = fprint(out, "(")
  val () =
  (
    emit_s2var(out, s2v);
    fprint(out, " "); emit_s2rt(out, s2v.srt())
  ) (* end of [val] *)
  val () = fprint(out, ")")
} (* end of [fwork] *)
//
val () = fprint(out, "(")
val () = list_foreach_clo(s2vs, fwork)
val () = fprint(out, ")")
//
} (* end of [auxsvs] *)
//
fun
auxsps
(
  s2ps: s2explst
) : void =
(
case+ s2ps of
| list_nil() => emit_bool(out, true)
| list_sing(s2p) => emit_s2exp(out, s2p)
  // end of [list_sing]
| list_cons
    (s2p, s2ps) => () where
  {
    val () =
      fprint(out, "(and ")
    // end of [val]
    val () = emit_s2exp(out, s2p)
    val () = fprint(out, " ")
    var
    fwork =
    lam@(s2p: s2exp) => (
      fprint(out, " ") ; emit_s2exp(out, s2p)
    ) (* end of [var] *)
    val () = list_foreach_clo<s2exp>(s2ps, fwork)
    val () = fprint(out, ")")
  } (* end of [list_cons] *)
)
//
fun
auxuni
(
  s2e0: s2exp
) : void = let
//
val-
S2Euni
(
  s2vs, s2ps, s2e_body
) = s2e0.s2exp_node
//
val issvs = list_is_cons(s2vs)
val issps = list_is_cons(s2ps)
//
val () =
  if issvs
    then fprint(out, "(forall ")
  // end of [if]
//
val () = if issvs then auxsvs(s2vs)
//
val () = if issvs then fprint(out, " ")
//
val () =
  if issps then fprint(out, "(=> ")
//
val () = if issps then auxsps(s2ps)
//
val () = if issps then fprint(out, " ")
//
val () = emit_s2exp(out, s2e_body)
//
val () = if issps then fprint(out, ")")
//
val () = if issvs then fprint(out, ")")
//
in
  // nothing
end // end of [auxuni]
//
fun
auxexi
(
  s2e0: s2exp
) : void = let
//
val-
S2Eexi
(
  s2vs, s2ps, s2e_body
) = s2e0.s2exp_node
//
val issvs = list_is_cons(s2vs)
val issps = list_is_cons(s2ps)
//
val () =
  if issvs
    then fprint(out, "(exists ")
  // end of [if]
//
val () = if issvs then auxsvs(s2vs)
//
val () = if issvs then fprint(out, " ")
//
val () =
  if issps then fprint(out, "(and ")
//
val () = if issps then auxsps(s2ps)
//
val () = if issps then fprint(out, " ")
//
val () = emit_s2exp(out, s2e_body)
//
val () = if issps then fprint(out, ")")
//
val () = if issvs then fprint(out, ")")
//
in
  // nothing
end // end of [auxexi]
//
in
//
case+
s2e0.s2exp_node
of // case+
| S2Eint(int) => fprint(out, int)
| S2Eintinf(rep) => fprint(out, rep)
| S2Ecst(s2c) => emit_s2cst(out, s2c)
| S2Evar(s2v) => emit_s2var(out, s2v)
//
| S2Eeqeq
    (s2e1, s2e2) =>
  {
    val () =
    fprint
      (out, "(s2exp_eqeq (=")
    // end of [val]
    val () = fprint(out, " ")
    val () = emit_s2exp(out, s2e1)
    val () = fprint(out, " ")
    val () = emit_s2exp(out, s2e2)
    val () = fprint(out, "))")
  }
//
| S2Esizeof(s2e) =>
  {
    val () =
    fprint(out, "(s2exp_sizeof ")
    val () = emit_s2exp(out, s2e)
    val () = fprintln! (out, ")")
  }
//
| S2Eapp
  (
    s2e_fun, s2es_arg
  ) =>
  {
    val () = fprint(out, "(")
    val () = emit_s2exp(out, s2e_fun)
//
    local
    var
    fwork =
    lam@
    (
      s2e: s2exp
    ) : void =<clo1>
    (
      fprint(out, " "); emit_s2exp(out, s2e)
    ) (* end of [list_foreach$fwork] *)
    in (* in-of-local*)
    val () = list_foreach_clo<s2exp>(s2es_arg, fwork)
    end // end of [local]
//
    val () = fprint(out, ")")
  } (* end of [S2Eapp] *)
//
| S2Emetdec
    (s2es1, s2es2) =>
  {
    val () = fprint(out, "(")
    val () =
      fprint(out, "s2exp_metdec")
    // end of [val]
    val () = fprint(out, " ")
    val () = aux_metdec(s2es1, s2es2)
    val () = fprint(out, ")")
  }
//
| S2Etop(knd, s2e) => emit_s2exp(out, s2e)
//
| S2Euni _ => auxuni(s2e0)
| S2Eexi _ => auxexi(s2e0)
//
| S2Efun
  (
    npf, s2es_arg, s2e_res
  ) => let
    val isarg = 
      list_is_cons(s2es_arg)
    // end of [val]
    val () =
      fprint(out, "(s2exp_fun ")
    // end of [val]
    val () =
      if isarg
        then fprint(out, "(=> ")
      // end of [if]
    val () =
      if isarg then auxsps(s2es_arg)
    val () =
      if isarg then fprint(out, " ")
    val () = emit_s2exp(out, s2e_res)
    val () =
      if isarg then fprint(out, ")")
    val ((*closed*)) = fprint(out, ")")
  in
    // nothing
  end // end of [S2Efun]
//
| _(*rest-of-s2exp*) => fprint(out, s2e0)
//
end // end of [emit_s2exp]

(* ****** ****** *)

implement
emit_decl_s2cst
  (out, s2c) = let
//
fun
auxs2t
(
  s2t: s2rt
) : void = (
//
case+ s2t of
| S2RTfun
  (
    s2ts_arg, s2t_res
  ) =>
  {
    val () =
      emit_s2rtlst(out, s2ts_arg)
    // end of [val]
    val () = fprint(out, " ")
    val () = emit_s2rt(out, s2t_res)
  }
| _(*non-fun*) => 
  (fprint(out, "() "); emit_s2rt(out, s2t))
//
) (* end of [auxs2t] *)
//
fun
auxs2c
(
  s2c: s2cst
) : void = let
//
val
extdef = s2c.extdef()
//
val () =
  fprint(out, "(declare-fun ")
//
val () =
(
case+ extdef of
| Some(name) =>
    fprint(out, name)
  // end of [Some]
| None((*void*)) =>
    fprint! (out, s2c.name(), "!", s2c.stamp())
  // end of [None]
)
val () = fprint(out, " ")
val () = auxs2t(s2c.srt())
val () = fprintln! (out, ")")
//
in
  // nothing
end // end of [auxs2c]
//
val opt0 =
  s2cst_get_s2cinterp(s2c)
//
in
//
case+ opt0 of
| None _ => auxs2c(s2c) | Some _ => ((*global*))
//
end // end of [emit_decl_s2cst]

(* ****** ****** *)

implement
emit_decl_s2cstlst
  (out, s2cs) = let
//
implement
list_foreach$fwork<s2cst><void>
  (s2c, env) = emit_decl_s2cst(out, s2c)
//
in
  list_foreach(s2cs)
end // end of [emit_decl_s2cstlst]

(* ****** ****** *)
//
implement
emit_decl_s2var
  (out, s2v) = {
//
val () =
fprint (
  out, "(declare-fun "
) (* fprint *)
//
val () = emit_s2var(out, s2v)
val () = fprint (out, " () ")
val () = emit_s2rt(out, s2v.srt())
val () = fprintln! (out, ")")
//
} (* end of [decl_s2var] *)
//
implement
emit_decl_s2varlst
  (out, s2vs) = let
//
implement
list_foreach$fwork<s2var><void>
  (s2v, env) = emit_decl_s2var(out, s2v)
//
in
  list_foreach(s2vs)
end // end of [emit_decl_s2varlst]
//
(* ****** ****** *)

implement
emit_solvercmd
  (out, cmd) = let
//
(*
val () =
println! ("emit_solvercmd")
*)
//
in
//
case+ cmd of
//
| SOLVERCMDpop() => fprintln! (out, "(pop 1)")
| SOLVERCMDpush() => fprintln! (out, "(push 1)")
//
| SOLVERCMDassert(fml) =>
  {
    val () =
      fprint(out, "(assert ")
    // end of [val]
    val () = emit_form(out, fml)
    val () = fprintln! (out, ")")
  } (* end of [SOLVERCMDassert] *)
//
| SOLVERCMDchecksat
    ((*void*)) => fprintln! (out, "(check-sat)")
//
| SOLVERCMDecholoc(loc) =>
  {
    val () = fprintln! (out, "(echo \"", loc, "\")")
  }
//
| SOLVERCMDpopenv _ => () // removed
| SOLVERCMDpushenv _ => () // removed
//
| SOLVERCMDpopenv2 _ =>
  {
    val ((*void*)) = fprintln! (out, "(pop 1)")
  }
| SOLVERCMDpushenv2(s2vs) =>
  {
    val ((*void*)) = fprintln! (out, "(push 1)")
    val ((*void*)) = emit_decl_s2varlst(out, s2vs)
  } (* SOLVERCMDpushenv2 *)
//
end // end of [emit_solvercmd]

(* ****** ****** *)

implement
emit_solvercmdlst
  (out, cmds) =
(
//
case+ cmds of
| list_nil() => ()
| list_cons(cmd, cmds) =>
  {
    val () = emit_solvercmd(out, cmd)
    val () = emit_solvercmdlst(out, cmds)
  } (* end of [list_cons] *)
//
) (* end of [emit_solvercmdlst] *)

(* ****** ****** *)

implement
emit_preamble(out) = {
//
macdef
emitln(x) = fprintln! (out, ,(x))
//
val () = emitln(";;")
val () = emitln(";;By [patsolve_smt2]:")
val () = emitln(";;")
//
val () = emitln("(declare-sort s2rt_cls 0)")
val () = emitln("(declare-sort s2rt_eff 0)")
val () = emitln("(declare-sort s2rt_prop 0)")
val () = emitln("(declare-sort s2rt_t0ype 0)")
val () = emitln("(declare-sort s2rt_tkind 0)")
val () = emitln("(declare-sort s2rt_error 0)")
//
val () = emitln("(define-sort s2rt_int () Int)")
val () = emitln("(define-sort s2rt_addr () Int)")
val () = emitln("(define-sort s2rt_bool () Bool)")
//
val () = emitln("(define-sort file_mode () Int)")
//
val () = emitln("(define-sort s2rt_view () s2rt_prop)")
val () = emitln("(define-sort s2rt_type () s2rt_t0ype)")
val () = emitln("(define-sort s2rt_vtype () s2rt_t0ype)")
val () = emitln("(define-sort s2rt_vt0ype () s2rt_t0ype)")
//
val () = emitln("(define-fun unit_p () Bool true)")
//
val () = emitln("(define-fun s2exp_fun ((x Bool)) Bool x)")
val () = emitln("(define-fun s2exp_eqeq ((x Bool)) Bool x)")
val () = emitln("(define-fun s2exp_metdec ((x Bool)) Bool x)")
//
val () = emitln("(declare-fun s2exp_sizeof (s2rt_t0ype) Int)")
//
val () = emitln("(define-fun neg_int ((x Int)) Int (- x))")
val () = emitln("(define-fun abs_int ((x Int)) Int (abs x))")
val () = emitln("(define-fun add_int_int ((x Int) (y Int)) Int (+ x y))")
val () = emitln("(define-fun sub_int_int ((x Int) (y Int)) Int (- x y))")
val () = emitln("(define-fun mul_int_int ((x Int) (y Int)) Int (* x y))")
val () = emitln("(define-fun div_int_int ((x Int) (y Int)) Int (div x y))")
val () = emitln("(define-fun mod_int_int ((x Int) (y Int)) Int (mod x y))")
//
val () = emitln("(define-fun idiv_int_int ((x Int) (y Int)) Int (div x y))")
val () = emitln("(define-fun ndiv_int_int ((x Int) (y Int)) Int (div x y))")
//
val () = emitln("(define-fun eq_int_int ((x Int) (y Int)) Bool (= x y))")
val () = emitln("(define-fun lt_int_int ((x Int) (y Int)) Bool (< x y))")
val () = emitln("(define-fun gt_int_int ((x Int) (y Int)) Bool (> x y))")
val () = emitln("(define-fun lte_int_int ((x Int) (y Int)) Bool (<= x y))")
val () = emitln("(define-fun gte_int_int ((x Int) (y Int)) Bool (>= x y))")
val () = emitln("(define-fun neq_int_int ((x Int) (y Int)) Bool (not (= x y)))")
//
val () = emitln("(define-fun max_int_int ((x Int) (y Int)) Int (ite (>= x y) x y))")
val () = emitln("(define-fun min_int_int ((x Int) (y Int)) Int (ite (<= x y) x y))")
//
val () = emitln("(define-fun sgn_int ((x Int)) Int (ite (> x 0) 1 (ite (>= x 0) 0 (- 1))))")
//
val () = emitln("(define-fun null_addr () s2rt_addr 0)")
//
val () = emitln("(define-fun add_addr_int ((x s2rt_addr) (y Int)) s2rt_addr (+ x y))")
val () = emitln("(define-fun sub_addr_int ((x s2rt_addr) (y Int)) s2rt_addr (- x y))")
//
val () = emitln("(define-fun eq_addr_addr ((x s2rt_addr) (y s2rt_addr)) Bool (= x y))")
val () = emitln("(define-fun lt_addr_addr ((x s2rt_addr) (y s2rt_addr)) Bool (< x y))")
val () = emitln("(define-fun gt_addr_addr ((x s2rt_addr) (y s2rt_addr)) Bool (> x y))")
val () = emitln("(define-fun lte_addr_addr ((x s2rt_addr) (y s2rt_addr)) Bool (<= x y))")
val () = emitln("(define-fun gte_addr_addr ((x s2rt_addr) (y s2rt_addr)) Bool (>= x y))")
val () = emitln("(define-fun neq_addr_addr ((x s2rt_addr) (y s2rt_addr)) Bool (not (= x y)))")
//
val () = emitln("(define-fun true_bool () Bool true)")
val () = emitln("(define-fun false_bool () Bool false)")
//
val () = emitln("(define-fun neg_bool ((x Bool)) Bool (not x))")
val () = emitln("(define-fun add_bool_bool ((x Bool) (y Bool)) Bool (or x y))")
val () = emitln("(define-fun mul_bool_bool ((x Bool) (y Bool)) Bool (and x y))")
//
val () = emitln("(define-fun eq_bool_bool ((x Bool) (y Bool)) Bool (= x y))")
val () = emitln("(define-fun lt_bool_bool ((x Bool) (y Bool)) Bool (and (not x) y))")
val () = emitln("(define-fun gt_bool_bool ((x Bool) (y Bool)) Bool (and x (not y)))")
val () = emitln("(define-fun neq_bool_bool ((x Bool) (y Bool)) Bool (not (= x y)))")
val () = emitln("(define-fun lte_bool_bool ((x Bool) (y Bool)) Bool (or (not x) y))")
val () = emitln("(define-fun gte_bool_bool ((x Bool) (y Bool)) Bool (or x (not y)))")
//
} (* end of [emit_preamble] *)

(* ****** ****** *)

implement
emit_preamble_real(out) = {
//
macdef
emitln(x) = fprintln! (out, ,(x))
//
val () = emitln(";;")
val () = emitln(";;emit_preamble_real()")
val () = emitln(";;")
//
val () = emitln("(define-sort s2rt_real () Real)")
//
val () = emitln("(define-fun int2real ((x Int)) Real (to_real x))")
val () = emitln("(define-fun floor_real ((x Real)) Int (to_int x))")
val () = emitln("(define-fun isint_real ((x Real)) Bool (is_int x))")
//
val () = emitln("(define-fun neg_real ((x Real)) Real (- x))")
val () = emitln("(define-fun abs_real ((x Real)) Real (ite (>= x 0.0) x (- x)))")
//
val () = emitln("(define-fun add_real_real ((x Real) (y Real)) Real (+ x y))")
val () = emitln("(define-fun sub_real_real ((x Real) (y Real)) Real (- x y))")
val () = emitln("(define-fun mul_real_real ((x Real) (y Real)) Real (* x y))")
val () = emitln("(define-fun div_real_real ((x Real) (y Real)) Real (/ x y))")
//
val () = emitln("(define-fun eq_real_real ((x Real) (y Real)) Bool (= x y))")
val () = emitln("(define-fun lt_real_real ((x Real) (y Real)) Bool (< x y))")
val () = emitln("(define-fun gt_real_real ((x Real) (y Real)) Bool (> x y))")
val () = emitln("(define-fun lte_real_real ((x Real) (y Real)) Bool (<= x y))")
val () = emitln("(define-fun gte_real_real ((x Real) (y Real)) Bool (>= x y))")
val () = emitln("(define-fun neq_real_real ((x Real) (y Real)) Bool (not (= x y)))")
//
val () = emitln("(define-fun max_real_real ((x Real) (y Real)) Real (ite (>= x y) x y))")
val () = emitln("(define-fun min_real_real ((x Real) (y Real)) Real (ite (<= x y) x y))")
//
val () = emitln("(define-fun sgn_real ((x Real)) Int (ite (> x 0.0) 1 (ite (>= x 0.0) 0 (- 1))))")
//
} (* end of [emit_preamble_real] *)

(* ****** ****** *)

implement
emit_the_s2cstmap
  (out) = () where
{
//
macdef
emitln(x) = fprintln! (out, ,(x))
//
fun
auxlst
(
  s2cs: s2cstlst
) : void = (
//
case+ s2cs of
| list_nil() => ()
| list_cons(s2c, s2cs) => let
    val n0 = s2cst_get_nused(s2c)
    val () =
      if n0 > 0 then emit_decl_s2cst(out, s2c)
    // end of [val]
  in
    auxlst(s2cs)
  end // end of [list_cons]
//
) (* end of [auxlst] *)
//
val s2cs = the_s2cstmap_listize()
//
val () = emitln(";;")
val () = emitln(";;emit_the_s2cstmap()")
val () = emitln(";;")
//
val ((*void*)) = auxlst($UN.list_vt2t(s2cs))
//
val ((*freed*)) = list_vt_free(s2cs)
//
} (* end of [emit_the_s2cstmap] *)

(* ****** ****** *)

(* end of [patsolve_smt2_solving_emit.dats] *)
