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
typedef
charptr =
$extype"atstype_string"
//
(* ****** ****** *)

#staload
UN = "prelude/SATS/unsafe.sats"

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
  val () =
  scadarglst_femit(out, args)
//
  val
  iscons = scadenv_is_cons(env)
//
  val () =
  if iscons then
  {
    val
    iscons = list_is_cons(args)
    val () =
    if iscons then fprint(out, ", ")
    val () = scadenv_femit(out, env)
  } (* end of [if] *) // end of [val]
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
| SCADEXPstring(s) =>
  (
    $extfcall
    ( void
    , "fprintf", out, "\"%s\"", $UN.cast{charptr}(s)
    ) (* $extfcall *)
  )
//
| SCADEXPvec(xs) =>
  (
    fprint(out, "[");
    scadexplst_femit(out, xs);
    fprint(out, "]");
  )
//
| SCADEXPcond(x0, x1, x2) =>
  (
    fprint!(out, "(", x0, ") ? (", x1, ") : (", x2, ")")
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
//
extern
fun
fprint_nspace
  (out: FILEref, nsp: int): void
//
implement
fprint_nspace
  (out, nsp) =
(
fix
loop
(
  out: FILEref, nsp: int
) : void =>
if nsp > 0
  then (fprint(out, ' '); loop(out, nsp-1))
// end of [if]
) (out, nsp) // end of [fprint_nspace]
//
(* ****** ****** *)

implement
scadobj_femit
  (out, nsp, obj) = let
(*
val () =
println! ("scadobj_femit")
*)
in
//
case+ obj of
| SCADOBJfapp
    (fopr, env, args) =>
  (
    fprint_nspace(out, nsp);
    fprint_string(out, fopr);
    fprint!(out, "(");
    scadarglst_env_femit(out, args, env);
    fprint!(out, ");\n");
  )
//
| SCADOBJmapp(mopr, objs) =>
  (
    fprint_nspace(out, nsp);
    fprint!(out, mopr, "()\n");
    fprint_nspace(out, nsp); fprint!(out, "{\n");
    scadobjlst_femit(out, nsp+2, objs);
    fprint_nspace(out, nsp); fprint!(out, "}\n");
  )
//
| SCADOBJtfmapp(tfm, objs) =>
  (
    scadtfm_femit(out, nsp, tfm);
    fprint_nspace(out, nsp); fprint!(out, "{\n");
    scadobjlst_femit(out, nsp+2, objs);
    fprint_nspace(out, nsp); fprint!(out, "}\n");
  )
//
| SCADOBJextcode(code) =>
  (
    fprint_nspace(out, nsp); fprint!(out, code, ";\n")
  )

//
end // end of [scadobj_femit]

(* ****** ****** *)

implement
scadobjlst_femit
  (out, nsp, objs) =
(
fix
loop
(
  out: FILEref, nsp: int, xs: scadobjlst
) : void =>
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  loop(out, nsp, xs) where
  {
    val () = scadobj_femit(out, nsp, x)
  } (* end of [list_cons] *)
)
) (out, nsp, objs) // end of [scadobjlst_femit]

(* ****** ****** *)

implement
scadtfm_femit
  (out, nsp, tfm) =
(
case+ tfm of
| SCADTFMident() =>
  (
    fprint_nspace(out, nsp);
    fprint!(out, "/* identity() */\n");
  )
//
| SCADTFMcompose
    (tfm1, tfm2) =>
  (
    scadtfm_femit(out, nsp, tfm1);
    scadtfm_femit(out, nsp, tfm2);  
  )
//
| SCADTFMextmcall
    (fmod, env, args) =>
  (
    fprint_nspace(out, nsp);
    fprint!(out, fmod); fprint!(out, "(");
    scadarglst_env_femit(out, args, env); fprint!(out, ")\n"); 
  ) (* SCADTFMextmcall *)
)

(* ****** ****** *)

(* end of [OpenSCAD_emit.dats] *)
