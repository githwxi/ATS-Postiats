//
// Implementing Game-of-24
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "GameOf24.sats"

(* ****** ****** *)

datatype
card_node =
  | CARDadd of (card, card)
  | CARDsub of (card, card)
  | CARDmul of (card, card)
  | CARDdiv of (card, card)
where
card = '{
//
card_val= double, card_node= card_node
//
} (* end of [card] *)

(* ****** ****** *)

assume card_type = card

(* ****** ****** *)

implement
add_card_card
  (c1, c2) = let
//
val v = c1.card_val + c2.card_val
//
in '{
//
card_val= v, card_node= CARDadd (c1, c2)
//
} end // end of [add_card_card]

(* ****** ****** *)

implement
sub_card_card
  (c1, c2) = let
//
val v = c1.card_val - c2.card_val
//
in '{
//
card_val= v, card_node= CARDsub (c1, c2)
//
} end // end of [sub_card_card]

(* ****** ****** *)

implement
mul_card_card
  (c1, c2) = let
//
val v = c1.card_val * c2.card_val
//
in '{
//
card_val= v, card_node= CARDmul (c1, c2)
//
} end // end of [mul_card_card]

(* ****** ****** *)

implement
div_card_card
  (c1, c2) = let
//
val v = c1.card_val / c2.card_val
//
in '{
//
card_val= v, card_node= CARDdiv (c1, c2)
//
} end // end of [div_card_card]

(* ****** ****** *)

implement
fprint_card
  (out, c0) = let
in
//
case+ c0.card_node of
| CARDadd (c1, c2) => fprintln! (out, "CARDadd(", c1, ", ", c2, ")")
| CARDsub (c1, c2) => fprintln! (out, "CARDsub(", c1, ", ", c2, ")")
| CARDmul (c1, c2) => fprintln! (out, "CARDmul(", c1, ", ", c2, ")")
| CARDdiv (c1, c2) => fprintln! (out, "CARDdiv(", c1, ", ", c2, ")")
//
end // end of [fprint_card]

(* ****** ****** *)

(* end of [GameOf24_card.dats] *)
