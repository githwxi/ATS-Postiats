(*
** Implementing Game-of-24
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#define :: list0_cons

(* ****** ****** *)

macdef
list0_sing(x) =
list0_cons(,(x), list0_nil())

(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)
//
#define
int2dbl g0int2float_int_double
#define
dbl2int g0float2int_double_int
//
(* ****** ****** *)
//
datatype expr =
  | EXPRnum of double
  | EXPRbop of (string, expr, expr)
//
typedef exprlst = list0(expr)
//
(* ****** ****** *)
//
extern
fun
eval_expr(x0: expr): double
//
overload eval with eval_expr
//
implement
eval_expr(x0) =
(
case+ x0 of
| EXPRnum(v0) => v0
| EXPRbop(opr, x1, x2) => let
    val v1 = eval_expr(x1)
    val v2 = eval_expr(x2)
  in
    case+ opr of
    | "+" => v1 + v2
    | "-" => v1 - v2
    | "*" => v1 * v2
    | "/" => v1 / v2
    | _(*unrecognized*) =>
      let val () = assertloc(false) in 0.0 end
  end
) (* end of [eval_expr] *)
//
(* ****** ****** *)
//
extern
fun
print_expr : (expr) -> void
extern
fun
fprint_expr : (FILEref, expr) -> void
//
overload print with print_expr
overload fprint with fprint_expr
//
(* ****** ****** *)
//
implement
print_expr(x0) =
fprint_expr(stdout_ref, x0)
//
implement
fprint_expr(out, x0) =
(
case x0 of
| EXPRnum(v0) =>
  fprint(out, dbl2int(v0))
| EXPRbop(opr, x1, x2) =>
  fprint!(out, "(", x1, opr, x2, ")")
)
//
(* ****** ****** *)
//
extern
fun
add_expr_expr
  : (expr, expr) -> expr
and
sub_expr_expr
  : (expr, expr) -> expr
and
mul_expr_expr
  : (expr, expr) -> expr
and
div_expr_expr
  : (expr, expr) -> expr
//
overload + with add_expr_expr
overload - with sub_expr_expr
overload * with mul_expr_expr
overload / with div_expr_expr
//
(* ****** ****** *)
//
implement
add_expr_expr(x1, x2) = EXPRbop("+", x1, x2)
implement
sub_expr_expr(x1, x2) = EXPRbop("-", x1, x2)
implement
mul_expr_expr(x1, x2) = EXPRbop("*", x1, x2)
implement
div_expr_expr(x1, x2) = EXPRbop("/", x1, x2)
//
(* ****** ****** *)

#define EPSILON 1E-8

(* ****** ****** *)
//
extern
fun
eq_expr_int(expr, int): bool
//
overload = with eq_expr_int
//
implement
eq_expr_int(x0, i0) =
abs(eval_expr(x0) - i0) < EPSILON
//
(* ****** ****** *)
//
extern
fun
combine_expr_expr(expr, expr): exprlst
//
overload combine with combine_expr_expr
//
(* ****** ****** *)
//
implement
combine_expr_expr
  (x1, x2) = res where
{
//
val res = list0_nil()
val res = list0_cons(x1+x2, res)
val res = list0_cons(x1-x2, res)
val res = list0_cons(x2-x1, res)
val res = list0_cons(x1*x2, res)
val res = if x2 = 0 then res else list0_cons(x1/x2, res)
val res = if x1 = 0 then res else list0_cons(x2/x1, res)
//
val res = list0_reverse(res)
//
} (* end of [combine_expr_expr] *)
//
(* ****** ****** *)

typedef task = exprlst
typedef tasklst = list0(task)

(* ****** ****** *)
//
extern
fun
do_one
(xs: task): tasklst
//
extern
fun
do_ones
(n: int, xss: tasklst): tasklst
//
(* ****** ****** *)
//
implement
do_one(xs) = let
//
val x1x2xss =
list0_nchoose_rest<expr>(xs, 2)
//
(*
val () =
println! ("xs = ", xs)
val () =
println! ("|x1x2xss| = ", length(x1x2xss))
*)
//
in
//
list0_mapjoin<$tup(exprlst, exprlst)><task>
(
x1x2xss
,
lam
($tup(x1x2, xs)) =>
list0_map<expr><task>
 (combine(x1x2[0], x1x2[1]), lam(x) => list0_cons(x, xs))
)
//
end // end of [do_one]
//
(* ****** ****** *)
//
implement
do_ones(n, xss) =
if n >= 2
  then
  do_ones
  ( n-1
  , list0_mapjoin<task><task>(xss, lam(xs) => do_one(xs))
  ) (* do_ones *)
  else xss
//
(* ****** ****** *)
//
extern
fun
play_game
( n1: int
, n2: int
, n3: int
, n4: int): exprlst
//
implement
play_game
  (n1, n2, n3, n4) = let
//
  val x1 = EXPRnum(int2dbl(n1))
  val x2 = EXPRnum(int2dbl(n2))
  val x3 = EXPRnum(int2dbl(n3))
  val x4 = EXPRnum(int2dbl(n4))
in
//
list0_mapopt<task><expr>
(
do_ones(4, list0_sing(g0ofg1($list{expr}(x1, x2, x3, x4))))
,
lam(xss) => if (xss[0] = 24) then Some0(xss[0]) else None0()
)
//
end // end of [play_game]
//
(* ****** ****** *)

implement
main0() = () where
{
//
val xs = play_game(3, 3, 8, 8)
val () = list0_foreach(xs, lam(x) => println!(x))
//
val xs = play_game(5, 5, 7, 11)
val () = list0_foreach(xs, lam(x) => println!(x))
//
val xs = play_game(5, 7, 7, 11)
val () = list0_foreach(xs, lam(x) => println!(x))
//
val xs = play_game(3, 5, 7, 13)
val () = list0_foreach(xs, lam(x) => println!(x))
//
val xs = play_game(4, 4, 10, 10)
val () = list0_foreach(xs, lam(x) => println!(x))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Game-of-24.dats] *)
