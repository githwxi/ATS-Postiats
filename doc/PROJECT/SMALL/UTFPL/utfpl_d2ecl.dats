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

implement
fprint_d2ecl
  (out, d2c0) = let
in
//
case+ d2c0.d2ecl_node of
//
| D2Cfundecs _ => fprint! (out, "D2Cfundecs(...)")
//
| D2Cerr((*void*)) => fprint! (out, "D2Eerr(", ")")
//
(*
| _ (*temporary*) => fprint! (out, "D2E...(", "...", ")")
*)
//
end // end of [fprint_d2ecl]

(* ****** ****** *)

implement
fprint_d2eclist
  (out, d2cs) = let
//
implement
fprint_val<d2ecl> = fprint_d2ecl
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<d2ecl> (out, d2cs)
end // end of [fprint_d2eclist]

(* ****** ****** *)

implement
d2ecl_make_node
  (loc, node) = '{
  d2ecl_loc= loc, d2ecl_node= node
} (* end of [d2ecl_make_node] *)

(* ****** ****** *)
//
implement
d2ecl_fundeclst
  (loc, f2ds) =
  d2ecl_make_node (loc, D2Cfundecs (f2ds))
//
(* ****** ****** *)

implement
d2ecl_err (loc) = d2ecl_make_node (loc, D2Cerr())

(* ****** ****** *)

(* end of [utfpl_d2ecl.dats] *)
