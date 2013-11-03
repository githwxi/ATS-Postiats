(* ****** ****** *)
//
// HX-2013-11
//
// Implementing a variant of
// the problem of Dining Philosophers
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/stdlib.sats"
staload "libc/SATS/unistd.sats"

(* ****** ****** *)

staload "./DiningPhil2.sats"

(* ****** ****** *)

implement
randsleep
  (n) = ignoret
(
  sleep($UN.cast{uInt}(rand() mod n + 1))
) (* end of [randsleep] *)
  
(* ****** ****** *)
  
implement
main0 ((*void*)) =
{
} (* end of [main0] *)

(* ****** ****** *)

(* end of [DiningPhil2.dats] *)
