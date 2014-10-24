//
// A simple example of withtype
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: October, 2014
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun fact (n) =
  if n > 0
    then n * fact(n-1) else 1
  // end of [if]
withtype {n:nat} int (n) -> int

(* ****** ****** *)

implement
main0 () = println! ("fact(10) = ", fact(10))

(* ****** ****** *)

(* end of [withtype.dats] *)

