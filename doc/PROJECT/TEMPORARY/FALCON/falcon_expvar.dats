(*
** FALCON project
*)

(* ****** ****** *)

staload "./falcon.sats"

(* ****** ****** *)

assume
expvar_type = @(double, double)

(* ****** ****** *)
//
implement
expvar_make
  (mean, stdev) = @(mean, stdev)
//
(* ****** ****** *)

implement
expvar_get_exp (x) = x.0
implement
expvar_get_var (x) = x.1

(* ****** ****** *)
//
implement
print_expvar (x) = fprint_expvar (stdout_ref, x)
//
implement
fprint_expvar (out, x) =
  fprint! (out, "(exp=", x.0, ", var=", x.1, ")")
//
(* ****** ****** *)

(* end of [falcon_expvar.dats] *)
