(*
** ATS constaint-solving
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./constraint.sats"

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

(* end of [constraint_location.dats] *)
