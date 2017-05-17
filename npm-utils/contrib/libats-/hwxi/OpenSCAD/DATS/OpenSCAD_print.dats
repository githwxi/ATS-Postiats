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
fprint_scadarg
  (out, arg) =
(
case+ arg of
| SCADARGexp(x) =>
  (
    fprint(out, x)
  )
| SCADARGlabexp(l, x) =>
  (
    fprint!(out, l, "=", x)
  )
)
//
(* ****** ****** *)

implement
fprint_scadexp
  (out, exp) =
(
case+ exp of
| SCADEXPnil() =>
  (
    fprint!(out, "SCADEXPnil()")
  )
//
| SCADEXPint(i) =>
  (
    fprint!(out, "SCADEXPint(", i, ")")
  )
//
| SCADEXPbool(b) =>
  (
    fprint!(out, "SCADEXPbool(", b, ")")
  )
| SCADEXPfloat(f0) =>
  $extfcall
  (
    void
  , "fprintf", out, "SCADEXPfloat(%.2f)", f0
  ) (* $extfcall *)
//
| SCADEXPvec(xs) =>
  (
    fprint!(out, "SCADEXPvec(", xs, ")")
  )
//
| SCADEXPcond(x0, x1, x2) =>
  (
    fprint!
    ( out
    , "SCADEXPcond(", x0, "; ", x1, "; ", x2, ")"
    ) (* fprint! *)
  )
//
| SCADEXPextfcall
    (fnm, env, args) =>
  (
    fprint!(out, fnm, "(", args, "; ", env, ")")
  )
) (* end of [fprint_scadexp] *)

(* ****** ****** *)

(* end of [OpenSCAD_print.dats] *)
