//
// Implementing Game-of-24
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./GameOf24.sats"

(* ****** ****** *)

local

assume cardset_type = arrszref (card)

in (* in of [local] *)

implement
cardset_size
  (cs) = g0u2i (arrszref_get_size (cs))
// end of [cardset_size]

implement
cardset_get_at (cs, i) = arrszref_get_at (cs, i)

implement
cardset_tabulate
  (n, f) = let
//
val n = g1ofg0 (n)
val () = assertloc (n >= 0)
//
implement
array_tabulate$fopr<card> (i) = f (g0u2i(i))
//
in
  arrszref_tabulate (i2sz(n))
end // end of [cardset_tabulate]

end // end of [local]

(* ****** ****** *)

implement
cardset_remove2_add1
  (cs, i, j, c) = let
//
fun f (k: int):<cloref1> card =
(
if k <= 0
then c else let
  val k1 = k - 1
in
  case+ 0 of
  | _ when k1 < i => cs[k1]
  | _ when k1 < j => (if k1+1 < j then cs[k1+1] else cs[k1+2])
  | _ (*k1 >= j*) => cs[k1+2]
end // end of [if]
)
//
val n = cardset_size (cs)
//
in
  cardset_tabulate (n-1, f)
end // end of [cardset_remove2_add1]

(* ****** ****** *)

(* end of [GameOf24_cardset.dats] *)
