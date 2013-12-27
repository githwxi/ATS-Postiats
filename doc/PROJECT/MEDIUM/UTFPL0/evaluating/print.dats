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
staload "./../utfpl.sats"
staload "./../utfpleval.sats"
//
(* ****** ****** *)

implement
fprint_val<value> = fprint_value
implement
fprint_val<labvalue> = fprint_labvalue

(* ****** ****** *)

implement
print_value (x0) = fprint (stdout_ref, x0)
implement
print_labvalue (x0) = fprint (stdout_ref, x0)

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
| VALtup (d2us) =>
    fprint! (out, "VALtup(", d2us, ")")
//
| VALrec (ld2us) =>
    fprint! (out, "VALrec(", ld2us, ")")
//
| VALlam _ => fprint! (out, "VALlam(...)")
| VALfix _ => fprint! (out, "VALfix(...)")
//
| VALfun _ => fprint! (out, "VALfun(...)")
//
| VALboxed _ => fprint! (out, "VALboxed(...)")
//
| VALerror (msg) => fprint! (out, "VALerror(", msg, ")")
//
end // end of [fprint_value]

(* ****** ****** *)

implement
fprint_labvalue
  (out, ld2u) = let
  val+LABVAL (lab, d2u) = ld2u
in
  fprint (out, lab); fprint (out, "->"); fprint_val<value> (out, d2u)
end // end of [fprint_labvalue]

(* ****** ****** *)

local

implement
fprint_val<value> = fprint2_value

in (* in of [local] *)

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
| VALtup (xs) => fprint! (out, "VALtup(", xs, ")")
| VALrec (lxs) => fprint! (out, "VALrec(", lxs, ")")
//
| _(*rest*) => fprint_value (out, x0)
//
end // end of [fprint2_value]

end // end of [local]

(* ****** ****** *)

(* end of [print.dats] *)
