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
typedef exprlst = list0(expr)
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
//
#define EPSILON 1E-6
//
extern
fun
eval_expr(expr): double
overload ! with eval_expr
//
extern
fun
expr_is_0 : expr -> bool
extern
fun
expr_is_24 : expr -> bool
//
overload iseqz with expr_is_0
//
(* ****** ****** *)
//
implement
expr_is_0(e) = abs(!e - 0) < EPSILON
implement
expr_is_24(e) = abs(!e - 24) < EPSILON
//
(* ****** ****** *)
//
extern
fun
arithops(x: expr, y: expr): exprlst
//
implement
arithops(x, y) =
list0_reverse(res) where
{
  val res = nil0()
  val res = cons0(EXPRadd(x, y), res)
  val res = cons0(EXPRsub(x, y), res)
  val res = cons0(EXPRsub(y, x), res)
  val res = cons0(EXPRmul(x, y), res)
  val res = (if iseqz(y) then res else cons0(EXPRdiv(x, y), res)): exprlst
  val res = (if iseqz(x) then res else cons0(EXPRdiv(y, x), res)): exprlst
}

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
