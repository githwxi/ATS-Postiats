(*
//
Task
//
Create a data structure and the associated methods to define and
manipulate a deck of playing cards.
//
The deck should contain 52 unique cards.
//
The methods must include the ability to:
  make a new deck
  shuffle (randomize) the deck
  deal from the deck
  print the current contents of a deck
//
Each card must have a pip value and a suit value which constitute the unique value of the card.
//
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
abst@ype
pip_type = int
abst@ype
suit_type = int
//
abst@ype
card_type = int
//
(* ****** ****** *)

typedef pip = pip_type
typedef suit = suit_type

(* ****** ****** *)

typedef card = card_type

(* ****** ****** *)
//
extern
fun
pip_make: intBtwe(1, 13) -> pip
extern
fun
pip_get_name: pip -> string
extern
fun
pip_get_value: pip -> intBtwe(1, 13)
//
extern
fun
suit_make: intBtwe(1, 4) -> suit
extern
fun
suit_get_name: suit -> string
extern
fun
suit_get_value: suit -> intBtwe(1, 4)
//
overload .name with pip_get_name
overload .name with suit_get_name
overload .value with pip_get_value
overload .value with suit_get_value
//
(* ****** ****** *)
//
(*
  | Two | Three | Four | Five
  | Six | Seven | Eight | Nine
  | Ten | Jack | Queen | King | Ace 
*)
//
(*
  | Spade | Heart | Diamond | Club
*)
//
(* ****** ****** *)

local

assume
pip_type = natLt(13)

in (* in-of-local *)

implement
pip_make(x) = x - 1
implement
pip_get_value(x) = x + 1

end // end of [local]

(* ****** ****** *)

local

assume
suit_type = natLt(4)

in (* in-of-local *)

implement
suit_make(x) = x - 1
implement
suit_get_value(x) = x + 1

end // end of [local]

(* ****** ****** *)

implement
pip_get_name
  (x) =
(
case+
x.value()
of // case+
| 1 => "Ace"
| 2 => "Two"
| 3 => "Three"
| 4 => "Four"
| 5 => "Five"
| 6 => "Six"
| 7 => "Seven"
| 8 => "Eight"
| 9 => "Nine"
| 10 => "Ten"
| 11 => "Jack"
| 12 => "Queen"
| 13 => "King"
)

(* ****** ****** *)
//
implement
suit_get_name
  (x) =
(
case+
x.value()
of // case+
| 1 => "S" | 2 => "H" | 3 => "D" | 4 => "C"
) (* end of [suit_get_name] *)
//
(* ****** ****** *)
//
extern
fun
card_get_pip: card -> pip
extern
fun
card_get_suit: card -> suit
//
extern
fun
card_make_suit_pip: (suit, pip) -> card
//
(* ****** ****** *)

extern
fun
fprint_pip : fprint_type(pip)
extern
fun
fprint_suit : fprint_type(suit)
extern
fun
fprint_card : fprint_type(card)

(* ****** ****** *)

overload .pip with card_get_pip
overload .suit with card_get_suit

(* ****** ****** *)

overload fprint with fprint_pip
overload fprint with fprint_suit
overload fprint with fprint_card

(* ****** ****** *)

local

assume
card_type = natLt(52)

in (* in-of-local *)
//
implement
card_get_pip
  (x) = pip_make(nmod(x, 13)+1)
implement
card_get_suit
  (x) = suit_make(ndiv(x, 13)+1)
//
implement
card_make_suit_pip(x, y) =
  (x.value()-1) * 13 + (y.value()-1)
//
end // end of [local]

(* ****** ****** *)
//
implement
fprint_pip(out, x) =
  fprint!(out, x.name())
implement
fprint_suit(out, x) =
  fprint!(out, x.name())
//
implement
fprint_card(out, c) =
  fprint!(out, c.suit(), "(", c.pip(), ")")
//
(* ****** ****** *)
//
absvtype deck_vtype(n:int)
vtypedef deck(n:int) = deck_vtype(n)
//
(* ****** ****** *)
//
extern
fun
deck_shuffle
  {n:nat}(!deck(n) >> _): void
//
(* ****** ****** *)
//
extern
fun
deck_get_size
  {n:nat}(!deck(n)): int(n)
//
extern
fun
deck_is_empty
  {n:nat}(!deck(n)): bool(n==0)
//
(* ****** ****** *)
//
extern
fun
deck_make_full((*void*)): deck(52)
//
(* ****** ****** *)
//
extern
fun
fprint_deck
  {n:nat}(FILEref, !deck(n)): void
//
(* ****** ****** *)
//
extern
fun
deck_takeout_top
  {n:pos}(!deck(n) >> deck(n-1)): card
//
(* ****** ****** *)

implement
main0() =
{
//
val () = println! ("Hello from [Playing_cards]!")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Playing_cards.dats] *)
