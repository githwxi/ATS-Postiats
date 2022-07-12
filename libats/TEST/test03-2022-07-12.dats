(* ****** ****** *)
//
(*
HX-2022-07-12
Tue Jul 12 00:50:34 EDT 2022
*)
//
(* ****** ****** *)
(*
For a bit of history of this example, please read:
https://groups.google.com/g/ats-lang-users/c/z-QbPs7JWgg
*)
(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)
#staload
Q = "libats/SATS/qlist.sats"
#staload
_ = "libats/DATS/qlist.dats"
(* ****** ****** *)

fun
{a:t0p}
stream_vt_take_while
( xs
: stream_vt(INV(a))
, pred
: (a) -<cloref1> bool): stream_vt(a) =
(
auxmain(xs, pred)) where
{
fun
auxmain
( xs
: stream_vt(a)
, pred
: ( a ) -<cloref1> bool
) : stream_vt(a) =
$ldelay
(auxloop(xs, pred), ~xs)
//
and
auxloop
( xs: stream_vt(a)
, pred
: ( a ) -<cloref1> bool
) : stream_vt_con(a) =
let
val xs = !xs
in//let
case+ xs of
| ~
stream_vt_nil
  ((*void*)) => stream_vt_nil()
| @
stream_vt_cons
  ( x0, tl ) =>
let
  val test = pred(x0)
in//let
if test then
//
let
  val tl_ = tl
  val ( ) = (tl := auxmain(tl_, pred))
in
  fold@(xs); xs
end else (~tl; free@(xs); stream_vt_nil())
//
end // let // end of [stream_vt_cons]
end // let // end of [auxloop(xs,pred)]
} (*where*)// end-of-[stream_vt_take_while(xs,pred)]

(* ****** ****** *)

fun
qfree
(q0: $Q.qlist(int)): void =
let
val xs =
$Q.qlist_takeout_list(q0)
in
$Q.qlist_free_nil(q0); list_vt_free(xs)
end (*let*) // end of [qfree]

(* ****** ****** *)

fun
isPrime
( n0: int
, ps:
! $Q.qlist(int)
) : bool = env where
{
var
env: bool = true
//
val
( ) =
$Q.qlist_foreach_env<int><bool>(ps, env) where
{
implement
$Q.qlist_foreach$cont<int><bool>(p0, env) = if env then p0*p0 <= n0 else false
implement
$Q.qlist_foreach$fwork<int><bool>(p0, env) = if n0 % p0 = 0 then (env := false)
}
//
} (*where*) // end of [isPrime(n0, ps)]

(* ****** ****** *)

fun
primes2
(
// argless
) : stream_vt(int) =
let
fun
auxmain
( n0: int
, ps
: $Q.qlist(int)
)
: stream_vt(int) =
$ldelay
(auxloop(n0, ps), qfree(ps))
//
and
auxloop
( n0: int
, ps
: $Q.qlist(int)
)
: stream_vt_con(int) =
if
isPrime(n0, ps)
then
let
(*
val () =
println!("n0 = ", n0)
*)
val () =
$Q.qlist_insert<int>(ps, n0)
in//let
stream_vt_cons(n0, auxmain(n0+2, ps))
end else auxloop(n0+2, ps) // end-of-if
//
in//let
let
val ps =
$Q.qlist_make_nil<>()
val () =
$Q.qlist_insert<int>(ps, 2)
in
stream_vt_make_cons(2, auxmain(3(*n0*), ps))
end
end (*let*) // end of [ primes() ]

(* ****** ****** *)

implement
main0() =
{
  val N1 =
  g0int_npow(2, 15)
  val N2 = N1 * N1
  val thePrimes = primes2()
  val thePrimes =
  stream_vt_take_while
  (thePrimes, lam p0 =<cloref1> p0 <= N2 )
  val () =
  println!
  ("nprime(", N2, ") = ", stream_vt_length(thePrimes))
} (*where*) // end of [main0()]

(* ****** ****** *)

(*
//
time ./test03
nprime(16777216) = 1077871 // N2 = 2^24
2.14user 0.01system 0:02.16elapsed 100%CPU (0avgtext+0avgdata 35076maxresident)k
0inputs+0outputs (0major+8485minor)pagefaults 0swaps
//
time ./test03
nprime(67108864) = 3957809 // N2 = 2^26
13.41user 0.04system 0:13.46elapsed 99%CPU (0avgtext+0avgdata 125016maxresident)k
0inputs+0outputs (0major+30984minor)pagefaults 0swaps
//
time ./test03
nprime(268435456) = 14630843 // N2 = 2^28
86.56user 0.18system 1:26.76elapsed 99%CPU (0avgtext+0avgdata 458576maxresident)k
0inputs+0outputs (0major+114367minor)pagefaults 0swaps
//
time ./test03
nprime(1073741824) = 54400028 // N2 = 2^30
645.03user 0.74system 10:45.97elapsed 99%CPU (0avgtext+0avgdata 1701336maxresident)k
0inputs+0outputs (0major+425062minor)pagefaults 0swaps
//
*)

(* ****** ****** *)

(* end of [ATS2-Postiats/test03-2022-07-12.dats] *)
