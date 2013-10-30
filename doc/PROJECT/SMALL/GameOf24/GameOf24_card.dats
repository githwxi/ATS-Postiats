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

datatype
card_node =
  | CARDint of (int)
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

assume card_type = card

(* ****** ****** *)

in (* in of [local] *)

(* ****** ****** *)

implement
card_get_val (c) = c.card_val

(* ****** ****** *)

implement
card_make_int (v) = '{
  card_val= g0i2f (v), card_node= CARDint (v)
} // end of [card_make_int]

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
| CARDint (v) => fprint! (out, "CARDint(", v, ")")
| CARDadd (c1, c2) => fprint! (out, "CARDadd(", c1, ", ", c2, ")")
| CARDsub (c1, c2) => fprint! (out, "CARDsub(", c1, ", ", c2, ")")
| CARDmul (c1, c2) => fprint! (out, "CARDmul(", c1, ", ", c2, ")")
| CARDdiv (c1, c2) => fprint! (out, "CARDdiv(", c1, ", ", c2, ")")
//
end // end of [fprint_card]

(* ****** ****** *)

implement
fpprint_card
  (out, c0) = let
//
overload fprint with fpprint_card of 10
//
in
//
case+ c0.card_node of
| CARDint (v) => fprint! (out, v)
| CARDadd (c1, c2) => fprint! (out, "(", c1, " + ", c2, ")")
| CARDsub (c1, c2) => fprint! (out, "(", c1, " - ", c2, ")")
| CARDmul (c1, c2) => fprint! (out, "(", c1, " * ", c2, ")")
| CARDdiv (c1, c2) => fprint! (out, "(", c1, " / ", c2, ")")
//
end // end of [fpprint_card]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
fprint_cardlst
  (out, cs) = let
//
implement
fprint_val<card> = fprint_card
//
implement
fprint_list$sep<> (out) = fprint_newline (out)
//
val () = fprint_list (out, cs)
//
in
end // end of [fprint_cardlst]

(* ****** ****** *)

#define EPSILON 0.1

implement
fpprint_cardlst
  (out, cs) = let
//
implement
fprint_val<card>
  (out, c) = let
  val v = card_get_val (c)
in
  fpprint_card (out, c);
  fprint_string (out, " = ");
  fprint_int (out, g0f2i(v+EPSILON))
end // end of [fprint_val]
implement
fprint_list$sep<> (out) = fprint_newline (out)
//
val () = fprint_list (out, cs)
//
in
end // end of [fpprint_cardlst]

(* ****** ****** *)

(* end of [GameOf24_card.dats] *)
