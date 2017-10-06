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
val xs =
R34vector_tabulate_fun{int}(100, lam(i) => (i+1)*(i+1))
//
val () = $extfcall(void, "message", "mean = ", mean(xs))
val () = $extfcall(void, "message", "median = ", median(xs))
val () = $extfcall(void, "message", "variance = ", variance(xs))
//
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
  sys.source("./mylib_cats.R")
  sys.source("./libatscc2r34/libatscc2r34_all.R")
}
######
%} // end of [%{^]

(* ****** ****** *)

%{$
my_dynload()
%} // end of [%{$]

(* ****** ****** *)

(* ****** ****** *)

(* end of [median.dats] *)
