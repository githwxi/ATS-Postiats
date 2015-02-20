(* ****** ****** *)
//
// A kind of loop unrolling
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

abstype Z
abstype S(type)

(* ****** ****** *)
//
dataprop
tieq (type, int) =
| TIEQZ(Z, 0)
| {t:type}{n:nat}
  TIEQS(S(t), n+1) of tieq(t, n)
//
(* ****** ****** *)

extern
fun
{t:type}
tally{n:nat}
(
  pf: tieq(t, n) | n: int(n)
) : int // end of [tally]

(* ****** ****** *)

implement
(t)(*tmp*)
tally<S(t)>
  (pf | n) = let
  prval TIEQS(pf) = pf in n + tally<t> (pf | n-1)
end // end of [tally]

(* ****** ****** *)

implement tally<Z> (pf | n) = 0

(* ****** ****** *)

val res = tally<S(S(Z))> (TIEQS(TIEQS(TIEQZ)) | 2)

(* ****** ****** *)

implement
main0 () = println! ("res = ", res)

(* ****** ****** *)

(* end of [qa-list-2015-02-20.dats] *)
