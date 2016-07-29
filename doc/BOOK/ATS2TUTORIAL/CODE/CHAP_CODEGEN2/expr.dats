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
#codegen2("fprint", expr, fprint_expr_)
//
#else
//
#include "expr_codegen2.hats"
//
extern
fun
datcon_expr : (expr) -> string
implement
datcon_expr(x) = datcon_expr_(x)
//
extern
fun
datcontag_expr : (expr) -> int
implement
datcontag_expr(x) = datcontag_expr_(x)
//
implement
fprint_expr_$carg<expr> = fprint_expr_
//
(*
implement
fprint_expr_$Int<>
  (out, x) =
  let val-Int(i) = x in fprint(out, i) end
*)
//
implement
fprint_expr_$Add$con<> (_, _) = ()
implement
fprint_expr_$Add$sep1<> (out, _) = fprint! (out, "+")
//
(*
implement
fprint_expr_$Sub$con<> (_, _) = ()
implement
fprint_expr_$Sub$sep1<> (out, _) = fprint! (out, "-")
//
implement
fprint_expr_$Mul$con<> (_, _) = ()
implement
fprint_expr_$Mul$sep1<> (out, _) = fprint! (out, "*")
//
implement
fprint_expr_$Div$con<> (_, _) = ()
implement
fprint_expr_$Div$sep1<> (out, _) = fprint! (out, "/")
*)
//
extern
fun
fprint_expr
  (out: FILEref, x: expr): void
//
implement
fprint_expr
  (out, x) = fprint_expr_<> (out, x)
//
overload fprint with fprint_expr
//
#endif // #ifdef(CODEGEN2)

(* ****** ****** *)

#ifdef
CODEGEN2
#then
#else
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
} (* end of [main0] *)
#endif // end of [ifdef]

(* ****** ****** *)

(* end of [expr.dats] *)
