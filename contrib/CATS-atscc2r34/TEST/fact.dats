(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2R3_targetloc
"$PATSHOME/contrib/libatscc2r3"
//
(* ****** ****** *)
//
#include "{$LIBATSCC2R3}/mylibies.hats"
//
(* ****** ****** *)
//
extern
fun
fact : int -> int = "mac#fact"
//
implement
fact (n) = if n > 0 then n * fact(n-1) else 1
//
(* ****** ****** *)
//
extern 
fun
main0_ats
(
  N : int
) : void = "mac#fact_main0_ats"
//
implement
main0_ats(N) =
{
//
val () = 
$extfcall(void, "message", "fact(", N, ") = ", fact(N))
//
} (* end of [main0_ats] *)
//
(* ****** ****** *)

%{^
######
if
(!(exists("libatscc2r3.is.loaded")))
{
  assign("libatscc2r3.is.loaded", FALSE)
}
######
if
(
!(libatscc2r3.is.loaded)
)
{
  sys.source("./libatscc2r3/CATS/libatscc2r3.R")
}
######
%} // end of [%{^]

(* ****** ****** *)

%{$
fact_main0_ats(10)
%} // end of [%{$]

(* ****** ****** *)

(* end of [fact.dats] *)
