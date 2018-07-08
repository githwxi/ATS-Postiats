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

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

implement
fprint_val<int> = fprint_int
implement
fprint_val<bool> = fprint_bool
implement
fprint_val<string> = fprint_string

(* ****** ****** *)
//
typedef
cont0() = cfun(void)
typedef
cont1(inp:t@ype) = cfun(inp, void)
//
(* ****** ****** *)

extern
fun do_async1(): void
extern
fun do_async2(): void

(* ****** ****** *)

(*
fun
do_async12(): void =
{
//
val () = do_async1(); val () = do_async2()
//
} (* end of [do_async_12] *)
*)

(* ****** ****** *)
//
extern
fun
do_async1_cont(k: cont0()): void
//
(* ****** ****** *)

(*
fun
do_async12(): void =
do_async1_cont(lam() => do_async2())
*)

(* ****** ****** *)
//
extern
fun
do_async2_cont(k: cont0()): void
//
(* ****** ****** *)

(*
fun
do_async12_cont
  (k: cont0()): void =
(
do_async1_cont(lam() => do_async2_cont(k))
)
*)

(* ****** ****** *)
//
fun
fact
(
n : int
) : int =
if n > 0 then n * fact(n-1) else 1
//
(* ****** ****** *)
//
fun
k_fact
(
n : int
,
k : cont1(int)
) : void =
(
if
(n > 0)
then k_fact(n-1, lam(res) => k(n*res))
else k(1)
// end of [if]
) (* end of [k_fact] *)
//
(* ****** ****** *)
//
fun
fibo
(
n : int
) : int =
if n >= 2 then fibo(n-1)+fibo(n-2) else n
//
(* ****** ****** *)
//
fun
k_fibo
(
n : int
,
k : cont1(int)
) : void =
(
if
(n >= 2)
then
k_fibo
( n-1
, lam(r1) => k_fibo(n-2, lam(r2) => k(r1+r2))
) (* end of [then] *)
else k(n) // end of [else]
// end of [if]
) (* end of [[k_fibo] *)
//
(* ****** ****** *)
//
fun
fact2
(
n : int, res: int
) : int =
if n > 0
  then fact2(n-1, n*res) else res
// end of [if]
//
(* ****** ****** *)
//
fun
k_fact2
(n: int, res: int, k: cont1(int)): void  =
if n > 0
  then k_fact2(n-1, n*res, k) else k(res)
// end of [if]
//
(* ****** ****** *)
//
fun
k_f91
(n: int, k: cont1(int)): void =
if n <= 100
then k_f91(n+11, lam(res) => k_f91(res, k))
else k(n-10)
//
(* ****** ****** *)
//
val () =
k_fact(10, lam(res) => println! ("fact(10) = ", res))
//
val () =
k_fibo(20, lam(res) => println! ("fibo(20) = ", res))
//
(* ****** ****** *)
//
val () = k_f91(0, lam(res) => println! ("f91(0) = ", res))
val () = k_f91(1, lam(res) => println! ("f91(1) = ", res))
val () = k_f91(2, lam(res) => println! ("f91(2) = ", res))
val () = k_f91(101, lam(res) => println! ("f91(101) = ", res))
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{b:t@ype}
list0_map
(xs: list0(INV(a)), f0: cfun(a, b)): list0(b)
implement
{a}{b}
list0_map(xs, f0) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  list0_cons(f0(x), list0_map<a><b>(xs, f0))
)
//
extern
fun
{a:t@ype}
{b:t@ype}
list0_kmap
( xs: list0(INV(a))
, f0: cfun(a, cont1(b), void), k0: cont1(list0(b))): void
implement
{a}{b}
list0_kmap(xs, f0, k0) =
(
case+ xs of
| list0_nil() =>
  k0(list0_nil())
| list0_cons(x, xs) =>
  f0(x, lam(y) => list0_kmap<a><b>(xs, f0, lam(ys) => k0(list0_cons(y, ys))))
)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{b:t@ype}
stream_kmap
( xs: stream(INV(a))
, f0: cfun(a, cont1(b), void), k0: cont1(list0(b))): void
implement
{a}{b}
stream_kmap(xs, f0, k0) =
(
case+ !xs of
| stream_nil() =>
  k0(list0_nil())
| stream_cons(x, xs) =>
  f0(x, lam(y) => stream_kmap<a><b>(xs, f0, lam(ys) => k0(list0_cons(y, ys))))
)
//
(* ****** ****** *)
//
val xs =
g0ofg1($list{int}(1, 2, 3, 4, 5))
//
val () =
list0_kmap<int><int>(xs, lam(x, k) => k(x*x), lam(ys) => println!("ys = ", ys))
//
(* ****** ****** *)
//
val xs = int_stream_from(1)
val xs = stream_takeLte<int>(xs, 10)
//
val () =
stream_kmap<int><int>(xs, lam(x, k) => k(x*x), lam(ys) => println!("ys = ", ys))
//
(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture12.dats] *)
