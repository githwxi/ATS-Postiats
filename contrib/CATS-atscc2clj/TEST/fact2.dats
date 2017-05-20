(* ****** ****** *)
//
// HX-2016-07:
// A running example
// from ATS2 to Clojure
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2CLJ_targetloc
"$PATSHOME\
/contrib/libatscc2clj/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2CLJ}/staloadall.hats"
//
(* ****** ****** *)
//
extern
fun
fact : double -> double = "mac#fact"
//
implement
fact (n) = let
//
fnx loop
(
  n: double, res: double
) : double =
  if n > 0.0 then loop (n-1.0, n*res) else res
//
in
  loop (n, 1.0)
end // end of [fact]

(* ****** ****** *)
//
extern 
fun
main0_ats
(
  N: double
) : void = "mac#fact2_main0_ats"
//
implement
main0_ats(N) =
{
//
val () = println! ("fact(", N, ") = ", fact(N))
//
} (* end of [main0_ats] *)
//
(* ****** ****** *)

%{$
(fact2_main0_ats 12.0)
%} // end of [%{$]

(* ****** ****** *)

(* end of [fact2.dats] *)
