(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "my_dynload"
//
(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
#include "{$LIBATSCC2R34}/mylibies.hats"
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
lms_solve
{p,n:pos}
( A: R34matrix(a, n, p)
, Y: R34vector(a, n   )): R34vector(a, p)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
lms_solve
(A, Y) =
solve<a>(
  crossprod(A), R34matrix2vector_col(crossprod(A, Y))
)(* solve *)
//
(* ****** ****** *)
//
val
A =
$extval
(R34matrix(double, 5, 3), "A")
//
val
Y =
$extval(R34vector(double, 5), "Y")
//
val () = $extfcall(void, "str", A)
val () = $extfcall(void, "str", Y)
//
(* ****** ****** *)

val () = $extfcall(void, "str", lms_solve<double>(A, Y))

(* ****** ****** *)

%{^
#
xs1 = c(1, 2104, 3, 400)
xs2 = c(1, 1600, 3, 330)
xs3 = c(1, 2400, 3, 369)
xs4 = c(1, 1416, 2, 232)
xs5 = c(1, 3000, 4, 540)
#
xss = rbind(xs1, xs2, xs3, xs4, xs4)
#
A   = xss[ ,1:3]; Y   = xss[ ,4:4]
%} // end of [%}]

(* ****** ****** *)

%{^
######
if
(!
(exists("libatscc2r34.is.loaded"))
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
my_dynload()
%} // end of [%{$]

(* ****** ****** *)

(* end of [lms_solve.dats] *)
