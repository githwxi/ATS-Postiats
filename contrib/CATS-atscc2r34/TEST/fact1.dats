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
LIBATSCC2R34_targetloc
"$PATSHOME\
/contrib/libatscc2r34"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2R34}/mylibies.hats"
//
(* ****** ****** *)
//
extern
fun
fact : int -> int = "mac#fact"
//
implement
fact (n) = let
//
fnx loop
(
  n: int, res: int
) : int =
  if n > 0 then loop (n-1, n*res) else res
//
in
  loop (n, 1)
end // end of [fact]

(* ****** ****** *)
//
extern 
fun
main0_ats
(
  N: int
) : void = "mac#fact1_main0_ats"
//
implement
main0_ats(N) =
{
//
val () =
$extfcall
(void, "message", "fact(", N, ") = ", fact(N))
//
} (* end of [main0_ats] *)
//
(* ****** ****** *)

%{^
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
fact1_main0_ats(10)
%} // end of [%{$]

(* ****** ****** *)

(* end of [fact1.dats] *)
