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
fact : int -> int = "mac#fact"
//
implement
fact (n) =
case+ n of
| 0 when n = 0 => 1 | _ => n * fact(n-1)
//
(* ****** ****** *)
//
extern 
fun
main0_ats
(
  N: int
) : void =
  "mac#fact3_main0_ats"
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
(fact3_main0_ats 12)
%} // end of [%{$]

(* ****** ****** *)

(* end of [fact3.dats] *)
