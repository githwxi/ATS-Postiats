(*
For testing GraphSearh_dfs
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
#include
"share/HATS\
/atslib_staload_libats_libc.hats"

(* ****** ****** *)

staload "./../DATS/GraphSearch.dats"
staload "./../DATS/GraphSearch_dfs.dats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

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
  | EXPRval(v) => fprint(out, g0float2int_double_int(v))
  | EXPRadd(e1, e2) => fprint!(out, "(", e1, "+", e2, ")")
  | EXPRsub(e1, e2) => fprint!(out, "(", e1, "-", e2, ")")
  | EXPRmul(e1, e2) => fprint!(out, "(", e1, "*", e2, ")")
  | EXPRdiv(e1, e2) => fprint!(out, "(", e1, "/", e2, ")")
)
//
(* ****** ****** *)

implement fprint_val<expr> = fprint_expr

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
g0float_abs_double(!e - 0) < EPSILON
implement
expr_is_24(e) =
g0float_abs_double(!e - 24) < EPSILON
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
) : void // end-of-function
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
).map(TYPE{expr})(lam x => EXPRval(g0i2f(x)))
//
val
nsol = ref<int>(0)
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
    then (!nsol := !nsol+1; println!(x))
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
if !nsol = 0
  then println! ("There is no solution found!")
// end of [if]
//
end (* end of [GameOf24Play] *)
//
(* ****** ****** *)

implement
main0
(
argc, argv
) = () where
{
//
(*
val () =
println! ("Hello from [Game-of-24]!")
*)
//
val () =
$STDLIB.srandom
  ($UN.cast{uint}($TIME.time()))
//
val n1 =
(
if argc >= 2
  then g0string2int(argv[1]) else randint(13)+1
) : int // end of [val]
val n2 =
(
if argc >= 3
  then g0string2int(argv[2]) else randint(13)+1
) : int // end of [val]
val n3 =
(
if argc >= 4
  then g0string2int(argv[3]) else randint(13)+1
) : int // end of [val]
val n4 =
(
if argc >= 5
  then g0string2int(argv[4]) else randint(13)+1
) : int // end of [val]
//
val () = println! ("n1 = ", n1)
val () = println! ("n2 = ", n2)
val () = println! ("n3 = ", n3)
val () = println! ("n4 = ", n4)
//
val () = GameOf24Play(n1, n2, n3, n4)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [GameOf24Play.dats] *)
