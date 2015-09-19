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

#codegen2("datcon", expr)
#codegen2("datcontag", expr)
#codegen2("fprint", expr, fprint_expr)

(* ****** ****** *)

#include "expr_codegen2.hats"

(* ****** ****** *)

overload fprint with fprint_expr

(* ****** ****** *)

#ifdef
CODEGEN2
#then
#else
//
implement
fprint_expr$Int<>
  (out, x) =
  let val-Int(i) = x in fprint(out, i) end
//
implement fprint_expr$carg<expr> = fprint_expr
//
#endif // #ifdef(CODEGEN2)

(* ****** ****** *)

implement
main0 () =
{
//
val E = Mul(Int(10), Add(Int(1), Int(2)))
//
val () = fprintln! (stdout_ref, "E = ", E)
val () = fprintln! (stdout_ref, "datcon(E) = ", datcon_expr(E))
val () = fprintln! (stdout_ref, "datcontag(E) = ", datcontag_expr(E))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [expr.dats] *)

