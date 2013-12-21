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

assume stamp_t0ype = int

(* ****** ****** *)

implement stamp_make (x) = x

(* ****** ****** *)

implement
fprint_stamp
  (out, stamp) = fprint_int (out, stamp)
// end of [fprint_stamp]

(* ****** ****** *)

implement
compare_stamp_stamp (s1, s2) = g0int_compare (s1, s2)

(* ****** ****** *)

(* end of [utfpl_stamp.dats] *)
