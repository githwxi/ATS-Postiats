(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)

assume location_type = string

(* ****** ****** *)

implement
location_make (rep) = rep

(* ****** ****** *)

implement
fprint_location
  (out, loc) = fprint_string (out, loc)
// end of [fprint_location]

(* ****** ****** *)

(* end of [utfpl_location.dats] *)
