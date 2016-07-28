(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./expr.sats"

(* ****** ****** *)

#ifdef
CODEGEN2
#then
//
#codegen2("datcon", expr)
#codegen2("datcontag", expr)
#codegen2("fprint", expr, fprint_expr)
//
#else
//
#include "expr_codegen2.hats"
//
implement
fprint_expr$carg<expr> = fprint_expr
//
(*
implement
fprint_expr$Int<>
  (out, x) =
  let val-Int(i) = x in fprint(out, i) end
*)
//
implement
fprint_expr$Add$con<> (_, _) = ()
implement
fprint_expr$Add$sep1<> (out, _) = fprint! (out, "+")
//
(*
implement
fprint_expr$Sub$con<> (_, _) = ()
implement
fprint_expr$Sub$sep1<> (out, _) = fprint! (out, "-")
//
implement
fprint_expr$Mul$con<> (_, _) = ()
implement
fprint_expr$Mul$sep1<> (out, _) = fprint! (out, "*")
//
implement
fprint_expr$Div$con<> (_, _) = ()
implement
fprint_expr$Div$sep1<> (out, _) = fprint! (out, "/")
*)
//
extern
fun
my_fprint_expr
  (out: FILEref, x: expr): void
implement
my_fprint_expr (out, x) = fprint_expr<> (out, x)
//
overload fprint with my_fprint_expr
//
#endif // #ifdef(CODEGEN2)

(* ****** ****** *)

implement
main0 () =
{
//
val E = Add(Int(10), Mul(Int(1), Int(2)))
val () = fprintln! (stdout_ref, "E = ", E)
val () = fprintln! (stdout_ref, "datcon(E) = ", datcon_expr(E))
val () = fprintln! (stdout_ref, "datcontag(E) = ", datcontag_expr(E))
//
val E2 = Div(Int(1), Sub(E, E))
val () = fprintln! (stdout_ref, "E2 = ", E2)
val () = fprintln! (stdout_ref, "datcon(E2) = ", datcon_expr(E2))
val () = fprintln! (stdout_ref, "datcontag(E2) = ", datcontag_expr(E2))
//
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [expr.dats] *)

