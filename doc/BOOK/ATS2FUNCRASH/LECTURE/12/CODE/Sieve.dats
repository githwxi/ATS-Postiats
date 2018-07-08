(* ****** ****** *)
(*
** Sieve of Erastosthenes
*)
(* ****** ****** *)
(*
##myatsccdef=\
patsopt -d $1 | atscc2js -o $fname($1)_dats.js -i -
*)
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
//
#define
ATS_DYNLOADNAME
"Sieve__dynload"
//
#define
ATS_STATIC_PREFIX "Sieve__"
//
(* ****** ****** *)
//
// HX: for accessing LIBATSCC2JS 
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib\
/libatscc2js/ATS2-0.3.2" // latest stable release
//
#include
"{$LIBATSCC2JS}/staloadall.hats" // for prelude stuff
#staload
"{$LIBATSCC2JS}/SATS/print.sats" // for print into a store
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include "./../../MYLIB/mylib.dats"
//
(* ****** ****** *)

val
thePrimes =
sieve
(
int_stream_from(2)
) where
{
//
fun
sieve
(
xs: stream(int)
) : stream(int) =
$delay let
//
val-stream_cons(x0, xs) = !xs
//
in
  stream_cons(x0, sieve(stream_filter(xs, lam(x) => x % x0 > 0)))  
end // end of [sieve]
} (* end of [thePrimes] *)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
stream_kforeach
( xs: stream(INV(a))
, f0: cfun(a, cont1(bool), void), k0: cont0()): void
implement
{a}(*tmp*)
stream_kforeach(xs, f0, k0) =
(
case+ !xs of
| stream_nil() => k0()
| stream_cons(x, xs) =>
  f0(x, lam(y) => if y then stream_kforeach<a>(xs, f0, k0) else k0())
)
//
(* ****** ****** *)
//
extern
fun
sieve_start(): void = "mac#"
//
implement
sieve_start() =
stream_kforeach<int>
(thePrimes, fopr, k0) where
{
//
val
fopr =
lam(
x: int
,
k: cont1(bool)
): void =<cloref1>
k
(
confirm
("Prime=" + String(x) + ". Continue?")
)
//
val k0 = lam() =<cloref1> alert("The End!")
//
} (* end of [sieve_start] *)

(* ****** ****** *)

%{$
//
function
Sieve__initize()
{
//
Sieve__dynload(); return;
//
} // end of [Sieve__initize]
%}

(* ****** ****** *)

%{$
//
jQuery(document).ready(function(){Sieve__initize();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [Sieve.dats] *)
