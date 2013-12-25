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

implement
eq_label_label (l1, l2) = compare (l1, l2) = 0
implement
neq_label_label (l1, l2) = compare (l1, l2) != 0

(* ****** ****** *)

implement
compare_label_label
  (l1, l2) = let
in
//
case+ (l1, l2) of
  | (LABint i1, LABint i2) => compare (i1, i2)
  | (LABsym s1, LABsym s2) => compare (s1, s2)
  | (LABint i1, LABsym s2) => ~1
  | (LABsym s1, LABint i2) =>  1
//
end // end of [compare_label_label]

(* ****** ****** *)

implement
fprint_label
  (out, lab) = let
in
//
case+ lab of
| LABint (int) => fprint (out, int)
| LABsym (sym) => fprint (out, sym)
//
end // end of [fprint_label]

(* ****** ****** *)

(* end of [utfpl_label.dats] *)
