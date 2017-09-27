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
staload TIME =
"libats/libc/SATS/time.sats"
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
point = $tup(double, double)
//
typedef points = list0(point)
typedef pointss = list0(points)
typedef pointsss = list0(pointss)
//
(* ****** ****** *)

fun sq(x: double): double = x * x
fun sqrt(x: double): double = $M.sqrt(x)

(* ****** ****** *)
//
// Computing the distance
// between two given points
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
matrix0_make_elt<points>(N, N, list0_nil)

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
hit_point_points
(
p0: point, ps: points
) : int =
(
list0_foldleft<int><point>
( ps, 0
, lam(res, p1) => res + hit_point_point(p0, p1)
) (* list0_foldleft *)
)
//
fun
hit_point_pointss
(
p0: point, pss: pointss
) : int =
(
list0_foldleft<int><points>
( pss, 0
, lam(res, ps) => res + hit_point_points(p0, ps)
) (* list0_foldleft *)
)
//
fun
hit_point_pointsss
(
p0: point, psss: pointsss
) : int =
(
list0_foldleft<int><pointss>
( psss, 0
, lam(res, ps) => res + hit_point_pointss(p0, ps)
) (* list0_foldleft *)
)
//
(* ****** ****** *)

fun
theGrid_get_neighbors
(
 i: int, j: int
) : pointsss = let
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
) : points =
if
(
isvalid_row(i)
&&
isvalid_col(j)
)
then theGrid[i, j] else list0_nil()
//
in
//
int_list0_map<pointss>
( 3
, lam(i') =>
  int_list0_map<points>
  ( 3
  , lam(j') => fopr(i + i' - 1, j + j' - 1)
  )
) (* end of [int_list0_map] *)
//
end // end of [theGrid_get_neighbors]

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
val x =
N * randfloat()
val y =
N * randfloat()
//
val p = $tup(x, y)
//
val i =
g0float2int_double_int(x)
val j =
g0float2int_double_int(y)
//
val nhit =
hit_point_pointsss
  (p, theGrid_get_neighbors(i, j))
//
in
//
  theGrid[i, j] :=
  list0_cons(p, theGrid[i, j]); nhit
//
end // end of [do_one]

(* ****** ****** *)
//
fun
do_all
(
 K: int
) : int =
(
fix
loop
(
 i: int, res: int
) : int =<cloref1>
  if i < K then loop(i+1, do_one()+res) else res
)(0, 0) // end of [do_all]
//
(* ****** ****** *)

implement
main0((*void*)) = let
//
val () =
$STDLIB.srand48
($UNSAFE.cast($TIME.time_get()))
//
val nhit = do_all(N*N)
//
in
  println! ("approx(pi) = ", 2.0 * nhit / (N*N))
end // end of [main0]

(* ****** ****** *)

(* end of [MonteCarlo.dats] *)
