(*
For Effective ATS
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

staload "./GraphSearch.dats"
staload "./GraphSearch_dfs.dats"

(* ****** ****** *)

implement node_mark<>(nx) = ()
implement node_unmark<>(nx) = ()
implement node_is_marked<>(nx) = false

(* ****** ****** *)

#define N 8

(* ****** ****** *)
//
datatype expr =
 | EXPRval of double
 | EXPRadd of (expr, expr)
 | EXPRsub of (expr, expr)
 | EXPRmul of (expr, expr)
 | EXPRdiv of (expr, expr)
//
(* ****** ****** *)
//
extern
fun
print_expr : expr -> void
and
fprint_expr : fprint_type(expr)  
//
overload print with print_expr
overload fprint with fprint_expr
//
implement
print_expr(x0) = fprint_expr(stdout_ref, x0)
//
implement
fprint_expr(out, x0) =
(
case+ x0 of
  | EXPRval(v) => fprint(out, v)
  | EXPRadd(e1, e2) => fprint!(out, "(", e1, "+", e2, ")")
  | EXPRsub(e1, e2) => fprint!(out, "(", e1, "-", e2, ")")
  | EXPRmul(e1, e2) => fprint!(out, "(", e1, "*", e2, ")")
  | EXPRdiv(e1, e2) => fprint!(out, "(", e1, "/", e2, ")")
)
//
(* ****** ****** *)

assume node = list0(expr)

(* ****** ****** *)

implement
main0() = () where
{
//
val () =
println! ("Hello from [Game-of-24]!")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Game-of-24.dats] *)
