(* ****** ****** *)
(*
** Game-of-24
*)
(* ****** ****** *)
(*
##myatsccdef=\
patsopt -d $1 | atscc2js -o $fname($1)_dats.js -i -
*)
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
//
#define
ATS_DYNLOADNAME
"GameOf24__dynload"
//
#define
ATS_EXTERN_PREFIX "GameOf24__"
#define
ATS_STATIC_PREFIX "GameOf24__"
//
(* ****** ****** *)
//
// HX: for accessing LIBATSCC2JS 
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib\
/libatscc2js/ATS2-0.3.2" // latest stable release
//
#include
"{$LIBATSCC2JS}/staloadall.hats" // for prelude stuff
#staload
"{$LIBATSCC2JS}/SATS/print.sats" // for print into a store
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include "./../../MYLIB/mylib.dats"
//
(* ****** ****** *)

%{^
//
function
input_rand()
{
//
var MAX = 13;
//
var input1 =
document.getElementById("card1_val");
var input2 =
document.getElementById("card2_val");
var input3 =
document.getElementById("card3_val");
var input4 =
document.getElementById("card4_val");
//
input1.value = Math.floor(1+MAX*Math.random()).toString();
input2.value = Math.floor(1+MAX*Math.random()).toString();
input3.value = Math.floor(1+MAX*Math.random()).toString();
input4.value = Math.floor(1+MAX*Math.random()).toString();
//
return;
} /* end of [input_rand] */
//
%} (* end of [%{^] *)

(* ****** ****** *)

%{^
//
function
input_play()
{
//
var
input1 =
document.getElementById("card1_val");
var
input2 =
document.getElementById("card2_val");
var
input3 =
document.getElementById("card3_val");
var
input4 =
document.getElementById("card4_val");
//
var n1 = parseInt( input1.value, 10 );
var n2 = parseInt( input2.value, 10 );
var n3 = parseInt( input3.value, 10 );
var n4 = parseInt( input4.value, 10 );
//
var
theStage = document.getElementById("theStage");
//
ats2jspre_the_print_store_clear();
//
GameOf24__play_game_print(n1, n2, n3, n4);
//
theStage.innerHTML = ats2jspre_the_print_store_join();
//
return;
//
}
//
%} (* end of [%{^] *)

(* ****** ****** *)

//
#define
int2dbl int2double
#define
dbl2int double2int
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
//
overload print with print_expr
//
(* ****** ****** *)
//
implement
print_expr(x0) =
(
case x0 of
| EXPRnum(v0) =>
  print(dbl2int(v0))
| EXPRbop(opr, x1, x2) =>
  print!("(", x1, opr, x2, ")")
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

#define :: list0_cons

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
extern
fun
play_game_print
( n1: int
, n2: int
, n3: int
, n4: int): void = "mac#%"
//
implement
play_game
  (n1, n2, n3, n4) = let
//
  val x1 = EXPRnum(int2dbl(n1))
  val x2 = EXPRnum(int2dbl(n2))
  val x3 = EXPRnum(int2dbl(n3))
  val x4 = EXPRnum(int2dbl(n4))
  val xs = x1 :: x2 :: x3 :: x4 :: nil0()
in
//
list0_mapopt<task><expr>
(
do_ones(4, list0_sing(xs))
,
lam(xss) => if (xss[0] = 24) then Some0(xss[0]) else None0()
)
//
end // end of [play_game]
//
implement
play_game_print
  (n1, n2, n3, n4) = let
//
val xs =
play_game(n1, n2, n3, n4)
//
in
//
if
isneqz(xs)
then
(
//
println!
("The tuple (", n1, ", ", n2, ", ", n3, ", ", n4,  ") is a good quad!");
//
println!();
//
list0_foreach(xs, lam(x) => println!(x))
)
//
else
println!
("The tuple (", n1, ", ", n2, ", ", n3, ", ", n4,  ") is not a good quad!")
//
end // end of [play_game_print]

(* ****** ****** *)

(* end of [Game-of-24-js.dats] *)
