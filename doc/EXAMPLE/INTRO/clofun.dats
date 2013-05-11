//
// A simple example of
// run-time closure creation
//
// Author: Hongwei Xi (May, 2013)
//
(* ****** ****** *)
//
staload
_(*anon*) = "prelude/DATS/integer.dats"
//
(* ****** ****** *)

fun rtfind
(
  f: int -> int
) : int = let
//
fun loop
(
  f: int -> int, i: int
) : int =
  if f (i) != 0 then loop (f, i+1) else i
//
in
  loop (f, 0)
end // end of [rtfind]

(* ****** ****** *)

fun rtfind2
(
  f: int -<cloref1> int
) : int = let
//
fun loop
(
  f: int -<cloref1> int, i: int
) : int =
  if f (i) != 0 then loop (f, i+1) else i
//
in
  loop (f, 0)
end // end of [rtfind2]

(* ****** ****** *)

implement
main0 () =
{
//
val rt = rtfind (lam (x) => (x+10)*(x-11))
val () = println! ("rt = ", rt)
val rt2 = rtfind2 (lam (x) => (x+10)*(x-11))
val () = println! ("rt2 = ", rt2)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [clofun.dats] *)
