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

typedef
d2var_struct =
@{
  d2var_sym= symbol
, d2var_stamp= stamp
} (* end of [d2var_struct] *)

(* ****** ****** *)

local

assume d2var_type = ref (d2var_struct)

in (* in of [local] *)

implement
d2var_get_stamp
  (d2v) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2v)
in
  p->d2var_stamp
end // end of [let]
) (* end of [d2var_get_stamp] *)

end // end of [local]

(* ****** ****** *)

implement
compare_d2var_d2var
  (d2v1, d2v2) = compare (d2v1.stamp, d2v2.stamp)
// end of [compare_d2var_d2var]

(* ****** ****** *)

(* end of [utfpl_d2var.dats] *)
