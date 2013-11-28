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

extern
fun eval_cloenv (cloenv, d2exp): value

(* ****** ****** *)

implement
eval0_cloenv
  (d2e0) = eval_cloenv (cloenv_nil (), d2e0)
// end of [eval0_cloenv]

(* ****** ****** *)

local

typedef
aux_type (a:type) = (cloenv, a) -> value
extern fun aux_d2cst : aux_type (d2cst)
extern fun aux_d2var : aux_type (d2var)
extern fun aux_d2exp : aux_type (d2exp)
extern fun aux_d2exp_app : aux_type (d2exp)
extern fun aux_d2exp_ifopt : aux_type (d2exp)

typedef
auxlst_type (a:type) = (cloenv, List(a)) -> valuelst
extern fun auxlst_d2exp : auxlst_type (d2exp)

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
| D2Eapp _ => aux_d2exp_app (env, d2e0)
//
| D2Eifopt _ => aux_d2exp_ifopt (env, d2e0)
//
| D2Elam _ => VALlam (d2e0, env)
| D2Efix _ => VALfix (d2e0, env)
//
| D2Eerr () =>
    let val () = assertloc (false) in exit(1) end
  // end of [D2Eerr]
//
end // end of [aux_d2exp]

implement
aux_d2exp_app
  (env, d2e0) = let
//
val-D2Eapp
  (d2e1, d2es2) = d2e0.d2exp_node
//
val v_fun = aux_d2exp (env, d2e1)
val vs_arg = auxlst_d2exp (env, d2es2)
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

implement
aux_d2exp_ifopt
  (env, d2e0) = let
//
val-D2Eifopt
  (d2e1, d2e2, d2eopt3) = d2e0.d2exp_node
//
val-VALbool(test) = aux_d2exp (env, d2e1)
//
in
//
if test
  then
    aux_d2exp (env, d2e2)
  else (
    case+ d2eopt3 of
    | Some (d2e3) =>
        aux_d2exp (env, d2e3)
    | None () => VALvoid ()
  ) (* end of [else] *)
//
end // end of [aux_d2exp_ifopt]

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

implement eval_cloenv (env, d2e0) = aux_d2exp (env, d2e0)

end (* end of [local] *)

(* ****** ****** *)

(* end of [eval_cloenv.dats] *)
