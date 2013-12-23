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
c3nstr_make_node
  (loc, node) = '{
  c3nstr_loc= loc, c3nstr_node= node
} (* end of [c3nstr_make_node] *)

(* ****** ****** *)

implement
c3nstr_prop (loc, s2e) =
  c3nstr_make_node (loc, C3NSTRprop (s2e))
implement
c3nstr_itmlst (loc, s3is) =
  c3nstr_make_node (loc, C3NSTRitmlst (s3is))

(* ****** ****** *)

implement
fprint_c3nstr
  (out, c3t0) = let
in
//
case+
c3t0.c3nstr_node of
//
| C3NSTRprop (s2e) =>
    fprint! (out, "C3NSTRprop(", s2e, ")")
| C3NSTRitmlst (s2is) =>
    fprint! (out, "C3NSTRitmlst(", s2is, ")")
//
end // end of [fprint_c3nstr]

(* ****** ****** *)

implement
fprint_c3nstropt (out, opt) = let
//
implement
fprint_val<c3nstr> (out, x) = fprint_c3nstr (out, x)
//
in
  fprint_option (out, opt)
end // end of [fprint_c3nstropt]

(* ****** ****** *)

(* end of [constraint_c3nstr.dats] *)
