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
pip_get_name: pip -> string
extern
fun
pip_get_value: pip -> natLt(13)
//
extern
fun
suit_get_name: suit -> string
extern
fun
suit_get_value: suit -> natLt(4)
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

(* end of [Playing_cards.dats] *)
