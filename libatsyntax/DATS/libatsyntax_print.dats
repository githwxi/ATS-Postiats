(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxi AT gmail DOT com)
**
** Start Time: June, 2012
**
*)

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libatsyntax/SATS/libatsyntax.sats"

(* ****** ****** *)

staload
LOC = "src/pats_location.sats"
typedef location2 = $LOC.location

implement
fprint_location
  (out, x) =
  $LOC.fprint_location (out, $UN.cast{location2}(x))
// end of [fprint_location]

(* ****** ****** *)

staload
LEX = "src/pats_lexing.sats"
typedef token2 = $LEX.token

implement
fprint_token
  (out, x) = $LEX.fprint_token (out, $UN.cast{token2} (x))
// end of [fprint_token]

(* ****** ****** *)

(* end of [libatsyntax_print.dats] *)
