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

assume stamp_t0ype = int

(* ****** ****** *)

implement
compare_stamp_stamp (s1, s2) = g0int_compare (s1, s2)

(* ****** ****** *)

(* end of [utfpl_stamp.dats] *)
