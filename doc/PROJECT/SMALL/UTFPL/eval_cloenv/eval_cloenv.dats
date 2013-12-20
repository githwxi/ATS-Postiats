(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "./../utfpl.sats"

(* ****** ****** *)

staload "./eval_cloenv.sats"

(* ****** ****** *)

local

typedef
aux_type (a:type) = (cloenv, a) -> value
//
extern fun aux_d2cst : aux_type (d2cst)
extern fun aux_d2var : aux_type (d2var)
extern fun aux_d2exp : aux_type (d2exp)
//
extern fun aux_d2exp_app (cloenv, value, d2explst): value
extern fun aux_d2exp_applst (cloenv, value, d2exparglst): value
//
extern fun aux_d2expopt : aux_type (d2expopt)
//
typedef
auxlst_type (a:type) = (cloenv, List(a)) -> valuelst
extern fun auxlst_d2exp : auxlst_type (d2exp)

(* ****** ****** *)

implement
aux_d2cst (env, d2c) = VALcst (d2c)

implement
aux_d2var (env, d2v) = cloenv_find_exn (env, d2v)

implement
aux_d2exp
  (env, d2e0) = let
in
//
case+ d2e0.d2exp_node of
//
| D2Evar (d2v) => aux_d2var (env, d2v)
| D2Ecst (d2c) => aux_d2cst (env, d2c)
//
| D2Eint (i) => VALint (i)
| D2Echar (c) => VALchar (c)
| D2Efloat (d) => VALfloat (d)
| D2Estring (str) => VALstring (str)
//
| D2Ei0nt (rep) => VALint (g0string2int(rep))
| D2Ef0loat (rep) => VALfloat (g0string2float(rep))
| D2Es0tring (str) => VALstring (str)
//
| D2Eempty () => VALvoid ()
//
| D2Elet
    (d2cs, d2e_scope) => let
    val env2 =
      eval_d2eclist (env, d2cs)
    // end of [val]
  in
    eval_d2exp (env2, d2e_scope)
  end // end of [D2Elet]
//
| D2Eapplst
    (d2e, d2as) => let
    val v_fun = aux_d2exp (env, d2e)
  in
    aux_d2exp_applst (env, v_fun, d2as)
  end // end of [D2Eapplst]
//
| D2Eifopt
    (d2e1, d2e2, d2eopt3) => let
    val-VALbool(test) = aux_d2exp (env, d2e1)
  in
    if test
      then aux_d2exp (env, d2e2)
      else aux_d2expopt (env, d2eopt3)
    // end of [if]
  end // end of [D2Eifopt]
//
| D2Elam _ => VALlam (d2e0, env)
| D2Efix _ => VALfix (d2e0, env)
//
| _(*rest*) =>
    let val () = assertloc (false) in exit(1) end
  // end of [_]
//
end // end of [aux_d2exp]

(* ****** ****** *)

implement
aux_d2exp_app
  (env, v_fun, d2es_arg) = let
//
val vs_arg = auxlst_d2exp (env, d2es_arg)
//
in
//
case+ v_fun of
| VALlam
    (d2e, env) => let
    val-D2Elam
      (p2ts_arg, d2e_body) = d2e.d2exp_node
    val env = cloenv_extend_arglst (env, p2ts_arg, vs_arg)
  in
    aux_d2exp (env, d2e_body)
  end // end of [VALlam]
//
| VALfix
    (d2e, env) => let
    val-D2Efix
      (d2v_fun, p2ts_arg, d2e_body) = d2e.d2exp_node
    val env = cloenv_extend (env, d2v_fun, v_fun)
    val env = cloenv_extend_arglst (env, p2ts_arg, vs_arg)
  in
    aux_d2exp (env, d2e_body)
  end // end of [VALfix]
//
| _ => let val () = assertloc (false) in exit(1) end
//
end // end of [aux_d2exp_app]

(* ****** ****** *)

implement
aux_d2exp_applst
  (env, v_fun, d2as) = let
in
//
case+ d2as of
| list_cons (d2a, d2as) =>
  (
    case+ d2a of
    | D2EXPARGsta _ =>
        aux_d2exp_applst (env, v_fun, d2as)
    | D2EXPARGdyn
        (_, _, d2es) => let
        val v_fun =
          aux_d2exp_app (env, v_fun, d2es)
        // end of [val]
      in
        aux_d2exp_applst (env, v_fun, d2as)
      end // end of [D2EXPARGlst]
  )
| list_nil ((*void*)) => v_fun
//
end // end of [aux_d2exp_applst]

(* ****** ****** *)

implement
aux_d2expopt (env, opt) =
(
case+ opt of
| Some (d2e) => aux_d2exp (env, d2e) | None () => VALvoid ()
) (* end of [aux_d2expopt] *)

(* ****** ****** *)

implement
auxlst_d2exp
  (env, d2es) = let
//
implement
list_map$fopr<d2exp><value> (d2e) = aux_d2exp (env, d2e)
//
in
  list_vt2t (list_map<d2exp><value> (d2es))
end // end of [auxlst_d2exp]

in (* in of [local] *)

implement eval_d2exp (env, d2e0) = aux_d2exp (env, d2e0)

end (* end of [local] *)

(* ****** ****** *)

local

extern
fun aux_impdec (cloenv, i2mpdec): cloenv
extern
fun aux_fundeclst (cloenv, f2undeclst): cloenv
extern
fun aux_valdeclst (cloenv, v2aldeclst): cloenv

in (* in of [local] *)

implement
aux_impdec
  (env, imp) = let
//
val d2c = imp.i2mpdec_cst
val def = eval_d2exp (env, imp.i2mpdec)
//
val () = impdec_insert (d2c, def)
//
in
  env
end // end of [aux_impdec]

implement
aux_fundeclst
  (env, f2ds) = let
in
//
case+ f2ds of
| list_nil () => env
| list_cons
    (f2d, f2ds) => let
    val def = eval_d2exp (env, f2d.f2undec_def)
    val env = cloenv_extend (env, f2d.f2undec_var, def)
  in
    aux_fundeclst (env, f2ds)
  end // end of [list_cons]
//
end // end of [aux_fundeclst]

(* ****** ****** *)

implement
aux_valdeclst
  (env, v2ds) = let
in
//
case+ v2ds of
| list_nil () => env
| list_cons
    (v2d, v2ds) => let
    val def = eval_d2exp (env, v2d.v2aldec_def)
    val env = cloenv_extend_arg (env, v2d.v2aldec_pat, def)
  in
    aux_valdeclst (env, v2ds)
  end // end of [list_cons]
//
end // end of [aux_valdeclst]

(* ****** ****** *)

implement
eval_d2ecl
  (env, d2c0) = let
in
//
case+
d2c0.d2ecl_node of
//
| D2Cimpdec
    (knd, imp) => aux_impdec (env, imp)
//
| D2Cfundecs
    (knd, f2ds) => aux_fundeclst (env, f2ds)
| D2Cvaldecs
    (knd, v2ds) => aux_valdeclst (env, v2ds)
//
| D2Clocal
  (
    d2cs_head, d2cs_body
  ) => let
    val env = eval_d2eclist (env, d2cs_head)
    val env = eval_d2eclist (env, d2cs_body)
  in
    env
  end (* end of [D2Clocal] *)
//
| D2Cignored () => env
//
end // end of [eval_d2ecl]

end // end of [local]

(* ****** ****** *)

implement
eval_d2eclist
  (env, d2cs) =
(
case+ d2cs of
| list_nil () => env
| list_cons
    (d2c, d2cs) => let
    val env = eval_d2ecl (env, d2c)
  in
    eval_d2eclist (env, d2cs)
  end // end of [list_cons]
)

(* ****** ****** *)

(* end of [eval_cloenv.dats] *)
