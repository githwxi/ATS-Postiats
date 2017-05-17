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
assume
scadenv_type = List0(@(label, scadexp))
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
| list_nil() => None_vt()
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

(* end of [OpenSCAD_argenv.dats] *)
