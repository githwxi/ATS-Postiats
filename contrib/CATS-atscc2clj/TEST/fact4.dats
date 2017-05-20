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
fact (n) = let
//
fun
loop
(
  n: int, res: ref(int)
) : int =
if n > 0
then let
//
val () = res[] := n * res[]
//
in
  loop(n-1, res)
end // end of [then]
else res[] // end of [else]
//
val res = ref{int}(1)
//
in
  loop (n, res)
end // end of [fact]

(* ****** ****** *)
//
extern 
fun
main0_ats
(
  N : int
) : void = "mac#fact4_main0_ats"
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
;;
(fact4_main0_ats 12)
;;
%} // end [%{$]

(* ****** ****** *)

(* end of [fact4.dats] *)
