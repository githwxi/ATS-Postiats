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
extern
fun
{res:t@ype
}{a:t@ype}
stream_foldleft
(
xs: stream(a),
r0: res, fopr: cfun(res, a, res)
) : res // end-of-function
//
implement
{res}{a}
stream_foldleft(xs, r0, fopr) =

(
//
case+ !xs of
| stream_nil() => r0
| stream_cons(x, xs) =>
  stream_foldleft<res><a>(xs, fopr(r0, x), fopr)
//
) (* end of [stream_foldleft] *)
//
(* ****** ****** *)
//
fun
ftally
( n: int
, f: cfun(int, double)): double =
  if n = 0 then 0.0 else ftally(n-1, f) + f(n)
//
(* ****** ****** *)

fun
ftally2
(
n : int
,
f : cfun(int, double)
) : double = let
//
val xs1 = int_stream_from(1)
val xs2 = stream_takeLte<int>(xs1, n)
val xs3 = stream_map<int><double>(xs2, lam(i) => f(i))
//
in
  stream_foldleft<double><double>(xs3, 0.0, lam(res, x) => res+x)
end // end of [ftally2]

(* ****** ****** *)
//
extern
fun
int_stream_vt_from(n: int): stream_vt(int)
//
implement
int_stream_vt_from(n) =
  $ldelay(stream_vt_cons(n, int_stream_vt_from(n+1)))
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
stream_vt_takeLte
  (xs: stream_vt(a), n: int): stream_vt(a)
//
implement
{a}(*tmp*)
stream_vt_takeLte
  (xs, n) = $ldelay
(
if
n > 0
then
(
case+ !xs of
| ~stream_vt_nil() =>
   stream_vt_nil()
| ~stream_vt_cons(x, xs) =>
   stream_vt_cons(x, stream_vt_takeLte(xs, n-1))
)
else (~xs; stream_vt_nil((*void*)))
,
lazy_vt_free(xs) // called when the stream is freed
) (* end of [stream_vt_takeLte] *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{b:t@ype}
stream_vt_map
(xs: stream_vt(a), fopr: cfun(a, b)): stream_vt(b)
//
implement
{a}{b}
stream_vt_map
  (xs, fopr) = $ldelay
(
case+ !xs of
| ~stream_vt_nil() =>
   stream_vt_nil()
| ~stream_vt_cons(x, xs) =>
   stream_vt_cons(fopr(x), stream_vt_map<a><b>(xs, fopr))
, lazy_vt_free(xs)
)
//
(* ****** ****** *)
//
extern
fun{
res:t@ype
}{a:t@ype}
stream_vt_foldleft
(
xs: stream_vt(a),
r0: res, fopr: cfun(res, a, res)
) : res // end-of-function
//
implement
{res}{a}
stream_vt_foldleft(xs, r0, fopr) =
(
//
case+ !xs of
| ~stream_vt_nil() => r0
| ~stream_vt_cons(x, xs) =>
   stream_vt_foldleft<res><a>(xs, fopr(r0, x), fopr)
//
) (* end of [stream_vt_foldleft] *)
//
(* ****** ****** *)

fun
ftally2_vt
(
n : int
,
f : cfun(int, double)
) : double = let
//
val xs1 = int_stream_vt_from(1)
val xs2 = stream_vt_takeLte<int>(xs1, n)
val xs3 = stream_vt_map<int><double>(xs2, lam(i) => f(i))
//
in
  stream_vt_foldleft<double><double>(xs3, 0.0, lam(res, x) => res+x)
end // end of [ftally2_vt]

(* ****** ****** *)

val () =
println! ("ftally(10) = ", ftally(10, lam(x) => g0i2f(x*x)))
val () =
println! ("ftally2(10) = ", ftally2(10, lam(x) => g0i2f(x*x)))
val () =
println! ("ftally2_vt(10) = ", ftally2_vt(10, lam(x) => g0i2f(x*x)))

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture11.dats] *)
