(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

abstype exp = ptr
typedef explst = list0(exp)
typedef explstlst = list0(explst)

(* ****** ****** *)

#define
sing0(x)
list0_cons(x, list0_nil())

(* ****** ****** *)

extern
fun
int2exp : int -> exp

(* ****** ****** *)
//
extern
fun
eval_exp : exp -> double
//
(* ****** ****** *)

extern
fun
exp_is_0 : (exp) -> bool
extern
fun
exp_is_24 : (exp) -> bool

(* ****** ****** *)

extern
fun
fopr_exp_exp : (exp, exp) -> explst

(* ****** ****** *)

extern
fun
solve_one : explst -> explstlst
extern
fun
solve_ones : explstlst -> explstlst

(* ****** ****** *)

extern
fun
choose_2_rest : explst -> list0($tup(exp, exp, explst))

(* ****** ****** *)

implement
solve_one(xs) =
list0_concat(
(choose_2_rest(xs)).map(TYPE{explstlst})
(
lam
(
  $tup(x1, x2, ys)
) =>
  (fopr_exp_exp(x1, x2)).map(TYPE{explst})(lam x12 => cons0(x12, ys))
)
)(*list0_concat*)

(* ****** ****** *)

implement
solve_ones(xss) =
concat(xss.map(TYPE{explstlst})(lam(xs) => solve_one(xs)))

(* ****** ****** *)

extern
fun
play24
(
  int, int, int, int
) : list0(exp)

(* ****** ****** *)

implement
play24(n1, n2, n3, n4) = let
//
val xs = nil0()
val xs = cons0(int2exp(n4), xs)
val xs = cons0(int2exp(n3), xs)
val xs = cons0(int2exp(n2), xs)
val xs = cons0(int2exp(n1), xs)
//
val xss = solve_one(xs)
val xss = solve_ones(xss)
val xss = solve_ones(xss)
//
in
//
xss.mapopt(TYPE{exp})
(
  lam(xs) =>
  let val-sing0(x) = xs in if exp_is_24(x) then Some_vt(x) else None_vt() end
) (* end of [mapopt] *)
//
end // end of [play24]

(* ****** ****** *)

(* end of [Game-of-24.dats] *)
