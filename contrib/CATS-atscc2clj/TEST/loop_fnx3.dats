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
// HX:
// loop0, loop1 and loop2
// are required to have the same arity
//
fnx
loop0(_: int, _: int): int = loop1(0, 0)
and
loop1(x: int, _: int): int = loop2(x, 0)
and
loop2(x: int, y: int): int = if x > 0 then loop2(x-1, y+y) else 0
//
(* ****** ****** *)
//
extern 
fun
main0_ats
(
// argumentless
) : void =
  "mac#fnx3_main0_ats"
//
implement
main0_ats () =
{
//
val () = println! ("loop0() = ", loop0(0, 0))
//
} (* end of [main0_ats] *)
//
(* ****** ****** *)


%{$
;;
(fnx3_main0_ats)
;;
%} // end of [%{]

(* ****** ****** *)

(* end of [loop_fnx3.dats] *)
