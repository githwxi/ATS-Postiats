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
(*
fun
{a:t@ype}
list0_last_opt(xs: list0(a)): option0(a)
fun
{a:t@ype}
list0_get_at_opt(xs: list0(a), n: int): option0(a)
*)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_get_at
(xs: list0(a), n: int): a
//
implement
{a}(*tmp*)
list0_get_at
  (xs, n) =
(
case+ xs of
| list0_nil() =>
  $raise ListSubscriptExn()
| list0_cons(x, xs) =>
  if n <= 0 then x else list0_get_at<a>(xs, n-1)
)
//
overload [] with list0_get_at of 100
//
(* ****** ****** *)
//
fun
list0_tally1
  (xs: list0(int)): int =
  list0_foldleft<int><int>(xs, 0, lam(res, x) => res + x)
//
fun
list0_tally2
  (xs: list0(int)): int =
  int_foldleft<int>
  (list0_length(xs), 0, lam(res, i) => res + list0_get_at<int>(xs, i))
//
val () =
println!
("list0_tally(1, 2, 3) = ", list0_tally1(1::2::3::nil0{int}()))
//
val () =
println!
("list0_tally(1, 2, 3) = ", list0_tally2(1::2::3::nil0{int}()))
//
(* ****** ****** *)

extern
fun
{a:t@ype}
{b:t@ype}
list0_map
(xs: list0(a), fopr: cfun(a, b)): list0(b)

(* ****** ****** *)

implement
{a}{b}
list0_map
(
  xs, fopr
) = auxlst(xs) where
{
//
fun
auxlst
(xs: list0(a)): list0(b) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  list0_cons(fopr(x), auxlst(xs))
)
//
} (* end of [list0_map] *)

(* ****** ****** *)

val xs =
g0ofg1($list{int}(1, 2, 3, 4, 5))
val () =
println!
( "map(xs, square) = "
, list0_map<int><int>(xs, lam(x) => x * x)
) (* println! *)

(* ****** ****** *)
//
extern
fun
{a,b:t@ype}
list0_cross
( xs: list0(a)
, ys: list0(b)): list0($tup(a, b))
//
implement
{a,b}(*tmp*)
list0_cross
  (xs, ys) = let
//
typedef ab = $tup(a, b)
//
in
//
list0_concat
(
list0_map<a><list0(ab)>
  (xs, lam(x) => list0_map<b><ab>(ys, lam(y) => $tup(x, y)))
) (* end of [list0_concat] *)
//
end // end of [list0_cross]
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_foreach
(xs: list0(a), fwork: cfun(a, void)): void
//
implement
{a}(*tmp*)
list0_foreach
(
  xs, fwork
) = loop(xs) where
{
//
fun
loop
(xs: list0(a)): void =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) => (fwork(x); loop(xs))
)
//
} (* end of [list0_foreach] *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_filter
(xs: list0(a), pred: cfun(a, bool)): list0(a)
//
implement
{a}(*tmp*)
list0_filter
(
  xs, test
) = auxlst(xs) where
{
//
fun
auxlst
(xs: list0(a)): list0(a) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  if test(x)
    then list0_cons(x, auxlst(xs)) else auxlst(xs)
  // end of [if]
)
//
} (* end of [list0_filter] *)
//
(* ****** ****** *)

val xs =
g0ofg1($list{int}(1, 2, 3, 4, 5))
val () =
println!
( "filter(xs, isevn) = "
, list0_filter<int>(xs, lam(x) => x % 2 = 0)
) (* end of [println!] *)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_remdup
(xs: list0(a), eqfn: cfun(a, a, bool)): list0(a)
//
implement
{a}(*tmp*)
list0_remdup(xs, eqfn) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x0, xs) =>
  list0_cons(x0, list0_remdup<a>(list0_filter<a>(xs, lam(x) => eqfn(x0, x)), eqfn))
)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_find_index
(xs: list0(a), test: cfun(a, bool)): int
//
implement
{a}(*tmp*)
list0_find_index
  (xs, test) = let
//
fun
loop
(xs: list0(a), i: int): int =
(
case+ xs of
| list0_nil() => ~1
| list0_cons(x, xs) =>
  if test(x) then i else loop(xs, i+1)
)
//
in
  loop(xs, 0)
end // end of [list0_find_index]
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_exists
(xs: list0(a), test: cfun(a, bool)): bool
extern
fun
{a:t@ype}
list0_forall
(xs: list0(a), test: cfun(a, bool)): bool
//
implement
{a}(*tmp*)
list0_exists(xs, test) =
list0_find_index<a>(xs, test) >= 0
implement
{a}(*tmp*)
list0_forall(xs, test) =
list0_find_index<a>(xs, lam(x) => not(test(x))) < 0
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{b:t@ype}
list0_imap
(xs: list0(a), fopr: cfun(int, a, b)): list0(b)
//
implement
{a}{b}
list0_imap
(
  xs, fopr
) = auxlst(0, xs) where
{
//
fun
auxlst
(i: int, xs: list0(a)): list0(b) =
(
case+ xs of
| list0_nil() => list0_nil()
| list0_cons(x, xs) => list0_cons(fopr(i, x), auxlst(i+1, xs))
)
//
} (* end of [list0_imap] *)
//
(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture06.dats] *)
