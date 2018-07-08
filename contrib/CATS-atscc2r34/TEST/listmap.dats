(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Node.js
//
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2R34}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun
list_map
{a:t0p}
{b:t0p}{n:int}
(
xs: list(INV(a), n), fopr: (a) -<cloref1> b
) : list(b, n) = "mac#" // end-of-function
//
(* ****** ****** *)
//
implement
list_map(xs, f) =
(
case+ xs of
| list_nil() => list_nil()
| list_cons(x, xs) => list_cons(f(x), list_map(xs, f))
) (* end of [list_map] *)
//
(* ****** ****** *)
//
extern
fun
fromto
  : (int, int) -> List0 (int) = "mac#fromto"
//
implement
fromto (m, n) =
if m < n
  then list_cons (m, fromto (m+1, n)) else list_nil ()
// end of [if]
//
(* ****** ****** *)
//
extern
fun
mytest
  : (int, int) -> List0(int) = "mac#mytest"
//
implement
mytest(m, n) = let
  val xs = fromto (m, n)
in
  list_map{int}{int} (xs, lam x => m * n * x)
end // end of [mytest]
//
(* ****** ****** *)

%{^
######
options(expressions=100000);
######
if
(
!(exists("libatscc2r34.is.loaded"))
)
{
  assign("libatscc2r34.is.loaded", FALSE)
}
######
if
(
!(libatscc2r34.is.loaded)
)
{
  sys.source("./libatscc2r34/libatscc2r34_all.R")
}
######
%} // end of [%{^]

(* ****** ****** *)

%{$
xs <- fromto(0, 10)
message("mytest(5, 10) =", mytest(5, 10))
%} // end of [%{$]

(* ****** ****** *)

(* end of [listmap.dats] *)
