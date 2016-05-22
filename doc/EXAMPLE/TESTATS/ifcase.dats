(* ****** ****** *)
//
// HX: 2016-05-15:
// A simple exercise of syntax design 
// 
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
acker
(
m: intGte(0),
n: intGte(0)
) : intGte(0) =
(
ifcase
| m = 0 => n + 1
| n = 0 => acker(m-1, 1)
| _(*else*) => acker(m-1, acker(m, n-1))
// end of [ifcase]
)
//
(* ****** ****** *)

implement main0() = assertloc(acker(3,3) = 61)

(* ****** ****** *)

(* end of [ifcase.dats] *)
