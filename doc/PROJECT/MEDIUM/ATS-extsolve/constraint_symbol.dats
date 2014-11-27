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

assume symbol_type = string

(* ****** ****** *)

implement symbol_make (x) = x

(* ****** ****** *)

implement
fprint_symbol
  (out, sym) = fprint_string (out, sym)
// end of [fprint_symbol]

(* ****** ****** *)

implement
compare_symbol_symbol
  (s1, s2) = compare_string_string (s1, s2)
// end of [compare_symbol_symbol]

(* ****** ****** *)

(* end of [constraint_symbol.dats] *)
