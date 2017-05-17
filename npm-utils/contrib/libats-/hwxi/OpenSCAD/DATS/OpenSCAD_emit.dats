(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: May, 2017
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
(*
** For implementing
** a DSL that supports
** ATS and OpenSCAD co-programming
*)
(* ****** ****** *)
//
#staload "./../SATS/OpenSCAD.sats"
//
(* ****** ****** *)
//
implement
scadarg_femit
  (out, arg) =
(
case+ arg of
| SCADARGexp(x) => scadexp_femit(out, x)
| SCADARGlabexp(l, x) =>
  (
    fprint!(out, l, "="); scadexp_femit(out, x)
  )
)
//
(* ****** ****** *)

implement
scadarglst_femit
  (out, args) =
  loop(0, args) where
{
//
fun
loop
(
 i: int, xs: scadarglst
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  (
    if i > 0
      then fprint(out, ", ");
    // end of [if]
    scadarg_femit(out, x); loop(i+1, xs)
  ) (* end of [list_cons] *)
)
//
} (* end of [scadarglst_femit] *)

(* ****** ****** *)

implement
scadarglst_env_femit
  (out, args, env) =
{
//
  val
  iscons = list_is_cons(args)
//
  val () =
  scadarglst_femit(out, args)
//
  val () =
  if iscons then fprint(out, ", ")
//
  val () = fprint_scadenv(out, env)
//
} (* end of [scadarglst_env_femit] *)

(* ****** ****** *)

implement
scadexp_femit
  (out, exp) =
(
case+ exp of
| SCADEXPnil() =>
  (
    fprint(out, "()")
  )
//
| SCADEXPint(i) =>
  (
    fprint_int(out, i)
  )
//
| SCADEXPbool(b) =>
  (
    fprint_string
      (out, ifval(b, "true", "false"))
    // fprint_string
  )
| SCADEXPfloat(f) =>
  (
    $extfcall(void, "fprintf", out, "%.2f", f)
  )
//
| SCADEXPvec(xs) =>
  (
    fprint(out, "[");
    scadexplst_femit(out, xs);
    fprint(out, "]");
  )
//
| SCADEXPextfcall
    (fnm, env, args) =>
  (
    fprint(out, fnm);
    fprint(out, "(");
    scadarglst_env_femit(out, args, env);
    fprint(out, ")");
  )
) (* end of [scadexp_femit] *)

(* ****** ****** *)

implement
scadexplst_femit
  (out, exps) =
  loop(0, exps) where
{
//
fun
loop
(
 i: int, xs: scadexplst
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  (
    if i > 0
      then fprint(out, ", ");
    // end of [if]
    scadexp_femit(out, x); loop(i+1, xs)
  ) (* end of [list_cons] *)
)
//
} (* end of [scadexplst_femit] *)

(* ****** ****** *)

(* end of [OpenSCAD_emit.dats] *)
