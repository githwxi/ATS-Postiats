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
//
staload "./eval.sats"
//
(* ****** ****** *)

implement
print_value (x0) = fprint (stdout_ref, x0)

(* ****** ****** *)

implement
fprint_value
  (out, x0) = let
in
//
case+ x0 of
//
| VALint (i) =>
    fprintln! (out, "VALint(", i, ")")
//
| VALbool (b) =>
    fprintln! (out, "VALbool(", b, ")")
| VALchar (c) =>
    fprintln! (out, "VALchar(", c, ")")
//
| VALfloat (d) =>
    fprintln! (out, "VALfloat(", d, ")")
//
| VALstring (str) =>
    fprintln! (out, "VALstring(", str, ")")
//
| VALvoid () => fprintln! (out, "VALvoid()")
//
| VALcst (d2c) =>
    fprintln! (out, "VALcst(", d2c, ")")
| VALsym (d2s) =>
    fprintln! (out, "VALsym(", d2s, ")")
//
| VALlam _ => fprintln! (out, "VALlam(...)")
| VALfix _ => fprintln! (out, "VALfix(...)")
//
| VALfun _ => fprintln! (out, "VALfun(...)")
//
| VALerror () => fprintln! (out, "VALerror()")
//
end // end of [fprint_value]

(* ****** ****** *)

(* end of [print.dats] *)
