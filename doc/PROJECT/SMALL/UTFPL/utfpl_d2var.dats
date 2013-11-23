(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)
//
implement
eq_d2var_d2var
  (d2v1, d2v2) = compare (d2v1, d2v2) = 0
implement
neq_d2var_d2var
  (d2v1, d2v2) = compare (d2v1, d2v2) != 0
//
(* ****** ****** *)

(* end of [utfpl_d2var.dats] *)
