//
// Towers of Hanoi
//

(* ****** ****** *)
//
// HX-2012-07-24:
// A simple implementation of the Towers-of-Hanoi puzzle
//
(* ****** ****** *)

staload INT = "prelude/DATS/integer.dats"
staload CHAR = "prelude/DATS/char.dats"
staload STRING = "prelude/DATS/string.dats"

(* ****** ****** *)

extern
fun{a:t0p}
fprint_infix (out: FILEref, x: a): FILEref
overload << with fprint_infix

implement{a}
fprint_infix (out, x) = let
  val () = fprint_val<a> (out, x) in out
end // end of [fprint_infix]

(* ****** ****** *)

datatype tower = A | B | C

fn tower2char
  (x: tower): char =
  case+ x of A () => 'A' | B () => 'B' | C () => 'C'
// end of [tower2char]

implement
fprint_val<tower> (out, x) = fprint_char (out, tower2char (x))

(* ****** ****** *)

datatype endl = endl of ()

implement
fprint_val<endl> (out, x) = fprint_newline (out)

(* ****** ****** *)

macdef cout = stdout_ref

(* ****** ****** *)

extern
fun TowersOfHanoi {n:nat}
  (n: int n, x: tower, y: tower, z: tower): void
// end of [TowersOfHanoi]

implement
TowersOfHanoi
  (n, x, y, z) = let
in
  if n > 0 then {
    val () = TowersOfHanoi (n-1, x, z, y)
    val _(*out*) =
      cout << "move top disk from tower " << x << " to top of tower " << y << endl
    // end of [val]
    val () = TowersOfHanoi (n-1, z, y, x)
  } // end of [if]
end // end of [TowersofHanoi]

(* ****** ****** *)

implement
main () = let
  val () =
    TowersOfHanoi (6, A, B, C) in 0(*normal*)
  // end of [val]
end // end of [main]

(* ****** ****** *)

(* end of [program-1-3.dats] *)
