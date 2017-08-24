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
fun
int_stream_from
  (n: int): stream(int) =
  $delay(stream_cons(n, int_stream_from(n+1)))
//
(* ****** ****** *)
//
fun
{a:t@ype}
stream_get_at
  (xs: stream(a), n: int): a =
(
case+ !xs of
| stream_nil() =>
  (
    $raise StreamSubscriptExn()
  )
| stream_cons(x, xs) =>
  (
    if n <= 0 then x else stream_get_at<a>(xs, n-1)
  )
)
//
(* ****** ****** *)
//
fun
{a:t@ype}
stream_length
  (xs: stream(a)): int =
(
case+ !xs of
| stream_nil() => 0
| stream_cons(_, xs) => stream_length<a>(xs) + 1
)
//
(* ****** ****** *)
//
val
theNats =
int_stream_from(0)
//
val
theNats10 =
stream_takeLte(theNats, 10)
//
(* ****** ****** *)
//
val () =
println!
("theNats10 = ", stream_vt_length(theNats10))
//
(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture10.dats] *)
