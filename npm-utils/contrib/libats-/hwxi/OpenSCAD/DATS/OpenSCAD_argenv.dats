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
scadexp_int
  (i0) = SCADEXPint(i0)
implement
scadexp_bool
  (b0) = SCADEXPbool(b0)
implement
scadexp_float
  (f0) = SCADEXPfloat(f0)
implement
scadexp_string
  (s0) = SCADEXPstring(s0)
//
implement
scadarg_int(i0) =
SCADARGexp(SCADEXPint(i0))
implement
scadarg_bool(b0) =
SCADARGexp(SCADEXPbool(b0))
implement
scadarg_float(f0) =
SCADARGexp(SCADEXPfloat(f0))
implement
scadarg_string(s0) =
SCADARGexp(SCADEXPstring(s0))
//
(* ****** ****** *)
//
assume
scadenv_type = List0(@(label, scadexp))
//
(* ****** ****** *)
//
implement
scadenv_nil() = list_nil()
//
implement
scadenv_sing(l, x) =
let
  val lx = @(l, x) in list_sing(lx)
end // end of [scadenv_sing]
//
(* ****** ****** *)
//
implement
scadenv_is_nil(env) = list_is_nil(env)
implement
scadenv_is_cons(env) = list_is_cons(env)
//
(* ****** ****** *)

implement
fprint_scadenv
  (out, lxs) = let
//
fun
loop
(
 i: int, lxs: scadenv
) : void =
(
case+ lxs of
| list_nil() => ()
| list_cons(lx, lxs) =>
  (
    if i > 0
      then fprint(out, ", ");
    // end of [if]
    fprint!(out, lx.0, "=", lx.1);
    loop(i+1, lxs)
  )
)
//
in
  loop(0, lxs)
end // end of [fprint_scadenv]

(* ****** ****** *)

implement
scadenv_search
  (lxs, k0) =
  loop(lxs) where
{
//
fun
loop
(
  lxs: scadenv
) : Option_vt(scadexp) =
(
case+ lxs of
| list_nil
    () => None_vt()
  // list_nil
| list_cons(lx, lxs) =>
  if (k0 = lx.0)
    then Some_vt(lx.1) else loop(lxs)
  // end of [if]
)
//
} (* end of [scadenv_search] *)

(* ****** ****** *)
//
implement
scadenv_insert_any
  (lxs, k0, x0) =
(
  scadenv_insert_any(lxs, k0, x0)
)
//
(* ****** ****** *)
//
implement
scadenv_femit
  (out, lxs) = let
//
fun
loop
(
 i: int, lxs: scadenv
) : void =
(
case+ lxs of
| list_nil() => ()
| list_cons(lx, lxs) =>
    loop(i+1, lxs) where
  {
    val () =
    if i > 0
      then fprint(out, ", ")
    // end of [if]
    val () = fprint!(out, lx.0, "=")
    val () = scadexp_femit(out, lx.1)
  }
) (* end of [loop] *)
//
in
  loop(0, lxs)
end // end of [scadenv_femit]

(* ****** ****** *)

(* end of [OpenSCAD_argenv.dats] *)
