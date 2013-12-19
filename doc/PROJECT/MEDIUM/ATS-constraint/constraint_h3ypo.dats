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

implement
h3ypo_make_node
  (loc, node) = '{
  h3ypo_loc= loc, h3ypo_node= node
} (* end of [h3ypo_make_node] *)

(* ****** ****** *)
//
implement
h3ypo_prop (loc, s2e) =
  h3ypo_make_node (loc, H3YPOprop (s2e))
implement
h3ypo_bind (loc, s2v, s2e) =
  h3ypo_make_node (loc, H3YPObind (s2v, s2e))
implement
h3ypo_eqeq (loc, s2e1, s2e2) =
  h3ypo_make_node (loc, H3YPOeqeq (s2e1, s2e2))
//
(* ****** ****** *)

(* end of [constraint_h3ypo.dats] *)
