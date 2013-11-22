(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)

staload "./../utfpl.sats"

(* ****** ****** *)

staload "./eval_cloenv.sats"

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
| VALint (i) => fprintln! (out, "VALint(", i, ")")
| VALchar (c) => fprintln! (out, "VALchar(", c, ")")
| VALfloat (d) => fprintln! (out, "VALfloat(", d, ")")
| VALstring (str) => fprintln! (out, "VALstring(", str, ")")
| VALcst (d2c) => fprintln! (out, "VALcst(...)")
| VALlam (d2e, env) => fprintln! (out, "VALlam(...)")
| VALfix (d2e, env) => fprintln! (out, "VALfix(...)")
//
end // end of [fprint_value]

(* ****** ****** *)

(* end of [print.dats] *)
