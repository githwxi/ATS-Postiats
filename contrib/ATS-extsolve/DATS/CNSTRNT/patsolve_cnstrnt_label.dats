(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)

implement
fprint_label
  (out, lab) =
(
//
case+ lab of
//
| LABint(int) =>
    fprint! (out, "LABint(", int, ")")
//
| LABsym(sym) =>
    fprint! (out, "LABsym(", sym, ")")
//
) (* end of [fprint_label] *)

(* ****** ****** *)

(* end of [patsolve_cnstrnt_label.dats] *)
