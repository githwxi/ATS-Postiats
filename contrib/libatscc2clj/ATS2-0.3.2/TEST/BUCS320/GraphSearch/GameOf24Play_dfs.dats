(*
For testing GraphSearh_dfs
*)

(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"GameOf24Play_dfs_dynload"
//
#define
ATS_STATIC_PREFIX"_GameOf24Play_dfs_"
//
(* ****** ****** *)
//
#include "./../../../staloadall.hats"
//
(* ****** ****** *)
//
#staload
"./../../../DATS/BUCS320/GraphSearch/GraphSearch_dfs.dats"
//
(* ****** ****** *)

implement node_mark<>(nx) = ()
implement node_unmark<>(nx) = ()
implement node_is_marked<>(nx) = false

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
print_expr : print_type(expr)  
//
overload print with print_expr
//
implement
print_expr(x0) =
(
case+ x0 of
  | EXPRval(v) => print(double2int(v))
  | EXPRadd(e1, e2) => print!("(", e1, "+", e2, ")")
  | EXPRsub(e1, e2) => print!("(", e1, "-", e2, ")")
  | EXPRmul(e1, e2) => print!("(", e1, "*", e2, ")")
  | EXPRdiv(e1, e2) => print!("(", e1, "/", e2, ")")
)
//
(* ****** ****** *)

implement print_val<expr> = print_expr

(* ****** ****** *)
//
#define EPSILON 1E-6
//
extern
fun
eval_expr(expr): double
overload ! with eval_expr
//
implement
eval_expr(e0) =
(
case+ e0 of
| EXPRval(v) => v
| EXPRadd(e1, e2) => !e1 + !e2
| EXPRsub(e1, e2) => !e1 - !e2
| EXPRmul(e1, e2) => !e1 * !e2
| EXPRdiv(e1, e2) => !e1 / !e2
) (* end of [eval_expr] *)
//
(* ****** ****** *)
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
expr_is_0(e) =
abs_double(!e - 0) < EPSILON
implement
expr_is_24(e) =
abs_double(!e - 24) < EPSILON
//
(* ****** ****** *)
//
#define
list0_sing(x)
list0_cons(x, list0_nil())
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

assume node = exprlst
assume nodelst = list0(exprlst)

(* ****** ****** *)
//
implement
{}(*tmp*)
theSearchStore_insert_lst(nxs) =
(
nxs
).rforeach()(lam nx => theSearchStore_insert(nx))
//
(* ****** ****** *)

implement
node_get_neighbors<>
  (nx) = aux1(nx, nil0()) where
{
//
fun
aux1
(
xs: exprlst
,
ys: exprlst
) : list0(exprlst) =
(
case+ xs of
| nil0() =>
  list0_nil()
| cons0(x, xs) =>
  aux2(x, xs, ys) + aux1(xs, cons0(x, ys))
)
//
and
aux2
(
x0: expr
,
xs: exprlst
,
ys: exprlst
) : list0(exprlst) =
(
case+ xs of
| nil0() =>
  list0_nil()
| cons0(x, xs) =>
  (arithops(x0, x)).map(TYPE{exprlst})
    (lam x1 => cons0(x1, list0_reverse_append(ys, xs))) + aux2(x0, xs, cons0(x, ys))
) (* end of [aux2] *)
//
} (* end of [node_get_neighbors] *)

(* ****** ****** *)
//
extern
fun
GameOf24Play
(
n1: int, n2: int, n3: int, n4: int
) : void = "mac#" // end-of-function
//
implement
GameOf24Play
(
  n1, n2, n3, n4
) = let
//
#define :: cons0
//
val nx =
(
n1::n2::n3::n4::nil0()
).map(TYPE{expr})(lam x => EXPRval(int2double(x)))
//
val
nsol = ref{int}(0)
//
implement
process_node<>
  (nx) = true where
{
//
(*
val () =
println!("process_node: nx = ", nx)
*)
//
val () =
case+ nx of
| list0_sing(x) =>
  if expr_is_24(x)
    then (nsol[] := nsol[]+1; println!(x))
  // end of [if]
| _(*non-sing*) => ()
}
//
val
store =
slistref_make_nil{node}()
val () =
slistref_insert(store, nx)
//
in
//
GraphSearch_dfs(store);
if nsol[] = 0
  then println! ("There is no solution found!")
// end of [if]
//
end (* end of [GameOf24Play] *)
//
(* ****** ****** *)

%{$
;;
(do
 (GameOf24Play 3 3 8 8)
 (GameOf24Play 3 5 7 13)
 (GameOf24Play 4 4 10 10)
 (GameOf24Play 5 5 7 11)
 (GameOf24Play 5 7 7 11)
) ;; end-of-do
;;
%} (* end of [%{$] *)

(* ****** ****** *)

(* end of [GameOf24Play_dfs.dats] *)
