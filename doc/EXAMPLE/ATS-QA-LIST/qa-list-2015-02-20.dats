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
//
// HX-2015-02-20:
// The maximal depth for template instantiation is 99!
//
(* ****** ****** *)
//
typedef
S11(t:type) =
  S(S(S(S(S(S(S(S(S(S(t))))))))))
//
typedef
S99(t:type) = S11(S11(S11(S11(S11(S11(S11(S11(S11(t)))))))))
//
extern
praxi pf99: tieq(S99(Z), 99)
//
(* ****** ****** *)
//
val res = tally<S99(Z)> (pf99 | 99)
//
(* ****** ****** *)

implement
main0 () = println! ("1 + 2 + ... + 99 = ", res)

(* ****** ****** *)

(* end of [qa-list-2015-02-20.dats] *)
