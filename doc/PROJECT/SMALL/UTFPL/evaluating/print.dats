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
    fprint! (out, "VALint(", i, ")")
//
| VALbool (b) =>
    fprint! (out, "VALbool(", b, ")")
| VALchar (c) =>
    fprint! (out, "VALchar(", c, ")")
//
| VALfloat (d) =>
    fprint! (out, "VALfloat(", d, ")")
//
| VALstring (str) =>
    fprint! (out, "VALstring(", str, ")")
//
| VALvoid () => fprint! (out, "VALvoid()")
//
| VALcst (d2c) =>
    fprint! (out, "VALcst(", d2c, ")")
| VALvar (d2v) =>
    fprint! (out, "VALvar(", d2v, ")")
| VALsym (d2s) =>
    fprint! (out, "VALsym(", d2s, ")")
//
| VALlam _ => fprint! (out, "VALlam(...)")
| VALfix _ => fprint! (out, "VALfix(...)")
//
| VALfun _ => fprint! (out, "VALfun(...)")
//
| VALerror (msg) => fprint! (out, "VALerror(", msg, ")")
//
end // end of [fprint_value]

(* ****** ****** *)

implement
fprint2_value
  (out, x0) = let
in
//
case+ x0 of
//
| VALint (i) => fprint! (out, i)
| VALbool (b) => fprint! (out, b)
| VALchar (c) => fprint! (out, c)
| VALfloat (d) => fprint! (out, d)
| VALstring (str) => fprint! (out, str)
//
| VALvoid () => fprint! (out, "()")
//
| _(*rest*) => fprint_value (out, x0)
//
end // end of [fprint2_value]

(* ****** ****** *)

(* end of [print.dats] *)
