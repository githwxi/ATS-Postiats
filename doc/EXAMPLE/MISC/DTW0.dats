(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
implement main0() = {}
(* ****** ****** *)

datatype
intlst1 =
| intlst1_nil of ()
| intlst1_cons of (int, intlst1)
(* ****** ****** *)
datatype
intlst2 = // run-length
| intlst2_nil of ()
| intlst2_cons of (int, int(*len*), intlst2)
(* ****** ****** *)
extern
fun
intlst1_length(xs: intlst1): int
extern
fun
intlst2_length1(xs: intlst2): int
extern
fun
intlst2_length2(xs: intlst2): int
(* ****** ****** *)
implement
intlst1_length(xs) =
(
case+ xs of
|
intlst1_nil
((*void*)) => 0
|
intlst1_cons
( x1, xs ) => 1+intlst1_length(xs)
)
(* ****** ****** *)
implement
intlst2_length1(xs) =
(
case+ xs of
|
intlst2_nil
((*void*)) => 0
|
intlst2_cons
( x1, n1, xs ) => 1+intlst2_length1(xs)
)
implement
intlst2_length2(xs) =
(
case+ xs of
|
intlst2_nil
((*void*)) => 0
|
intlst2_cons
( x1, n1, xs ) => n1+intlst2_length2(xs)
)
(* ****** ****** *)
extern
fun
print_intlst1
(xs: intlst1): void
extern
fun
fprint_intlst1
(out: FILEref, xs: intlst1): void
overload print with print_intlst1
overload fprint with fprint_intlst1
(* ****** ****** *)
extern
fun
print_intlst2
(xs: intlst2): void
extern
fun
fprint_intlst2
(out: FILEref, xs: intlst2): void
overload print with print_intlst2
overload fprint with fprint_intlst2
(* ****** ****** *)
implement
print_intlst1(xs) =
fprint_intlst1(stdout_ref, xs)
implement
print_intlst2(xs) =
fprint_intlst2(stdout_ref, xs)
(* ****** ****** *)
implement
fprint_intlst1
(out, xs) =
(
case+ xs of
| intlst1_nil() => ()
| intlst1_cons(x0, xs) =>
  fprint!(out, x0, ";", xs)
)
implement
fprint_intlst2
(out, xs) =
(
case+ xs of
| intlst2_nil() => ()
| intlst2_cons(x0, n0, xs) =>
  fprint!(out, x0, "(", n0, ");", xs)
)
(* ****** ****** *)
extern
fun
trans12(xs: intlst1): intlst2
extern
fun
trans21(xs: intlst2): intlst1
(* ****** ****** *)

implement
trans21(xs) =
(
case+ xs of
|
intlst2_nil() =>
intlst1_nil()
|
intlst2_cons(x1, n1, xs) =>
helper(n1, trans21(xs)) where
{
fun
helper
(n0: int, xs: intlst1): intlst1 =
if
(
n0 <= 0
) then xs
  else helper(n0-1, intlst1_cons(x1, xs))
}
)

(* ****** ****** *)
fun
sq(x: int): int = x*x
extern
fun{}
DTW_dist
(int, int): int
implement
{}(*tmp*)
DTW_dist(x1, y1) = sq(x1-y1)
(* ****** ****** *)
extern
fun{}
DTW_intlst1_length
(xs: intlst1): int
implement
{}(*tmp*)
DTW_intlst1_length
  (xs) =
  helper(xs) where
{
fun
helper
(xs: intlst1): int =
(
case+ xs of
|
intlst1_nil() => 0
|
intlst1_cons(x1, xs) =>
DTW_dist(x1, 0) + helper(xs)
)
}
(* ****** ****** *)
extern
fun{}
DTW0_intlst1_intlst1
(xs: intlst1, ys: intlst1): int
(* ****** ****** *)
fun
int_min3
(x: int, y: int, z: int): int =
if x <= y then min(x, z) else min(y, z)
(* ****** ****** *)
implement
{}(*tmp*)
DTW0_intlst1_intlst1
  (xs, ys) =
(
  auxmain(xs, ys)
) where
{
fun
auxmain
( xs0: intlst1
, ys0: intlst1): int =
(
case+ xs0 of
|
intlst1_nil() =>
DTW_intlst1_length(ys0)
|
intlst1_cons(x1, xs1) =>
(
case+ ys0 of
|
intlst1_nil() =>
DTW_intlst1_length(xs0)
|
intlst1_cons(y1, ys1) =>
DTW_dist(x1, y1) +
int_min3
(auxmain(xs0, ys1), auxmain(xs1, ys0), auxmain(xs1, ys1))
)
)
} (* end of [DTW0_intlst1_intlst1] *)
(* ****** ****** *)

val () =
{
val xs =
intlst1_nil()
val xs =
intlst1_cons(4, xs)
val xs =
intlst1_cons(3, xs)
val xs =
intlst1_cons(2, xs)
val xs =
intlst1_cons(1, xs)
val () = println!("xs = ", xs)
val ys =
intlst1_nil()
val ys =
intlst1_cons(6, ys)
val ys =
intlst1_cons(5, ys)
val ys =
intlst1_cons(4, ys)
val ys =
intlst1_cons(3, ys)
val ys =
intlst1_cons(2, ys)
val () = println!("ys = ", ys)
//
val dd = DTW0_intlst1_intlst1(xs, ys)
val () = println!("DTW0(xs, ys) = ", dd)
val dd = DTW0_intlst1_intlst1(ys, xs)
val () = println!("DTW0(ys, xs) = ", dd)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val xs =
intlst1_nil()
val xs =
intlst1_cons(4, xs)
val xs =
intlst1_cons(3, xs)
val xs =
intlst1_cons(2, xs)
val xs =
intlst1_cons(1, xs)
val () = println!("xs = ", xs)
//
val ys =
intlst2_nil()
val ys =
intlst2_cons(4, 4, ys)
val ys =
intlst2_cons(3, 3, ys)
val ys =
intlst2_cons(2, 2, ys)
val ys =
intlst2_cons(1, 1, ys)
val ys = trans21(ys)
val () = println!("ys = ", ys)
//
val dd = DTW0_intlst1_intlst1(xs, ys)
val () = println!("DTW0(xs, ys) = ", dd)
val dd = DTW0_intlst1_intlst1(ys, xs)
val () = println!("DTW0(ys, xs) = ", dd)
//
} (* end of [val] *)

(* ****** ****** *)

(* end of [DTW0.dats] *)
