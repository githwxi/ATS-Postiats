(* ****** ****** *)
//
(*
HX-2022-07-11
Mon Jul 11 17:11:16 EDT 2022
*)
//
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

fn
primes2
(
// argless
)
: stream_vt(int) =
(
auxmain(2(*from*))) where
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
isPrime(n0)
then
stream_vt_cons
( n0
, auxmain(n0+1)) else auxloop(n0+1)
} (*where*) // end of [ primes2() ]
//
(* ****** ****** *)

implement
main0() =
{
  val N0 =
  g0int_npow(2, 26)
  val thePrimes = primes2()
  val thePrimes =
  stream_vt_take_while
  (thePrimes, lam p0 =<cloref1> p0 <= N0 )
  val () =
  println!
  ("nprime(", N0, ") = ", stream_vt_length(thePrimes))
} (*where*) // end of [main0()]

(* ****** ****** *)

(* end of [primes1.dats] *)
