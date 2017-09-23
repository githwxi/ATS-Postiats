(*
** Implementing
** Monte Carlo pi simulation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
staload M =
"libats/libc/SATS/math.sats"
staload _(*M*) =
"libats/libc/DATS/math.dats"
//
staload STDLIB =
"libats/libc/SATS/stdlib.sats"
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

#define N 1024

(* ****** ****** *)
//
typedef
point =
$tup(double, double)
typedef
pointlst = list0(point)
typedef
pointlstlst = list0(pointlst)
typedef
pointlstlstlst = list0(pointlstlst)
//
(* ****** ****** *)

fun sq(x: double): double = x * x
fun sqrt(x: double): double = $M.sqrt(x)

(* ****** ****** *)
//
fun
dist_point_point
(p1: point, p2: point): double =
sqrt(sq(p1.0 - p2.0) + sq(p1.1 - p2.1))
//
overload dist with dist_point_point
//
(* ****** ****** *)

val
theGrid =
matrix0_make_elt<pointlst>(N, N, list0_nil)

(* ****** ****** *)
//
fun
hit_point_point
(
p1: point, p2: point
) : int =
(
if dist(p1, p2) <= 1.0 then 1 else 0
)
//
fun
hit_point_pointlst
(
p0: point, ps: pointlst
) : int =
(
list0_foldleft<int><point>
( ps, 0
, lam(res, p1) => res + hit_point_point(p0, p1)
) (* list0_foldleft *)
)
//
fun
hit_point_pointlstlst
(
p0: point, pss: pointlstlst
) : int =
(
list0_foldleft<int><pointlst>
( pss, 0
, lam(res, ps) => res + hit_point_pointlst(p0, ps)
) (* list0_foldleft *)
)
//
fun
hit_point_pointlstlstlst
(
p0: point, psss: pointlstlstlst
) : int =
(
list0_foldleft<int><pointlstlst>
( psss, 0
, lam(res, ps) => res + hit_point_pointlstlst(p0, ps)
) (* list0_foldleft *)
)
//
(* ****** ****** *)

fun
theGrid_get_neibors
(
 i: int, j: int
) : pointlstlstlst = let
//
fun
isvalid_row
(i: int): bool = (0 <= i && i < N)
fun
isvalid_col
(j: int): bool = (0 <= j && j < N)
//
fun
fopr
(
  i: int
, j: int
) : pointlst =
if
(
isvalid_row(i)
&&
isvalid_row(j)
)
then theGrid[i, j] else list0_nil()
//
in
//
int_list0_map<pointlstlst>
( 3
, lam(i') =>
  int_list0_map<pointlst>(3, lam(j') => fopr(i+i'-1, j+j'-1))
) (* end of [int_list0_map] *)
//
end // end of [theGrid_get_neibors]

(* ****** ****** *)

#define
ALPHA 0.999999

(* ****** ****** *)

fun
randfloat
(
// argless
) : double =
(
ALPHA * $STDLIB.drand48()
)

(* ****** ****** *)

fun
do_one(): int = let
//
val x = N * randfloat()
val y = N * randfloat()
//
val i = g0float2int_double_int(x)
val j = g0float2int_double_int(y)
//
val p = $tup(x, y)
//
val nhit =
hit_point_pointlstlstlst
  (p, theGrid_get_neibors(i, j))
//
in
  theGrid[i, j] := list0_cons(p, theGrid[i, j]); nhit
end // end of [do_one]

(* ****** ****** *)
//
fun
do_all
(
 T: int
) : int =
(
fix
loop(i: int, res: int): int =<cloref1>
  if i < T then loop(i+1, do_one()+res) else res
)(0, 0) // end of [do_all]
//
(* ****** ****** *)

implement
main0((*void*)) = let
//
val nhit = do_all(N*N)
//
in
  println! ("approx(pi) = ", 2.0 * nhit / (N*N))
end // end of [main0]

(* ****** ****** *)

(* end of [MonteCarlo.dats] *)
