(* ****** ****** *)
//
(*
HX-2022-07-11
Mon Jul 11 18:24:57 EDT 2022
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
UN = "prelude/SATS/unsafe.sats"
(* ****** ****** *)

fn
primes1
(
// argless
)
: stream_vt(int) =
(
  sieve(from(2))) where
{
//
fun
from
(n0: int)
: stream_vt(int) =
$ldelay(stream_vt_cons(n0, from(n0+1)))
//
fun
sieve
( xs
: stream_vt(int)): stream_vt(int) =
$ldelay
(
let
val xs = !xs
in//let
case- xs of
| @
stream_vt_cons(p1, tl) =>
let
val ps =
sieve(filter(p1, tl)) in tl := ps; fold@(xs); xs
end // let // stream_vt_cons
end, ~xs) // let // end of [sieve(xs)]
//
and
filter
( p1: int
, xs
: stream_vt(int)
)
: stream_vt(int) =
$ldelay
(filter1(p1, xs), ~xs)

and
filter1
( p1: int
, xs
: stream_vt(int)
)
: stream_vt_con(int) =
let
val xs = !xs
in
case- xs of
| @
stream_vt_cons(x1, tl) =>
if
(x1 % p1 = 0)
then
let
val tl = tl in
free@(xs); filter1(p1, tl) end
else
(tl := filter(p1, tl); fold@(xs); xs)
end // let // end of [filter]
//
} (*where*) // end of [primes_vt]
//
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

val
thePrimes1 =
stream_vt2t(primes1())

(* ****** ****** *)

fn
isPrime
(x0: int): bool =
(
  loop(thePrimes1)) where
{
fnx
loop(ps: stream(int)): bool =
case- !ps of
|
stream_cons(p0, ps) =>
let
  val pp = p0 * p0
in
if pp > x0 then true else
(
if (x0 % p0) = 0 then false else loop(ps)
) end//let//stream_cons//end-of-(loop)
} (*where*) // end of [isPrime(x0,primes)]

(* ****** ****** *)
//
fn
ps1env
( N1: int)
: List0(int) = list_vt2t
(
loop
( primes1()
, list_vt_nil())) where
{
fnx loop
( ps
: stream_vt(int)
, r0
: List0_vt( int )
) : List0_vt( int ) =
case- !ps of
| ~
stream_vt_cons(p0, ps) =>
if
(p0 > N1)
then
(~ps; list_vt_reverse(r0))
else
loop(ps, list_vt_cons(p0, r0)) }//ps1env
//
(* ****** ****** *)

(*
HX-2022-07-11:
[isPrime2] should be more efficient as
traversing a list involves less pointer-chasing
than traversing a (non-linear) stream.
*)

fn
isPrime2
( x0: int
, ps: List0(int)): bool =
(
  loop(x0, ps)) where
{
fnx
loop
( x0: int
, ps: List0(int)): bool =
case+ ps of
|
list_nil() => true
|
list_cons(p0, ps) =>
if
(x0 % p0) = 0
then false else
let
val pp = p0 * p0
in//let
if
(pp > x0)
then true else loop(x0, ps)
end//let//list_cons//end-of-(loop)
} (*where*) // end of [isPrime2(x0,primes)]

(* ****** ****** *)

fn
primes2
(
ps
: List0(int))
: stream_vt(int) =
(
stream_vt_make_cons
(  2, auxmain(3)  )) where
{
fun
auxmain
( n0: int
) : stream_vt(int) =
$ldelay(auxloop(n0))
and
auxloop
( n0: int
) : stream_vt_con(int) =
if
isPrime2(n0, ps)
then
stream_vt_cons
( n0
, auxmain(n0+2)) else auxloop(n0+2)
} (*where*) // end of [ primes2() ]
//
(* ****** ****** *)

implement
main0() =
{
  val N1 =
  g0int_npow(2, 14)
  val N2 = N1 * N1
  val thePS1Env = ps1env(N1)
  val thePrimes = primes2(thePS1Env)
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
time ./test02
nprime(16777216) = 1077871 // N2 = 2^24
1.96user 0.00system 0:01.96elapsed 99%CPU (0avgtext+0avgdata 1428maxresident)k
0inputs+0outputs (0major+78minor)pagefaults 0swaps
//
time ./test02
nprime(67108864) = 3957809 // N2 = 2^26
15.14user 0.00system 0:15.14elapsed 99%CPU (0avgtext+0avgdata 1464maxresident)k
0inputs+0outputs (0major+87minor)pagefaults 0swaps
//
time ./test02
nprime(268435456) = 14630843 // N2 = 2^28
112.74user 0.00system 1:52.75elapsed 99%CPU (0avgtext+0avgdata 1548maxresident)k
0inputs+0outputs (0major+108minor)pagefaults 0swaps
//
time ./test02
nprime(1073741824) = 54400027 // N2 = 2^30
929.28user 0.10system 15:29.73elapsed 99%CPU (0avgtext+0avgdata 1700maxresident)k
0inputs+0outputs (0major+145minor)pagefaults 0swaps
//
*)

(* ****** ****** *)

(* end of [ATS2-Postiats/test02-2022-07-11.dats] *)
