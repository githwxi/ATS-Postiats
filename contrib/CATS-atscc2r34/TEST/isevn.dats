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
#include "{$LIBATSCC2R34}/mylibies.hats"
//
(* ****** ****** *)
//
fnx isevn_ (n: int): bool =
  if n > 0 then isodd_(n-1) else true
and isodd_ (n: int): bool =
  if n > 0 then isevn_(n-1) else false
//
(* ****** ****** *)
//
extern
fun isevn
  : (int) -> bool = "mac#isevn"
extern
fun isodd
  : (int) -> bool = "mac#isodd"
//
implement isevn (n) = isevn_(n)
implement isodd (n) =
  if n > 0 then isevn_(n-1) else false
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
######
message("isevn(100) = ", isevn(100))
message("isodd(100) = ", isodd(100))
######
%} // end of [%{$]

(* ****** ****** *)

(* end of [isevn.dats] *)
