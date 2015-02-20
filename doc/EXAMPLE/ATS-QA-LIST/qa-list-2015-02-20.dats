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
teqint (type, int) =
| TEQINTZ(Z, 0)
| {t:type}{n:nat}
  TEQINTS(S(t), n+1) of teqint(t, n)
//
(* ****** ****** *)

extern
fun
{t:type}
tally{n:nat}
(
  pf: teqint(t, n) | n: int(n)
) : int

(* ****** ****** *)

implement
(t)(*tmp*)
tally<S(t)>
  (pf | n) = let
  prval TEQINTS(pf) = pf in n + tally<t> (pf | n-1)
end // end of [tally]

(* ****** ****** *)

implement tally<Z> (pf | n) = 0

(* ****** ****** *)

val res = tally<S(S(Z))> (TEQINTS(TEQINTS(TEQINTZ)) | 2)

(* ****** ****** *)

implement
main0 () = println! ("res = ", res)

(* ****** ****** *)

(* end of [qa-list-2015-02-20.dats] *)
