(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"./../utfpl.sats"
staload
"./../utfpleval.sats"
//
staload "./eval.sats"
//
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
val def = eval_d2exp (env, imp.i2mpdec_def)
//
val () = the_d2cstmap_add (d2c, def)
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
    val d2v = f2d.f2undec_var
    val def = f2d.f2undec_def
    val () = d2var_set_bind (d2v, def)
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
    val env = cloenv_extend_pat (env, v2d.v2aldec_pat, def)
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
(*
    val () = fprintln! (stdout_ref, "eval_d2eclist: env(bef) = ", env)
*)
    val env = eval_d2ecl (env, d2c)
(*
    val () = fprintln! (stdout_ref, "eval_d2eclist: env(aft) = ", env)
*)
  in
    eval_d2eclist (env, d2cs)
  end // end of [list_cons]
)

(* ****** ****** *)

implement
eval0_d2eclist
  (d2cs) = let
//
val env = cloenv_nil ()
//
in
  eval_d2eclist (env, d2cs)
end // end of [eval_d2eclist]

(* ****** ****** *)

(* end of [eval.dats] *)
