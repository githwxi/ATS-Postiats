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
fun do_async_1(): void
extern
fun do_async_2(): void

(* ****** ****** *)

fun
do_async_12(): void =
{
//
val () = do_async_1()
val () = do_async_2()
//
} (* end of [do_async_12] *)

(* ****** ****** *)
//
extern
fun k_do_async_1(k: cont0()): void
extern
fun k_do_async_2(k: cont0()): void
extern
fun k_do_async_12(k: cont0()): void
//
(* ****** ****** *)

implement
k_do_async_12(k) =
k_do_async_1(lam() => k_do_async_2(k))

(* ****** ****** *)

fun
k_fact(n: int, k: cont1(int)): void =
(
if n > 0
  then k_fact(n-1, lam(res) => k(n*res)) else k(1)
// end of [if]
)

(* ****** ****** *)

val () =
k_fact(10, lam(res) => println! ("fact(10) = ", res))

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture12.dats] *)
